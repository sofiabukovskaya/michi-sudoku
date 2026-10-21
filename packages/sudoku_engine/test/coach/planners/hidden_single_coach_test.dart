import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../../human_solver/fixtures.dart';
import '../fixtures.dart';

void main() {
  for (final (unit, target) in [
    (SudokuUnit.row(0), cell(0, 4)),
    (SudokuUnit.column(5), cell(4, 5)),
    (SudokuUnit.box(4), cell(4, 4)),
  ]) {
    test('Hidden Single in $unit reveals unit, positions, then placement', () {
      final deduction = hiddenSingleDeduction(unit, target);
      final plan = const StructuredCoachEngine().createPlan(deduction);

      expect(plan.length, 4);
      expect(plan.first.intent, CoachHintIntent.inspectUnit);
      expect(plan.first.focusUnits, [unit]);
      expect(plan.first.focusCells, isEmpty);
      expect(plan.first.candidateHighlights, isEmpty);
      expect(plan.hints[1].intent, CoachHintIntent.inspectCandidatePositions);
      expect(plan.hints[1].focusCells, [target]);
      expect(plan.hints[1].candidateHighlights, [CandidateRef(target, 7)]);
      expect(plan.hints[2].intent, CoachHintIntent.onlyPositionRemains);
      expect(plan.hints[2].evidence, deduction.evidence);
      expect(plan.last.intent, CoachHintIntent.revealPlacement);
      expect(plan.last.revealedPlacements, deduction.placements);
      for (final hint in plan.hints.take(3)) {
        expect(hint.revealedPlacements, isEmpty);
        expect(hint.revealedEliminations, isEmpty);
      }
    });
  }
}
