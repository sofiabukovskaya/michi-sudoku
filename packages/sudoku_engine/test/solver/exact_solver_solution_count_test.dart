import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';

void main() {
  const solver = BacktrackingExactSolver();

  group('ExactSolver solution counting', () {
    test('a unique puzzle has exactly one solution', () {
      final board = SudokuBoard.parse(standardPuzzle);

      expect(solver.hasSolution(board), isTrue);
      expect(solver.countSolutions(board), 1);
      expect(solver.hasUniqueSolution(board), isTrue);
    });

    test('a four-cell rectangle has two solutions', () {
      final board = _twoSolutionBoard();

      expect(SudokuConstraints.validate(board).isValid, isTrue);
      expect(solver.hasSolution(board), isTrue);
      expect(solver.countSolutions(board, limit: 1), 1);
      expect(solver.countSolutions(board), 2);
      expect(solver.countSolutions(board, limit: 3), 2);
      expect(solver.hasUniqueSolution(board), isFalse);

      final first = solver.solve(board);
      expect(first, isNotNull);
      expect(first!.isComplete, isTrue);
      expect(SudokuConstraints.validate(first).isValid, isTrue);
      expect(solver.solve(board), first);
      expect(board.emptyCellCount, 4);
    });

    test('the empty board stops after the requested number of solutions', () {
      final board = SudokuBoard.empty();

      expect(solver.hasSolution(board), isTrue);
      expect(solver.countSolutions(board), 2);
      expect(solver.hasUniqueSolution(board), isFalse);
      final solution = solver.solve(board);
      expect(solution, isNotNull);
      expect(solution!.isComplete, isTrue);
      expect(SudokuConstraints.validate(solution).isValid, isTrue);
      expect(solver.solve(board), solution);
    });

    test('rejects nonpositive limits before searching', () {
      final board = SudokuBoard.empty();

      expect(() => solver.countSolutions(board, limit: 0), throwsArgumentError);
      expect(
        () => solver.countSolutions(board, limit: -1),
        throwsArgumentError,
      );
    });
  });
}

SudokuBoard _twoSolutionBoard() {
  var board = SudokuBoard.parse(solvedPuzzle);
  // Rows 3 and 4 have the exchangeable rectangle 1,3 / 3,1.
  for (final cell in [
    CellRef(row: 3, column: 5),
    CellRef(row: 3, column: 8),
    CellRef(row: 4, column: 5),
    CellRef(row: 4, column: 8),
  ]) {
    board = board.withValue(cell, 0);
  }
  return board;
}
