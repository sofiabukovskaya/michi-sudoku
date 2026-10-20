import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures.dart';

void main() {
  const technique = NakedPairTechnique();

  for (final (unit, first, second) in [
    (SudokuUnit.row(0), cell(0, 0), cell(0, 4)),
    (SudokuUnit.column(0), cell(0, 0), cell(4, 0)),
    (SudokuUnit.box(0), cell(0, 0), cell(1, 1)),
  ]) {
    test('finds a pair in $unit and eliminates from other unit cells', () {
      final state = stateWithMasks({
        first: mask([2, 7]),
        second: mask([2, 7]),
      });

      final matches = technique
          .find(state)
          .where(
            (deduction) => deduction.evidence.first == UnitEvidence(unit),
          );

      expect(matches, hasLength(1));
      final deduction = matches.single;
      expect(deduction.technique, SudokuTechnique.nakedPair);
      expect(deduction.focusCells, [first, second]);
      expect(deduction.evidence, [
        UnitEvidence(unit),
        CandidateSetEvidence(first, mask([2, 7])),
        CandidateSetEvidence(second, mask([2, 7])),
      ]);
      expect(deduction.placements, isEmpty);
      expect(deduction.eliminations.length, 14);
      for (final other in unit.cells.where(
        (item) => item != first && item != second,
      )) {
        expect(
          deduction.eliminations,
          containsAll([
            CandidateElimination(other, 2),
            CandidateElimination(other, 7),
          ]),
        );
      }
      expect(state.candidatesFor(first), mask([2, 7]));
    });
  }

  test('does not return a pair when no external candidate can be removed', () {
    final pair = [cell(0, 0), cell(0, 1)];
    final affected = <CellRef>{
      ...SudokuUnit.row(0).cells,
      ...SudokuUnit.box(0).cells,
    }..removeAll(pair);
    final state = stateWithMasks({
      pair[0]: mask([2, 7]),
      pair[1]: mask([2, 7]),
      for (final other in affected)
        other: CandidateMask.all.remove(2).remove(7),
    });

    expect(technique.find(state), isEmpty);
  });

  test('three identical two-candidate cells are not a pair', () {
    final state = stateWithMasks({
      cell(0, 0): mask([2, 7]),
      cell(0, 1): mask([2, 7]),
      cell(0, 2): mask([2, 7]),
    });

    expect(technique.find(state), isEmpty);
  });

  test('different two-digit masks do not make a pair', () {
    final state = stateWithMasks({
      cell(0, 0): mask([2, 7]),
      cell(0, 1): mask([2, 8]),
    });

    expect(technique.find(state), isEmpty);
  });

  test('orders multiple pair deductions by row, column, then box', () {
    final state = stateWithMasks({
      cell(0, 0): mask([2, 7]),
      cell(0, 4): mask([2, 7]),
      cell(1, 8): mask([3, 9]),
      cell(4, 8): mask([3, 9]),
    });

    final deductions = technique.find(state);

    expect(
      (deductions[0].evidence.first as UnitEvidence).unit,
      SudokuUnit.row(0),
    );
    expect(
      deductions.any(
        (deduction) =>
            deduction.evidence.first == UnitEvidence(SudokuUnit.column(8)),
      ),
      isTrue,
    );
  });
}
