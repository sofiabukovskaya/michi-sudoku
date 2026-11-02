import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _Clock implements GameClock {
  DateTime wall = DateTime.utc(2026, 10);
  Duration ticks = Duration.zero;

  @override
  DateTime now() => wall;

  @override
  Duration monotonic() => ticks;

  void advance(Duration duration) {
    wall = wall.add(duration);
    ticks += duration;
  }
}

final class _FailOnceRepository implements GameRepository {
  _FailOnceRepository(this.delegate);

  final GameRepository delegate;
  bool failNext = true;

  @override
  Future<void> saveActiveGame(StoredGame game) async {
    if (failNext) {
      failNext = false;
      throw StateError('Simulated storage failure');
    }
    await delegate.saveActiveGame(game);
  }

  @override
  Future<StoredGame?> loadActiveGame() => delegate.loadActiveGame();

  @override
  Future<ActiveGameSummary?> loadActiveSummary() =>
      delegate.loadActiveSummary();

  @override
  Future<void> deleteActiveGame(String gameId) =>
      delegate.deleteActiveGame(gameId);

  @override
  Future<void> completeGame(CompletedGame game) => delegate.completeGame(game);

  @override
  Future<List<CompletedGame>> loadRecentCompletedGames({
    int limit = 20,
    bool normalOnly = false,
  }) => delegate.loadRecentCompletedGames(
    limit: limit,
    normalOnly: normalOnly,
  );

  @override
  Future<List<String>> recentCompletedPuzzleIds({int limit = 20}) =>
      delegate.recentCompletedPuzzleIds(limit: limit);

  @override
  Future<bool> isDailyCompleted(String challengeKey) =>
      delegate.isDailyCompleted(challengeKey);
}

void main() {
  const exact = BacktrackingExactSolver();
  const human = DeterministicHumanSolver();
  const coach = StructuredCoachEngine();
  final entry = CellRef(row: 0, column: 2);
  final noteCell = CellRef(row: 0, column: 3);
  late GameDatabase database;
  late DriftGameRepository repository;
  late _Clock clock;

  GameCubit create({GameRepository? storage}) => GameCubit(
    puzzle: DemoPuzzle.standard,
    exactSolver: exact,
    humanSolver: human,
    coachEngine: coach,
    repository: storage ?? repository,
    clock: clock,
  );

  setUp(() {
    database = GameDatabase(NativeDatabase.memory());
    repository = DriftGameRepository(database);
    clock = _Clock();
  });
  tearDown(() async => database.close());

  test('meaningful edits are durably saved in order', () async {
    final game = create();
    addTearDown(game.close);
    await game.flushPersistence();
    expect(
      (await repository.loadActiveGame())!.currentBoard,
      DemoPuzzle.standard.givens,
    );

    game
      ..selectCell(entry)
      ..enterDigit(1)
      ..erase()
      ..toggleNotesMode()
      ..selectCell(noteCell)
      ..enterDigit(2);
    await game.flushPersistence();
    var stored = (await repository.loadActiveGame())!;
    expect(stored.currentBoard.valueAt(entry), 0);
    expect(stored.notes[noteCell]!.digits, [2]);
    expect(stored.mistakes, 1);
    expect(stored.undoHistory, hasLength(3));

    game.undo();
    await game.flushPersistence();
    stored = (await repository.loadActiveGame())!;
    expect(stored.notes, isEmpty);
    expect(stored.undoHistory, hasLength(2));
    expect(stored.mistakes, 1);
  });

  test('background restoration preserves elapsed and givens', () async {
    final game = create();
    addTearDown(() async {
      if (!game.isClosed) await game.close();
    });
    game
      ..selectCell(entry)
      ..enterDigit(1);
    clock.advance(const Duration(seconds: 44));
    await game.onAppBackground();
    final paused = (await repository.loadActiveGame())!;
    expect(paused.isPaused, isTrue);
    expect(paused.elapsedBeforeRun, const Duration(seconds: 44));
    clock.advance(const Duration(hours: 2));
    await game.close();

    final restored = GameCubit.restore(
      stored: paused,
      exactSolver: exact,
      humanSolver: human,
      coachEngine: coach,
      repository: repository,
      clock: clock,
    );
    addTearDown(restored.close);
    expect(restored.state.isPaused, isTrue);
    expect(restored.elapsed, const Duration(seconds: 44));
    expect(restored.state.board.valueAt(entry), 1);
    expect(restored.state.puzzle.givens.valueAt(entry), 0);
    expect(restored.state.mistakes, 1);
    expect(restored.state.history, hasLength(1));
    expect(restored.state.coach, isNull);
    restored.resume();
    clock.advance(const Duration(seconds: 3));
    expect(restored.elapsed, const Duration(seconds: 47));
    restored.undo();
    expect(restored.state.board, DemoPuzzle.standard.givens);
    restored.requestHint();
    expect(restored.state.coach, isNotNull);
    await restored.flushPersistence();
  });

  test(
    'storage failure surfaces but gameplay remains usable and can retry',
    () async {
      final failing = _FailOnceRepository(repository);
      final game = create(storage: failing);
      addTearDown(game.close);
      await game.flushPersistence();
      expect(game.state.storageFailure, isNotNull);
      game
        ..selectCell(entry)
        ..enterDigit(4);
      await game.flushPersistence();
      expect(game.state.storageFailure, isNull);
      expect(
        (await repository.loadActiveGame())!.currentBoard.valueAt(entry),
        4,
      );
    },
  );

  test('final move completes once and no active record remains', () async {
    final solution = exact.solve(DemoPuzzle.standard.givens)!;
    final last = CellRef(row: 0, column: 0);
    final puzzle = SudokuPuzzle(
      id: 'one-away',
      givens: solution.withValue(last, 0),
    );
    final game = GameCubit(
      puzzle: puzzle,
      exactSolver: exact,
      humanSolver: human,
      coachEngine: coach,
      repository: repository,
      clock: clock,
    );
    addTearDown(game.close);
    game
      ..selectCell(last)
      ..enterDigit(5)
      ..enterDigit(5);
    await game.flushPersistence();
    expect(game.state.status, GameStatus.completed);
    expect(await repository.loadActiveGame(), isNull);
    expect(await repository.loadRecentCompletedGames(), hasLength(1));
  });

  test(
    'Daily identity survives restoration and the completion transaction',
    () async {
      const key = '2026-10-26|catalog-v1';
      final solution = exact.solve(DemoPuzzle.standard.givens)!;
      final last = CellRef(row: 0, column: 0);
      final puzzle = SudokuPuzzle(
        id: 'daily-content-puzzle',
        givens: solution.withValue(last, 0),
      );
      final game = GameCubit(
        puzzle: puzzle,
        dailyChallengeKey: key,
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
        repository: repository,
        clock: clock,
      );
      await game.flushPersistence();
      final stored = (await repository.loadActiveGame())!;
      expect(stored.dailyChallengeKey, key);
      expect(stored.gameId, isNot(stored.puzzleId));
      await game.close();

      final restored = GameCubit.restore(
        stored: stored,
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
        repository: repository,
        clock: clock,
      );
      addTearDown(restored.close);
      expect(restored.state.dailyChallengeKey, key);
      restored
        ..resume()
        ..selectCell(last)
        ..enterDigit(5);
      await restored.flushPersistence();
      expect(await repository.isDailyCompleted(key), isTrue);
      expect(
        await repository.isDailyCompleted('2026-10-27|catalog-v1'),
        isFalse,
      );
      expect(
        (await repository.loadRecentCompletedGames()).single.puzzleId,
        'daily-content-puzzle',
      );
    },
  );
}
