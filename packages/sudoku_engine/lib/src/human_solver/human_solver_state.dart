import 'package:meta/meta.dart';

import '../core/candidate_calculator.dart';
import '../core/sudoku_constraints.dart';
import '../core/sudoku_unit.dart';
import '../model/candidate_mask.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_move.dart';
import 'deduction.dart';

/// Immutable board values plus persistent logical candidate eliminations.
@immutable
final class HumanSolverState {
  HumanSolverState._(this.board, Map<CellRef, CandidateMask> candidates)
    : candidates = Map<CellRef, CandidateMask>.unmodifiable(candidates);

  factory HumanSolverState.initial(SudokuBoard board) =>
      HumanSolverState.fromCandidates(
        board: board,
        candidates: const CandidateCalculator().calculateAll(board),
      );

  /// Restores a snapshot; every mask must be a subset of legal digits.
  ///
  /// This accepts empty masks so contradictory states remain inspectable.
  factory HumanSolverState.fromCandidates({
    required SudokuBoard board,
    required Map<CellRef, CandidateMask> candidates,
  }) {
    final legal = const CandidateCalculator().calculateAll(board);
    if (candidates.length != legal.length ||
        candidates.keys.any((cell) => !legal.containsKey(cell))) {
      throw ArgumentError.value(
        candidates,
        'candidates',
        'Expected every empty cell.',
      );
    }
    final ordered = <CellRef, CandidateMask>{};
    for (final cell in legal.keys) {
      final mask = candidates[cell];
      if (mask == null || !mask.difference(legal[cell]!).isEmpty) {
        throw ArgumentError.value(
          candidates,
          'candidates',
          'Contains illegal digits.',
        );
      }
      ordered[cell] = mask;
    }
    return HumanSolverState._(board, ordered);
  }

  final SudokuBoard board;

  /// Masks for empty cells only, in ascending flat cell order.
  final Map<CellRef, CandidateMask> candidates;

  CandidateMask candidatesFor(CellRef cell) =>
      candidates[cell] ?? CandidateMask.empty;

  List<CellRef> get emptyCells => List<CellRef>.unmodifiable(candidates.keys);

  bool get isSolved => board.isComplete && !hasContradiction;

  bool get hasContradiction {
    if (!SudokuConstraints.validate(board).isValid) return true;
    if (candidates.values.any((mask) => mask.isEmpty)) return true;

    // A missing digit with no candidate position in a unit is also impossible.
    for (final unit in SudokuUnit.allUnits) {
      for (var digit = 1; digit <= 9; digit++) {
        if (unit.cells.any((cell) => board.valueAt(cell) == digit)) continue;
        if (!unit.cells.any((cell) => candidatesFor(cell).contains(digit))) {
          return true;
        }
      }
    }
    return false;
  }

  /// Applies a complete deduction atomically; prior eliminations never return.
  ///
  /// Invalid actions throw [StateError]. A valid action may yield a state whose
  /// [hasContradiction] is true, which the orchestrator reports explicitly.
  HumanSolverState apply(Deduction deduction) {
    if (hasContradiction) {
      throw StateError('Cannot apply a deduction to a contradictory state.');
    }
    for (final elimination in deduction.eliminations) {
      if (board.isFilled(elimination.cell) ||
          !candidatesFor(elimination.cell).contains(elimination.digit)) {
        throw StateError('Candidate elimination is not present: $elimination');
      }
    }

    var nextBoard = board;
    for (final placement in deduction.placements) {
      if (nextBoard.isFilled(placement.cell) ||
          !candidatesFor(placement.cell).contains(placement.digit) ||
          deduction.eliminations.contains(
            CandidateElimination(placement.cell, placement.digit),
          ) ||
          !SudokuConstraints.canPlace(
            nextBoard,
            placement.cell,
            placement.digit,
          )) {
        throw StateError('Illegal digit placement: $placement');
      }
      nextBoard = nextBoard.withValue(placement.cell, placement.digit);
    }

    final nextCandidates = Map<CellRef, CandidateMask>.of(candidates);
    for (final elimination in deduction.eliminations) {
      nextCandidates[elimination.cell] = nextCandidates[elimination.cell]!
          .remove(elimination.digit);
    }
    for (final placement in deduction.placements) {
      nextCandidates.remove(placement.cell);
    }
    const calculator = CandidateCalculator();
    for (final cell in nextCandidates.keys) {
      nextCandidates[cell] = nextCandidates[cell]!.intersection(
        calculator.candidatesFor(nextBoard, cell),
      );
    }
    return HumanSolverState._(nextBoard, nextCandidates);
  }
}
