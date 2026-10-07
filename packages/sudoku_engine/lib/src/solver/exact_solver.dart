import '../model/sudoku_board.dart';

/// Mathematical solving and uniqueness checks; never used to invent hints.
abstract interface class ExactSolver {
  SudokuBoard? solve(SudokuBoard board);

  /// Counts up to [limit] solutions so uniqueness checks can stop at two.
  int countSolutions(SudokuBoard board, {int limit = 2});
}
