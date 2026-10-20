import 'package:meta/meta.dart';

import '../model/candidate_mask.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_board.dart';
import 'sudoku_unit.dart';

/// Basic Sudoku rules. These checks do not establish solvability or uniqueness.
abstract final class SudokuConstraints {
  static CandidateMask usedInRow(SudokuBoard board, int row) =>
      _usedInUnit(board, SudokuUnit.row(row));

  static CandidateMask usedInColumn(SudokuBoard board, int column) =>
      _usedInUnit(board, SudokuUnit.column(column));

  static CandidateMask usedInBox(SudokuBoard board, int box) =>
      _usedInUnit(board, SudokuUnit.box(box));

  static CandidateMask _usedInUnit(SudokuBoard board, SudokuUnit unit) {
    var mask = CandidateMask.empty;
    for (final cell in unit.cells) {
      final digit = board.valueAt(cell);
      if (digit != 0) mask = mask.add(digit);
    }
    return mask;
  }

  /// The 20 distinct peers, ordered by flat cell index.
  static List<CellRef> peersOf(CellRef cell) {
    final peers = <CellRef>[];
    for (var index = 0; index < 81; index++) {
      final peer = CellRef.fromIndex(index);
      if (peer != cell &&
          (peer.row == cell.row ||
              peer.column == cell.column ||
              peer.box == cell.box)) {
        peers.add(peer);
      }
    }
    return List<CellRef>.unmodifiable(peers);
  }

  /// Checks a placement against other cells, ignoring the target's value.
  static bool canPlace(SudokuBoard board, CellRef cell, int digit) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
    for (final peer in peersOf(cell)) {
      if (board.valueAt(peer) == digit) return false;
    }
    return true;
  }

  static bool hasDuplicateInRow(SudokuBoard board, int row) =>
      _hasDuplicateInUnit(board, SudokuUnit.row(row));

  static bool hasDuplicateInColumn(SudokuBoard board, int column) =>
      _hasDuplicateInUnit(board, SudokuUnit.column(column));

  static bool hasDuplicateInBox(SudokuBoard board, int box) =>
      _hasDuplicateInUnit(board, SudokuUnit.box(box));

  static bool _hasDuplicateInUnit(SudokuBoard board, SudokuUnit unit) {
    var seen = CandidateMask.empty;
    for (final cell in unit.cells) {
      final digit = board.valueAt(cell);
      if (digit == 0) continue;
      if (seen.contains(digit)) return true;
      seen = seen.add(digit);
    }
    return false;
  }

  /// Reports every repeated digit in rows, columns, then boxes.
  ///
  /// Each violation includes all cells carrying its digit in that unit.
  static SudokuValidationResult validate(SudokuBoard board) {
    final violations = <SudokuViolation>[];
    for (final unit in SudokuUnit.allUnits) {
      for (var digit = 1; digit <= 9; digit++) {
        final cells = [
          for (final cell in unit.cells)
            if (board.valueAt(cell) == digit) cell,
        ];
        if (cells.length < 2) continue;
        violations.add(switch (unit.type) {
          SudokuUnitType.row => DuplicateInRow(unit.index, digit, cells),
          SudokuUnitType.column => DuplicateInColumn(unit.index, digit, cells),
          SudokuUnitType.box => DuplicateInBox(unit.index, digit, cells),
        });
      }
    }
    return SudokuValidationResult(violations);
  }
}

@immutable
final class SudokuValidationResult {
  SudokuValidationResult(List<SudokuViolation> violations)
    : violations = List<SudokuViolation>.unmodifiable(violations);

  final List<SudokuViolation> violations;

  bool get isValid => violations.isEmpty;
}

/// A repeated nonzero digit in a unit. Cell order follows unit order.
@immutable
sealed class SudokuViolation {
  SudokuViolation(this.unitIndex, this.digit, List<CellRef> cells)
    : cells = List<CellRef>.unmodifiable(cells);

  final int unitIndex;
  final int digit;
  final List<CellRef> cells;

  SudokuUnit get unit;
}

final class DuplicateInRow extends SudokuViolation {
  DuplicateInRow(super.unitIndex, super.digit, super.cells);

  @override
  SudokuUnit get unit => SudokuUnit.row(unitIndex);
}

final class DuplicateInColumn extends SudokuViolation {
  DuplicateInColumn(super.unitIndex, super.digit, super.cells);

  @override
  SudokuUnit get unit => SudokuUnit.column(unitIndex);
}

final class DuplicateInBox extends SudokuViolation {
  DuplicateInBox(super.unitIndex, super.digit, super.cells);

  @override
  SudokuUnit get unit => SudokuUnit.box(unitIndex);
}
