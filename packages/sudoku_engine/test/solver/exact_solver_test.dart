import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';

void main() {
  const solver = BacktrackingExactSolver();

  group('ExactSolver.solve', () {
    test('solves the standard puzzle to its known completed board', () {
      final puzzle = SudokuBoard.parse(standardPuzzle);
      final originalValues = puzzle.values.toList();

      final solution = solver.solve(puzzle);

      expect(solution, SudokuBoard.parse(solvedPuzzle));
      expect(solution!.isComplete, isTrue);
      expect(SudokuConstraints.validate(solution).isValid, isTrue);
      expect(puzzle.values, originalValues);
      expect(puzzle, SudokuBoard.parse(standardPuzzle));
    });

    test('propagates a single missing cell', () {
      final solved = SudokuBoard.parse(solvedPuzzle);
      final almostSolved = solved.withValue(CellRef(row: 8, column: 8), 0);

      expect(solver.solve(almostSolved), solved);
      expect(almostSolved.valueAtPosition(8, 8), 0);
    });

    test('returns the same logical board when already solved', () {
      final solved = SudokuBoard.parse(solvedPuzzle);

      expect(solver.solve(solved), same(solved));
      expect(solver.hasSolution(solved), isTrue);
      expect(solver.countSolutions(solved), 1);
      expect(solver.hasUniqueSolution(solved), isTrue);
    });

    test('rejects a partial board with duplicate givens', () {
      final invalid = SudokuBoard.parse(standardPuzzle).withValue(
        CellRef(row: 0, column: 2),
        5,
      );

      expect(SudokuConstraints.validate(invalid).isValid, isFalse);
      expect(solver.solve(invalid), isNull);
      expect(solver.hasSolution(invalid), isFalse);
      expect(solver.countSolutions(invalid), 0);
      expect(solver.hasUniqueSolution(invalid), isFalse);
    });

    test('rejects a complete rule-invalid board', () {
      final invalid = SudokuBoard.parse(solvedPuzzle).withValue(
        CellRef(row: 0, column: 0),
        3,
      );

      expect(invalid.isComplete, isTrue);
      expect(SudokuConstraints.validate(invalid).isValid, isFalse);
      expect(solver.solve(invalid), isNull);
      expect(solver.hasSolution(invalid), isFalse);
      expect(solver.countSolutions(invalid), 0);
      expect(solver.hasUniqueSolution(invalid), isFalse);
    });

    test('rejects a valid partial board with a zero-candidate cell', () {
      final contradictory = SudokuBoard.parse('''
012345678
900000000
000000000
000000000
000000000
000000000
000000000
000000000
000000000
''');

      expect(SudokuConstraints.validate(contradictory).isValid, isTrue);
      expect(
        const CandidateCalculator()
            .candidatesFor(contradictory, CellRef(row: 0, column: 0))
            .isEmpty,
        isTrue,
      );
      expect(solver.solve(contradictory), isNull);
      expect(solver.hasSolution(contradictory), isFalse);
      expect(solver.countSolutions(contradictory), 0);
      expect(solver.hasUniqueSolution(contradictory), isFalse);
    });

    test('finds a deeper contradiction without initial zero candidates', () {
      final contradictory = SudokuBoard.parse(standardPuzzle).withValue(
        CellRef(row: 0, column: 2),
        1,
      );

      expect(SudokuConstraints.validate(contradictory).isValid, isTrue);
      expect(
        const CandidateCalculator()
            .calculateAll(contradictory)
            .values
            .any((mask) => mask.isEmpty),
        isFalse,
      );
      expect(solver.solve(contradictory), isNull);
      expect(solver.hasSolution(contradictory), isFalse);
      expect(solver.countSolutions(contradictory), 0);
      expect(solver.hasUniqueSolution(contradictory), isFalse);
    });
  });
}
