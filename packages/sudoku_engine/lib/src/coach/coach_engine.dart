import '../core/sudoku_unit.dart';
import '../human_solver/deduction.dart';
import '../human_solver/sudoku_technique.dart';
import '../model/cell_ref.dart';
import 'candidate_ref.dart';
import 'coach_hint.dart';
import 'coach_plan.dart';

/// Selects how much of an existing deduction to disclose at each hint level.
abstract interface class CoachEngine {
  CoachPlan createPlan(Deduction deduction);
}

/// Deterministic Phase 5 mapping from HumanSolver evidence to four hints.
///
/// It checks the shape of the supplied evidence, but never examines a board,
/// calculates candidates, or discovers a move.
final class StructuredCoachEngine implements CoachEngine {
  const StructuredCoachEngine();

  @override
  CoachPlan createPlan(Deduction deduction) {
    final hints = switch (deduction.technique) {
      SudokuTechnique.nakedSingle => _nakedSingle(deduction),
      SudokuTechnique.hiddenSingle => _hiddenSingle(deduction),
      SudokuTechnique.nakedPair => _nakedPair(deduction),
      SudokuTechnique.pointingPair => _pointingPair(deduction),
      _ => throw UnsupportedError(
        'Coach planning is not available for ${deduction.technique}.',
      ),
    };
    return CoachPlan(deduction: deduction, hints: hints);
  }
}

List<CoachHint> _nakedSingle(Deduction deduction) {
  final candidates = deduction.evidence.whereType<CandidateSetEvidence>();
  if (deduction.placements.length != 1 ||
      deduction.focusCells.length != 1 ||
      candidates.length != 1 ||
      deduction.evidence.length != 1) {
    throw StateError('Naked Single needs one target and candidate set.');
  }
  final placement = deduction.placements.single;
  final candidateSet = candidates.single;
  if (deduction.focusCells.single != placement.cell ||
      candidateSet.cell != placement.cell ||
      !candidateSet.candidates.isSingle ||
      candidateSet.candidates.singleDigit != placement.digit) {
    throw StateError('Naked Single evidence does not match its placement.');
  }

  final cell = placement.cell;
  final highlights = [CandidateRef(cell, placement.digit)];
  return [
    CoachHint(
      level: CoachHintLevel.direction,
      intent: CoachHintIntent.inspectCell,
      focusCells: [cell],
    ),
    CoachHint(
      level: CoachHintLevel.focus,
      intent: CoachHintIntent.inspectCandidates,
      focusCells: [cell],
    ),
    CoachHint(
      level: CoachHintLevel.reasoning,
      intent: CoachHintIntent.singleCandidateRemains,
      focusCells: [cell],
      candidateHighlights: highlights,
      evidence: [candidateSet],
    ),
    _resultHint(
      deduction,
      focusCells: [cell],
      candidateHighlights: highlights,
      evidence: [candidateSet],
    ),
  ];
}

List<CoachHint> _hiddenSingle(Deduction deduction) {
  final positions = deduction.evidence.whereType<UnitCandidateEvidence>();
  if (deduction.placements.length != 1 ||
      positions.length != 1 ||
      deduction.evidence.length != 1) {
    throw StateError('Hidden Single needs one placement and unit evidence.');
  }
  final placement = deduction.placements.single;
  final evidence = positions.single;
  if (evidence.candidateCells.length != 1 ||
      evidence.candidateCells.single != placement.cell ||
      evidence.digit != placement.digit ||
      !deduction.focusCells.contains(placement.cell)) {
    throw StateError('Hidden Single evidence does not match its placement.');
  }

  final unit = evidence.unit;
  final highlights = [CandidateRef(placement.cell, evidence.digit)];
  return [
    CoachHint(
      level: CoachHintLevel.direction,
      intent: CoachHintIntent.inspectUnit,
      focusUnits: [unit],
    ),
    CoachHint(
      level: CoachHintLevel.focus,
      intent: CoachHintIntent.inspectCandidatePositions,
      focusUnits: [unit],
      focusCells: evidence.candidateCells,
      candidateHighlights: highlights,
    ),
    CoachHint(
      level: CoachHintLevel.reasoning,
      intent: CoachHintIntent.onlyPositionRemains,
      focusUnits: [unit],
      focusCells: evidence.candidateCells,
      candidateHighlights: highlights,
      evidence: [evidence],
    ),
    _resultHint(
      deduction,
      focusUnits: [unit],
      focusCells: deduction.focusCells,
      candidateHighlights: highlights,
      evidence: [evidence],
    ),
  ];
}

