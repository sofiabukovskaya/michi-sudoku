import 'package:meta/meta.dart';

import '../core/sudoku_unit.dart';
import '../human_solver/sudoku_technique.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_move.dart';

enum WhyStepKind {
  unitRestrictions,
  onlyCandidate,
  unitSearch,
  solePosition,
  placement,
}

/// One numbered fact, copied exclusively from structured deduction evidence.
@immutable
final class WhyStep {
  WhyStep({
    required this.number,
    required this.kind,
    required this.digit,
    required List<CellRef> markerCells,
    this.unit,
    List<DigitPlacement> filledCells = const [],
  }) : markerCells = List<CellRef>.unmodifiable(markerCells),
       filledCells = List<DigitPlacement>.unmodifiable(filledCells);

  final int number;
  final WhyStepKind kind;
  final int digit;
  final SudokuUnit? unit;
  final List<CellRef> markerCells;
  final List<DigitPlacement> filledCells;
}

/// UI-independent retrospective proof for one already justified placement.
@immutable
final class WhyPlan {
  WhyPlan({
    required this.technique,
    required this.target,
    required List<WhyStep> steps,
  }) : steps = List<WhyStep>.unmodifiable(steps);

  final SudokuTechnique technique;
  final DigitPlacement target;
  final List<WhyStep> steps;
}
