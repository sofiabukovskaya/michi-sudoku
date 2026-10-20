import 'package:meta/meta.dart';

/// A cell on a classic board. Coordinates and indexes are always zero-based.
///
/// The UI may display `r1c1`, but that cell is [CellRef(row: 0, column: 0)]
/// inside the engine.
@immutable
final class CellRef {
  CellRef({required this.row, required this.column}) {
    RangeError.checkValueInInterval(row, 0, 8, 'row');
    RangeError.checkValueInInterval(column, 0, 8, 'column');
  }

  factory CellRef.fromIndex(int index) {
    RangeError.checkValueInInterval(index, 0, 80, 'index');
    return CellRef(row: index ~/ 9, column: index % 9);
  }

  final int row;
  final int column;

  int get index => row * 9 + column;

  int get box => (row ~/ 3) * 3 + column ~/ 3;

  @override
  bool operator ==(Object other) =>
      other is CellRef && row == other.row && column == other.column;

  @override
  int get hashCode => Object.hash(row, column);

  @override
  String toString() => 'CellRef(row: $row, column: $column)';
}
