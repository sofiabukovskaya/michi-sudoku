import '../../core/sudoku_unit.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// A digit with exactly one candidate position in a row, column, or box.
final class HiddenSingleTechnique implements HumanTechniqueStrategy {
  const HiddenSingleTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.hiddenSingle;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    final seen = <DigitPlacement>{};
    // allUnits establishes the canonical evidence priority: rows, columns,
    // then boxes. Within a unit, digits are checked from 1 to 9.
    for (final unit in SudokuUnit.allUnits) {
      for (var digit = 1; digit <= 9; digit++) {
        final cells = [
          for (final cell in unit.cells)
            if (state.candidatesFor(cell).contains(digit)) cell,
        ];
        if (cells.length != 1) continue;
        final placement = DigitPlacement(cells.single, digit);
        if (!seen.add(placement)) continue;
        deductions.add(
          Deduction(
            technique: technique,
            focusCells: cells,
            evidence: [
              UnitCandidateEvidence(
                unit: unit,
                digit: digit,
                candidateCells: cells,
              ),
            ],
            eliminations: const [],
            placements: [placement],
          ),
        );
      }
    }
    return deductions;
  }
}
