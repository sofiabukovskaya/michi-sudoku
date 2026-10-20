import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

void main() {
  group('CellRef', () {
    test('maps corners and centre to zero-based index and box', () {
      for (final (row, column, index, box) in [
        (0, 0, 0, 0),
        (0, 8, 8, 2),
        (8, 0, 72, 6),
        (8, 8, 80, 8),
        (4, 4, 40, 4),
        (4, 2, 38, 3),
      ]) {
        final cell = CellRef(row: row, column: column);
        expect(cell.index, index);
        expect(cell.box, box);
        expect(CellRef.fromIndex(index), cell);
      }
    });

    test('rejects coordinates and indexes outside the board', () {
      for (final invalid in [-1, 9]) {
        expect(
          () => CellRef(row: invalid, column: 0),
          throwsRangeError,
        );
        expect(
          () => CellRef(row: 0, column: invalid),
          throwsRangeError,
        );
      }
      for (final invalid in [-1, 81]) {
        expect(() => CellRef.fromIndex(invalid), throwsRangeError);
      }
    });

    test('has value equality, matching hashes and useful debug text', () {
      final cell = CellRef(row: 4, column: 2);
      expect(cell, CellRef.fromIndex(38));
      expect(cell.hashCode, CellRef.fromIndex(38).hashCode);
      expect(cell.toString(), 'CellRef(row: 4, column: 2)');
    });
  });
}
