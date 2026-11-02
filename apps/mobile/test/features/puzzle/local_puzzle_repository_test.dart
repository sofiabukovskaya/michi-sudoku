import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GameDatabase database;
  late DriftGameRepository games;
  late LocalPuzzleRepository puzzles;

  setUp(() {
    database = GameDatabase(NativeDatabase.memory());
    games = DriftGameRepository(database);
    puzzles = LocalPuzzleRepository(LocalPuzzleCatalogLoader(), games);
  });
  tearDown(() => database.close());

  test('stable hash uses published FNV-1a vectors', () {
    expect(LocalPuzzleRepository.stableHash(''), 0x811c9dc5);
    expect(LocalPuzzleRepository.stableHash('a'), 0xe40c292c);
    expect(LocalPuzzleRepository.stableHash('foobar'), 0xbf9cf968);
  });

  test('Daily is stable by local date and pack version', () async {
    final date = LocalDate(2026, 10, 26);
    final today = await puzzles.getDailyPuzzle(date);
    final restarted = LocalPuzzleRepository(LocalPuzzleCatalogLoader(), games);
    expect((await restarted.getDailyPuzzle(date)).puzzle.id, today.puzzle.id);
    expect(today.challengeKey, '2026-10-26|catalog-v2');
    expect(today.puzzle.dailyEligible, isTrue);
    expect(await games.isDailyCompleted(today.challengeKey), isFalse);
    for (final other in [
      LocalDate(2026, 10, 27),
      LocalDate(2026, 10, 31),
      LocalDate(2026, 12, 31),
      LocalDate(2024, 2, 29),
    ]) {
      expect(
        (await puzzles.getDailyPuzzle(other)).challengeKey,
        contains('$other'),
      );
    }
    expect(() => LocalDate(2025, 2, 29), throwsArgumentError);
  });

  test(
    'selection avoids active and recent, then replays least recent',
    () async {
      final catalog = await LocalPuzzleCatalogLoader().load();
      final easy = catalog.puzzlesByDifficulty(PuzzleDifficulty.easy);
      expect(
        (await puzzles.selectPuzzle(difficulty: PuzzleDifficulty.easy)).id,
        easy.first.id,
      );
      final now = DateTime.utc(2026, 10, 26);
      await games.saveActiveGame(
        StoredGame(
          gameId: 'active',
          puzzleId: easy.first.id,
          initialBoard: easy.first.initialBoard,
          currentBoard: easy.first.initialBoard,
          notes: const {},
          undoHistory: const [],
          mistakes: 0,
          elapsedBeforeRun: Duration.zero,
          runningSince: null,
          startedAt: now,
          updatedAt: now,
          isPaused: true,
          hintsRequested: 0,
          highestHintLevelUsed: 0,
          correctEditableCells: 0,
          editableCells: easy.first.initialBoard.emptyCellCount,
        ),
      );
      expect(
        (await puzzles.selectPuzzle(difficulty: PuzzleDifficulty.easy)).id,
        easy[1].id,
      );
      for (var index = 1; index < easy.length; index++) {
        await games.completeGame(
          CompletedGame(
            gameId: 'completed-$index',
            puzzleId: easy[index].id,
            initialBoard: easy[index].initialBoard,
            completedBoard: const BacktrackingExactSolver().solve(
              easy[index].initialBoard,
            )!,
            startedAt: now,
            completedAt: now.add(Duration(minutes: index)),
            elapsed: const Duration(minutes: 5),
            mistakes: 0,
            hintsRequested: 0,
            highestHintLevelUsed: 0,
          ),
        );
      }
      expect(
        (await puzzles.selectPuzzle(difficulty: PuzzleDifficulty.easy)).id,
        easy[1].id,
      );
      expect((await puzzles.getPuzzle(easy[2].id)).id, easy[2].id);
      expect(() => puzzles.getPuzzle('missing'), throwsStateError);
    },
  );

  test(
    'Daily completion is keyed by challenge rather than puzzle ID',
    () async {
      final daily = await puzzles.getDailyPuzzle(LocalDate(2026, 10, 26));
      final now = DateTime.utc(2026, 10, 26);
      await games.completeGame(
        CompletedGame(
          gameId: 'daily-session',
          puzzleId: daily.puzzle.id,
          dailyChallengeKey: daily.challengeKey,
          initialBoard: daily.puzzle.initialBoard,
          completedBoard: const BacktrackingExactSolver().solve(
            daily.puzzle.initialBoard,
          )!,
          startedAt: now,
          completedAt: now,
          elapsed: const Duration(minutes: 7),
          mistakes: 1,
          hintsRequested: 2,
          highestHintLevelUsed: 3,
        ),
      );
      expect(await games.isDailyCompleted(daily.challengeKey), isTrue);
      expect(await games.isDailyCompleted('2026-10-27|catalog-v2'), isFalse);
      expect(
        (await games.loadRecentCompletedGames()).single.dailyChallengeKey,
        daily.challengeKey,
      );
    },
  );
}
