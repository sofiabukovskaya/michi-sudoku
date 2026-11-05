import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/data/drift_imported_puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  test(
    'confirmed imported clues persist and restore into normal Game and Coach',
    () async {
      final database = GameDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final imported = DriftImportedPuzzleRepository(database);
      final games = DriftGameRepository(database);
      final puzzle = PuzzleDefinition.imported(
        board: DemoPuzzle.standard.givens,
        humanSolverFullySupported: true,
        requiredTechniques: const [SudokuTechnique.nakedSingle],
      );
      await imported.save(puzzle);
      await imported.save(puzzle);
      final loaded = await imported.load(puzzle.id);
      expect(loaded, isNotNull);
      expect(loaded!.source, PuzzleSource.imported);
      expect(loaded.initialBoard, puzzle.initialBoard);
      expect(loaded.requiredTechniques, puzzle.requiredTechniques);
      final rows = await database.select(database.importedPuzzles).get();
      expect(rows, hasLength(1));

      final game = GameCubit(
        puzzle: loaded.puzzle,
        exactSolver: const BacktrackingExactSolver(),
        humanSolver: const DeterministicHumanSolver(),
        coachEngine: const StructuredCoachEngine(),
        repository: games,
      );
      addTearDown(game.close);
      final given = CellRef(row: 0, column: 0);
      game
        ..selectCell(given)
        ..enterDigit(1);
      expect(game.state.board.valueAt(given), 5);
      game.requestHint();
      expect(game.state.coach, isNotNull);
      await game.flushPersistence();

      final stored = await games.loadActiveGame();
      expect(stored, isNotNull);
      expect(stored!.puzzleId, puzzle.id);
      expect(stored.initialBoard, puzzle.initialBoard);
      final restored = GameCubit.restore(
        stored: stored,
        exactSolver: const BacktrackingExactSolver(),
        humanSolver: const DeterministicHumanSolver(),
        coachEngine: const StructuredCoachEngine(),
        repository: games,
      );
      addTearDown(restored.close);
      expect(restored.state.puzzle.id, puzzle.id);
      expect(restored.state.board, puzzle.initialBoard);
      expect(
        (await imported.load(stored.puzzleId))!.initialBoard,
        puzzle.initialBoard,
      );
    },
  );
}
