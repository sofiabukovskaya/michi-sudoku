import '../model/candidate_mask.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_board.dart';

/// Calculates legal candidates without depending on UI notes.
abstract interface class CandidateCalculator {
  CandidateMask candidatesFor(SudokuBoard board, CellRef cell);
}
