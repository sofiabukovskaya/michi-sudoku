import 'package:sudoku_engine/sudoku_engine.dart';

/// What checking a paper solution found. It never reveals an answer.
enum SolutionVerdict {
  /// Every cell is filled and the board follows the rules.
  solved,

  /// The digits so far can still be completed: no mistakes yet.
  onTrack,

  /// A digit repeats in a row, column or box.
  conflicts,

  /// No repeats, but the digits can no longer be completed; [SolutionCheck]
  /// marks the digits that could be the cause.
  offTrack,
}

final class SolutionCheck {
  SolutionCheck(this.verdict, {Set<CellRef> suspects = const {}})
    : suspects = Set.unmodifiable(suspects);

  final SolutionVerdict verdict;

  /// For [SolutionVerdict.conflicts]: the repeating digits. For
  /// [SolutionVerdict.offTrack]: digits whose removal makes the board
  /// solvable again ("one of these does not fit"), or, when no single digit
  /// explains it, the empty cells where nothing fits any more.
  final Set<CellRef> suspects;
}

/// Checks a paper puzzle in progress without knowing which digits were
/// printed. A published puzzle has exactly one solution, so the scanned
/// digits (printed and written together) can be completed only if every
/// written digit is right. When they cannot, the digits whose removal
/// restores a solution are the possible mistakes.
SolutionCheck checkSolutionOf(SudokuBoard board, ExactSolver solver) {
  final violations = SudokuConstraints.validate(board).violations;
  if (violations.isNotEmpty) {
    return SolutionCheck(
      SolutionVerdict.conflicts,
      suspects: {for (final v in violations) ...v.cells},
    );
  }
  if (board.isComplete) return SolutionCheck(SolutionVerdict.solved);
  if (solver.hasSolution(board)) return SolutionCheck(SolutionVerdict.onTrack);

  final suspects = <CellRef>{
    for (var index = 0; index < 81; index++)
      if (board.values[index] != 0 &&
          solver.hasSolution(board.withValue(CellRef.fromIndex(index), 0)))
        CellRef.fromIndex(index),
  };
  if (suspects.isNotEmpty) {
    return SolutionCheck(SolutionVerdict.offTrack, suspects: suspects);
  }
  // Several mistakes together: point at where the board visibly breaks,
  // the empty cells that no digit can fill.
  final dead = <CellRef>{
    for (var index = 0; index < 81; index++)
      if (board.values[index] == 0 && _candidates(board, index) == 0)
        CellRef.fromIndex(index),
  };
  return SolutionCheck(SolutionVerdict.offTrack, suspects: dead);
}

int _candidates(SudokuBoard board, int index) {
  final row = index ~/ 9;
  final column = index % 9;
  final used = <int>{};
  for (var k = 0; k < 9; k++) {
    used
      ..add(board.values[row * 9 + k])
      ..add(board.values[k * 9 + column]);
  }
  final boxRow = row - row % 3;
  final boxColumn = column - column % 3;
  for (var r = 0; r < 3; r++) {
    for (var c = 0; c < 3; c++) {
      used.add(board.values[(boxRow + r) * 9 + boxColumn + c]);
    }
  }
  return List.generate(9, (d) => d + 1).where((d) => !used.contains(d)).length;
}
