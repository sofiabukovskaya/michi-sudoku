import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  group('semantic moves', () {
    test('have value equality and useful debugging text', () {
      final placement = DigitPlacement(cell(2, 3), 7);
      final samePlacement = DigitPlacement(cell(2, 3), 7);
      final elimination = CandidateElimination(cell(2, 3), 7);
      expect(placement, samePlacement);
      expect(placement.hashCode, samePlacement.hashCode);
      expect(placement, isNot(elimination));
      expect(placement.toString(), contains('DigitPlacement'));
      expect(elimination.toString(), contains('CandidateElimination'));
      expect(() => DigitPlacement(cell(0, 0), 0), throwsRangeError);
      expect(() => CandidateElimination(cell(0, 0), 10), throwsRangeError);
    });
  });

  group('Deduction', () {
    test('stores immutable, sorted focus and action collections', () {
      final focus = [cell(0, 4), cell(0, 1)];
      final eliminations = [
        CandidateElimination(cell(0, 4), 7),
        CandidateElimination(cell(0, 4), 2),
      ];
      final evidence = <DeductionEvidence>[
        UnitEvidence(SudokuUnit.row(0)),
      ];
      final deduction = Deduction(
        technique: SudokuTechnique.nakedPair,
        focusCells: focus,
        evidence: evidence,
        eliminations: eliminations,
        placements: const [],
      );
      focus.clear();
      eliminations.clear();
      evidence.clear();

      expect(deduction.focusCells, [cell(0, 1), cell(0, 4)]);
      expect(deduction.eliminations, [
        CandidateElimination(cell(0, 4), 2),
        CandidateElimination(cell(0, 4), 7),
      ]);
      expect(deduction.evidence, hasLength(1));
      expect(deduction.focusCells.clear, throwsUnsupportedError);
      expect(deduction.eliminations.clear, throwsUnsupportedError);
      expect(deduction.evidence.clear, throwsUnsupportedError);
    });

    test('requires focus, evidence and at least one action', () {
      final evidence = [UnitEvidence(SudokuUnit.row(0))];
      expect(
        () => Deduction(
          technique: SudokuTechnique.nakedPair,
          focusCells: [cell(0, 0)],
          evidence: evidence,
          eliminations: const [],
          placements: const [],
        ),
        throwsArgumentError,
      );
      expect(
        () => Deduction(
          technique: SudokuTechnique.nakedSingle,
          focusCells: const [],
          evidence: evidence,
          eliminations: const [],
          placements: [DigitPlacement(cell(0, 0), 1)],
        ),
        throwsArgumentError,
      );
      expect(
        () => Deduction(
          technique: SudokuTechnique.nakedSingle,
          focusCells: [cell(0, 0)],
          evidence: const [],
          eliminations: const [],
          placements: [DigitPlacement(cell(0, 0), 1)],
        ),
        throwsArgumentError,
      );
    });

    test('rejects duplicate actions and multiple placements at one cell', () {
      final evidence = [UnitEvidence(SudokuUnit.row(0))];
      expect(
        () => Deduction(
          technique: SudokuTechnique.nakedPair,
          focusCells: [cell(0, 0)],
          evidence: evidence,
          eliminations: [
            CandidateElimination(cell(0, 0), 1),
            CandidateElimination(cell(0, 0), 1),
          ],
          placements: const [],
        ),
        throwsArgumentError,
      );
      expect(
        () => Deduction(
          technique: SudokuTechnique.hiddenSingle,
          focusCells: [cell(0, 0)],
          evidence: evidence,
          eliminations: const [],
          placements: [
            DigitPlacement(cell(0, 0), 1),
            DigitPlacement(cell(0, 0), 2),
          ],
        ),
        throwsArgumentError,
      );
    });

    test('evidence is structured, validated, and compares by value', () {
      final first = UnitCandidateEvidence(
        unit: SudokuUnit.box(0),
        digit: 7,
        candidateCells: [cell(1, 1), cell(0, 1)],
      );
      final second = UnitCandidateEvidence(
        unit: SudokuUnit.box(0),
        digit: 7,
        candidateCells: [cell(0, 1), cell(1, 1)],
      );
      expect(first, second);
      expect(first.hashCode, second.hashCode);
      expect(first.candidateCells, [cell(0, 1), cell(1, 1)]);
      expect(
        CandidateSetEvidence(cell(0, 0), mask([1, 2])),
        CandidateSetEvidence(cell(0, 0), mask([2, 1])),
      );
      expect(UnitEvidence(SudokuUnit.row(0)), UnitEvidence(SudokuUnit.row(0)));
      expect(
        () => UnitCandidateEvidence(
          unit: SudokuUnit.box(0),
          digit: 7,
          candidateCells: [cell(4, 4)],
        ),
        throwsArgumentError,
      );
    });
  });
}
