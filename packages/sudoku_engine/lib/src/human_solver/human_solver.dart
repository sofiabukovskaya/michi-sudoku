import '../model/sudoku_board.dart';
import 'deduction.dart';
import 'human_solve_result.dart';
import 'human_solver_state.dart';
import 'human_technique_strategy.dart';
import 'techniques/hidden_single.dart';
import 'techniques/naked_pair.dart';
import 'techniques/naked_single.dart';
import 'techniques/pointing_pair.dart';

/// Finds human-recognizable logical deductions without exact-solver search.
abstract interface class HumanSolver {
  Deduction? findNextDeduction(HumanSolverState state);

  HumanSolveResult solveLogically(SudokuBoard board);
}

/// Applies Phase 4 techniques from simplest to most advanced.
final class DeterministicHumanSolver implements HumanSolver {
  const DeterministicHumanSolver();

  static const List<HumanTechniqueStrategy> _techniques = [
    NakedSingleTechnique(),
    HiddenSingleTechnique(),
    NakedPairTechnique(),
    PointingPairTechnique(),
  ];

  @override
  Deduction? findNextDeduction(HumanSolverState state) {
    if (state.hasContradiction || state.isSolved) return null;
    for (final strategy in _techniques) {
      final deductions = strategy.find(state);
      if (deductions.isNotEmpty) return deductions.first;
    }
    return null;
  }

  @override
  HumanSolveResult solveLogically(SudokuBoard board) {
    var state = HumanSolverState.initial(board);
    final deductions = <Deduction>[];
    while (true) {
      if (state.hasContradiction) {
        return HumanSolveResult(
          status: HumanSolveStatus.contradiction,
          initialBoard: board,
          finalState: state,
          deductions: deductions,
        );
      }
      if (state.isSolved) {
        return HumanSolveResult(
          status: HumanSolveStatus.solved,
          initialBoard: board,
          finalState: state,
          deductions: deductions,
        );
      }
      final next = findNextDeduction(state);
      if (next == null) {
        return HumanSolveResult(
          status: HumanSolveStatus.stuck,
          initialBoard: board,
          finalState: state,
          deductions: deductions,
        );
      }
      state = state.apply(next);
      deductions.add(next);
    }
  }
}
