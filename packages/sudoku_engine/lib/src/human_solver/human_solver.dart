import '../model/sudoku_board.dart';
import 'deduction.dart';
import 'human_solve_result.dart';
import 'human_solver_state.dart';
import 'human_technique_strategy.dart';
import 'sudoku_technique.dart';
import 'techniques/box_line_reduction.dart';
import 'techniques/hidden_pair.dart';
import 'techniques/hidden_single.dart';
import 'techniques/naked_pair.dart';
import 'techniques/naked_single.dart';
import 'techniques/naked_triple.dart';
import 'techniques/pointing_pair.dart';
import 'techniques/x_wing.dart';

/// Finds human-recognizable logical deductions without exact-solver search.
abstract interface class HumanSolver {
  Deduction? findNextDeduction(HumanSolverState state);

  HumanSolveResult solveLogically(SudokuBoard board);
}

/// Applies supported techniques from simplest to most advanced.
final class DeterministicHumanSolver implements HumanSolver {
  const DeterministicHumanSolver();

  static const Map<SudokuTechnique, HumanTechniqueStrategy> _strategies = {
    SudokuTechnique.nakedSingle: NakedSingleTechnique(),
    SudokuTechnique.hiddenSingle: HiddenSingleTechnique(),
    SudokuTechnique.nakedPair: NakedPairTechnique(),
    SudokuTechnique.pointingPair: PointingPairTechnique(),
    SudokuTechnique.hiddenPair: HiddenPairTechnique(),
    SudokuTechnique.boxLineReduction: BoxLineReductionTechnique(),
    SudokuTechnique.nakedTriple: NakedTripleTechnique(),
    SudokuTechnique.xWing: XWingTechnique(),
  };

  @override
  Deduction? findNextDeduction(HumanSolverState state) {
    if (state.hasContradiction || state.isSolved) return null;
    for (final technique in SudokuTechniqueOrder.supported) {
      final strategy = _strategies[technique];
      if (strategy == null) {
        throw StateError('No strategy registered for $technique.');
      }
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
