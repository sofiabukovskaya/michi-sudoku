import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/profile/local_profile_manager.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/sync_engine.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';

enum SyncStatus {
  disabledGuest,
  initialMerge,
  syncing,
  synced,
  pending,
  offline,
  error,
}

/// Auth changes select the local owner before any feature view can use another
/// account's cache. Sync runs only when the app has execution time.
final class SyncCoordinator extends ChangeNotifier with WidgetsBindingObserver {
  SyncCoordinator({
    required this.auth,
    required this.scope,
    required this.profiles,
    required this.engine,
    required this.database,
    required this.router,
  });

  final AuthCubit auth;
  final LocalProfileScope scope;
  final LocalProfileManager profiles;
  final SyncEngine engine;
  final GameDatabase database;
  final AppRouter router;

  SyncStatus _status = SyncStatus.disabledGuest;
  SyncStatus get status => _status;
  DateTime? _lastSynced;
  DateTime? get lastSynced => _lastSynced;
  int _pendingCount = 0;
  int get pendingCount => _pendingCount;
  int _dataRevision = 0;
  int get dataRevision => _dataRevision;
  String? _uid;
  int _generation = 0;
  bool _started = false;
  bool _running = false;
  bool _rerunRequested = false;
  bool _holdAfterFailure = false;
  int _automaticFailures = 0;
  bool _recoveredDeletionMarks = false;
  StreamSubscription<AuthState>? _authSubscription;
  StreamSubscription<List<SyncOutboxData>>? _outboxSubscription;
  Timer? _debounce;
  Timer? _retryTimer;

  void start() {
    if (_started) return;
    _started = true;
    WidgetsBinding.instance.addObserver(this);
    _authSubscription = auth.stream.listen((state) {
      if (state.available && !_recoveredDeletionMarks) {
        _recoveredDeletionMarks = true;
        unawaited(
          profiles.purgePendingDeletedAccounts(
            currentUid: state.account?.uid,
          ),
        );
      }
      unawaited(_onAuth(state.account?.uid));
    });
    unawaited(_onAuth(auth.state.account?.uid));
    _outboxSubscription = database.select(database.syncOutbox).watch().listen(
      (rows) {
        final uid = _uid;
        if (uid == null) return;
        final count = rows
            .where((row) => row.profileId == 'firebase:$uid')
            .length;
        if (count == _pendingCount) return;
        _pendingCount = count;
        notifyListeners();
        if (count > 0 && !_holdAfterFailure) {
          _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 600), () {
            unawaited(retry());
          });
        }
      },
    );
  }

  Future<void> _onAuth(String? uid) async {
    if (uid == _uid) return;
    final oldUid = _uid;
    final generation = ++_generation;
    _uid = uid;
    _debounce?.cancel();
    _retryTimer?.cancel();
    _automaticFailures = 0;
    _holdAfterFailure = false;
    _pendingCount = 0;
    _lastSynced = null;
    if (oldUid != null) {
      scope.selectGuest();
      unawaited(router.replaceAll([AppShellRoute()]));
    }
    if (uid == null) {
      _setStatus(SyncStatus.disabledGuest);
      return;
    }
    _setStatus(SyncStatus.initialMerge);
    try {
      await profiles.claimGuest(uid);
      if (generation != _generation) return;
      scope.selectAccount(uid);
      _dataRevision++;
      notifyListeners();
      final row =
          await (database.select(database.syncMetadata)
                ..where((item) => item.key.equals('lastSynced:firebase:$uid')))
              .getSingleOrNull();
      final millis = int.tryParse(row?.value ?? '');
      _lastSynced = millis == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
      await retry();
    } on Object {
      if (generation == _generation) _setStatus(SyncStatus.error);
    }
  }

  Future<void> retry({bool automatic = false}) async {
    final uid = _uid;
    if (uid == null) return;
    if (!automatic) {
      _retryTimer?.cancel();
      _automaticFailures = 0;
    }
    if (_running) {
      _rerunRequested = true;
      return;
    }
    _holdAfterFailure = false;
    if (scope.profileId != 'firebase:$uid') {
      try {
        await profiles.claimGuest(uid);
        if (auth.state.account?.uid != uid) return;
        scope.selectAccount(uid);
        _dataRevision++;
        notifyListeners();
      } on Object {
        _setStatus(SyncStatus.error);
        return;
      }
    }
    final generation = _generation;
    _running = true;
    _setStatus(SyncStatus.syncing);
    try {
      await engine.sync(
        uid,
        isCurrent: () =>
            generation == _generation && auth.state.account?.uid == uid,
      );
      if (generation != _generation) return;
      _pendingCount = await engine.pendingCount(uid);
      _lastSynced = DateTime.now().toUtc();
      _automaticFailures = 0;
      _dataRevision++;
      _setStatus(_pendingCount == 0 ? SyncStatus.synced : SyncStatus.pending);
    } on FirebaseException catch (error) {
      if (generation != _generation) return;
      _holdAfterFailure = true;
      final transient = _isTransient(error.code);
      _setStatus(
        error.code == 'unavailable' || error.code == 'network-request-failed'
            ? SyncStatus.offline
            : SyncStatus.error,
      );
      if (transient) _scheduleRetry();
    } on Object {
      if (generation != _generation) return;
      _holdAfterFailure = true;
      _setStatus(SyncStatus.error);
    } finally {
      _running = false;
      final rerun = _rerunRequested && !_holdAfterFailure;
      _rerunRequested = false;
      if (rerun) {
        unawaited(retry());
      }
    }
  }

  bool _isTransient(String code) =>
      code == 'unavailable' ||
      code == 'network-request-failed' ||
      code == 'deadline-exceeded' ||
      code == 'aborted' ||
      code == 'resource-exhausted';

  void _scheduleRetry() {
    // Four retries at 2, 4, 8, and 16 seconds. After that, app resume or a
    // deliberate Retry can start another bounded attempt sequence.
    if (_automaticFailures >= 4) return;
    final delay = Duration(seconds: 2 << _automaticFailures);
    _automaticFailures++;
    _retryTimer?.cancel();
    _retryTimer = Timer(delay, () => unawaited(retry(automatic: true)));
  }

  Future<bool> deleteAccount() async {
    final uid = _uid;
    if (uid == null) return false;
    final deleted = await auth.deleteAccount();
    if (!deleted) return false;
    await profiles.markAccountForDeletion(uid);
    await profiles.purgeAccount(uid);
    await router.replaceAll([const WelcomeRoute()]);
    return true;
  }

  void _setStatus(SyncStatus value) {
    _status = value;
    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(retry());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _debounce?.cancel();
    _retryTimer?.cancel();
    unawaited(_authSubscription?.cancel());
    unawaited(_outboxSubscription?.cancel());
    super.dispose();
  }
}
