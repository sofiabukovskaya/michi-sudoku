import '../core/sudoku_unit.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_move.dart';
import 'sudoku_technique.dart';

/// A machine-verifiable reason for a human-solvable move.
final class Deduction {
  Deduction({
    required this.technique,
    required List<CellRef> focusCells,
    required List<DeductionEvidence> evidence,
    required List<CandidateElimination> eliminations,
    required List<DigitPlacement> placements,
  }) : focusCells = List.unmodifiable(focusCells),
       evidence = List.unmodifiable(evidence),
       eliminations = List.unmodifiable(eliminations),
       placements = List.unmodifiable(placements);

  final SudokuTechnique technique;
  final List<CellRef> focusCells;
  final List<DeductionEvidence> evidence;
  final List<CandidateElimination> eliminations;
  final List<DigitPlacement> placements;
}

/// Structured support for a deduction, with no localized explanation text.
final class DeductionEvidence {
  DeductionEvidence({
    required this.unit,
    required this.digit,
    required List<CellRef> cells,
  }) : cells = List.unmodifiable(cells);

  final SudokuUnit unit;
  final int digit;
  final List<CellRef> cells;
}
