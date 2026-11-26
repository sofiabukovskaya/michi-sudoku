/// When the gentle streak reminder fires, and which streak is at stake.
///
/// - Around when the player usually finishes: 30 minutes before their
///   median completion time of day, kept between 08:00 and 21:00; 19:00
///   before there is any history.
/// - Only for a day whose Daily is not done: today if its time is still
///   ahead and today's Daily is open, otherwise tomorrow.
/// - One reminder at a time; the app reschedules whenever Home loads, so a
///   finished Daily cancels today's reminder.
final class StreakReminderPlan {
  const StreakReminderPlan({required this.at, required this.streak});

  /// [completions] are recent completed games, newest first; [streak] is the
  /// current Daily streak (it already counts today when [dailyDone]).
  factory StreakReminderPlan.next({
    required DateTime now,
    required bool dailyDone,
    required int streak,
    required Iterable<DateTime> completions,
  }) {
    final local = now.toLocal();
    final minute = minuteOfDay(completions);
    DateTime on(int dayOffset) => DateTime(
      local.year,
      local.month,
      local.day + dayOffset,
      minute ~/ 60,
      minute % 60,
    );
    final today = on(0);
    if (!dailyDone && today.isAfter(local)) {
      return StreakReminderPlan(at: today, streak: streak);
    }
    // Tomorrow: a streak survives only if today's Daily is done.
    return StreakReminderPlan(at: on(1), streak: dailyDone ? streak : 0);
  }

  /// Local time to notify.
  final DateTime at;

  /// The streak the reminder protects; 0 means a plain "ready" reminder.
  final int streak;

  static const int _default = 19 * 60;
  static const int _earliest = 8 * 60;
  static const int _latest = 21 * 60;
  static const int _lead = 30;

  /// Minutes after midnight for the reminder, from recent completion times.
  static int minuteOfDay(Iterable<DateTime> completions) {
    final minutes = [
      for (final completed in completions.take(14))
        completed.toLocal().hour * 60 + completed.toLocal().minute,
    ]..sort();
    if (minutes.isEmpty) return _default;
    final median = minutes[minutes.length ~/ 2];
    return (median - _lead).clamp(_earliest, _latest);
  }
}
