import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

void main() {
  group('CandidateMask', () {
    test('all 512 digit subsets round-trip through their bitmask', () {
      for (var bits = 0; bits <= CandidateMask.allBits; bits++) {
        final mask = CandidateMask(bits);
        expect(CandidateMask.fromDigits(mask.digits), mask);
        expect(mask.count, mask.digits.length);
      }
    });

    test('empty and all represent the correct bits and digits', () {
      expect(CandidateMask.empty.bits, 0);
      expect(CandidateMask.empty.isEmpty, isTrue);
      expect(CandidateMask.empty.count, 0);
      expect(CandidateMask.all.bits, 0x1ff);
      expect(CandidateMask.all.count, 9);
      expect(
        CandidateMask.all.digits,
        orderedEquals([1, 2, 3, 4, 5, 6, 7, 8, 9]),
      );
    });

    test('fromDigits deduplicates and iterates in ascending order', () {
      final mask = CandidateMask.fromDigits(const [9, 2, 5, 2]);
      expect(mask.bits, (1 << 8) | (1 << 1) | (1 << 4));
      expect(mask.digits, orderedEquals([2, 5, 9]));
      expect(mask.count, 3);
      expect(mask.contains(5), isTrue);
      expect(mask.contains(4), isFalse);
      expect(mask.isSingle, isFalse);
      expect(mask.singleDigit, isNull);
    });

    test('add and remove create new masks and identify singles', () {
      const original = CandidateMask.empty;
      final single = original.add(7);
      expect(original.isEmpty, isTrue);
      expect(single.isSingle, isTrue);
      expect(single.singleDigit, 7);
      expect(single.remove(7), CandidateMask.empty);
      expect(single.withoutDigit(7), CandidateMask.empty);
      expect(original.withDigit(7), single);
      expect(single.add(7), single);
    });

    test('union, intersection and difference perform set operations', () {
      final left = CandidateMask.fromDigits(const [2, 5, 9]);
      final right = CandidateMask.fromDigits(const [1, 5, 8]);
      expect(left.union(right).digits, orderedEquals([1, 2, 5, 8, 9]));
      expect(left.intersection(right).digits, orderedEquals([5]));
      expect(left.difference(right).digits, orderedEquals([2, 9]));
    });

    test('rejects invalid raw bits and digits', () {
      expect(() => CandidateMask(-1), throwsRangeError);
      expect(() => CandidateMask(0x200), throwsRangeError);
      for (final invalid in [0, 10]) {
        expect(
          () => CandidateMask.fromDigits([invalid]),
          throwsRangeError,
        );
        expect(() => CandidateMask.empty.contains(invalid), throwsRangeError);
        expect(() => CandidateMask.empty.add(invalid), throwsRangeError);
        expect(() => CandidateMask.all.remove(invalid), throwsRangeError);
      }
    });

    test('compares by value', () {
      final left = CandidateMask.fromDigits(const [2, 5, 9]);
      final right = CandidateMask.fromDigits(const [9, 5, 2]);
      expect(left, right);
      expect(left.hashCode, right.hashCode);
      expect(left.toString(), 'CandidateMask(2, 5, 9)');
    });
  });
}
