import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../human_solver/fixtures.dart';
import 'fixtures.dart';

void main() {
  const engine = StructuredCoachEngine();

  group('malformed supported deductions', () {
    test('Naked Single without a placement fails explicitly', () {
      final target = cell(0, 0);
      final deduction = Deduction(
        technique: SudokuTechnique.nakedSingle,
        focusCells: [target],
        evidence: [
          CandidateSetEvidence(target, mask([1])),
        ],
        eliminations: [CandidateElimination(cell(0, 1), 1)],
        placements: const [],
      );

      expect(() => engine.createPlan(deduction), throwsStateError);
    });

    test('Hidden Single without unit candidate evidence fails', () {
      final target = cell(0, 0);
      final deduction = Deduction(
        technique: SudokuTechnique.hiddenSingle,
        focusCells: [target],
        evidence: [
          CandidateSetEvidence(target, mask([7])),
        ],
        eliminations: const [],
        placements: [DigitPlacement(target, 7)],
      );

      expect(() => engine.createPlan(deduction), throwsStateError);
    });

    test('Naked Pair with only one pattern cell fails', () {
      final target = cell(0, 0);
      final deduction = Deduction(
        technique: SudokuTechnique.nakedPair,
        focusCells: [target],
        evidence: [
          UnitEvidence(SudokuUnit.row(0)),
          CandidateSetEvidence(target, mask([2, 7])),
        ],
        eliminations: [CandidateElimination(cell(0, 2), 2)],
        placements: const [],
      );

      expect(() => engine.createPlan(deduction), throwsStateError);
    });

    test('Pointing Pair without alignment evidence fails', () {
      final first = cell(0, 0);
      final second = cell(0, 1);
      final deduction = Deduction(
        technique: SudokuTechnique.pointingPair,
        focusCells: [first, second],
        evidence: [
          UnitCandidateEvidence(
            unit: SudokuUnit.box(0),
            digit: 6,
            candidateCells: [first, second],
          ),
        ],
        eliminations: [CandidateElimination(cell(0, 3), 6)],
        placements: const [],
      );

      expect(() => engine.createPlan(deduction), throwsStateError);
    });

    test('inconsistent Pointing Pair target fails', () {
      final source = pointingPairDeduction(cell(0, 0), cell(0, 1));
      final deduction = Deduction(
        technique: source.technique,
        focusCells: source.focusCells,
        evidence: source.evidence,
        eliminations: [CandidateElimination(cell(3, 0), 6)],
        placements: const [],
      );

      expect(() => engine.createPlan(deduction), throwsStateError);
    });
  });

  test('unsupported future technique fails instead of a generic hint', () {
    final deduction = Deduction(
      technique: SudokuTechnique.hiddenPair,
      focusCells: [cell(0, 0)],
      evidence: [UnitEvidence(SudokuUnit.row(0))],
      eliminations: [CandidateElimination(cell(0, 1), 2)],
      placements: const [],
    );

    expect(() => engine.createPlan(deduction), throwsUnsupportedError);
  });

  test('result preserves both action kinds when supplied together', () {
    final source = hiddenSingleDeduction(SudokuUnit.row(0), cell(0, 0));
    final mixed = Deduction(
      technique: source.technique,
      focusCells: source.focusCells,
      evidence: source.evidence,
      eliminations: [CandidateElimination(cell(0, 1), 2)],
      placements: source.placements,
    );
    final plan = engine.createPlan(mixed);

    expect(plan.last.intent, CoachHintIntent.revealActions);
    expect(plan.last.revealedPlacements, mixed.placements);
    expect(plan.last.revealedEliminations, mixed.eliminations);
    for (final hint in plan.hints.take(3)) {
      expect(hint.revealedPlacements, isEmpty);
      expect(hint.revealedEliminations, isEmpty);
    }
  });
}
