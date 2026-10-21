import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../../human_solver/fixtures.dart';
import '../fixtures.dart';

void main() {
  for (final (first, second, line) in [
    (cell(0, 0), cell(0, 1), SudokuUnit.row(0)),
    (cell(0, 0), cell(1, 0), SudokuUnit.column(0)),
  ]) {
    test('Pointing Pair along $line reveals alignment before eliminations', () {
      final deduction = pointingPairDeduction(first, second);
      final plan = const StructuredCoachEngine().createPlan(deduction);
      final box = SudokuUnit.box(0);

      expect(plan.length, 4);
      expect(plan.first.intent, CoachHintIntent.inspectUnit);
      expect(plan.first.focusUnits, [box]);
      expect(plan.first.focusCells, isEmpty);
      expect(plan.hints[1].intent, CoachHintIntent.inspectCandidatePositions);
      expect(plan.hints[1].focusCells, deduction.focusCells);
      expect(plan.hints[1].candidateHighlights, [
        CandidateRef(first, 6),
        CandidateRef(second, 6),
      ]);
      expect(plan.hints[2].intent, CoachHintIntent.understandAlignment);
      expect(plan.hints[2].focusUnits, containsAll([box, line]));
      expect(plan.hints[2].evidence, deduction.evidence);
      expect(plan.last.intent, CoachHintIntent.revealEliminations);
      expect(plan.last.revealedEliminations, deduction.eliminations);
      expect(plan.last.revealedPlacements, isEmpty);
      for (final elimination in plan.last.revealedEliminations) {
        expect(line.cells, contains(elimination.cell));
        expect(box.cells, isNot(contains(elimination.cell)));
      }
      for (final hint in plan.hints.take(3)) {
        expect(hint.revealedEliminations, isEmpty);
        expect(hint.revealedPlacements, isEmpty);
      }
    });
  }
}
