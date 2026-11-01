import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';
import '../human_solver/fixtures.dart';

void main() {
  const solver = DeterministicHumanSolver();
  const why = StructuredWhyEngine();

  test('targeted search finds a later Naked Single without solving ahead', () {
    final state = stateWithMasks({
      cell(0, 0): mask([1]),
      cell(0, 1): mask([2]),
    });
    final target = DigitPlacement(cell(0, 1), 2);
    expect(solver.findNextDeduction(state)!.placements.single.cell, cell(0, 0));
    final deduction = solver.findDeductionForPlacement(state, target);
    expect(deduction!.placements, [target]);
    expect(deduction.technique, SudokuTechnique.nakedSingle);
    expect(solver.findDeductionForPlacement(state, target), deduction);
    expect(state.board, SudokuBoard.empty());
  });

  test('targeted search finds a Hidden Single and rejects wrong targets', () {
    final state = stateWithMasks({
      for (var column = 1; column < 9; column++)
        cell(0, column): CandidateMask.all.remove(7),
    });
    final target = DigitPlacement(cell(0, 0), 7);
    final deduction = solver.findDeductionForPlacement(state, target);
    expect(deduction?.technique, SudokuTechnique.hiddenSingle);
    expect(
      solver.findDeductionForPlacement(
        state,
        DigitPlacement(cell(0, 0), 8),
      ),
      isNull,
    );
    expect(
      solver.findDeductionForPlacement(
        HumanSolverState.initial(SudokuBoard.empty()),
        target,
      ),
      isNull,
    );
  });

  test('filled target cannot receive a retrospective direct deduction', () {
    final board = SudokuBoard.empty().withValue(cell(0, 0), 7);
    expect(
      solver.findDeductionForPlacement(
        HumanSolverState.initial(board),
        DigitPlacement(cell(0, 0), 7),
      ),
      isNull,
    );
  });

  test('Naked Single plan has only evidence-backed unit and target facts', () {
    final state = HumanSolverState.initial(SudokuBoard.parse(standardPuzzle));
    final deduction = solver.findNextDeduction(state)!;
    final target = deduction.placements.single;
    final plan = why.createPlan(deduction, target)!;
    expect(plan.technique, SudokuTechnique.nakedSingle);
    expect(plan.steps.map((step) => step.number), [1, 2, 3, 4]);
    expect(
      plan.steps.map((step) => step.kind),
      [
        WhyStepKind.unitRestrictions,
        WhyStepKind.unitRestrictions,
        WhyStepKind.unitRestrictions,
        WhyStepKind.onlyCandidate,
      ],
    );
    expect(plan.steps.last.markerCells, [target.cell]);
    for (final step in plan.steps.take(3)) {
      expect(
        step.filledCells.every(
          (move) => state.board.valueAt(move.cell) == move.digit,
        ),
        isTrue,
      );
    }
    expect(why.createPlan(deduction, target)!.steps.last.digit, target.digit);
  });

  test('Hidden Single plan uses the exact unit candidate evidence', () {
    final state = stateWithMasks({
      for (var column = 1; column < 9; column++)
        cell(0, column): CandidateMask.all.remove(7),
    });
    final target = DigitPlacement(cell(0, 0), 7);
    final deduction = solver.findDeductionForPlacement(state, target)!;
    final plan = why.createPlan(deduction, target)!;
    expect(plan.steps.map((step) => step.number), [1, 2, 3]);
    expect(plan.steps[0].unit, SudokuUnit.row(0));
    expect(plan.steps[1].markerCells, isNot(contains(target.cell)));
    expect(plan.steps.last.markerCells, [target.cell]);
    expect(plan.steps.last.kind, WhyStepKind.placement);
    expect(plan.steps.last.digit, 7);
  });

  test(
    'malformed supported evidence fails and unsupported technique is null',
    () {
      final target = DigitPlacement(cell(0, 0), 1);
      final malformed = Deduction(
        technique: SudokuTechnique.nakedSingle,
        focusCells: [target.cell],
        evidence: [
          CandidateSetEvidence(target.cell, mask([1])),
        ],
        eliminations: const [],
        placements: [target],
      );
      expect(() => why.createPlan(malformed, target), throwsStateError);
      final unsupported = Deduction(
        technique: SudokuTechnique.nakedPair,
        focusCells: [target.cell],
        evidence: [
          CandidateSetEvidence(target.cell, mask([1])),
        ],
        eliminations: const [],
        placements: [target],
      );
      expect(why.createPlan(unsupported, target), isNull);
      expect(
        () => why.createPlan(
          malformed,
          DigitPlacement(cell(0, 1), 1),
        ),
        throwsStateError,
      );
    },
  );
}
