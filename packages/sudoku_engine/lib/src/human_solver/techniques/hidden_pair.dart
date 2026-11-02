import '../../core/sudoku_unit.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// Two digits restricted to the same two cells eliminate other candidates.
final class HiddenPairTechnique implements HumanTechniqueStrategy {
  const HiddenPairTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.hiddenPair;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    final seen = <String>{};
    for (final unit in SudokuUnit.allUnits) {
      for (var first = 1; first <= 8; first++) {
        final firstCells = [
          for (final cell in unit.cells)
            if (state.candidatesFor(cell).contains(first)) cell,
        ];
        if (firstCells.length != 2) continue;
        for (var second = first + 1; second <= 9; second++) {
          final secondCells = [
            for (final cell in unit.cells)
              if (state.candidatesFor(cell).contains(second)) cell,
          ];
          if (secondCells.length != 2 ||
              firstCells[0] != secondCells[0] ||
              firstCells[1] != secondCells[1]) {
            continue;
          }
          final eliminations = <CandidateElimination>[
            for (final cell in firstCells)
              for (final digit in state.candidatesFor(cell).digits)
                if (digit != first && digit != second)
                  CandidateElimination(cell, digit),
          ];
          if (eliminations.isEmpty) continue;
          final key =
              '${firstCells[0].index}:${firstCells[1].index}:'
              '$first:$second:${eliminations.join(',')}';
          if (!seen.add(key)) continue;
          deductions.add(
            Deduction(
              technique: technique,
              focusCells: firstCells,
              evidence: [
                UnitCandidateEvidence(
                  unit: unit,
                  digit: first,
                  candidateCells: firstCells,
                ),
                UnitCandidateEvidence(
                  unit: unit,
                  digit: second,
                  candidateCells: firstCells,
                ),
                for (final cell in firstCells)
                  CandidateSetEvidence(cell, state.candidatesFor(cell)),
              ],
              eliminations: eliminations,
              placements: const [],
            ),
          );
        }
      }
    }
    return deductions;
  }
}
