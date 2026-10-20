import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuConstraints peers', () {
    test('every board cell has 20 distinct peers', () {
      for (var index = 0; index < 81; index++) {
        final peers = SudokuConstraints.peersOf(CellRef.fromIndex(index));
        expect(peers.length, 20, reason: 'cell index $index');
        expect(peers.toSet().length, 20, reason: 'cell index $index');
      }
    });

    for (final cell in [
      CellRef(row: 0, column: 0),
      CellRef(row: 0, column: 4),
      CellRef(row: 4, column: 4),
      CellRef(row: 8, column: 8),
    ]) {
      test('$cell has exactly 20 unique peers', () {
        final peers = SudokuConstraints.peersOf(cell);
        expect(peers.length, 20);
        expect(peers.toSet().length, 20);
        expect(peers, isNot(contains(cell)));
        expect(
          peers.map((peer) => peer.index),
          orderedEquals(
            peers.map((peer) => peer.index).toList()..sort(),
          ),
        );
        for (final peer in peers) {
          expect(
            peer.row == cell.row ||
                peer.column == cell.column ||
                peer.box == cell.box,
            isTrue,
          );
        }
        final unrelated = CellRef(
          row: (cell.row + 3) % 9,
          column: (cell.column + 3) % 9,
        );
        expect(peers, isNot(contains(unrelated)));
        expect(
          () => peers.add(cell),
          throwsUnsupportedError,
        );
      });
    }
  });

  group('SudokuConstraints placements and used digits', () {
    final target = CellRef(row: 4, column: 4);
    final board = SudokuBoard.empty()
        .withValue(CellRef(row: 4, column: 0), 1)
        .withValue(CellRef(row: 0, column: 4), 2)
        .withValue(CellRef(row: 3, column: 3), 3);

    test('returns digits used in each unit', () {
      expect(
        SudokuConstraints.usedInRow(board, 4).digits,
        orderedEquals([1]),
      );
      expect(
        SudokuConstraints.usedInColumn(board, 4).digits,
        orderedEquals([2]),
      );
      expect(
        SudokuConstraints.usedInBox(board, 4).digits,
        orderedEquals([3]),
      );
    });

    test('allows valid digits and rejects row, column or box conflicts', () {
      expect(SudokuConstraints.canPlace(board, target, 4), isTrue);
      for (final invalid in [1, 2, 3]) {
        expect(SudokuConstraints.canPlace(board, target, invalid), isFalse);
      }
      expect(
        () => SudokuConstraints.canPlace(board, target, 0),
        throwsRangeError,
      );
      expect(
        () => SudokuConstraints.canPlace(board, target, 10),
        throwsRangeError,
      );
    });

    test('does not treat the target value as a conflict with itself', () {
      final filled = board.withValue(target, 4);
      expect(SudokuConstraints.canPlace(filled, target, 4), isTrue);
      expect(SudokuConstraints.canPlace(filled, target, 1), isFalse);
    });

    test('detects duplicate values per unit, ignoring zeroes', () {
      expect(SudokuConstraints.hasDuplicateInRow(board, 4), isFalse);
      expect(SudokuConstraints.hasDuplicateInColumn(board, 4), isFalse);
      expect(SudokuConstraints.hasDuplicateInBox(board, 4), isFalse);
      expect(
        SudokuConstraints.hasDuplicateInRow(
          board.withValue(CellRef(row: 4, column: 8), 1),
          4,
        ),
        isTrue,
      );
      expect(
        SudokuConstraints.hasDuplicateInColumn(
          board.withValue(CellRef(row: 8, column: 4), 2),
          4,
        ),
        isTrue,
      );
      expect(
        SudokuConstraints.hasDuplicateInBox(
          board.withValue(CellRef(row: 5, column: 5), 3),
          4,
        ),
        isTrue,
      );
    });
  });
}
