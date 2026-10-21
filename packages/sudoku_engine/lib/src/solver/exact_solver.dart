import '../core/candidate_calculator.dart';
import '../core/sudoku_constraints.dart';
import '../model/candidate_mask.dart';
import '../model/cell_ref.dart';
import '../model/sudoku_board.dart';

/// Mathematical solving and uniqueness checks; never used to invent hints.
abstract interface class ExactSolver {
  /// Returns one completed solution, or null for a contradictory board.
  SudokuBoard? solve(SudokuBoard board);

  /// Whether at least one mathematical solution exists.
  bool hasSolution(SudokuBoard board);

  /// Counts at most [limit] solutions, stopping as soon as the limit is met.
  ///
  /// The default of two is suited to uniqueness checks. [limit] must be
  /// positive; a rule-invalid board has zero solutions.
  int countSolutions(SudokuBoard board, {int limit = 2});

  /// Whether exactly one solution exists, counting no more than two.
  bool hasUniqueSolution(SudokuBoard board);
}

/// Deterministic exact search using singles propagation, MRV, and backtracking.
///
/// Search states are immutable [SudokuBoard] copies. The tested candidate and
/// constraint primitives remain the sole source of Sudoku rules.
final class BacktrackingExactSolver implements ExactSolver {
  const BacktrackingExactSolver();

  static const CandidateCalculator _calculator = CandidateCalculator();

  @override
  SudokuBoard? solve(SudokuBoard board) {
    if (!SudokuConstraints.validate(board).isValid) return null;
    return _search(board, 1).firstSolution;
  }

  @override
  bool hasSolution(SudokuBoard board) => countSolutions(board, limit: 1) == 1;

  @override
  int countSolutions(SudokuBoard board, {int limit = 2}) {
    if (limit < 1) {
      throw ArgumentError.value(limit, 'limit', 'Must be at least 1.');
    }
    if (!SudokuConstraints.validate(board).isValid) return 0;
    return _search(board, limit).count;
  }

  @override
  bool hasUniqueSolution(SudokuBoard board) => countSolutions(board) == 1;

  _SearchResult _search(SudokuBoard board, int limit) {
    final position = _propagate(board);
    if (position == null) return (count: 0, firstSolution: null);

    final branchCell = position.branchCell;
    if (branchCell == null) {
      return (count: 1, firstSolution: position.board);
    }

    var count = 0;
    SudokuBoard? firstSolution;
    for (final digit in position.candidates.digits) {
      final next = position.board.withValue(branchCell, digit);
      final result = _search(next, limit - count);
      count += result.count;
      firstSolution ??= result.firstSolution;
      if (count >= limit) break;
    }
    return (count: count, firstSolution: firstSolution);
  }

  /// Repeatedly place the lowest-index cell with one candidate.
  ///
  /// A full scan checks zero-candidate contradictions before any placement.
  /// If no single exists, the lowest-index cell with the fewest candidates
  /// becomes the next branch. Null means the board is contradictory.
  _SearchPosition? _propagate(SudokuBoard startingBoard) {
    var board = startingBoard;
    while (true) {
      CellRef? forcedCell;
      int? forcedDigit;
      CellRef? branchCell;
      CandidateMask? branchCandidates;

      for (var index = 0; index < 81; index++) {
        final cell = CellRef.fromIndex(index);
        if (board.isFilled(cell)) continue;

        final candidates = _calculator.candidatesFor(board, cell);
        if (candidates.isEmpty) return null;
        if (forcedCell == null && candidates.isSingle) {
          forcedCell = cell;
          forcedDigit = candidates.singleDigit;
        }
        if (branchCandidates == null ||
            candidates.count < branchCandidates.count) {
          branchCell = cell;
          branchCandidates = candidates;
        }
      }

      if (forcedCell != null) {
        board = board.withValue(forcedCell, forcedDigit!);
        continue;
      }
      return (
        board: board,
        branchCell: branchCell,
        candidates: branchCandidates ?? CandidateMask.empty,
      );
    }
  }
}

typedef _SearchResult = ({int count, SudokuBoard? firstSolution});

typedef _SearchPosition = ({
  SudokuBoard board,
  CellRef? branchCell,
  CandidateMask candidates,
});
