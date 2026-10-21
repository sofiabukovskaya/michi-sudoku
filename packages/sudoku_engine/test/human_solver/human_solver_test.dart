import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';
import 'fixtures.dart';

void main() {
  const solver = DeterministicHumanSolver();

  group('HumanSolver technique priority', () {
    final hiddenMasks = <CellRef, CandidateMask>{
      for (var column = 1; column < 9; column++)
        cell(0, column): CandidateMask.all.remove(1),
    };
    final pointingMasks = <CellRef, CandidateMask>{
      for (final source in SudokuUnit.box(0).cells)
        if (source != cell(0, 0) && source != cell(0, 1))
          source: CandidateMask.all.remove(3),
    };
    final pairMasks = <CellRef, CandidateMask>{
      cell(4, 4): mask([2, 7]),
      cell(4, 5): mask([2, 7]),
    };

    test('chooses Naked Single before an available Hidden Single', () {
      final state = stateWithMasks({
        ...hiddenMasks,
        cell(0, 0): mask([1]),
      });

      expect(state.hasContradiction, isFalse);
      expect(
        solver.findNextDeduction(state)?.technique,
        SudokuTechnique.nakedSingle,
      );
    });

    test('chooses Hidden Single before available eliminations', () {
      final state = stateWithMasks({
        ...pointingMasks,
        ...pairMasks,
        ...hiddenMasks,
      });

      expect(state.hasContradiction, isFalse);
      expect(
        solver.findNextDeduction(state)?.technique,
        SudokuTechnique.hiddenSingle,
      );
    });

    test('chooses Naked Pair before Pointing Pair', () {
      final state = stateWithMasks({...pairMasks, ...pointingMasks});

      expect(state.hasContradiction, isFalse);
      expect(
        solver.findNextDeduction(state)?.technique,
        SudokuTechnique.nakedPair,
      );
    });

    test('chooses Pointing Pair when simpler techniques are absent', () {
      final state = stateWithMasks(pointingMasks);

      expect(state.hasContradiction, isFalse);
      expect(
        solver.findNextDeduction(state)?.technique,
        SudokuTechnique.pointingPair,
      );
    });

    test('returns no move on a valid state without supported patterns', () {
      final state = HumanSolverState.initial(SudokuBoard.empty());

      expect(state.hasContradiction, isFalse);
      expect(solver.findNextDeduction(state), isNull);
    });
  });

  group('HumanSolver logical trace', () {
    test('solves a supported puzzle through ordered deductions', () {
      final board = SudokuBoard.parse(standardPuzzle);
      final result = solver.solveLogically(board);

      expect(result.status, HumanSolveStatus.solved);
      expect(result.initialBoard, board);
      expect(result.finalState.board, SudokuBoard.parse(solvedPuzzle));
      expect(result.finalState.isSolved, isTrue);
      expect(result.deductions, isNotEmpty);
      expect(result.deductions.first.technique, SudokuTechnique.nakedSingle);
      expect(result.deductions.clear, throwsUnsupportedError);
      expect(board, SudokuBoard.parse(standardPuzzle));
    });

    test('reports stuck on a solvable board with no supported first move', () {
      final board = SudokuBoard.empty();
      final result = solver.solveLogically(board);

      expect(result.status, HumanSolveStatus.stuck);
      expect(result.finalState.board, board);
      expect(result.finalState.hasContradiction, isFalse);
      expect(result.deductions, isEmpty);
    });

    test('reports contradiction on a duplicate-containing board', () {
      final board = SudokuBoard.empty()
          .withValue(cell(0, 0), 5)
          .withValue(cell(0, 1), 5);
      final result = solver.solveLogically(board);

      expect(result.status, HumanSolveStatus.contradiction);
      expect(result.finalState.board, board);
      expect(result.finalState.hasContradiction, isTrue);
      expect(result.deductions, isEmpty);
      expect(solver.findNextDeduction(result.finalState), isNull);
    });

    test('an already solved valid board has an empty trace', () {
      final board = SudokuBoard.parse(solvedPuzzle);
      final result = solver.solveLogically(board);

      expect(result.status, HumanSolveStatus.solved);
      expect(result.finalState.board, board);
      expect(result.deductions, isEmpty);
      expect(solver.findNextDeduction(result.finalState), isNull);
    });
  });
}