List<CoachHint> _nakedPair(Deduction deduction) {
  final units = deduction.evidence.whereType<UnitEvidence>();
  final sets = deduction.evidence.whereType<CandidateSetEvidence>().toList();
  if (deduction.eliminations.isEmpty ||
      deduction.focusCells.length != 2 ||
      units.length != 1 ||
      sets.length != 2 ||
      deduction.evidence.length != 3) {
    throw StateError('Naked Pair needs a unit and two matching cell sets.');
  }
  final unit = units.single.unit;
  final mask = sets.first.candidates;
  if (mask.count != 2 ||
      sets.any(
        (set) =>
            set.candidates != mask ||
            !deduction.focusCells.contains(set.cell) ||
            !unit.cells.contains(set.cell),
      ) ||
      sets[0].cell == sets[1].cell ||
      deduction.eliminations.any(
        (move) =>
            !unit.cells.contains(move.cell) ||
            deduction.focusCells.contains(move.cell) ||
            !mask.contains(move.digit),
      )) {
    throw StateError('Naked Pair evidence and eliminations disagree.');
  }

  final highlights = [
    for (final cell in deduction.focusCells)
      for (final digit in mask.digits) CandidateRef(cell, digit),
  ];
  return [
    CoachHint(
      level: CoachHintLevel.direction,
      intent: CoachHintIntent.inspectUnit,
      focusUnits: [unit],
    ),
    CoachHint(
      level: CoachHintLevel.focus,
      intent: CoachHintIntent.identifyMatchingCandidatePair,
      focusUnits: [unit],
      focusCells: deduction.focusCells,
      candidateHighlights: highlights,
      evidence: sets,
    ),
    CoachHint(
      level: CoachHintLevel.reasoning,
      intent: CoachHintIntent.understandPairRestriction,
      focusUnits: [unit],
      focusCells: deduction.focusCells,
      candidateHighlights: highlights,
      evidence: deduction.evidence,
    ),
    _resultHint(
      deduction,
      focusUnits: [unit],
      focusCells: deduction.focusCells,
      candidateHighlights: highlights,
      evidence: deduction.evidence,
    ),
  ];
}

List<CoachHint> _pointingPair(Deduction deduction) {
  final positions = deduction.evidence.whereType<UnitCandidateEvidence>();
  final lines = deduction.evidence.whereType<UnitEvidence>();
  if (deduction.eliminations.isEmpty ||
      positions.length != 1 ||
      lines.length != 1 ||
      deduction.evidence.length != 2) {
    throw StateError('Pointing Pair needs a source box and aligned line.');
  }
  final source = positions.single;
  final line = lines.single.unit;
  if (source.unit.type != SudokuUnitType.box ||
      line.type == SudokuUnitType.box ||
      source.candidateCells.length != 2 ||
      !_sameCells(source.candidateCells, deduction.focusCells) ||
      source.candidateCells.any((cell) => !line.cells.contains(cell)) ||
      deduction.eliminations.any(
        (move) =>
            move.digit != source.digit ||
            !line.cells.contains(move.cell) ||
            source.unit.cells.contains(move.cell),
      )) {
    throw StateError('Pointing Pair evidence and eliminations disagree.');
  }

  final highlights = [
    for (final cell in source.candidateCells) CandidateRef(cell, source.digit),
  ];
  return [
    CoachHint(
      level: CoachHintLevel.direction,
      intent: CoachHintIntent.inspectUnit,
      focusUnits: [source.unit],
    ),
    CoachHint(
      level: CoachHintLevel.focus,
      intent: CoachHintIntent.inspectCandidatePositions,
      focusUnits: [source.unit],
      focusCells: source.candidateCells,
      candidateHighlights: highlights,
      evidence: [source],
    ),
    CoachHint(
      level: CoachHintLevel.reasoning,
      intent: CoachHintIntent.understandAlignment,
      focusUnits: [source.unit, line],
      focusCells: source.candidateCells,
      candidateHighlights: highlights,
      evidence: deduction.evidence,
    ),
    _resultHint(
      deduction,
      focusUnits: [source.unit, line],
      focusCells: deduction.focusCells,
      candidateHighlights: highlights,
      evidence: deduction.evidence,
    ),
  ];
}

CoachHint _resultHint(
  Deduction deduction, {
  List<CellRef> focusCells = const [],
  List<SudokuUnit> focusUnits = const [],
  List<CandidateRef> candidateHighlights = const [],
  List<DeductionEvidence> evidence = const [],
}) {
  final intent = switch ((
    deduction.placements.isNotEmpty,
    deduction.eliminations.isNotEmpty,
  )) {
    (true, false) => CoachHintIntent.revealPlacement,
    (false, true) => CoachHintIntent.revealEliminations,
    (true, true) => CoachHintIntent.revealActions,
    (false, false) => throw StateError('A deduction must contain an action.'),
  };
  return CoachHint(
    level: CoachHintLevel.result,
    intent: intent,
    focusCells: focusCells,
    focusUnits: focusUnits,
    candidateHighlights: candidateHighlights,
    evidence: evidence,
    revealedEliminations: deduction.eliminations,
    revealedPlacements: deduction.placements,
  );
}

bool _sameCells(List<CellRef> left, List<CellRef> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
