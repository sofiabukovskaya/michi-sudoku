import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// An empty cell with exactly one remaining logical candidate.
final class NakedSingleTechnique implements HumanTechniqueStrategy {
  const NakedSingleTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.nakedSingle;

  @override
  List<Deduction> find(HumanSolverState state) => [
    for (final cell in state.emptyCells)
      if (state.candidatesFor(cell).isSingle)
        Deduction(
          technique: technique,
          focusCells: [cell],
          evidence: [CandidateSetEvidence(cell, state.candidatesFor(cell))],
          eliminations: const [],
          placements: [
            DigitPlacement(cell, state.candidatesFor(cell).singleDigit!),
          ],
        ),
  ];
}
