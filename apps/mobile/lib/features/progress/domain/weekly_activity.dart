import 'package:michi_mobile/features/game/domain/game_repository.dart';

/// A calendar week of completed local games. Days are display/status data,
/// never links to historical Daily puzzles.
final class WeeklyActivity {
  WeeklyActivity({required this.monday, required List<CompletedGame> games})
    : days = List<DayActivity>.unmodifiable(
        List.generate(7, (index) {
          final day = monday.add(Duration(days: index));
          final matching = games.where((game) {
            final completed = game.completedAt.toLocal();
            return completed.year == day.year &&
                completed.month == day.month &&
                completed.day == day.day;
          }).toList();
          return DayActivity(
            date: day,
            puzzles: matching.length,
            dailyPuzzles: matching
                .where((game) => game.dailyChallengeKey != null)
                .length,
            elapsed: matching.fold(
              Duration.zero,
              (total, game) => total + game.elapsed,
            ),
          );
        }),
      );

  factory WeeklyActivity.current(
    DateTime now,
    List<CompletedGame> games,
  ) {
    final local = now.toLocal();
    final today = DateTime(local.year, local.month, local.day);
    return WeeklyActivity(
      monday: today.subtract(Duration(days: today.weekday - 1)),
      games: games,
    );
  }

  final DateTime monday;
  final List<DayActivity> days;

  int get puzzleCount => days.fold(0, (total, day) => total + day.puzzles);
  int get dailyCount => days.fold(0, (total, day) => total + day.dailyPuzzles);
  Duration get elapsed => days.fold(
    Duration.zero,
    (total, day) => total + day.elapsed,
  );
  int get activeDays => days.where((day) => day.puzzles > 0).length;
}

final class DayActivity {
  const DayActivity({
    required this.date,
    required this.puzzles,
    required this.dailyPuzzles,
    required this.elapsed,
  });

  final DateTime date;
  final int puzzles;
  final int dailyPuzzles;
  final Duration elapsed;

  bool get isActive => puzzles > 0;
}
