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

  test('interrupted running session catches up with bounded wall time', () {
    final clock = _FakeClock();
    final timer = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: const Duration(minutes: 2),
      runningSince: clock.now().subtract(const Duration(minutes: 3)),
    );
    expect(timer.isPaused, isTrue);
    expect(timer.elapsed, const Duration(minutes: 5));
    final changedClock = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: const Duration(minutes: 2),
      runningSince: clock.now().add(const Duration(hours: 1)),
    );
    expect(changedClock.elapsed, const Duration(minutes: 2));
    final longGap = GameTimer.restore(
      clock: clock,
      elapsedBeforeRun: Duration.zero,
      runningSince: clock.now().subtract(const Duration(days: 2)),
    );
    expect(longGap.elapsed, const Duration(hours: 12));
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
