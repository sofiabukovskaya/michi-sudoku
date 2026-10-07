import '../model/sudoku_board.dart';

/// Rule validation contract. Implementation arrives with Sudoku core logic.
abstract interface class SudokuConstraints {
  bool isValid(SudokuBoard board);
}
