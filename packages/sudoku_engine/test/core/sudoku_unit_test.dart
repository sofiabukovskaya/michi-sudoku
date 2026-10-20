import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuUnit', () {
    test('rows and columns have deterministic cell order', () {
      expect(
        SudokuUnit.row(0).cells,
        [
          for (var column = 0; column < 9; column++)
            CellRef(row: 0, column: column),
        ],
      );
      expect(
        SudokuUnit.column(0).cells,
        [for (var row = 0; row < 9; row++) CellRef(row: row, column: 0)],
      );
    });

    test('boxes have row-major order within their 3×3 region', () {
      expect(SudokuUnit.box(0).cells, [
        for (var row = 0; row < 3; row++)
          for (var column = 0; column < 3; column++)
            CellRef(row: row, column: column),
      ]);
      expect(SudokuUnit.box(4).cells, [
        for (var row = 3; row < 6; row++)
          for (var column = 3; column < 6; column++)
            CellRef(row: row, column: column),
      ]);
    });

    test('all 27 units contain nine distinct cells', () {
      expect(SudokuUnit.allRows.length, 9);
      expect(SudokuUnit.allColumns.length, 9);
      expect(SudokuUnit.allBoxes.length, 9);
      expect(SudokuUnit.allUnits.length, 27);
      expect(SudokuUnit.allUnits.toSet().length, 27);
      for (final unit in SudokuUnit.allUnits) {
        expect(unit.cells.length, 9);
        expect(unit.cells.toSet().length, 9);
        expect(
          () => unit.cells.add(CellRef(row: 0, column: 0)),
          throwsUnsupportedError,
        );
        for (final cell in unit.cells) {
          expect(switch (unit.type) {
            SudokuUnitType.row => cell.row,
            SudokuUnitType.column => cell.column,
            SudokuUnitType.box => cell.box,
          }, unit.index);
        }
      }
    });

    test('rejects invalid indices and compares by value', () {
      expect(() => SudokuUnit.row(-1), throwsRangeError);
      expect(() => SudokuUnit.column(9), throwsRangeError);
      expect(() => SudokuUnit.box(9), throwsRangeError);
      expect(SudokuUnit.row(3), SudokuUnit(SudokuUnitType.row, 3));
      expect(SudokuUnit.row(3).hashCode, SudokuUnit.row(3).hashCode);
      expect(SudokuUnit.row(3), isNot(SudokuUnit.column(3)));
    });
  });
}
