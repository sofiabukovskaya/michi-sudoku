import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures.dart';

void main() {
  const technique = NakedSingleTechnique();

  test('detects a single with candidate evidence and placement', () {
    final state = stateWithMasks({
      cell(4, 6): mask([9]),
    });

    final deductions = technique.find(state);

    expect(deductions, hasLength(1));
    final deduction = deductions.single;
    expect(deduction.technique, SudokuTechnique.nakedSingle);
    expect(deduction.focusCells, [cell(4, 6)]);
    expect(deduction.evidence, [
      CandidateSetEvidence(cell(4, 6), mask([9])),
    ]);
    expect(deduction.placements, [DigitPlacement(cell(4, 6), 9)]);
    expect(deduction.eliminations, isEmpty);
    expect(state.board.valueAt(cell(4, 6)), 0);
  });

  test('returns multiple singles in ascending cell order', () {
    final state = stateWithMasks({
      cell(8, 8): mask([4]),
      cell(0, 2): mask([1]),
    });

    expect(
      technique.find(state).map((deduction) => deduction.placements.single),
      [DigitPlacement(cell(0, 2), 1), DigitPlacement(cell(8, 8), 4)],
    );
  });

  test('ignores cells with multiple candidates', () {
    final state = stateWithMasks({
      cell(4, 6): mask([2, 9]),
    });

    expect(technique.find(state), isEmpty);
  });
}
