import '../model/sudoku_board.dart';
import 'deduction.dart';

/// Finds the next logical deduction in configured technique order.
abstract interface class HumanSolver {
  Deduction? nextDeduction(SudokuBoard board);
}
