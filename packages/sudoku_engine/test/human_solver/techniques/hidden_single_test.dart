import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures.dart';

void main() {
  const technique = HiddenSingleTechnique();

  for (final (unit, target) in [
    (SudokuUnit.row(2), cell(2, 5)),
    (SudokuUnit.column(4), cell(6, 4)),
    (SudokuUnit.box(4), cell(4, 4)),
  ]) {
    test('detects a hidden single in $unit', () {
      final state = _onlyPosition(unit, target, 7);

      final matches = technique
          .find(state)
          .where(
            (deduction) =>
                deduction.placements.single == DigitPlacement(target, 7),
          );

      expect(matches, hasLength(1));
      final deduction = matches.single;
      expect(deduction.technique, SudokuTechnique.hiddenSingle);
      expect(deduction.focusCells, [target]);
      expect(deduction.evidence, [
        UnitCandidateEvidence(
          unit: unit,
          digit: 7,
          candidateCells: [target],
        ),
      ]);
      expect(state.board.valueAt(target), 0);
    });
  }

  test('returns row deductions in unit and digit order', () {
    final overrides = <CellRef, CandidateMask>{};
    for (final other in SudokuUnit.row(
      0,
    ).cells.where((item) => item != cell(0, 0))) {
      overrides[other] = CandidateMask.all.remove(9);
    }
    for (final other in SudokuUnit.row(
      1,
    ).cells.where((item) => item != cell(1, 0))) {
      overrides[other] = (overrides[other] ?? CandidateMask.all).remove(8);
    }
    final state = stateWithMasks(overrides);

    final firstTwo = technique.find(state).take(2).toList();

    expect(firstTwo.map((deduction) => deduction.placements.single), [
      DigitPlacement(cell(0, 0), 9),
      DigitPlacement(cell(1, 0), 8),
    ]);
  });

  test('deduplicates a placement found in row, column, and box', () {
    final target = cell(0, 0);
    final affected = <CellRef>{
      ...SudokuUnit.row(0).cells,
      ...SudokuUnit.column(0).cells,
      ...SudokuUnit.box(0).cells,
    }..remove(target);
    final state = stateWithMasks({
      for (final other in affected) other: CandidateMask.all.remove(7),
    });

    final matches = technique
        .find(state)
        .where(
          (deduction) =>
              deduction.placements.single == DigitPlacement(target, 7),
        );

    expect(matches, hasLength(1));
    expect(
      (matches.single.evidence.single as UnitCandidateEvidence).unit,
      SudokuUnit.row(0),
    );
  });

  test('returns no hidden single on an empty board', () {
    expect(
      technique.find(HumanSolverState.initial(SudokuBoard.empty())),
      isEmpty,
    );
  });
}

HumanSolverState _onlyPosition(SudokuUnit unit, CellRef target, int digit) =>
    stateWithMasks({
      for (final other in unit.cells)
        if (other != target) other: CandidateMask.all.remove(digit),
    });
