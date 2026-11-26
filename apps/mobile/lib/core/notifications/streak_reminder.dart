import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:michi_mobile/features/progress/domain/streak_reminder_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// The gentle streak reminder: one local notification, scheduled on the
/// device (works for guests, no server), only for a day whose Daily is not
/// done, around when the player usually plays (see [StreakReminderPlan]).
final class StreakReminder {
  StreakReminder({
    FlutterLocalNotificationsPlugin? plugin,
    SharedPreferencesAsync? preferences,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
       _preferences = preferences;

  static const _enabledKey = 'michi.reminder.local.enabled';
  static const _id = 7001;
  static const _payload = 'daily';
  static const _channel = 'michi_streak';

  final FlutterLocalNotificationsPlugin _plugin;
  SharedPreferencesAsync? _preferences;
  SharedPreferencesAsync get _store =>
      _preferences ??= SharedPreferencesAsync();
  Future<bool>? _ready;

  /// The last state Home reported, so turning reminders on schedules at once.
  Future<void> Function()? _last;

  /// Opens today's Daily; set by the notification coordinator.
  VoidCallback? onOpenDaily;

  static bool get _supported =>
      !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  Future<bool> _initialize() => _ready ??= () async {
    if (!_supported) return false;
    try {
      tz_data.initializeTimeZones();
      final zone = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(zone));
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings(
            '@drawable/ic_daily_notification',
          ),
          // Permission is asked only when the player turns reminders on.
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestSoundPermission: false,
            requestBadgePermission: false,
          ),
        ),
        onDidReceiveNotificationResponse: (response) {
          if (response.payload == _payload) onOpenDaily?.call();
        },
      );
      return true;
    } on Object catch (error, stack) {
      developer.log(
        'Local reminders unavailable',
        name: 'michi.reminder',
        error: error,
        stackTrace: stack,
      );
      return false;
    }
  }();

  /// Whether the app was opened by tapping the reminder.
  Future<bool> launchedFromReminder() async {
    if (!await _initialize()) return false;
    try {
      final details = await _plugin.getNotificationAppLaunchDetails();
      return (details?.didNotificationLaunchApp ?? false) &&
          details?.notificationResponse?.payload == _payload;
    } on Object {
      return false;
    }
  }

  Future<bool> isEnabled() async {
    try {
      return await _store.getBool(_enabledKey) ?? false;
    } on Object {
      return false;
    }
  }

  /// Whether the system currently allows MICHI's notifications.
  Future<bool> permitted() async {
    if (!await _initialize()) return false;
    try {
      if (Platform.isIOS) {
        final options = await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.checkPermissions();
        return options?.isEnabled ?? false;
      }
      return await _plugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.areNotificationsEnabled() ??
          false;
    } on Object {
      return false;
    }
  }

  /// Asks for permission when needed; returns whether reminders are now on.
  Future<bool> enable() async {
    if (!await _initialize()) return false;
    bool? granted;
    try {
      granted = Platform.isIOS
          ? await _plugin
                .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin
                >()
                ?.requestPermissions(alert: true, sound: true)
          : await _plugin
                .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin
                >()
                ?.requestNotificationsPermission();
    } on Object {
      granted = false;
    }
    if (granted != true) return false;
    try {
      await _store.setBool(_enabledKey, true);
    } on Object {
      return false;
    }
    await _last?.call();
    return true;
  }

  Future<void> disable() async {
    try {
      await _store.setBool(_enabledKey, false);
    } on Object {
      // Cancelling below still stops the next reminder.
    }
    if (await _initialize()) {
      try {
        await _plugin.cancel(id: _id);
      } on Object {
        // Nothing scheduled.
      }
    }
  }

  /// Replaces the scheduled reminder with the next one, or cancels it when
  /// reminders are off. [streakBody] and [readyBody] are localized texts.
  Future<void> reschedule({
    required DateTime now,
    required bool dailyDone,
    required int streak,
    required Iterable<DateTime> completions,
    required String title,
    required String Function(int streak) streakBody,
    required String readyBody,
  }) async {
    _last = () => reschedule(
      now: DateTime.now(),
      dailyDone: dailyDone,
      streak: streak,
      completions: completions,
      title: title,
      streakBody: streakBody,
      readyBody: readyBody,
    );
    if (!await _initialize()) return;
    try {
      await _plugin.cancel(id: _id);
      if (!await isEnabled()) return;
      final plan = StreakReminderPlan.next(
        now: now,
        dailyDone: dailyDone,
        streak: streak,
        completions: completions,
      );
      await _plugin.zonedSchedule(
        id: _id,
        title: title,
        body: plan.streak > 0 ? streakBody(plan.streak) : readyBody,
        scheduledDate: tz.TZDateTime.from(plan.at, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channel,
            'Daily streak',
            channelDescription: "A gentle reminder when today's Sudoku waits.",
          ),
          iOS: DarwinNotificationDetails(),
        ),
        // Inexact is fine for a gentle nudge and needs no alarm permission.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: _payload,
      );
    } on Object catch (error, stack) {
      developer.log(
        'Streak reminder not scheduled',
        name: 'michi.reminder',
        error: error,
        stackTrace: stack,
      );
    }
  }
}
