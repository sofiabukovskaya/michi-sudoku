// DI and platform callbacks invoke these members across generated boundaries.
// ignore_for_file: unreachable_from_main

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/notifications/streak_reminder.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';

/// The background isolate performs no UI or account work.
@pragma('vm:entry-point')
Future<void> michiBackgroundMessage(RemoteMessage message) async {}

final class NotificationCoordinator {
  NotificationCoordinator(
    this.runtime,
    this.router,
    this.auth,
    this.sync,
    this.reminder,
  );

  final FirebaseRuntime runtime;
  final AppRouter router;
  final AuthCubit auth;
  final SyncCoordinator sync;
  final StreakReminder reminder;
  StreamSubscription<RemoteMessage>? _opened;
  StreamSubscription<RemoteMessage>? _foreground;
  final Set<String> _handledIds = {};

  Future<void> start() async {
    // The local streak reminder needs no account or server.
    reminder.onOpenDaily = () => unawaited(_openDaily(null));
    if (await reminder.launchedFromReminder()) unawaited(_openDaily(null));
    if (!await runtime.ready || FirebaseRuntime.useEmulators) return;
    _foreground = FirebaseMessaging.onMessage.listen((message) {
      // Foreground messages are intentionally silent; Home already shows Daily.
    });
    _opened = FirebaseMessaging.onMessageOpenedApp.listen(_handle);
    try {
      final initial = await FirebaseMessaging.instance.getInitialMessage();
      if (initial != null) _handle(initial);
    } on Object {
      // Notification startup is optional when the platform service is offline.
    }
  }

  void _handle(RemoteMessage message) {
    if (message.data['type'] != 'dailyReminder') return;
    final recipient = message.data['uid'];
    if (recipient is! String || recipient.isEmpty) return;
    final id = message.messageId;
    if (id != null && !_handledIds.add(id)) return;
    unawaited(_openDaily(recipient));
  }

  /// [recipient] is the account a push was sent to; a local reminder
  /// (null) opens the Daily of whoever is using the app.
  Future<void> _openDaily(String? recipient) async {
    // Route after first frame and account/profile selection. Home resolves its
    // locked Daily and completed/active state; a tap never creates a new game.
    await WidgetsBinding.instance.endOfFrame;
    for (var attempt = 0; attempt < 300; attempt++) {
      if (_profileReady) break;
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    if (!_profileReady) return;
    if (recipient != null && auth.state.account?.uid != recipient) return;
    await router.replaceAll([
      AppShellRoute(
        children: [HomeRoute(key: UniqueKey(), launchAction: 'daily')],
      ),
    ]);
  }

  bool get _profileReady {
    if (!auth.state.available || sync.status == SyncStatus.initialMerge) {
      return false;
    }
    final uid = auth.state.account?.uid;
    return uid == null || sync.scope.profileId == 'firebase:$uid';
  }

  Future<void> dispose() async {
    await _opened?.cancel();
    await _foreground?.cancel();
  }
}
