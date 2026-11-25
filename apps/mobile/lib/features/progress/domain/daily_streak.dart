import 'package:michi_mobile/features/game/domain/game_repository.dart';

/// Consecutive local days with a solved Daily Sudoku, from real history.
///
/// Today counts once solved; until then a streak that ended yesterday is
/// still alive. A missed day resets only the streak, never other progress.
abstract final class DailyStreak {
  static int count(DateTime now, Iterable<CompletedGame> games) {
    DateTime day(DateTime value) {
      final local = value.toLocal();
      return DateTime(local.year, local.month, local.day);
    }

    final solved = {
      for (final game in games)
        if (game.dailyChallengeKey != null) day(game.completedAt),
    };
    var cursor = day(now);
    if (!solved.contains(cursor)) {
      cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
    }
    var streak = 0;
    while (solved.contains(cursor)) {
      streak++;
      cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
    }
    return streak;
  }
}
