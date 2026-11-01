import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_codec.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final _cell = CellRef(row: 0, column: 2);
final _started = DateTime.utc(2026, 10, 1, 12);

StoredGame _active({String id = 'game-1'}) {
  final givens = DemoPuzzle.standard.givens;
  return StoredGame(
    gameId: id,
    puzzleId: DemoPuzzle.standard.id,
    initialBoard: givens,
    currentBoard: givens.withValue(_cell, 1),
    notes: {
      CellRef(row: 0, column: 3): CandidateMask.fromDigits(const [2, 5, 9]),
    },
    undoHistory: [StoredGameSnapshot(board: givens, notes: const {})],
    mistakes: 2,
    elapsedBeforeRun: const Duration(minutes: 4, seconds: 12),
    runningSince: null,
    startedAt: _started,
    updatedAt: _started.add(const Duration(minutes: 5)),
    isPaused: true,
    hintsRequested: 1,
    highestHintLevelUsed: 2,
    techniqueHelp: const {SudokuTechnique.nakedPair: 2},
    correctEditableCells: 0,
    editableCells: givens.emptyCellCount,
  );
}

CompletedGame _completed(String id, DateTime at) => CompletedGame(
  gameId: id,
  puzzleId: DemoPuzzle.standard.id,
  initialBoard: DemoPuzzle.standard.givens,
  completedBoard: const BacktrackingExactSolver().solve(
    DemoPuzzle.standard.givens,
  )!,
  startedAt: _started,
  completedAt: at,
  elapsed: const Duration(minutes: 9),
  mistakes: 2,
  hintsRequested: 1,
  highestHintLevelUsed: 2,
  techniqueHelp: const {SudokuTechnique.nakedPair: 2},
);

void main() {
  late GameDatabase database;
  late DriftGameRepository repository;

  setUp(() {
    database = GameDatabase(NativeDatabase.memory());
    repository = DriftGameRepository(database);
  });
  tearDown(() async => database.close());

  test('schema version 4 initializes all tables without data loss', () async {
    expect(database.schemaVersion, 4);
    await repository.saveActiveGame(_active());
    final tables = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table'",
        )
        .get();
    expect(
      tables.map((row) => row.read<String>('name')),
      containsAll([
        'active_games',
        'completed_games',
        'technique_progress_entries',
      ]),
    );
    expect(await repository.loadActiveGame(), isNotNull);
  });

  test('active state, notes, timer, hints and undo round-trip', () async {
    final game = _active();
    await repository.saveActiveGame(game);
    final loaded = (await repository.loadActiveGame())!;
    expect(loaded.gameId, game.gameId);
    expect(loaded.initialBoard, game.initialBoard);
    expect(loaded.currentBoard, game.currentBoard);
    expect(loaded.notes[_cell], isNull);
    expect(loaded.notes.values.single.digits, [2, 5, 9]);
    expect(loaded.undoHistory.single.board, game.initialBoard);
    expect(loaded.mistakes, 2);
    expect(loaded.elapsedBeforeRun, game.elapsedBeforeRun);
    expect(loaded.isPaused, isTrue);
    expect(loaded.hintsRequested, 1);
    expect(loaded.highestHintLevelUsed, 2);
    expect(loaded.techniqueHelp, {SudokuTechnique.nakedPair: 2});
    expect((await repository.loadActiveSummary())!.progress, 0);
  });

  test(
    'legacy undo snapshots and damaged Why metadata keep the game',
    () async {
      final legacy = GameCodec.parseHistory(
        '[{"board":"${GameCodec.board(DemoPuzzle.standard.givens)}",'
        '"notes":"{}"}]',
      );
      expect(legacy.single.reasoning, isEmpty);

      await repository.saveActiveGame(_active());
      await database.customUpdate(
        "UPDATE active_games SET reasoning_json = 'broken' WHERE slot = 1",
      );
      final loaded = await repository.loadActiveGame();
      expect(loaded?.gameId, 'game-1');
      expect(loaded?.reasoning, isEmpty);
    },
  );

  test('updates the singleton active game and deletes by identity', () async {
    final first = _active();
    await repository.saveActiveGame(first);
    await repository.saveActiveGame(_active(id: 'game-2'));
    expect((await repository.loadActiveGame())!.gameId, 'game-2');
    await repository.deleteActiveGame(first.gameId);
    expect((await repository.loadActiveGame())!.gameId, 'game-2');
    await repository.deleteActiveGame('game-2');
    expect(await repository.loadActiveGame(), isNull);
  });

  test('completion atomically clears active and is idempotent', () async {
    await repository.saveActiveGame(_active());
    final result = _completed('game-1', _started.add(const Duration(hours: 1)));
    await repository.completeGame(result);
    await repository.completeGame(result);
    expect(await repository.loadActiveGame(), isNull);
    final history = await repository.loadRecentCompletedGames();
    expect(history, hasLength(1));
    expect(history.single.completedBoard, result.completedBoard);
    expect(history.single.mistakes, 2);
    expect(history.single.techniqueHelp, {SudokuTechnique.nakedPair: 2});
  });

  test('recent history is newest first and respects limit', () async {
    await repository.completeGame(_completed('first', _started));
    await repository.completeGame(
      _completed('second', _started.add(const Duration(days: 1))),
    );
    final recent = await repository.loadRecentCompletedGames(limit: 1);
    expect(recent.map((game) => game.gameId), ['second']);
    expect(
      () => repository.loadRecentCompletedGames(limit: 0),
      throwsRangeError,
    );
  });

  test('corrupt active data is discarded while history remains', () async {
    await repository.saveActiveGame(_active());
    await repository.completeGame(_completed('prior', _started));
    await database.customStatement(
      "UPDATE active_games SET current_board = 'bad' WHERE slot = 1",
    );
    expect(await repository.loadActiveGame(), isNull);
    expect(await repository.loadActiveSummary(), isNull);
    expect(await repository.loadRecentCompletedGames(), hasLength(1));
  });

  test('codec uses deterministic compact board and note formats', () {
    final game = _active();
    final source = GameCodec.board(game.currentBoard);
    expect(source, hasLength(81));
    expect(GameCodec.parseBoard(source), game.currentBoard);
    final notes = GameCodec.notes(game.notes);
    expect(
      GameCodec.parseNotes(notes, game.currentBoard).values.single.digits,
      [2, 5, 9],
    );
    final history = GameCodec.history(game.undoHistory);
    expect(GameCodec.parseHistory(history).single.board, game.initialBoard);
  });
}
