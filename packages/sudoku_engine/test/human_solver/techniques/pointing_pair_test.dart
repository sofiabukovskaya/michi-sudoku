import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures.dart';

void main() {
  const technique = PointingPairTechnique();

  for (final (first, second, line, expectedTargets) in [
    (
      cell(0, 0),
      cell(0, 1),
      SudokuUnit.row(0),
      [for (var column = 3; column < 9; column++) cell(0, column)],
    ),
    (
      cell(0, 0),
      cell(1, 0),
      SudokuUnit.column(0),
      [for (var row = 3; row < 9; row++) cell(row, 0)],
    ),
  ]) {
    test('detects box pair aligned with $line', () {
      final state = _digitOnlyInBoxCells([first, second], 6);

      final matches = technique
          .find(state)
          .where(
            (deduction) =>
                deduction.evidence.first is UnitCandidateEvidence &&
                (deduction.evidence.first as UnitCandidateEvidence).unit ==
                    SudokuUnit.box(0) &&
                (deduction.evidence.first as UnitCandidateEvidence).digit == 6,
          );

      expect(matches, hasLength(1));
      final deduction = matches.single;
      expect(deduction.technique, SudokuTechnique.pointingPair);
      expect(deduction.focusCells, [first, second]);
      expect(deduction.evidence, [
        UnitCandidateEvidence(
          unit: SudokuUnit.box(0),
          digit: 6,
          candidateCells: [first, second],
        ),
        UnitEvidence(line),
      ]);
      expect(
        deduction.eliminations,
        [for (final target in expectedTargets) CandidateElimination(target, 6)],
      );
      expect(
        deduction.eliminations.every((move) => move.cell.box != 0),
        isTrue,
      );
    });
  }

  test('returns no deduction when no external candidate exists', () {
    final pair = [cell(0, 0), cell(0, 1)];
    final initial = _digitOnlyInBoxCells(pair, 6);
    final overrides = <CellRef, CandidateMask>{
      for (final target in SudokuUnit.row(0).cells.where(
        (item) => item.box != 0,
      ))
        target: initial.candidatesFor(target).remove(6),
    };
    final state = stateWithMasks({
      ...initial.candidates,
      ...overrides,
    });

    expect(technique.find(state), isEmpty);
  });

  test('three box candidates are not the Phase 4 pair form', () {
    final state = _digitOnlyInBoxCells(
      [cell(0, 0), cell(0, 1), cell(0, 2)],
      6,
    );

    expect(technique.find(state), isEmpty);
  });

  test('two box candidates in different rows and columns do not qualify', () {
    final state = _digitOnlyInBoxCells([cell(0, 0), cell(1, 1)], 6);

    expect(technique.find(state), isEmpty);
  });

  test('orders source boxes before digits', () {
    final first = _digitOnlyInBoxCells([cell(0, 0), cell(0, 1)], 6);
    final overrides = <CellRef, CandidateMask>{...first.candidates};
    final secondPair = [cell(0, 3), cell(0, 4)];
    for (final other in SudokuUnit.box(1).cells) {
      if (!secondPair.contains(other)) {
        overrides[other] = overrides[other]!.remove(7);
      }
    }
    final state = stateWithMasks(overrides);

    final deductions = technique.find(state);

    expect(
      (deductions[0].evidence.first as UnitCandidateEvidence).unit,
      SudokuUnit.box(0),
    );
    expect(
      (deductions[1].evidence.first as UnitCandidateEvidence).unit,
      SudokuUnit.box(1),
    );
  });
}

HumanSolverState _digitOnlyInBoxCells(List<CellRef> cells, int digit) =>
    stateWithMasks({
      for (final other in SudokuUnit.box(0).cells)
        if (!cells.contains(other)) other: CandidateMask.all.remove(digit),
    });
