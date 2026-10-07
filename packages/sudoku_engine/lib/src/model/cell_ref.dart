import 'package:meta/meta.dart';

/// A zero-based row and column on a classic 9×9 board.
@immutable
final class CellRef {
  CellRef(this.row, this.column) {
    if (row < 0 || row > 8 || column < 0 || column > 8) {
      throw RangeError('Cell coordinates must be between 0 and 8.');
    }
  }

  factory CellRef.fromIndex(int index) {
    if (index < 0 || index >= 81) {
      throw RangeError.range(index, 0, 80, 'index');
    }
    return CellRef(index ~/ 9, index % 9);
  }

  final int row;
  final int column;

  int get index => row * 9 + column;

  @override
  bool operator ==(Object other) =>
      other is CellRef && row == other.row && column == other.column;

  @override
  int get hashCode => Object.hash(row, column);

  @override
  String toString() => 'CellRef(row: $row, column: $column)';
}
