import 'package:meta/meta.dart';

enum SudokuUnitType { row, column, box }

/// One row, column or 3×3 box, indexed from zero.
@immutable
final class SudokuUnit {
  SudokuUnit(this.type, this.index) {
    if (index < 0 || index > 8) {
      throw RangeError.range(index, 0, 8, 'index');
    }
  }

  final SudokuUnitType type;
  final int index;

  @override
  bool operator ==(Object other) =>
      other is SudokuUnit && type == other.type && index == other.index;

  @override
  int get hashCode => Object.hash(type, index);
}
