import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/solver_puzzles.dart';

void main() {
  const solver = BacktrackingExactSolver();

  group('ExactSolver regression corpus', () {
    test('top95 #0 requires a branch before any single placement', () {
      final fixture = solverRegressionPuzzles.firstWhere(
        (item) => item.name == 'top95 #0',
      );
      final puzzle = SudokuBoard.parse(fixture.puzzle);
      final candidates = const CandidateCalculator().calculateAll(puzzle);

      expect(candidates.values.any((mask) => mask.isSingle), isFalse);
      final solution = solver.solve(puzzle);
      expect(solution, isNotNull);
      expect(solution!.isComplete, isTrue);
      expect(SudokuConstraints.validate(solution).isValid, isTrue);
    });

    for (final fixture in solverRegressionPuzzles) {
      test('${fixture.name} retains givens and solves to a valid grid', () {
        final puzzle = SudokuBoard.parse(fixture.puzzle);
        final originalValues = puzzle.values.toList();

        final solution = solver.solve(puzzle);

        expect(solution, isNotNull);
        expect(solution!.isComplete, isTrue);
        expect(SudokuConstraints.validate(solution).violations, isEmpty);
        for (var index = 0; index < 81; index++) {
          if (originalValues[index] != 0) {
            expect(
              solution.values[index],
              originalValues[index],
              reason: '${fixture.name}, cell $index',
            );
          }
        }
        expect(puzzle.values, originalValues);
      });
    }
  });
}
