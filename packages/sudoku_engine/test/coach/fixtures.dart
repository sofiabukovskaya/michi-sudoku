import 'package:sudoku_engine/sudoku_engine.dart';

import '../human_solver/fixtures.dart';

Deduction nakedSingleDeduction() {
  final target = cell(4, 7);
  final state = stateWithMasks({
    target: mask([9]),
  });
  return const NakedSingleTechnique().find(state).single;
}

Deduction hiddenSingleDeduction(SudokuUnit unit, CellRef target) {
  const digit = 7;
  final state = stateWithMasks({
    for (final other in unit.cells)
      if (other != target) other: CandidateMask.all.remove(digit),
  });
  return const HiddenSingleTechnique().find(state).firstWhere((deduction) {
    final evidence = deduction.evidence.single as UnitCandidateEvidence;
    return evidence.unit == unit &&
        evidence.digit == digit &&
        deduction.placements.single.cell == target;
  });
}

Deduction nakedPairDeduction(
  SudokuUnit unit,
  CellRef first,
  CellRef second,
) {
  final state = stateWithMasks({
    first: mask([2, 7]),
    second: mask([2, 7]),
  });
  return const NakedPairTechnique().find(state).firstWhere((deduction) {
    final source = deduction.evidence.whereType<UnitEvidence>().single.unit;
    return source == unit &&
        deduction.focusCells.contains(first) &&
        deduction.focusCells.contains(second);
  });
}

Deduction pointingPairDeduction(CellRef first, CellRef second) {
  const digit = 6;
  final sourceBox = SudokuUnit.box(first.box);
  final state = stateWithMasks({
    for (final other in sourceBox.cells)
      if (other != first && other != second)
        other: CandidateMask.all.remove(digit),
  });
  return const PointingPairTechnique().find(state).firstWhere((deduction) {
    final source = deduction.evidence.whereType<UnitCandidateEvidence>().single;
    return source.unit == sourceBox &&
        source.digit == digit &&
        deduction.focusCells.contains(first) &&
        deduction.focusCells.contains(second);
  });
}
