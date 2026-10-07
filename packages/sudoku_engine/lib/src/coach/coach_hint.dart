import '../human_solver/deduction.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_move.dart';

enum CoachHintLevel { direction, focus, reasoning, solution }

/// One semantic reveal in a progressive hint plan.
final class CoachHint {
  CoachHint({
    required this.level,
    required List<CellRef> focusCells,
    required List<DeductionEvidence> evidence,
    required List<SudokuMove> moves,
  }) : focusCells = List.unmodifiable(focusCells),
       evidence = List.unmodifiable(evidence),
       moves = List.unmodifiable(moves);

  final CoachHintLevel level;
  final List<CellRef> focusCells;
  final List<DeductionEvidence> evidence;
  final List<SudokuMove> moves;
}
