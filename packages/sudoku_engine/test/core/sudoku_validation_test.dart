import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';

void main() {
  group('SudokuConstraints.validate', () {
    test('accepts a valid partial board', () {
      final result = SudokuConstraints.validate(
        SudokuBoard.parse(standardPuzzle),
      );
      expect(result.isValid, isTrue);
      expect(result.violations, isEmpty);
    });

    test('reports a row duplicate with both affected cells', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 0, column: 0), 5)
          .withValue(CellRef(row: 0, column: 3), 5);
      final result = SudokuConstraints.validate(board);
      expect(result.isValid, isFalse);
      expect(result.violations, hasLength(1));
      final violation = result.violations.single;
      expect(violation, isA<DuplicateInRow>());
      expect(violation.unit, SudokuUnit.row(0));
      expect(violation.unitIndex, 0);
      expect(violation.digit, 5);
      expect(violation.cells, [
        CellRef(row: 0, column: 0),
        CellRef(row: 0, column: 3),
      ]);
      expect(violation.cells.clear, throwsUnsupportedError);
    });

    test('reports a column duplicate', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 0, column: 1), 4)
          .withValue(CellRef(row: 3, column: 1), 4);
      final violation = SudokuConstraints.validate(board).violations.single;
      expect(violation, isA<DuplicateInColumn>());
      expect(violation.unit, SudokuUnit.column(1));
      expect(violation.cells, [
        CellRef(row: 0, column: 1),
        CellRef(row: 3, column: 1),
      ]);
    });

    test('reports a box duplicate', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 3, column: 3), 7)
          .withValue(CellRef(row: 4, column: 4), 7);
      final violation = SudokuConstraints.validate(board).violations.single;
      expect(violation, isA<DuplicateInBox>());
      expect(violation.unit, SudokuUnit.box(4));
      expect(violation.cells, [
        CellRef(row: 3, column: 3),
        CellRef(row: 4, column: 4),
      ]);
    });

    test('returns rows, columns, boxes in stable order', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 0, column: 0), 5)
          .withValue(CellRef(row: 0, column: 1), 5)
          .withValue(CellRef(row: 1, column: 0), 5);
      final result = SudokuConstraints.validate(board);
      expect(result.violations, [
        isA<DuplicateInRow>(),
        isA<DuplicateInColumn>(),
        isA<DuplicateInBox>(),
      ]);
      expect(
        result.violations.map((violation) => violation.unitIndex),
        orderedEquals([0, 0, 0]),
      );
      expect(result.violations.clear, throwsUnsupportedError);
    });

    test('includes every affected cell when a digit occurs three times', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 0, column: 0), 8)
          .withValue(CellRef(row: 0, column: 3), 8)
          .withValue(CellRef(row: 0, column: 6), 8);
      final violation = SudokuConstraints.validate(board).violations.single;
      expect(violation, isA<DuplicateInRow>());
      expect(violation.cells, [
        CellRef(row: 0, column: 0),
        CellRef(row: 0, column: 3),
        CellRef(row: 0, column: 6),
      ]);
    });

    test('sorts repeated digits within a unit', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 0, column: 0), 8)
          .withValue(CellRef(row: 0, column: 1), 8)
          .withValue(CellRef(row: 0, column: 3), 2)
          .withValue(CellRef(row: 0, column: 4), 2);
      final rowViolations = SudokuConstraints.validate(
        board,
      ).violations.whereType<DuplicateInRow>().toList();
      expect(rowViolations.map((violation) => violation.digit), [2, 8]);
    });
  });
}
