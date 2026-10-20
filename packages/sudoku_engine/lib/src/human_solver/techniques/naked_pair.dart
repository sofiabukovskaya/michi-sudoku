import '../../core/sudoku_unit.dart';
import '../../model/candidate_mask.dart';
import '../../model/cell_ref.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// Two cells with the same two candidates reserve those digits in a unit.
final class NakedPairTechnique implements HumanTechniqueStrategy {
  const NakedPairTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.nakedPair;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    for (final unit in SudokuUnit.allUnits) {
      final cellsByMask = <CandidateMask, List<CellRef>>{};
      for (final cell in unit.cells) {
        final mask = state.candidatesFor(cell);
        if (mask.count == 2) {
          cellsByMask.putIfAbsent(mask, () => []).add(cell);
        }
      }
      for (final entry in cellsByMask.entries) {
        // Three identical masks are not a Naked Pair.
        if (entry.value.length != 2) continue;
        final pairCells = entry.value;
        final eliminations = <CandidateElimination>[
          for (final cell in unit.cells)
            if (!pairCells.contains(cell))
              for (final digit in entry.key.digits)
                if (state.candidatesFor(cell).contains(digit))
                  CandidateElimination(cell, digit),
        ];
        if (eliminations.isEmpty) continue;
        deductions.add(
          Deduction(
            technique: technique,
            focusCells: pairCells,
            evidence: [
              UnitEvidence(unit),
              for (final cell in pairCells)
                CandidateSetEvidence(cell, entry.key),
            ],
            eliminations: eliminations,
            placements: const [],
          ),
        );
      }
    }
    return deductions;
  }
}
