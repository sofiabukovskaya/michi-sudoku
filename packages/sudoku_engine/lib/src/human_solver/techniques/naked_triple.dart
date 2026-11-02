import '../../core/sudoku_unit.dart';
import '../../model/candidate_mask.dart';
import '../../model/cell_ref.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// Three cells sharing exactly three digits reserve them in a unit.
final class NakedTripleTechnique implements HumanTechniqueStrategy {
  const NakedTripleTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.nakedTriple;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    final seen = <String>{};
    for (final unit in SudokuUnit.allUnits) {
      final eligible = [
        for (final cell in unit.cells)
          if (state.candidatesFor(cell).count >= 2 &&
              state.candidatesFor(cell).count <= 3)
            cell,
      ];
      for (var a = 0; a < eligible.length - 2; a++) {
        for (var b = a + 1; b < eligible.length - 1; b++) {
          for (var c = b + 1; c < eligible.length; c++) {
            final triple = <CellRef>[eligible[a], eligible[b], eligible[c]];
            var union = CandidateMask.empty;
            for (final cell in triple) {
              union = union.union(state.candidatesFor(cell));
            }
            if (union.count != 3) continue;
            final eliminations = <CandidateElimination>[
              for (final cell in unit.cells)
                if (!triple.contains(cell))
                  for (final digit in union.digits)
                    if (state.candidatesFor(cell).contains(digit))
                      CandidateElimination(cell, digit),
            ];
            if (eliminations.isEmpty) continue;
            final key =
                '${triple.map((cell) => cell.index).join(',')}:'
                '${eliminations.join(',')}';
            if (!seen.add(key)) continue;
            deductions.add(
              Deduction(
                technique: technique,
                focusCells: triple,
                evidence: [
                  UnitEvidence(unit),
                  for (final cell in triple)
                    CandidateSetEvidence(cell, state.candidatesFor(cell)),
                ],
                eliminations: eliminations,
                placements: const [],
              ),
            );
          }
        }
      }
    }
    return deductions;
  }
}
