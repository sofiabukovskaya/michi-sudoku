import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';

void main() {
  group('SudokuBoard', () {
    test('requires exactly 81 values in the range 0–9', () {
      expect(() => SudokuBoard(const []), throwsArgumentError);
      expect(() => SudokuBoard(List<int>.filled(80, 0)), throwsArgumentError);
      expect(() => SudokuBoard(List<int>.filled(82, 0)), throwsArgumentError);
      expect(
        () => SudokuBoard([-1, ...List<int>.filled(80, 0)]),
        throwsRangeError,
      );
      expect(
        () => SudokuBoard([10, ...List<int>.filled(80, 0)]),
        throwsRangeError,
      );
    });

    test('accepts empty and complete boards and counts values', () {
      final empty = SudokuBoard.empty();
      final complete = SudokuBoard.parse(solvedPuzzle);
      expect(empty.emptyCellCount, 81);
      expect(empty.filledCellCount, 0);
      expect(empty.isComplete, isFalse);
      expect(complete.emptyCellCount, 0);
      expect(complete.filledCellCount, 81);
      expect(complete.isComplete, isTrue);
      expect(complete.valueAtPosition(8, 8), 9);
    });

    test('copies input, protects values and returns a changed board', () {
      final input = List<int>.filled(81, 0);
      final original = SudokuBoard.fromValues(input);
      input[0] = 9;
      expect(original.valueAt(CellRef(row: 0, column: 0)), 0);
      expect(() => original.values[0] = 9, throwsUnsupportedError);

      final cell = CellRef(row: 0, column: 0);
      final changed = original.withValue(cell, 5);
      expect(changed.valueAt(cell), 5);
      expect(changed.isFilled(cell), isTrue);
      expect(original.isEmpty(cell), isTrue);
      expect(changed.withValue(cell, 0), original);
      expect(changed, SudokuBoard([5, ...List<int>.filled(80, 0)]));
      expect(
        changed.hashCode,
        SudokuBoard([5, ...List<int>.filled(80, 0)]).hashCode,
      );
      expect(() => original.withValue(cell, 10), throwsRangeError);
    });

    test('parses whitespace and dots as empty cells', () {
      final board = SudokuBoard.parse(standardPuzzle.replaceFirst('0', '.'));
      expect(board.valueAtPosition(0, 0), 5);
      expect(board.valueAtPosition(0, 2), 0);
      expect(board.filledCellCount, 30);
    });

    test('rejects malformed compact boards', () {
      expect(() => SudokuBoard.parse('123'), throwsFormatException);
      expect(
        () => SudokuBoard.parse('x0'),
        throwsFormatException,
      );
      expect(
        () => SudokuBoard.parse('0' * 80 + '٥'),
        throwsFormatException,
      );
    });

    test('can represent duplicate digits for subsequent validation', () {
      final board = SudokuBoard.empty()
          .withValue(CellRef(row: 0, column: 0), 5)
          .withValue(CellRef(row: 0, column: 1), 5);
      expect(board.filledCellCount, 2);
      expect(SudokuConstraints.validate(board).isValid, isFalse);
    });
  });

  test('semantic moves still reject invalid digits', () {
    expect(
      () => DigitPlacement(CellRef(row: 0, column: 0), 0),
      throwsRangeError,
    );
    expect(
      () => CandidateElimination(CellRef(row: 0, column: 0), 10),
      throwsRangeError,
    );
  });
}
