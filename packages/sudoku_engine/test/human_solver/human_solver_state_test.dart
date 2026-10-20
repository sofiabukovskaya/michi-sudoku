import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';
import 'fixtures.dart';

void main() {
  group('HumanSolverState', () {
    test('initializes legal candidates and hides filled-cell candidates', () {
      final board = SudokuBoard.parse(standardPuzzle);
      final state = HumanSolverState.initial(board);

      expect(state.board, board);
      expect(state.candidatesFor(cell(0, 2)).digits, orderedEquals([1, 2, 4]));
      expect(state.candidatesFor(cell(0, 0)), CandidateMask.empty);
      expect(state.candidates.length, board.emptyCellCount);
      expect(state.emptyCells.first, cell(0, 2));
      expect(state.hasContradiction, isFalse);
      expect(state.isSolved, isFalse);
      expect(
        () => state.candidates[cell(0, 2)] = CandidateMask.empty,
        throwsUnsupportedError,
      );
    });

    test('solved board reports solved without a contradiction', () {
      final state = HumanSolverState.initial(SudokuBoard.parse(solvedPuzzle));

      expect(state.candidates, isEmpty);
      expect(state.isSolved, isTrue);
      expect(state.hasContradiction, isFalse);
    });

    test('invalid board and zero-candidate cell report contradiction', () {
      final duplicate = SudokuBoard.empty()
          .withValue(cell(0, 0), 5)
          .withValue(cell(0, 1), 5);
      expect(HumanSolverState.initial(duplicate).hasContradiction, isTrue);

      final zeroCandidate = SudokuBoard.parse('''
012345678
900000000
000000000
000000000
000000000
000000000
000000000
000000000
000000000
''');
      expect(SudokuConstraints.validate(zeroCandidate).isValid, isTrue);
      expect(HumanSolverState.initial(zeroCandidate).hasContradiction, isTrue);
    });

    test('detects a missing unit digit even when every mask is nonempty', () {
      final state = stateWithMasks({
        for (final source in SudokuUnit.row(0).cells)
          source: CandidateMask.all.remove(1),
      });

      expect(state.candidates.values.every((mask) => !mask.isEmpty), isTrue);
      expect(SudokuConstraints.validate(state.board).isValid, isTrue);
      expect(state.hasContradiction, isTrue);
    });

    test('rejects incomplete or structurally illegal candidate snapshots', () {
      final board = SudokuBoard.parse(standardPuzzle);
      final initial = HumanSolverState.initial(board);
      final missing = {...initial.candidates}..remove(cell(0, 2));
      expect(
        () => HumanSolverState.fromCandidates(
          board: board,
          candidates: missing,
        ),
        throwsArgumentError,
      );
      final illegal = {
        ...initial.candidates,
        cell(0, 2): mask([5]),
      };
      expect(
        () => HumanSolverState.fromCandidates(
          board: board,
          candidates: illegal,
        ),
        throwsArgumentError,
      );
    });

    test('eliminations survive an unrelated later placement', () {
      final original = HumanSolverState.initial(SudokuBoard.empty());
      final target = cell(5, 4);
      final eliminated = original.apply(_eliminate(original, target, 7));
      expect(original.candidatesFor(target).contains(7), isTrue);
      expect(eliminated.candidatesFor(target).contains(7), isFalse);

      final placed = eliminated.apply(_place(eliminated, cell(8, 8), 1));
      expect(placed.board.valueAt(cell(8, 8)), 1);
      expect(placed.candidatesFor(target).contains(7), isFalse);
      expect(placed.candidatesFor(cell(8, 8)), CandidateMask.empty);
      expect(original.board.valueAt(cell(8, 8)), 0);
      expect(eliminated.board.valueAt(cell(8, 8)), 0);
    });

    test('placement removes its digit from peers but not unrelated cells', () {
      final original = HumanSolverState.initial(SudokuBoard.empty());
      final placed = original.apply(_place(original, cell(0, 0), 5));

      expect(placed.board.valueAt(cell(0, 0)), 5);
      expect(placed.candidates.containsKey(cell(0, 0)), isFalse);
      expect(placed.candidatesFor(cell(0, 1)).contains(5), isFalse);
      expect(placed.candidatesFor(cell(1, 0)).contains(5), isFalse);
      expect(placed.candidatesFor(cell(1, 1)).contains(5), isFalse);
      expect(placed.candidatesFor(cell(4, 4)).contains(5), isTrue);
      expect(original.board.valueAt(cell(0, 0)), 0);
    });

    test('applies elimination and placement in one immutable transition', () {
      final original = HumanSolverState.initial(SudokuBoard.empty());
      final target = cell(5, 4);
      final placementCell = cell(8, 8);
      final deduction = Deduction(
        technique: SudokuTechnique.pointingPair,
        focusCells: [target, placementCell],
        evidence: [UnitEvidence(SudokuUnit.row(5))],
        eliminations: [CandidateElimination(target, 7)],
        placements: [DigitPlacement(placementCell, 1)],
      );

      final next = original.apply(deduction);

      expect(next.board.valueAt(placementCell), 1);
      expect(next.candidatesFor(target).contains(7), isFalse);
      expect(next.candidatesFor(cell(8, 7)).contains(1), isFalse);
      expect(original.board.valueAt(placementCell), 0);
      expect(original.candidatesFor(target).contains(7), isTrue);
    });

    test('invalid actions fail atomically', () {
      final initial = HumanSolverState.initial(SudokuBoard.empty());
      final eliminated = initial.apply(_eliminate(initial, cell(0, 0), 7));
      expect(
        () => eliminated.apply(_eliminate(eliminated, cell(0, 0), 7)),
        throwsStateError,
      );
      expect(
        () => eliminated.apply(_place(eliminated, cell(0, 0), 7)),
        throwsStateError,
      );

      final conflicting = Deduction(
        technique: SudokuTechnique.hiddenSingle,
        focusCells: [cell(0, 0), cell(0, 1)],
        evidence: [UnitEvidence(SudokuUnit.row(0))],
        eliminations: const [],
        placements: [
          DigitPlacement(cell(0, 0), 1),
          DigitPlacement(cell(0, 1), 1),
        ],
      );
      expect(() => initial.apply(conflicting), throwsStateError);
      expect(initial.board, SudokuBoard.empty());
      expect(initial.candidatesFor(cell(0, 0)), CandidateMask.all);
    });
  });
}

Deduction _eliminate(HumanSolverState state, CellRef target, int digit) =>
    Deduction(
      technique: SudokuTechnique.nakedPair,
      focusCells: [target],
      evidence: [CandidateSetEvidence(target, state.candidatesFor(target))],
      eliminations: [CandidateElimination(target, digit)],
      placements: const [],
    );

Deduction _place(HumanSolverState state, CellRef target, int digit) =>
    Deduction(
      technique: SudokuTechnique.nakedSingle,
      focusCells: [target],
      evidence: [CandidateSetEvidence(target, state.candidatesFor(target))],
      eliminations: const [],
      placements: [DigitPlacement(target, digit)],
    );
