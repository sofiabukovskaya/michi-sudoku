import 'cell_ref.dart';

/// A semantic change proposed by a human technique.
sealed class SudokuMove {
  SudokuMove(this.cell, this.digit) {
    if (digit < 1 || digit > 9) {
      throw RangeError.range(digit, 1, 9, 'digit');
    }
  }

  final CellRef cell;
  final int digit;
}

final class DigitPlacement extends SudokuMove {
  DigitPlacement(super.cell, super.digit);
}

final class CandidateElimination extends SudokuMove {
  CandidateElimination(super.cell, super.digit);
}
