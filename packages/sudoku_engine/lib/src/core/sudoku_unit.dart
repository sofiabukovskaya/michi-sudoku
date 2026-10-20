import 'package:meta/meta.dart';

import '../model/cell_ref.dart';

enum SudokuUnitType { row, column, box }

/// One zero-based row, column, or 3×3 box with nine ordered cells.
@immutable
final class SudokuUnit {
  SudokuUnit(this.type, this.index) {
    RangeError.checkValueInInterval(index, 0, 8, 'index');
  }

  factory SudokuUnit.row(int index) => SudokuUnit(SudokuUnitType.row, index);

  factory SudokuUnit.column(int index) =>
      SudokuUnit(SudokuUnitType.column, index);

  factory SudokuUnit.box(int index) => SudokuUnit(SudokuUnitType.box, index);

  final SudokuUnitType type;
  final int index;

  List<CellRef> get cells => List<CellRef>.unmodifiable(
    List<CellRef>.generate(9, (position) {
      return switch (type) {
        SudokuUnitType.row => CellRef(row: index, column: position),
        SudokuUnitType.column => CellRef(row: position, column: index),
        SudokuUnitType.box => CellRef(
          row: (index ~/ 3) * 3 + position ~/ 3,
          column: (index % 3) * 3 + position % 3,
        ),
      };
    }),
  );

  static final List<SudokuUnit> allRows = List<SudokuUnit>.unmodifiable(
    List<SudokuUnit>.generate(9, SudokuUnit.row),
  );

  static final List<SudokuUnit> allColumns = List<SudokuUnit>.unmodifiable(
    List<SudokuUnit>.generate(9, SudokuUnit.column),
  );

  static final List<SudokuUnit> allBoxes = List<SudokuUnit>.unmodifiable(
    List<SudokuUnit>.generate(9, SudokuUnit.box),
  );

  /// Rows, then columns, then boxes; each group is ordered by index.
  static final List<SudokuUnit> allUnits = List<SudokuUnit>.unmodifiable([
    ...allRows,
    ...allColumns,
    ...allBoxes,
  ]);

  @override
  bool operator ==(Object other) =>
      other is SudokuUnit && type == other.type && index == other.index;

  @override
  int get hashCode => Object.hash(type, index);

  @override
  String toString() => 'SudokuUnit(type: $type, index: $index)';
}
