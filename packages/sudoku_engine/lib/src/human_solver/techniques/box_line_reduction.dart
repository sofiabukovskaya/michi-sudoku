import '../../core/sudoku_unit.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// A line confines a digit to one box, removing it elsewhere in that box.
final class BoxLineReductionTechnique implements HumanTechniqueStrategy {
  const BoxLineReductionTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.boxLineReduction;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    for (final line in [...SudokuUnit.allRows, ...SudokuUnit.allColumns]) {
      for (var digit = 1; digit <= 9; digit++) {
        final sourceCells = [
          for (final cell in line.cells)
            if (state.candidatesFor(cell).contains(digit)) cell,
        ];
        if (sourceCells.length < 2 || sourceCells.length > 3) continue;
        final boxIndex = sourceCells.first.box;
        if (sourceCells.any((cell) => cell.box != boxIndex)) continue;
        final box = SudokuUnit.box(boxIndex);
        final eliminations = <CandidateElimination>[
          for (final cell in box.cells)
            if (!line.cells.contains(cell) &&
                state.candidatesFor(cell).contains(digit))
              CandidateElimination(cell, digit),
        ];
        if (eliminations.isEmpty) continue;
        deductions.add(
          Deduction(
            technique: technique,
            focusCells: sourceCells,
            evidence: [
              UnitCandidateEvidence(
                unit: line,
                digit: digit,
                candidateCells: sourceCells,
              ),
              UnitEvidence(box),
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
