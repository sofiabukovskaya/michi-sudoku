import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/progress/domain/daily_streak.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

CompletedGame _game(DateTime completedAt, {bool daily = true}) => CompletedGame(
  gameId: 'g-${completedAt.microsecondsSinceEpoch}-$daily',
  puzzleId: 'p',
  dailyChallengeKey: daily ? 'd-${completedAt.day}' : null,
  initialBoard: SudokuBoard.empty(),
  completedBoard: SudokuBoard.empty(),
  startedAt: completedAt.subtract(const Duration(minutes: 5)),
  completedAt: completedAt,
  elapsed: const Duration(minutes: 5),
  mistakes: 0,
  hintsRequested: 0,
  highestHintLevelUsed: 0,
);

void main() {
  final now = DateTime(2026, 11, 24, 9);

  test('counts consecutive solved Daily days ending today', () {
    expect(
      DailyStreak.count(now, [
        _game(DateTime(2026, 11, 24, 8)),
        _game(DateTime(2026, 11, 23, 20)),
        _game(DateTime(2026, 11, 22, 7)),
        _game(DateTime(2026, 11, 20, 7)),
      ]),
      3,
    );
  });

  test('a streak that ended yesterday is still alive today', () {
    expect(DailyStreak.count(now, [_game(DateTime(2026, 11, 23, 20))]), 1);
  });

  test('non-Daily games and older gaps never invent a streak', () {
    expect(DailyStreak.count(now, [_game(now, daily: false)]), 0);
    expect(DailyStreak.count(now, [_game(DateTime(2026, 11, 21))]), 0);
    expect(DailyStreak.count(now, const []), 0);
  });
}
