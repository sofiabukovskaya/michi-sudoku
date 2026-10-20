import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

import '../fixtures/boards.dart';

void main() {
  const calculator = CandidateCalculator();

  group('CandidateCalculator', () {
    test('empty board gives every cell all digits', () {
      final board = SudokuBoard.empty();
      final candidates = calculator.calculateAll(board);
      expect(candidates.length, 81);
      for (final mask in candidates.values) {
        expect(mask, CandidateMask.all);
      }
      expect(
        () => candidates[CellRef(row: 0, column: 0)] = CandidateMask.empty,
        throwsUnsupportedError,
      );
    });

    test(
      'filled cells have no candidates and are absent from calculateAll',
      () {
        final board = SudokuBoard.empty().withValue(
          CellRef(row: 0, column: 0),
          5,
        );
        final cell = CellRef(row: 0, column: 0);
        expect(calculator.candidatesFor(board, cell), CandidateMask.empty);
        expect(calculator.calculateAll(board).length, 80);
        expect(calculator.calculateAll(board).containsKey(cell), isFalse);
      },
    );

    test('row, column and box each remove their used digit', () {
      final target = CellRef(row: 4, column: 4);
      for (final (given, digit) in [
        (CellRef(row: 4, column: 0), 1),
        (CellRef(row: 0, column: 4), 2),
        (CellRef(row: 3, column: 3), 3),
      ]) {
        final board = SudokuBoard.empty().withValue(given, digit);
        final mask = calculator.candidatesFor(board, target);
        expect(mask.contains(digit), isFalse);
        expect(mask.count, 8);
      }
    });

    test('combines restrictions into exact candidates', () {
      final board = SudokuBoard.parse(standardPuzzle);
      expect(
        calculator.candidatesFor(board, CellRef(row: 0, column: 2)).digits,
        orderedEquals([1, 2, 4]),
      );
      expect(
        calculator.candidatesFor(board, CellRef(row: 4, column: 4)).digits,
        orderedEquals([5]),
      );
      expect(
        calculator.candidatesFor(board, CellRef(row: 4, column: 4)).singleDigit,
        5,
      );
    });

    test('a contradictory empty cell may have no candidates', () {
      final board = SudokuBoard.parse('''
        012345678
        900000000
        000000000
        000000000
        000000000
        000000000
        000000000
        000000000
        000000000
      ''');
      expect(
        calculator.candidatesFor(board, CellRef(row: 0, column: 0)),
        CandidateMask.empty,
      );
    });
  });
}
