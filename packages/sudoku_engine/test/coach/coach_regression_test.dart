import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/solver_puzzles.dart';

void main() {
  const human = DeterministicHumanSolver();
  const coach = StructuredCoachEngine();

  test('real HumanSolver traces produce repeatable, bounded Coach plans', () {
    final seenTechniques = <SudokuTechnique>{};
    for (final name in [
      'MICHI standard',
      'easy50 #1',
      'top95 #0',
      'top95 #14',
    ]) {
      final fixture = solverRegressionPuzzles.firstWhere(
        (item) => item.name == name,
      );
      final board = SudokuBoard.parse(fixture.puzzle);
      final deductions = human.solveLogically(board).deductions;
      expect(deductions, isNotEmpty);

      for (final deduction in deductions) {
        seenTechniques.add(deduction.technique);
        final plan = coach.createPlan(deduction);
        expect(plan, coach.createPlan(deduction));
        expect(plan.technique, deduction.technique);
        expect(plan.hints.map((hint) => hint.level), CoachHintLevel.values);
        expect(plan.last.revealedPlacements, deduction.placements);
        expect(plan.last.revealedEliminations, deduction.eliminations);

        final relatedCells = <CellRef>{
          ...deduction.focusCells,
          ...deduction.placements.map((move) => move.cell),
          ...deduction.eliminations.map((move) => move.cell),
        };
        final relatedUnits = <SudokuUnit>{};
        final relatedCandidates = <CandidateRef>{};
        for (final evidence in deduction.evidence) {
          switch (evidence) {
            case CandidateSetEvidence(:final cell, :final candidates):
              relatedCells.add(cell);
              for (final digit in candidates.digits) {
                relatedCandidates.add(CandidateRef(cell, digit));
              }
            case UnitCandidateEvidence(
              :final unit,
              :final digit,
              :final candidateCells,
            ):
              relatedUnits.add(unit);
              relatedCells.addAll(candidateCells);
              for (final cell in candidateCells) {
                relatedCandidates.add(CandidateRef(cell, digit));
              }
            case UnitEvidence(:final unit):
              relatedUnits.add(unit);
          }
        }

        for (final hint in plan.hints) {
          expect(relatedCells.containsAll(hint.focusCells), isTrue);
          expect(relatedUnits.containsAll(hint.focusUnits), isTrue);
          expect(
            relatedCandidates.containsAll(hint.candidateHighlights),
            isTrue,
          );
          expect(deduction.evidence.toSet().containsAll(hint.evidence), isTrue);
        }
        for (final hint in plan.hints.take(3)) {
          expect(hint.revealedPlacements, isEmpty);
          expect(hint.revealedEliminations, isEmpty);
        }
      }
    }
    expect(seenTechniques, {
      SudokuTechnique.nakedSingle,
      SudokuTechnique.hiddenSingle,
      SudokuTechnique.nakedPair,
      SudokuTechnique.pointingPair,
    });
  });
}
