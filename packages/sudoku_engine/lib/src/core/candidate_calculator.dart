import '../model/candidate_mask.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_board.dart';
import 'sudoku_constraints.dart';

/// Derives legal candidates from board values; no candidate state is stored.
final class CandidateCalculator {
  const CandidateCalculator();

  /// Filled cells have no candidates. Contradictory empty cells may have none.
  CandidateMask candidatesFor(SudokuBoard board, CellRef cell) {
    if (board.isFilled(cell)) return CandidateMask.empty;
    final used = SudokuConstraints.usedInRow(board, cell.row)
        .union(SudokuConstraints.usedInColumn(board, cell.column))
        .union(SudokuConstraints.usedInBox(board, cell.box));
    return CandidateMask.all.difference(used);
  }

  /// Immutable candidate map for every empty cell, in flat board order.
  Map<CellRef, CandidateMask> calculateAll(SudokuBoard board) {
    final candidates = <CellRef, CandidateMask>{};
    for (var index = 0; index < 81; index++) {
      final cell = CellRef.fromIndex(index);
      if (board.isEmpty(cell)) {
        candidates[cell] = candidatesFor(board, cell);
      }
    }
    return Map<CellRef, CandidateMask>.unmodifiable(candidates);
  }
}
