import 'package:meta/meta.dart';

import 'cell_ref.dart';

/// Immutable cell values for a classic 9×9 Sudoku board.
///
/// Values are flat, row-major, and zero means empty. Construction checks only
/// shape and digit range; duplicate Sudoku values are reported by validation.
@immutable
final class SudokuBoard {
  SudokuBoard(List<int> values) : _values = List<int>.unmodifiable(values) {
    if (_values.length != 81) {
      throw ArgumentError.value(values.length, 'values.length', 'Expected 81.');
    }
    for (final value in _values) {
      RangeError.checkValueInInterval(value, 0, 9, 'value');
    }
  }

  factory SudokuBoard.fromValues(Iterable<int> values) =>
      SudokuBoard(values.toList());

  factory SudokuBoard.empty() => SudokuBoard(List<int>.filled(81, 0));

  /// Parses 81 digits, optionally with whitespace and `.` for empty cells.
  factory SudokuBoard.parse(String source) {
    final compact = source.replaceAll(RegExp(r'\s'), '');
    if (compact.length != 81) {
      throw FormatException('Expected 81 cells; found ${compact.length}.');
    }
    final values = <int>[];
    for (var index = 0; index < compact.length; index++) {
      final character = compact[index];
      if (character == '.') {
        values.add(0);
      } else {
        final digit = int.tryParse(character);
        if (digit == null || digit < 0 || digit > 9) {
          throw FormatException('Invalid cell character at index $index.');
        }
        values.add(digit);
      }
    }
    return SudokuBoard(values);
  }

  final List<int> _values;

  /// An unmodifiable view of the 81 values.
  List<int> get values => _values;

  int valueAt(CellRef cell) => _values[cell.index];

  int valueAtPosition(int row, int column) =>
      valueAt(CellRef(row: row, column: column));

  bool isEmpty(CellRef cell) => valueAt(cell) == 0;

  bool isFilled(CellRef cell) => !isEmpty(cell);

  int get emptyCellCount => _values.where((value) => value == 0).length;

  int get filledCellCount => 81 - emptyCellCount;

  bool get isComplete => emptyCellCount == 0;

  SudokuBoard withValue(CellRef cell, int digit) {
    RangeError.checkValueInInterval(digit, 0, 9, 'digit');
    final next = _values.toList()..[cell.index] = digit;
    return SudokuBoard(next);
  }

  @override
  bool operator ==(Object other) {
    if (other is! SudokuBoard) return false;
    for (var index = 0; index < 81; index++) {
      if (_values[index] != other._values[index]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(_values);
}
