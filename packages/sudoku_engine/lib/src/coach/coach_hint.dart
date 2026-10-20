import 'package:meta/meta.dart';

import '../core/sudoku_unit.dart';
import '../human_solver/deduction.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_move.dart';
import 'candidate_ref.dart';

/// Stable stages of progressive disclosure.
enum CoachHintLevel { direction, focus, reasoning, result }

/// Teaching purpose; presentation owns all localized wording and visuals.
enum CoachHintIntent {
  inspectCell,
  inspectUnit,
  inspectCandidates,
  inspectCandidatePositions,
  identifyMatchingCandidatePair,
  singleCandidateRemains,
  onlyPositionRemains,
  understandPairRestriction,
  understandAlignment,
  revealPlacement,
  revealEliminations,
  revealActions,
}

/// One immutable semantic reveal in a four-level Coach plan.
@immutable
final class CoachHint {
  CoachHint({
    required this.level,
    required this.intent,
    List<CellRef> focusCells = const [],
    List<SudokuUnit> focusUnits = const [],
    List<CandidateRef> candidateHighlights = const [],
    List<DeductionEvidence> evidence = const [],
    List<CandidateElimination> revealedEliminations = const [],
    List<DigitPlacement> revealedPlacements = const [],
  }) : focusCells = _sortedCells(focusCells),
       focusUnits = _sortedUnits(focusUnits),
       candidateHighlights = _sortedCandidates(candidateHighlights),
       evidence = List<DeductionEvidence>.unmodifiable(evidence),
       revealedEliminations = _sortedMoves(revealedEliminations),
       revealedPlacements = _sortedMoves(revealedPlacements) {
    if (level != CoachHintLevel.result &&
        (this.revealedEliminations.isNotEmpty ||
            this.revealedPlacements.isNotEmpty)) {
      throw ArgumentError('Only the result hint may reveal actions.');
    }
    if (level == CoachHintLevel.result &&
        this.revealedEliminations.isEmpty &&
        this.revealedPlacements.isEmpty) {
      throw ArgumentError('A result hint must reveal an action.');
    }
  }

  final CoachHintLevel level;
  final CoachHintIntent intent;
  final List<CellRef> focusCells;
  final List<SudokuUnit> focusUnits;
  final List<CandidateRef> candidateHighlights;
  final List<DeductionEvidence> evidence;
  final List<CandidateElimination> revealedEliminations;
  final List<DigitPlacement> revealedPlacements;

  @override
  bool operator ==(Object other) =>
      other is CoachHint &&
      level == other.level &&
      intent == other.intent &&
      _sameList(focusCells, other.focusCells) &&
      _sameList(focusUnits, other.focusUnits) &&
      _sameList(candidateHighlights, other.candidateHighlights) &&
      _sameList(evidence, other.evidence) &&
      _sameList(revealedEliminations, other.revealedEliminations) &&
      _sameList(revealedPlacements, other.revealedPlacements);

  @override
  int get hashCode => Object.hash(
    level,
    intent,
    Object.hashAll(focusCells),
    Object.hashAll(focusUnits),
    Object.hashAll(candidateHighlights),
    Object.hashAll(evidence),
    Object.hashAll(revealedEliminations),
    Object.hashAll(revealedPlacements),
  );
}

List<CellRef> _sortedCells(List<CellRef> cells) => List<CellRef>.unmodifiable(
  cells.toSet().toList()..sort((a, b) => a.index.compareTo(b.index)),
);

List<SudokuUnit> _sortedUnits(List<SudokuUnit> units) =>
    List<SudokuUnit>.unmodifiable(
      units.toSet().toList()..sort((a, b) {
        final typeOrder = a.type.index.compareTo(b.type.index);
        return typeOrder != 0 ? typeOrder : a.index.compareTo(b.index);
      }),
    );

List<CandidateRef> _sortedCandidates(List<CandidateRef> candidates) =>
    List<CandidateRef>.unmodifiable(
      candidates.toSet().toList()..sort((a, b) {
        final cellOrder = a.cell.index.compareTo(b.cell.index);
        return cellOrder != 0 ? cellOrder : a.digit.compareTo(b.digit);
      }),
    );

List<T> _sortedMoves<T extends SudokuMove>(List<T> moves) =>
    List<T>.unmodifiable(
      <T>[...moves]..sort((a, b) {
        final cellOrder = a.cell.index.compareTo(b.cell.index);
        return cellOrder != 0 ? cellOrder : a.digit.compareTo(b.digit);
      }),
    );

bool _sameList<T>(List<T> left, List<T> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
