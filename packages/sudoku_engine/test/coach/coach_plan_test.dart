import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../human_solver/fixtures.dart';
import 'fixtures.dart';

void main() {
  const engine = StructuredCoachEngine();

  test('CandidateRef is a validated immutable value object', () {
    final first = CandidateRef(cell(2, 3), 7);
    final equal = CandidateRef(cell(2, 3), 7);

    expect(first, equal);
    expect(first.hashCode, equal.hashCode);
    expect(first.toString(), contains('CandidateRef'));
    expect(() => CandidateRef(cell(0, 0), 0), throwsRangeError);
    expect(() => CandidateRef(cell(0, 0), 10), throwsRangeError);
  });

  test('CoachHint sorts and protects its semantic collections', () {
    final cells = [cell(4, 4), cell(0, 0)];
    final units = [SudokuUnit.box(4), SudokuUnit.row(0)];
    final candidates = [
      CandidateRef(cell(4, 4), 7),
      CandidateRef(cell(0, 0), 9),
      CandidateRef(cell(4, 4), 2),
    ];
    final hint = CoachHint(
      level: CoachHintLevel.focus,
      intent: CoachHintIntent.inspectCandidates,
      focusCells: cells,
      focusUnits: units,
      candidateHighlights: candidates,
    );
    cells.clear();
    units.clear();
    candidates.clear();

    expect(hint.focusCells, [cell(0, 0), cell(4, 4)]);
    expect(hint.focusUnits, [SudokuUnit.row(0), SudokuUnit.box(4)]);
    expect(hint.candidateHighlights, [
      CandidateRef(cell(0, 0), 9),
      CandidateRef(cell(4, 4), 2),
      CandidateRef(cell(4, 4), 7),
    ]);
    expect(hint.focusCells.clear, throwsUnsupportedError);
    expect(hint.focusUnits.clear, throwsUnsupportedError);
    expect(hint.candidateHighlights.clear, throwsUnsupportedError);
    expect(
      hint,
      CoachHint(
        level: CoachHintLevel.focus,
        intent: CoachHintIntent.inspectCandidates,
        focusCells: [cell(0, 0), cell(4, 4)],
        focusUnits: [SudokuUnit.box(4), SudokuUnit.row(0)],
        candidateHighlights: [
          CandidateRef(cell(4, 4), 2),
          CandidateRef(cell(0, 0), 9),
          CandidateRef(cell(4, 4), 7),
        ],
      ),
    );
  });

  test('only the result level may contain an action', () {
    final placement = DigitPlacement(cell(0, 0), 1);
    expect(
      () => CoachHint(
        level: CoachHintLevel.focus,
        intent: CoachHintIntent.inspectCandidates,
        revealedPlacements: [placement],
      ),
      throwsArgumentError,
    );
    expect(
      () => CoachHint(
        level: CoachHintLevel.result,
        intent: CoachHintIntent.revealPlacement,
      ),
      throwsArgumentError,
    );
  });

  test('CoachPlan is ordered, immutable, and tied to one deduction', () {
    final deduction = nakedSingleDeduction();
    final plan = engine.createPlan(deduction);
    final samePlan = engine.createPlan(deduction);

    expect(plan.technique, SudokuTechnique.nakedSingle);
    expect(plan.deduction, deduction);
    expect(plan.length, 4);
    expect(plan.first, plan.hintForLevel(CoachHintLevel.direction));
    expect(plan.last, plan.hintForLevel(CoachHintLevel.result));
    expect(plan.hints.map((hint) => hint.level), CoachHintLevel.values);
    expect(plan.hints.clear, throwsUnsupportedError);
    expect(plan, samePlan);
    expect(plan.hashCode, samePlan.hashCode);
  });

  test('CoachPlan rejects missing, reordered, or changed result hints', () {
    final deduction = nakedSingleDeduction();
    final hints = engine.createPlan(deduction).hints;
    expect(
      () => CoachPlan(deduction: deduction, hints: hints.take(3).toList()),
      throwsArgumentError,
    );
    expect(
      () => CoachPlan(
        deduction: deduction,
        hints: [hints[1], hints[0], hints[2], hints[3]],
      ),
      throwsArgumentError,
    );
    expect(
      () => CoachPlan(
        deduction: deduction,
        hints: [
          ...hints.take(3),
          CoachHint(
            level: CoachHintLevel.result,
            intent: CoachHintIntent.revealPlacement,
            revealedPlacements: [DigitPlacement(cell(0, 0), 1)],
          ),
        ],
      ),
      throwsArgumentError,
    );
  });
}
