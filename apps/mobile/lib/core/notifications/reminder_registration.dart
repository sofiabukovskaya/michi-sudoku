import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/puzzle/data/content_flags.dart';

/// Notification settings are semantic; FCM tokens stay inside this adapter.
enum ReminderPermission {
  notRequested,
  authorized,
  denied,
  provisional,
  unsupported,
}

final class ReminderSettings {
  const ReminderSettings({
    required this.enabled,
    required this.permission,
    this.hour = 8,
    this.minute = 0,
  });

  final bool enabled;
  final ReminderPermission permission;
  final int hour;
  final int minute;
}

final class ReminderRegistration with WidgetsBindingObserver {
  ReminderRegistration(this.runtime, this.database, this.flags);

  final FirebaseRuntime runtime;
  final GameDatabase database;
  final ContentFlags flags;
  StreamSubscription<String>? _tokenRefresh;
  StreamSubscription<AuthState>? _authSubscription;
  String? _uid;
  String? _suppressUid;
  int _accountGeneration = 0;

  void start(AuthCubit auth) {
    if (_authSubscription != null) return;
    WidgetsBinding.instance.addObserver(this);
    _authSubscription = auth.stream.listen((state) {
      unawaited(_onAccount(state.account?.uid));
    });
    unawaited(_onAccount(auth.state.account?.uid));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final uid = _uid;
    if (state == AppLifecycleState.resumed && uid != null) {
      unawaited(_refreshOnResume(uid));
    }
  }

  Future<void> _refreshOnResume(String uid) async {
    try {
      await refreshTimezone(uid, LocaleSettings.currentLocale.languageCode);
    } on Object {
      // Resume retries opportunistically; Settings shows explicit state.
    }
  }

  Future<void> _onAccount(String? uid) async {
    if (uid == null) _suppressUid = null;
    if (uid != null && uid == _suppressUid) return;
    if (_uid == uid) return;
    final generation = ++_accountGeneration;
    _uid = null;
    await _tokenRefresh?.cancel();
    _tokenRefresh = null;
    if (uid == null ||
        !await runtime.ready ||
        FirebaseRuntime.useEmulators ||
        !flags.notificationsEnabled) {
      return;
    }
    try {
      final id = await _installationId();
      final doc = await runtime.firestore
          .collection('users')
          .doc(uid)
          .collection('devices')
          .doc(id)
          .get();
      if (generation != _accountGeneration ||
          doc.data()?['remindersEnabled'] != true) {
        return;
      }
      await _markEnabledLocally(uid);
      _uid = uid;
      _listenForTokenRotation();
      await refreshTimezone(uid, LocaleSettings.currentLocale.languageCode);
    } on Object {
      // A Settings visit or later session event can retry registration.
    }
  }

  void _listenForTokenRotation() {
    if (_tokenRefresh != null) return;
    // Admin Messaging still needs registration tokens after rotation.
    // ignore: deprecated_member_use
    _tokenRefresh = FirebaseMessaging.instance.onTokenRefresh.listen((fresh) {
      final current = _uid;
      if (current != null) {
        unawaited(_refreshToken(current, fresh));
      }
    });
  }

  Future<void> _refreshToken(String uid, String token) async {
    try {
      await _write(uid, token, LocaleSettings.currentLocale.languageCode);
    } on Object {
      // A later resume or Settings visit retries registration when online.
    }
  }

  Future<String> _installationId() async {
    final row = await (database.select(
      database.syncMetadata,
    )..where((item) => item.key.equals('installationId'))).getSingleOrNull();
    if (row == null) {
      throw StateError('Installation ID missing');
    }
    return row.value;
  }

  Future<bool> _enabledLocally(String uid) async {
    final row =
        await (database.select(database.syncMetadata)
              ..where((item) => item.key.equals('reminderEnabled:$uid')))
            .getSingleOrNull();
    return row?.value == '1';
  }

  Future<void> _markEnabledLocally(String uid) => database
      .into(database.syncMetadata)
      .insertOnConflictUpdate(
        SyncMetadataCompanion.insert(key: 'reminderEnabled:$uid', value: '1'),
      );

  Future<ReminderSettings> load(String? uid) async {
    await flags.refresh();
    if (!flags.notificationsEnabled) {
      return const ReminderSettings(
        enabled: false,
        permission: ReminderPermission.unsupported,
      );
    }
    if (uid == null || !await runtime.ready || FirebaseRuntime.useEmulators) {
      return const ReminderSettings(
        enabled: false,
        permission: ReminderPermission.unsupported,
      );
    }
    try {
      final messaging = FirebaseMessaging.instance;
      final permission = _map(
        (await messaging.getNotificationSettings()).authorizationStatus,
      );
      final id = await _installationId();
      final doc = await runtime.firestore
          .collection('users')
          .doc(uid)
          .collection('devices')
          .doc(id)
          .get();
      return ReminderSettings(
        enabled:
            doc.data()?['remindersEnabled'] == true &&
            (permission == ReminderPermission.authorized ||
                permission == ReminderPermission.provisional),
        permission: permission,
      );
    } on Object {
      return const ReminderSettings(
        enabled: false,
        permission: ReminderPermission.notRequested,
      );
    }
  }

