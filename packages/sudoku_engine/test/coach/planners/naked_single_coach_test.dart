import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../../human_solver/fixtures.dart';
import '../fixtures.dart';

void main() {
  test('Naked Single reveals the lone digit only at reasoning level', () {
    final deduction = nakedSingleDeduction();
    final plan = const StructuredCoachEngine().createPlan(deduction);
    final target = cell(4, 7);
    final highlights = [CandidateRef(target, 9)];

    expect(plan.hints.map((hint) => hint.level), CoachHintLevel.values);
    expect(plan.first.intent, CoachHintIntent.inspectCell);
    expect(plan.first.focusCells, [target]);
    expect(plan.first.candidateHighlights, isEmpty);
    expect(plan.hints[1].intent, CoachHintIntent.inspectCandidates);
    expect(plan.hints[1].candidateHighlights, isEmpty);
    expect(plan.hints[2].intent, CoachHintIntent.singleCandidateRemains);
    expect(plan.hints[2].candidateHighlights, highlights);
    expect(plan.hints[2].evidence, deduction.evidence);
    expect(plan.last.intent, CoachHintIntent.revealPlacement);
    expect(plan.last.revealedPlacements, deduction.placements);
    expect(plan.last.revealedEliminations, isEmpty);
    for (final hint in plan.hints) {
      expect(hint.focusCells, [target]);
      expect(hint.focusUnits, isEmpty);
    }
    for (final hint in plan.hints.take(3)) {
      expect(hint.revealedPlacements, isEmpty);
      expect(hint.revealedEliminations, isEmpty);
    }
  });
}
