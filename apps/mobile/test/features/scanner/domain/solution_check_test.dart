import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/scanner/domain/solution_check.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  const solver = BacktrackingExactSolver();
  // Book page 1, puzzle 2 (printed givens only) and its solution.
  final puzzle = SudokuBoard.parse('''
    000000820
    080039000
    045006000
    650000001
    400195007
    100600504
    000240030
    007900006
    094300000
  ''');
  final solution = solver.solve(puzzle)!;

  SudokuBoard partly(int filled) {
    var board = puzzle;
    var placed = 0;
    for (var i = 0; i < 81 && placed < filled; i++) {
      if (board.values[i] == 0) {
        board = board.withValue(CellRef.fromIndex(i), solution.values[i]);
        placed++;
      }
    }
    return board;
  }

  test('a fully and correctly solved page is solved', () {
    expect(checkSolutionOf(solution, solver).verdict, SolutionVerdict.solved);
  });

  test('correct entries so far are on track, whatever is printed', () {
    expect(
      checkSolutionOf(partly(20), solver).verdict,
      SolutionVerdict.onTrack,
    );
  });

  test('a repeated digit is a conflict with both cells marked', () {
    final board = puzzle.withValue(CellRef(row: 0, column: 0), 8);
    final check = checkSolutionOf(board, solver);
    expect(check.verdict, SolutionVerdict.conflicts);
    expect(check.suspects, contains(CellRef(row: 0, column: 0)));
  });

  test('a wrong but rule-following entry is found without the answer', () {
    var board = partly(30);
    // Change one written digit to another value that breaks no rule yet.
    final index =
        [
          for (var i = 0; i < 81; i++)
            if (puzzle.values[i] == 0 && board.values[i] != 0) i,
        ].firstWhere((i) {
          for (var d = 1; d <= 9; d++) {
            if (d == board.values[i]) continue;
            final trial = board.withValue(CellRef.fromIndex(i), d);
            if (SudokuConstraints.validate(trial).isValid) return true;
          }
          return false;
        });
    for (var d = 1; d <= 9; d++) {
      if (d == board.values[index]) continue;
      final trial = board.withValue(CellRef.fromIndex(index), d);
      if (SudokuConstraints.validate(trial).isValid) {
        board = trial;
        break;
      }
    }
    final check = checkSolutionOf(board, solver);
    expect(check.verdict, SolutionVerdict.offTrack);
    expect(check.suspects, contains(CellRef.fromIndex(index)));
  });
}
