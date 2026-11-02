import '../../core/sudoku_unit.dart';
import '../../model/cell_ref.dart';
import '../../model/sudoku_move.dart';
import '../deduction.dart';
import '../human_solver_state.dart';
import '../human_technique_strategy.dart';
import '../sudoku_technique.dart';

/// Two matching two-position lines eliminate a digit on crossing lines.
final class XWingTechnique implements HumanTechniqueStrategy {
  const XWingTechnique();

  @override
  SudokuTechnique get technique => SudokuTechnique.xWing;

  @override
  List<Deduction> find(HumanSolverState state) {
    final deductions = <Deduction>[];
    final seen = <String>{};
    for (final sourceUnits in [SudokuUnit.allRows, SudokuUnit.allColumns]) {
      final rowBased = sourceUnits.first.type == SudokuUnitType.row;
      for (var digit = 1; digit <= 9; digit++) {
        for (var first = 0; first <= 7; first++) {
          final firstCells = _positions(state, sourceUnits[first], digit);
          if (firstCells.length != 2) continue;
          for (var second = first + 1; second <= 8; second++) {
            final secondCells = _positions(state, sourceUnits[second], digit);
            if (secondCells.length != 2 ||
                _crossIndex(firstCells[0], rowBased) !=
                    _crossIndex(secondCells[0], rowBased) ||
                _crossIndex(firstCells[1], rowBased) !=
                    _crossIndex(secondCells[1], rowBased)) {
              continue;
            }
            final crossUnits = [
              if (rowBased)
                for (final cell in firstCells) SudokuUnit.column(cell.column)
              else
                for (final cell in firstCells) SudokuUnit.row(cell.row),
            ];
            final pattern = [...firstCells, ...secondCells];
            final eliminations = <CandidateElimination>[
              for (final cross in crossUnits)
                for (final cell in cross.cells)
                  if (!pattern.contains(cell) &&
                      state.candidatesFor(cell).contains(digit))
                    CandidateElimination(cell, digit),
            ];
            if (eliminations.isEmpty) continue;
            final key =
                '$digit:${pattern.map((cell) => cell.index).toList()..sort()}:'
                '${eliminations.join(',')}';
            if (!seen.add(key)) continue;
            deductions.add(
              Deduction(
                technique: technique,
                focusCells: pattern,
                evidence: [
                  UnitCandidateEvidence(
                    unit: sourceUnits[first],
                    digit: digit,
                    candidateCells: firstCells,
                  ),
                  UnitCandidateEvidence(
                    unit: sourceUnits[second],
                    digit: digit,
                    candidateCells: secondCells,
                  ),
                  for (final cross in crossUnits) UnitEvidence(cross),
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

  List<CellRef> _positions(
    HumanSolverState state,
    SudokuUnit unit,
    int digit,
  ) => [
    for (final cell in unit.cells)
      if (state.candidatesFor(cell).contains(digit)) cell,
  ];

  int _crossIndex(CellRef cell, bool rowBased) =>
      rowBased ? cell.column : cell.row;
}
