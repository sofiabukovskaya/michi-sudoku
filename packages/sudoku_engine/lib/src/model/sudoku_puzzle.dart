import 'sudoku_board.dart';

/// A published puzzle and its givens. Solution metadata can be added later.
final class SudokuPuzzle {
  const SudokuPuzzle({required this.id, required this.givens});

  final String id;
  final SudokuBoard givens;
}
