import 'package:meta/meta.dart';

import '../model/cell_ref.dart';

/// A candidate to highlight, without claiming it can be eliminated.
@immutable
final class CandidateRef {
  CandidateRef(this.cell, this.digit) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
  }

  final CellRef cell;
  final int digit;

  @override
  bool operator ==(Object other) =>
      other is CandidateRef && other.cell == cell && other.digit == digit;

  @override
  int get hashCode => Object.hash(cell, digit);

  @override
  String toString() => 'CandidateRef(cell: $cell, digit: $digit)';
}
