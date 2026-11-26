import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/progress/domain/streak_reminder_plan.dart';

void main() {
  DateTime at(int day, int hour, [int minute = 0]) =>
      DateTime(2026, 11, day, hour, minute);

  test('no history: 19:00 today while the Daily is open', () {
    final plan = StreakReminderPlan.next(
      now: at(26, 9),
      dailyDone: false,
      streak: 4,
      completions: const [],
    );
    expect(plan.at, at(26, 19));
    expect(plan.streak, 4);
  });

  test('30 minutes before the usual completion time', () {
    final plan = StreakReminderPlan.next(
      now: at(26, 7),
      dailyDone: false,
      streak: 2,
      completions: [at(25, 21, 10), at(24, 20, 40), at(23, 21)],
    );
    expect(plan.at, at(26, 20, 30));
  });

  test('a done Daily moves the reminder to tomorrow, keeping the streak', () {
    final plan = StreakReminderPlan.next(
      now: at(26, 9),
      dailyDone: true,
      streak: 6,
      completions: const [],
    );
    expect(plan.at, at(27, 19));
    expect(plan.streak, 6);
  });

  test('a missed reminder time with the Daily open: tomorrow, no streak', () {
    final plan = StreakReminderPlan.next(
      now: at(26, 22),
      dailyDone: false,
      streak: 6,
      completions: const [],
    );
    expect(plan.at, at(27, 19));
    expect(plan.streak, 0);
  });

  test('the reminder stays between 08:00 and 21:00', () {
    expect(StreakReminderPlan.minuteOfDay([at(26, 6)]), 8 * 60);
    expect(StreakReminderPlan.minuteOfDay([at(26, 23, 50)]), 21 * 60);
  });
}
