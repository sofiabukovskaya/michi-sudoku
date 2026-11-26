import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_timer.dart';

final class _FakeClock implements GameClock {
  DateTime wall = DateTime.utc(2026, 10);
  Duration ticks = Duration.zero;

  @override
  DateTime now() => wall;

  @override
  Duration monotonic() => ticks;

  void advance(Duration amount) {
    wall = wall.add(amount);
    ticks += amount;
  }
}

void main() {
  test('starts at zero, pauses, and resumes without counting paused time', () {
    final clock = _FakeClock();
    var timer = GameTimer.start(clock);
    expect(timer.elapsed, Duration.zero);
    clock.advance(const Duration(seconds: 15));
    expect(timer.elapsed, const Duration(seconds: 15));
    timer = timer.pause();
    clock.advance(const Duration(hours: 1));
    expect(timer.elapsed, const Duration(seconds: 15));
    timer = timer.resume();
    clock.advance(const Duration(seconds: 5));
    expect(timer.elapsed, const Duration(seconds: 20));
  });

  test('restore keeps paused duration and never resumes implicitly', () {
    final clock = _FakeClock();
    final timer = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: const Duration(minutes: 2),
      runningSince: null,
    );
    expect(timer.isPaused, isTrue);
    clock.advance(const Duration(hours: 3));
    expect(timer.elapsed, const Duration(minutes: 2));
  });

  test('interrupted run counts only up to the last save, never dead time', () {
    final clock = _FakeClock();
    final startedRun = clock.now().subtract(
      const Duration(hours: 12, minutes: 9),
    );
    final lastSave = startedRun.add(const Duration(minutes: 9));
    // The 729-minute report: 9 minutes of play, then 12 hours not running.
    final timer = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: const Duration(minutes: 2),
      runningSince: startedRun,
      lastActiveAt: lastSave,
    );
    expect(timer.isPaused, isTrue);
    expect(timer.elapsed, const Duration(minutes: 11));
    clock.advance(const Duration(hours: 1));
    expect(timer.elapsed, const Duration(minutes: 11));
    final changedClock = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: const Duration(minutes: 2),
      runningSince: clock.now().add(const Duration(hours: 1)),
      lastActiveAt: clock.now(),
    );
    expect(changedClock.elapsed, const Duration(minutes: 2));
    final futureSave = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: Duration.zero,
      runningSince: clock.now().subtract(const Duration(minutes: 3)),
      lastActiveAt: clock.now().add(const Duration(days: 1)),
    );
    expect(futureSave.elapsed, const Duration(minutes: 3));
  });

  test('backward monotonic clock reading cannot subtract elapsed time', () {
    final clock = _FakeClock();
    final timer = GameTimer.start(
      clock..ticks = const Duration(seconds: 10),
    );
    clock.ticks = Duration.zero;
    expect(timer.elapsed, Duration.zero);
  });
}
