import 'package:michi_mobile/features/practice/domain/technique_practice_scenario.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Finds a "Spot it" moment in a real puzzle: a point in its logical solve
/// where exactly one cell can be filled for sure, as a hidden single, from
/// the board alone (no earlier candidate eliminations the player cannot
/// see). One right answer means no "valid but not the one we wanted".
abstract final class SpotItFinder {
  /// At least this many empty cells, so the moment feels like a real game.
  static const int minimumEmpty = 30;

  static TechniquePracticeScenario? find({
    required String id,
    required SudokuBoard puzzle,
    required HumanSolver solver,
  }) {
    const legal = CandidateCalculator();
    var state = HumanSolverState.initial(puzzle);
    while (!state.isSolved) {
      final deduction = solver.findNextDeduction(state);
      if (deduction == null) return null;
      // Only singles keep the candidates equal to what the board shows.
      final singles =
          deduction.technique == SudokuTechnique.nakedSingle ||
          deduction.technique == SudokuTechnique.hiddenSingle;
      if (!singles) return null;
      if (deduction.technique == SudokuTechnique.hiddenSingle &&
          state.emptyCells.length >= minimumEmpty &&
          _onlyPlacement(state, legal.calculateAll(state.board))) {
        return TechniquePracticeScenario(
          id: id,
          technique: SudokuTechnique.hiddenSingle,
          board: state.board,
          contentVersion: 1,
        );
      }
      state = state.apply(deduction);
    }
    return null;
  }

  /// No naked single anywhere, and exactly one hidden single.
  static bool _onlyPlacement(
    HumanSolverState state,
    Map<CellRef, CandidateMask> candidates,
  ) {
    if (candidates.values.any((mask) => mask.count == 1)) return false;
    final found = <(CellRef, int)>{};
    for (final unit in SudokuUnit.allUnits) {
      for (var digit = 1; digit <= 9; digit++) {
        final places = [
          for (final cell in unit.cells)
            if (candidates[cell]?.contains(digit) ?? false) cell,
        ];
        if (places.length == 1) found.add((places.single, digit));
        if (found.length > 1) return false;
      }
    }
    return found.length == 1;
  }
}
