import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../../human_solver/fixtures.dart';
import '../fixtures.dart';

void main() {
  for (final (unit, first, second) in [
    (SudokuUnit.row(0), cell(0, 0), cell(0, 1)),
    (SudokuUnit.column(0), cell(0, 0), cell(1, 0)),
    (SudokuUnit.box(4), cell(3, 3), cell(4, 4)),
  ]) {
    test('Naked Pair in $unit discloses the pair before eliminations', () {
      final deduction = nakedPairDeduction(unit, first, second);
      final plan = const StructuredCoachEngine().createPlan(deduction);

      expect(plan.length, 4);
      expect(plan.first.intent, CoachHintIntent.inspectUnit);
      expect(plan.first.focusUnits, [unit]);
      expect(plan.first.focusCells, isEmpty);
      expect(
        plan.hints[1].intent,
        CoachHintIntent.identifyMatchingCandidatePair,
      );
      expect(plan.hints[1].focusCells, deduction.focusCells);
      expect(plan.hints[1].candidateHighlights, [
        CandidateRef(first, 2),
        CandidateRef(first, 7),
        CandidateRef(second, 2),
        CandidateRef(second, 7),
      ]);
      expect(plan.hints[2].intent, CoachHintIntent.understandPairRestriction);
      expect(plan.hints[2].evidence, deduction.evidence);
      expect(plan.last.intent, CoachHintIntent.revealEliminations);
      expect(plan.last.revealedEliminations, deduction.eliminations);
      expect(plan.last.revealedPlacements, isEmpty);
      for (final elimination in plan.last.revealedEliminations) {
        expect(unit.cells, contains(elimination.cell));
        expect(deduction.focusCells, isNot(contains(elimination.cell)));
      }
      for (final hint in plan.hints.take(3)) {
        expect(hint.revealedEliminations, isEmpty);
        expect(hint.revealedPlacements, isEmpty);
      }
    });
  }
}
