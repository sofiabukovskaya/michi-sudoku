import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

void main() {
  group('SudokuBoard', () {
    test('requires exactly 81 cells with digits from 1 to 9', () {
      expect(() => SudokuBoard(const []), throwsArgumentError);
      expect(
        () => SudokuBoard([0, ...List<int?>.filled(80, null)]),
        throwsArgumentError,
      );
      expect(
        () => SudokuBoard([10, ...List<int?>.filled(80, null)]),
        throwsArgumentError,
      );
    });

    test('copies input and returns a new board when a cell changes', () {
      final input = List<int?>.filled(81, null);
      final original = SudokuBoard(input);
      input[0] = 9;
      expect(original.valueAt(CellRef(0, 0)), isNull);
      expect(() => original.cells[0] = 9, throwsUnsupportedError);

      final changed = original.withValue(CellRef(0, 0), 5);
      expect(changed.valueAt(CellRef(0, 0)), 5);
      expect(original.valueAt(CellRef(0, 0)), isNull);
      expect(changed, SudokuBoard([5, ...List<int?>.filled(80, null)]));
    });
  });

  test('CellRef validates coordinates and maps indices', () {
    expect(CellRef.fromIndex(80), CellRef(8, 8));
    expect(CellRef(4, 3).index, 39);
    expect(() => CellRef(9, 0), throwsRangeError);
    expect(() => CellRef.fromIndex(81), throwsRangeError);
  });

  test('CandidateMask keeps digits in the 1–9 range', () {
    final mask = CandidateMask(0).withDigit(7);
    expect(mask.contains(7), isTrue);
    expect(mask.withoutDigit(7).contains(7), isFalse);
    expect(() => mask.contains(0), throwsRangeError);
  });

  test('semantic moves reject invalid digits', () {
    expect(() => DigitPlacement(CellRef(0, 0), 0), throwsRangeError);
    expect(() => CandidateElimination(CellRef(0, 0), 10), throwsRangeError);
  });
}