  Future<ReminderSettings> enable(String uid, String locale) async {
    _suppressUid = null;
    await flags.refresh();
    if (!flags.notificationsEnabled) {
      return const ReminderSettings(
        enabled: false,
        permission: ReminderPermission.unsupported,
      );
    }
    if (!await runtime.ready || FirebaseRuntime.useEmulators) {
      return const ReminderSettings(
        enabled: false,
        permission: ReminderPermission.unsupported,
      );
    }
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    final permission = _map(settings.authorizationStatus);
    if (permission != ReminderPermission.authorized &&
        permission != ReminderPermission.provisional) {
      return ReminderSettings(enabled: false, permission: permission);
    }
    // Admin Messaging sends to registration tokens; the new onRegistered
    // stream yields a Firebase Installation ID, not an Admin send token.
    // ignore: deprecated_member_use
    final token = await messaging.getToken();
    if (token == null || token.isEmpty) {
      return const ReminderSettings(
        enabled: false,
        permission: ReminderPermission.unsupported,
      );
    }
    _uid = uid;
    try {
      await _write(uid, token, locale);
      await _markEnabledLocally(uid);
    } on Object {
      _uid = null;
      rethrow;
    }
    _listenForTokenRotation();
    return ReminderSettings(enabled: true, permission: permission);
  }

  Future<void> _write(String uid, String token, String locale) async {
    final id = await _installationId();
    final zone = (await FlutterTimezone.getLocalTimezone()).identifier;
    final now = DateTime.now();
    var next = DateTime(now.year, now.month, now.day, 8);
    if (!next.isAfter(now)) {
      next = DateTime(now.year, now.month, now.day + 1, 8);
    }
    if (_uid != uid) return;
    await runtime.firestore
        .collection('users')
        .doc(uid)
        .collection('devices')
        .doc(id)
        .set({
          'schemaVersion': 1,
          'deviceId': id,
          'fcmToken': token,
          'platform': Platform.isIOS ? 'ios' : 'android',
          'locale': locale,
          'timezone': zone,
          'remindersEnabled': true,
          'reminderHour': 8,
          'reminderMinute': 0,
          'nextReminderAt': Timestamp.fromDate(next.toUtc()),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  /// Called while User A still has credentials, before Firebase sign-out.
  Future<void> disable(String uid) async {
    _accountGeneration++;
    _suppressUid = uid;
    _uid = null;
    await _tokenRefresh?.cancel();
    _tokenRefresh = null;
    if (!await _enabledLocally(uid)) return;
    if (!await runtime.ready) {
      throw StateError('Cannot remove reminder registration while offline.');
    }
    Object? deletionError;
    StackTrace? deletionStack;
    try {
      final id = await _installationId();
      await runtime.firestore
          .collection('users')
          .doc(uid)
          .collection('devices')
          .doc(id)
          .delete();
    } on Object catch (error, stack) {
      deletionError = error;
      deletionStack = stack;
    }
    if (!FirebaseRuntime.useEmulators) {
      try {
        // The deprecated API invalidates the token accepted by Admin send.
        // ignore: deprecated_member_use
        await FirebaseMessaging.instance.deleteToken();
      } on Object {
        // The server record deletion above is the primary cleanup.
      }
    }
    if (deletionError != null) {
      Error.throwWithStackTrace(deletionError, deletionStack!);
    }
    await (database.delete(
      database.syncMetadata,
    )..where((item) => item.key.equals('reminderEnabled:$uid'))).go();
  }

  Future<void> refreshTimezone(String uid, String locale) async {
    if (!await runtime.ready || FirebaseRuntime.useEmulators) return;
    final id = await _installationId();
    final ref = runtime.firestore
        .collection('users')
        .doc(uid)
        .collection('devices')
        .doc(id);
    final doc = await ref.get();
    if (doc.data()?['remindersEnabled'] != true) return;
    final zone = (await FlutterTimezone.getLocalTimezone()).identifier;
    if (doc.data()?['timezone'] == zone && doc.data()?['locale'] == locale) {
      return;
    }
    final token = doc.data()?['fcmToken'];
    if (token is String && token.isNotEmpty) {
      await _write(uid, token, locale);
    }
  }

  static ReminderPermission _map(AuthorizationStatus status) =>
      switch (status) {
        AuthorizationStatus.authorized => ReminderPermission.authorized,
        AuthorizationStatus.provisional => ReminderPermission.provisional,
        AuthorizationStatus.denied => ReminderPermission.denied,
        AuthorizationStatus.notDetermined => ReminderPermission.notRequested,
        AuthorizationStatus.deniedPermanently => ReminderPermission.denied,
      };

  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _authSubscription?.cancel();
    await _tokenRefresh?.cancel();
  }
}
