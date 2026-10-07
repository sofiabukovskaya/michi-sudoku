import 'package:meta/meta.dart';

import 'cell_ref.dart';

/// An immutable classic Sudoku board. Null represents an empty cell.
@immutable
final class SudokuBoard {
  SudokuBoard(List<int?> cells) : _cells = List<int?>.unmodifiable(cells) {
    if (_cells.length != 81) {
      throw ArgumentError.value(cells.length, 'cells.length', 'Expected 81.');
    }
    for (final value in _cells) {
      if (value != null && (value < 1 || value > 9)) {
        throw ArgumentError.value(value, 'cell', 'Expected null or 1–9.');
      }
    }
  }

  factory SudokuBoard.empty() => SudokuBoard(List<int?>.filled(81, null));

  final List<int?> _cells;

  List<int?> get cells => _cells;

  int? valueAt(CellRef cell) => _cells[cell.index];

  SudokuBoard withValue(CellRef cell, int? value) {
    final next = _cells.toList()..[cell.index] = value;
    return SudokuBoard(next);
  }

  @override
  bool operator ==(Object other) {
    if (other is! SudokuBoard) return false;
    for (var index = 0; index < 81; index++) {
      if (_cells[index] != other._cells[index]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(_cells);
}
