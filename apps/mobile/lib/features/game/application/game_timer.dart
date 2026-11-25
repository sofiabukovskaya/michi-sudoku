import 'package:michi_mobile/core/time/game_clock.dart';

/// Accumulated wall time is durable; the live run uses a monotonic clock.
final class GameTimer {
  GameTimer._({
    required this.clock,
    required this.elapsedBeforeRun,
    required this.runningSince,
    required this.monotonicSince,
  });

  factory GameTimer.start(GameClock clock) => GameTimer._(
    clock: clock,
    elapsedBeforeRun: Duration.zero,
    runningSince: clock.now(),
    monotonicSince: clock.monotonic(),
  );

  /// A game always restores paused. If the process ended while the timer was
  /// running (terminated, killed, or reinstalled before a background pause
  /// was saved), only the run up to the last save counts: [lastActiveAt] is
  /// the last moment the player was known to be solving. Time while the app
  /// was not running is never solving time. Bounded against clock changes.
  factory GameTimer.restore({
    required GameClock clock,
    required Duration elapsedBeforeRun,
    required DateTime? runningSince,
    DateTime? lastActiveAt,
  }) {
    var elapsed = elapsedBeforeRun;
    if (runningSince != null) {
      final now = clock.now();
      final end = lastActiveAt == null || lastActiveAt.isAfter(now)
          ? now
          : lastActiveAt;
      elapsed += _bounded(
        end.difference(runningSince),
        const Duration(hours: 12),
      );
    }
    return GameTimer._(
      clock: clock,
      elapsedBeforeRun: elapsed,
      runningSince: null,
      monotonicSince: null,
    );
  }

  final GameClock clock;
  final Duration elapsedBeforeRun;
  final DateTime? runningSince;
  final Duration? monotonicSince;

  bool get isPaused => runningSince == null;

  Duration get elapsed {
    final since = monotonicSince;
    if (since == null) return elapsedBeforeRun;
    return elapsedBeforeRun + _bounded(clock.monotonic() - since, null);
  }

  GameTimer pause() => isPaused
      ? this
      : GameTimer._(
          clock: clock,
          elapsedBeforeRun: elapsed,
          runningSince: null,
          monotonicSince: null,
        );

  GameTimer resume() => !isPaused
      ? this
      : GameTimer._(
          clock: clock,
          elapsedBeforeRun: elapsedBeforeRun,
          runningSince: clock.now(),
          monotonicSince: clock.monotonic(),
        );

  static Duration _bounded(Duration value, Duration? maximum) {
    if (value.isNegative) return Duration.zero;
    if (maximum != null && value > maximum) return maximum;
    return value;
  }
}
