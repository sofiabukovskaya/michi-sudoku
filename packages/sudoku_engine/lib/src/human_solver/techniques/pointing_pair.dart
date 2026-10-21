import '../../core/sudoku_unit.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// A box's two positions for a digit confine it to one row or column.
final class PointingPairTechnique implements HumanTechniqueStrategy {
  const PointingPairTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.pointingPair;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    for (final box in SudokuUnit.allBoxes) {
      for (var digit = 1; digit <= 9; digit++) {
        final pairCells = [
          for (final cell in box.cells)
            if (state.candidatesFor(cell).contains(digit)) cell,
        ];
        if (pairCells.length != 2) continue;

        SudokuUnit? line;
        if (pairCells[0].row == pairCells[1].row) {
          line = SudokuUnit.row(pairCells[0].row);
        } else if (pairCells[0].column == pairCells[1].column) {
          line = SudokuUnit.column(pairCells[0].column);
        }
        if (line == null) continue;

        final eliminations = <CandidateElimination>[
          for (final cell in line.cells)
            if (cell.box != box.index &&
                state.candidatesFor(cell).contains(digit))
              CandidateElimination(cell, digit),
        ];
        if (eliminations.isEmpty) continue;
        deductions.add(
          Deduction(
            technique: technique,
            focusCells: pairCells,
            evidence: [
              UnitCandidateEvidence(
                unit: box,
                digit: digit,
                candidateCells: pairCells,
              ),
              UnitEvidence(line),
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
