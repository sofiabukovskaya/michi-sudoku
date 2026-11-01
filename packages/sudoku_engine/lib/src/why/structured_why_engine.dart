import '../core/sudoku_unit.dart';
import '../human_solver/deduction.dart';
import '../human_solver/sudoku_technique.dart';
import '../model/sudoku_move.dart';
import 'why_plan.dart';

/// Converts proved placement evidence into numbered, localizable facts.
///
/// It never receives a board or an exact solver and cannot infer future moves.
final class StructuredWhyEngine {
  const StructuredWhyEngine();

  /// Returns null only for a technique without a supported placement proof.
  /// Malformed evidence for a supported technique throws [StateError].
  WhyPlan? createPlan(Deduction deduction, DigitPlacement target) {
    if (!deduction.placements.contains(target)) {
      throw StateError('The deduction does not place $target.');
    }
    return switch (deduction.technique) {
      SudokuTechnique.nakedSingle => _nakedSingle(deduction, target),
      SudokuTechnique.hiddenSingle => _hiddenSingle(deduction, target),
      _ => null,
    };
  }

  WhyPlan _nakedSingle(Deduction deduction, DigitPlacement target) {
    final restrictions = deduction.evidence.whereType<UnitFilledEvidence>();
    final candidates = deduction.evidence.whereType<CandidateSetEvidence>();
    if (restrictions.length != 3 ||
        candidates.length != 1 ||
        candidates.single.cell != target.cell ||
        candidates.single.candidates.singleDigit != target.digit) {
      throw StateError('Incomplete Naked Single evidence.');
    }
    final byType = {for (final item in restrictions) item.unit.type: item};
    if (byType.length != 3 ||
        byType[SudokuUnitType.row]?.unit.index != target.cell.row ||
        byType[SudokuUnitType.column]?.unit.index != target.cell.column ||
        byType[SudokuUnitType.box]?.unit.index != target.cell.box) {
      throw StateError('Naked Single restrictions do not match the target.');
    }
    final steps = <WhyStep>[];
    for (final type in SudokuUnitType.values) {
      final evidence = byType[type]!;
      steps.add(
        WhyStep(
          number: steps.length + 1,
          kind: WhyStepKind.unitRestrictions,
          digit: target.digit,
          unit: evidence.unit,
          markerCells: [
            for (final placement in evidence.placements) placement.cell,
          ],
          filledCells: evidence.placements,
        ),
      );
    }
    steps.add(
      WhyStep(
        number: 4,
        kind: WhyStepKind.onlyCandidate,
        digit: target.digit,
        markerCells: [target.cell],
      ),
    );
    return WhyPlan(
      technique: deduction.technique,
      target: target,
      steps: steps,
    );
  }

  WhyPlan _hiddenSingle(Deduction deduction, DigitPlacement target) {
    final evidence = deduction.evidence.whereType<UnitCandidateEvidence>();
    if (evidence.length != 1 ||
        evidence.single.digit != target.digit ||
        evidence.single.candidateCells.length != 1 ||
        evidence.single.candidateCells.single != target.cell) {
      throw StateError('Incomplete Hidden Single evidence.');
    }
    final unit = evidence.single.unit;
    return WhyPlan(
      technique: deduction.technique,
      target: target,
      steps: [
        WhyStep(
          number: 1,
          kind: WhyStepKind.unitSearch,
          digit: target.digit,
          unit: unit,
          markerCells: unit.cells.where((cell) => cell != target.cell).toList(),
        ),
        WhyStep(
          number: 2,
          kind: WhyStepKind.solePosition,
          digit: target.digit,
          unit: unit,
          markerCells: unit.cells
              .where((cell) => !evidence.single.candidateCells.contains(cell))
              .toList(),
        ),
        WhyStep(
          number: 3,
          kind: WhyStepKind.placement,
          digit: target.digit,
          markerCells: [target.cell],
        ),
      ],
    );
  }
}
