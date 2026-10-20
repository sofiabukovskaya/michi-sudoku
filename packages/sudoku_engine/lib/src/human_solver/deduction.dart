import 'package:meta/meta.dart';

import '../core/sudoku_unit.dart';
import '../model/candidate_mask.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_move.dart';
import 'sudoku_technique.dart';

/// A structured, localizable reason for one logical step.
@immutable
final class Deduction {
  Deduction({
    required this.technique,
    required List<CellRef> focusCells,
    required List<DeductionEvidence> evidence,
    required List<CandidateElimination> eliminations,
    required List<DigitPlacement> placements,
  }) : focusCells = _sortedCells(focusCells),
       evidence = List<DeductionEvidence>.unmodifiable(evidence),
       eliminations = _sortedMoves(eliminations),
       placements = _sortedMoves(placements) {
    if (this.focusCells.isEmpty || this.evidence.isEmpty) {
      throw ArgumentError('A deduction needs focus cells and evidence.');
    }
    if (this.eliminations.isEmpty && this.placements.isEmpty) {
      throw ArgumentError(
        'A deduction must change candidates or place a digit.',
      );
    }
    if (this.eliminations.toSet().length != this.eliminations.length) {
      throw ArgumentError('Duplicate candidate eliminations.');
    }
    if (this.placements.map((move) => move.cell).toSet().length !=
        this.placements.length) {
      throw ArgumentError('A cell cannot receive multiple placements.');
    }
  }

  final SudokuTechnique technique;
  final List<CellRef> focusCells;
  final List<DeductionEvidence> evidence;
  final List<CandidateElimination> eliminations;
  final List<DigitPlacement> placements;

  @override
  bool operator ==(Object other) =>
      other is Deduction &&
      technique == other.technique &&
      _sameList(focusCells, other.focusCells) &&
      _sameList(evidence, other.evidence) &&
      _sameList(eliminations, other.eliminations) &&
      _sameList(placements, other.placements);

  @override
  int get hashCode => Object.hash(
    technique,
    Object.hashAll(focusCells),
    Object.hashAll(evidence),
    Object.hashAll(eliminations),
    Object.hashAll(placements),
  );
}

/// Semantic facts sufficient for a later Coach to explain a deduction.
@immutable
sealed class DeductionEvidence {
  const DeductionEvidence();
}

/// The remaining candidates of one empty cell.
final class CandidateSetEvidence extends DeductionEvidence {
  const CandidateSetEvidence(this.cell, this.candidates);

  final CellRef cell;
  final CandidateMask candidates;

  @override
  bool operator ==(Object other) =>
      other is CandidateSetEvidence &&
      cell == other.cell &&
      candidates == other.candidates;

  @override
  int get hashCode => Object.hash(cell, candidates);
}

/// The cells supporting a digit within a row, column, or box.
final class UnitCandidateEvidence extends DeductionEvidence {
  UnitCandidateEvidence({
    required this.unit,
    required this.digit,
    required List<CellRef> candidateCells,
  }) : candidateCells = _sortedCells(candidateCells) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
    if (this.candidateCells.isEmpty ||
        this.candidateCells.any((cell) => !unit.cells.contains(cell))) {
      throw ArgumentError.value(candidateCells, 'candidateCells');
    }
  }

  final SudokuUnit unit;
  final int digit;
  final List<CellRef> candidateCells;

  @override
  bool operator ==(Object other) =>
      other is UnitCandidateEvidence &&
      unit == other.unit &&
      digit == other.digit &&
      _sameList(candidateCells, other.candidateCells);

  @override
  int get hashCode => Object.hash(unit, digit, Object.hashAll(candidateCells));
}

/// A unit involved in a pair or box-to-line relationship.
final class UnitEvidence extends DeductionEvidence {
  const UnitEvidence(this.unit);

  final SudokuUnit unit;

  @override
  bool operator ==(Object other) => other is UnitEvidence && unit == other.unit;

  @override
  int get hashCode => unit.hashCode;
}

List<CellRef> _sortedCells(List<CellRef> cells) => List<CellRef>.unmodifiable(
  cells.toSet().toList()..sort(
    (left, right) => left.index.compareTo(right.index),
  ),
);

List<T> _sortedMoves<T extends SudokuMove>(List<T> moves) =>
    List<T>.unmodifiable(
      <T>[...moves]..sort((left, right) {
        final cellOrder = left.cell.index.compareTo(right.cell.index);
        return cellOrder != 0 ? cellOrder : left.digit.compareTo(right.digit);
      }),
    );

bool _sameList<T>(List<T> left, List<T> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
