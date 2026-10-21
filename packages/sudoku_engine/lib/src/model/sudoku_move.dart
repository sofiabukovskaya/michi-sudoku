import 'package:meta/meta.dart';

import 'cell_ref.dart';

/// A semantic change proposed by a human technique.
@immutable
sealed class SudokuMove {
  SudokuMove(this.cell, this.digit) {
    if (digit < 1 || digit > 9) {
      throw RangeError.range(digit, 1, 9, 'digit');
    }
  }

  final CellRef cell;
  final int digit;

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType &&
      other is SudokuMove &&
      other.cell == cell &&
      other.digit == digit;

  @override
  int get hashCode => Object.hash(runtimeType, cell, digit);
}

final class DigitPlacement extends SudokuMove {
  DigitPlacement(super.cell, super.digit);

  @override
  String toString() => 'DigitPlacement(cell: $cell, digit: $digit)';
}

final class CandidateElimination extends SudokuMove {
  CandidateElimination(super.cell, super.digit);

  @override
  String toString() => 'CandidateElimination(cell: $cell, digit: $digit)';
}
