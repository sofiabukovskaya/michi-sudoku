import 'dart:convert';
import 'dart:io';

import 'package:in_app_review/in_app_review.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/progress/domain/daily_streak.dart';
import 'package:michi_mobile/features/review/domain/review_policy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  ReviewService(this._database, this._profile);

  // TODO(owner): Set the numeric App Store Connect Apple ID.
  static const String? appStoreId = null;
  static bool get canOpenListing =>
      Platform.isAndroid || (Platform.isIOS && appStoreId != null);

  static const _installKey = 'michi.review.installedAt';
  static const _requestsKey = 'michi.review.requests';
  static const _settingsKey = 'michi.review.usedSettings';
  static const _activeDaysKey = 'michi.review.activeDays';
  final GameDatabase _database;
  final LocalProfileScope _profile;
  late final _preferences = SharedPreferencesAsync();
  bool _busy = false;
  bool _openingListing = false;
  bool _usedListing = false;
  Future<DateTime>? _installed;
  DateTime? _recordedDay;

  Future<void> initialize() async {
    await recordActiveDay();
    try {
      await _installDate();
    } on Object {
      // A failed preference read should never gate startup.
    }
  }

  Future<void> recordActiveDay() async {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    if (_recordedDay == day) return;
    _recordedDay = day;
    try {
      final days = await _preferences.getStringList(_activeDaysKey) ?? [];
      final recent = {day.toIso8601String(), ...days}.take(3).toList();
      await _preferences.setStringList(_activeDaysKey, recent);
    } on Object {
      _recordedDay = null;
    }
  }

  Future<DateTime> _installDate() async {
    try {
      return await (_installed ??= _readInstallDate());
    } on Object {
      _installed = null;
      rethrow;
    }
  }

  Future<DateTime> _readInstallDate() async {
    final saved = await _preferences.getString(_installKey);
    if (saved != null) {
      final date = DateTime.tryParse(saved);
      if (date != null) return date;
    }
    final info = await PackageInfo.fromPlatform();
    // The OS can provide install time on supported platforms. Otherwise use
    // first observation, including upgrades on platforms without that data.
    final date = info.installTime ?? DateTime.now();
    await _preferences.setString(_installKey, date.toIso8601String());
    return date;
  }

  Future<bool> openListing() async {
    if (!canOpenListing || _openingListing) return false;
    _openingListing = true;
    try {
      await InAppReview.instance.openStoreListing(
        appStoreId: Platform.isIOS ? appStoreId : null,
      );
      _usedListing = true;
      try {
        await _preferences.setBool(_settingsKey, true);
      } on Object {
        // Keep suppression for this session if preferences are unavailable.
      }
      return true;
    } on Object {
      return false;
    } finally {
      _openingListing = false;
    }
  }

  Future<void> consider({
    required Set<ReviewMoment> moments,
    required bool Function() isVisible,
    String? completedDailyId,
  }) async {
    if (_busy || _openingListing || _usedListing || !isVisible()) return;
    _busy = true;
    try {
      _usedListing = await _preferences.getBool(_settingsKey) ?? _usedListing;
      if (_usedListing) return;
      final now = DateTime.now();
      final installed = await _installDate();
      final version = (await PackageInfo.fromPlatform()).version;
      final requested = (await _preferences.getStringList(_requestsKey) ?? [])
          .map((entry) => jsonDecode(entry) as List<Object?>)
          .map(
            (entry) => (
              at: DateTime.parse(entry[0]! as String),
              version: entry[1]! as String,
            ),
          )
          .toList();

      final rows = await _database
          .customSelect(
            'SELECT game_id, completed_at_ms, daily_challenge_key, profile_id '
            'FROM completed_games',
          )
          .get();
      final games = <String>{};
      final savedDays = await _preferences.getStringList(_activeDaysKey) ?? [];
      final days = savedDays.map(DateTime.tryParse).nonNulls.toSet();
      final dailyDays = <DateTime>{};
      ({String id, DateTime at})? firstDailyToday;
      final today = DateTime(now.year, now.month, now.day);
      for (final row in rows) {
        final id = row.read<String>('game_id');
        final time = DateTime.fromMillisecondsSinceEpoch(
          row.read<int>('completed_at_ms'),
        );
        final day = DateTime(time.year, time.month, time.day);
        games.add(id);
        days.add(day);
        if (row.readNullable<String>('daily_challenge_key') != null &&
            row.read<String>('profile_id') == _profile.profileId) {
          dailyDays.add(day);
          final first = firstDailyToday;
          if (day == today &&
              (first == null ||
                  time.isBefore(first.at) ||
                  (time == first.at && id.compareTo(first.id) < 0))) {
            firstDailyToday = (id: id, at: time);
          }
        }
      }
      final eligible = {
        ...moments,
        if (completedDailyId != null &&
            firstDailyToday?.id == completedDailyId &&
            DailyStreak.countDays(now, dailyDays) == 7)
          ReviewMoment.dailyStreak,
      };
      if (!ReviewPolicy.allows(
        moments: eligible,
        completedPuzzles: games.length,
        activeDays: days.length,
        installedAt: installed,
        now: now,
        version: version,
        requests: requested,
        usedSettings: false,
      )) {
        return;
      }
      if (!isVisible() ||
          _openingListing ||
          !await InAppReview.instance.isAvailable()) {
        return;
      }
      final usedListing = await _preferences.getBool(_settingsKey) ?? false;
      if (!isVisible() || _openingListing || _usedListing || usedListing) {
        return;
      }

      final history = [
        for (final request in requested)
          jsonEncode([request.at.toIso8601String(), request.version]),
      ];
      // Persist the attempt first, since native APIs cannot tell us whether
      // the sheet was shown. Restore history if the route left mid-write.
      await _preferences.setStringList(_requestsKey, [
        ...history,
        jsonEncode([now.toIso8601String(), version]),
      ]);
      if (!isVisible() || _openingListing || _usedListing) {
        await _preferences.setStringList(_requestsKey, history);
        return;
      }
      await InAppReview.instance.requestReview();
    } on Object {
      // Review availability never affects the completed user flow.
    } finally {
      _busy = false;
    }
  }
}
