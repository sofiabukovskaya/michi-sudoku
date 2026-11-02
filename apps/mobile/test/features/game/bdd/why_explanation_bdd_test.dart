import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  const exact = BacktrackingExactSolver();
  const human = DeterministicHumanSolver();
  const coach = StructuredCoachEngine();

  GameCubit create(SudokuBoard board, String id, {DriftGameRepository? repo}) =>
      GameCubit(
        puzzle: SudokuPuzzle(id: id, givens: board),
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
        repository: repo,
      );

  group('Feature: Understand a solved Sudoku cell', () {
    test('Scenario: Hidden Single explanation is bound to its deduction', () {
      // Given a puzzle where a Hidden Single target has multiple candidates.
      final board = SudokuBoard.parse(
        '306020000004015000907004850700000009090000040002000600'
        '000000316008002000061007000',
      );
      final state = HumanSolverState.initial(board);
      final deduction = const HiddenSingleTechnique()
          .find(state)
          .firstWhere(
            (item) =>
                state.candidatesFor(item.placements.single.cell).count > 1,
          );
      final move = deduction.placements.single;
      final game = create(board, 'bdd-hidden');
      addTearDown(game.close);

      // When the player makes the move and opens Why.
      game
        ..selectCell(move.cell)
        ..enterDigit(move.digit);
      final result = game.whyForCell(move.cell);

      // Then exactly the proved Hidden Single is explained.
      expect(result.availability, WhyAvailability.available);
      expect(result.plan!.technique, SudokuTechnique.hiddenSingle);
      expect(result.plan!.target, move);
      expect(result.plan!.steps.map((step) => step.number), [1, 2, 3]);
      expect(result.plan!.steps.last.markerCells, [move.cell]);
      expect(result.plan!.steps.last.digit, move.digit);
    });

    test('Scenario: Naked Single ends with only the entered digit', () {
      // Given a direct single in a real puzzle.
      final board = DemoPuzzle.standard.givens;
      final deduction = human.findNextDeduction(
        HumanSolverState.initial(board),
      )!;
      expect(deduction.technique, SudokuTechnique.nakedSingle);
      final move = deduction.placements.single;
      final game = create(board, 'bdd-naked');
      addTearDown(game.close);

      // When the correct placement is made and Why is requested.
      game
        ..selectCell(move.cell)
        ..enterDigit(move.digit);
      final plan = game.whyForCell(move.cell).plan!;

      // Then each unit restriction and the final candidate are present.
      expect(plan.steps.map((step) => step.kind), [
        WhyStepKind.unitRestrictions,
        WhyStepKind.unitRestrictions,
        WhyStepKind.unitRestrictions,
        WhyStepKind.onlyCandidate,
      ]);
      expect(plan.steps.last.markerCells, [move.cell]);
      expect(plan.steps.last.digit, move.digit);
    });

    test('Scenario: original clue never receives a fabricated technique', () {
      // Given an original filled clue.
      final game = create(DemoPuzzle.standard.givens, 'bdd-given');
      addTearDown(game.close);
      final given = CellRef(row: 0, column: 0);

      // When Why is requested, only the clue state is returned.
      final result = game.whyForCell(given);
      expect(result.availability, WhyAvailability.given);
      expect(result.plan, isNull);
    });

    test('Scenario: saved explanation survives restart', () async {
      // Given a proved move saved in local storage.
      final database = GameDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final repo = DriftGameRepository(database);
      final board = DemoPuzzle.standard.givens;
      final move = human
          .findNextDeduction(HumanSolverState.initial(board))!
          .placements
          .single;
      final game = create(board, 'bdd-restore', repo: repo);
      // Keep the emitted state available before saving and closing the Cubit.
      // ignore: cascade_invocations
      game
        ..selectCell(move.cell)
        ..enterDigit(move.digit);
      final before = game.whyForCell(move.cell).plan!;
      await game.flushPersistence();
      await game.close();

      // When the game is recreated from its stored record.
      final restored = GameCubit.restore(
        stored: (await repo.loadActiveGame())!,
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
        repository: repo,
      );
      addTearDown(restored.close);

      // Then the same technique, target and semantic step kinds are available.
      final after = restored.whyForCell(move.cell).plan!;
      expect(after.technique, before.technique);
      expect(after.target, before.target);
      expect(
        after.steps.map((step) => step.kind),
        before.steps.map((step) => step.kind),
      );
    });
  });
}
