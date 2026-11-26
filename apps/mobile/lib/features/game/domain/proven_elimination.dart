import 'package:flutter/foundation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// A candidate removal the player accepted from Coach, with the position it
/// was proven on.
///
/// Human deductions are monotonic: adding correct digits only removes
/// candidates, so a removal proven on [basis] stays valid while every digit
/// of [basis] is still on the board. Erasing or undoing any of them may take
/// away its justification, so it is dropped. This is logical solver state,
/// never the player's own pencil notes.
@immutable
final class ProvenElimination {
  const ProvenElimination({required this.removal, required this.basis});

  final CandidateElimination removal;
  final SudokuBoard basis;

  bool holdsOn(SudokuBoard board) {
    if (board.isFilled(removal.cell)) return false;
    for (var index = 0; index < 81; index++) {
      final digit = basis.values[index];
      if (digit != 0 && board.values[index] != digit) return false;
    }
    return true;
  }

  @override
  bool operator ==(Object other) =>
      other is ProvenElimination &&
      other.removal == removal &&
      other.basis == basis;

  @override
  int get hashCode => Object.hash(removal, basis);
}
