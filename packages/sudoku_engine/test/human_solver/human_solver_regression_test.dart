import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/human_puzzles.dart';
import '../fixtures/solver_puzzles.dart';

void main() {
  const human = DeterministicHumanSolver();
  const exact = BacktrackingExactSolver();

  // The Phase 3 corpus mixes straightforward and search-heavy puzzles. The
  // exact solver is used here only as a test oracle; it is never consulted by
  // production HumanSolver code.
  for (final expectation in humanPuzzleExpectations) {
    test(
      '${expectation.name}: every logical step preserves the true solution',
      () {
        final fixture = solverRegressionPuzzles.firstWhere(
          (item) => item.name == expectation.name,
        );
        final board = SudokuBoard.parse(fixture.puzzle);
        final solution = exact.solve(board);
        expect(solution, isNotNull);
        expect(exact.hasUniqueSolution(board), isTrue);

        final result = human.solveLogically(board);
        var state = HumanSolverState.initial(board);
        for (final deduction in result.deductions) {
          expect(human.findNextDeduction(state), deduction);
          expect(deduction.focusCells, isNotEmpty);
          expect(deduction.evidence, isNotEmpty);
          for (final placement in deduction.placements) {
            expect(solution!.valueAt(placement.cell), placement.digit);
          }
          for (final elimination in deduction.eliminations) {
            expect(
              solution!.valueAt(elimination.cell),
              isNot(elimination.digit),
            );
          }

          state = state.apply(deduction);
          expect(SudokuConstraints.validate(state.board).isValid, isTrue);
          expect(exact.hasSolution(state.board), isTrue);
          for (final cell in state.emptyCells) {
            expect(
              state.candidatesFor(cell).contains(solution!.valueAt(cell)),
              isTrue,
              reason: '${fixture.name}: true digit lost at $cell',
            );
          }
        }

        expect(state.board, result.finalState.board);
        expect(state.candidates, result.finalState.candidates);
        expect(result.status, expectation.status);
        expect(
          result.deductions.map((deduction) => deduction.technique).toSet(),
          containsAll(expectation.requiredTechniques),
        );
        expect(board, SudokuBoard.parse(fixture.puzzle));
      },
    );
  }

  test('the standard puzzle is solved by the supported techniques', () {
    final board = SudokuBoard.parse(solverRegressionPuzzles.first.puzzle);
    final result = human.solveLogically(board);

    expect(result.status, HumanSolveStatus.solved);
    expect(result.finalState.board.isComplete, isTrue);
    expect(result.deductions, isNotEmpty);
  });

  test('top95 #14 remains solvable but exceeds the Phase 4 technique set', () {
    final board = SudokuBoard.parse(
      solverRegressionPuzzles
          .firstWhere(
            (fixture) => fixture.name == 'top95 #14',
          )
          .puzzle,
    );
    final result = human.solveLogically(board);

    expect(exact.hasUniqueSolution(board), isTrue);
    expect(result.status, HumanSolveStatus.stuck);
    expect(result.finalState.board.isComplete, isFalse);
    expect(result.finalState.hasContradiction, isFalse);
  });
}
