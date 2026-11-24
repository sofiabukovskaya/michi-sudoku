import 'dart:typed_data';

import '../core/sudoku_constraints.dart';
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
/// [SudokuConstraints] validates the input; the search itself works on
/// row/column/box bitmasks so each node costs a few integer operations. The
/// search order is fixed: the lowest-index naked single is placed first, then
/// the lowest-index cell with the fewest candidates branches on digits in
/// ascending order. That order defines which solution [solve] returns for a
/// board with several solutions.
final class BacktrackingExactSolver implements ExactSolver {
  const BacktrackingExactSolver();

  @override
  SudokuBoard? solve(SudokuBoard board) {
    if (!SudokuConstraints.validate(board).isValid) return null;
    if (board.isComplete) return board;
    final search = _BitmaskSearch(board, 1)..run();
    final solution = search.firstSolution;
    return solution == null ? null : SudokuBoard(solution);
  }

  @override
  bool hasSolution(SudokuBoard board) => countSolutions(board, limit: 1) == 1;

  @override
  int countSolutions(SudokuBoard board, {int limit = 2}) {
    if (limit < 1) {
      throw ArgumentError.value(limit, 'limit', 'Must be at least 1.');
    }
    if (!SudokuConstraints.validate(board).isValid) return 0;
    return (_BitmaskSearch(board, limit)..run()).count;
  }

  @override
  bool hasUniqueSolution(SudokuBoard board) => countSolutions(board) == 1;
}

/// One search over a rule-valid board. Each recursion level owns a copy of
/// 81 cell values and 27 unit masks, so backtracking needs no undo log.
final class _BitmaskSearch {
  _BitmaskSearch(SudokuBoard board, this._limit) {
    final values = board.values;
    final cells = Int8List(81);
    final units = Int32List(27);
    for (var index = 0; index < 81; index++) {
      final digit = values[index];
      if (digit == 0) continue;
      cells[index] = digit;
      final bit = 1 << (digit - 1);
      units[_row[index]] |= bit;
      units[_column[index]] |= bit;
      units[_box[index]] |= bit;
    }
    _cells = cells;
    _units = units;
  }

  static const int _all = 0x1ff;
  static final Int8List _row = Int8List.fromList([
    for (var index = 0; index < 81; index++) index ~/ 9,
  ]);
  static final Int8List _column = Int8List.fromList([
    for (var index = 0; index < 81; index++) 9 + index % 9,
  ]);
  static final Int8List _box = Int8List.fromList([
    for (var index = 0; index < 81; index++)
      18 + (index ~/ 27) * 3 + (index % 9) ~/ 3,
  ]);
  static final Int8List _bitCount = Int8List.fromList([
    for (var bits = 0; bits <= _all; bits++) _countBits(bits),
  ]);

  static int _countBits(int bits) {
    var count = 0;
    for (var remaining = bits; remaining != 0; remaining &= remaining - 1) {
      count++;
    }
    return count;
  }

  final int _limit;
  late final Int8List _cells;
  late final Int32List _units;
  int count = 0;
  List<int>? firstSolution;

  void run() => _search(_cells, _units);

  void _search(Int8List cells, Int32List units) {
    // Repeatedly place the lowest-index cell with one candidate. A full scan
    // checks zero-candidate contradictions before any placement. Without a
    // single, the lowest-index cell with the fewest candidates branches.
    int branchCell;
    int branchCandidates;
    while (true) {
      var forcedCell = -1;
      var forcedBits = 0;
      branchCell = -1;
      branchCandidates = 0;
      var branchCount = 10;
      for (var index = 0; index < 81; index++) {
        if (cells[index] != 0) continue;
        final candidates =
            _all &
            ~(units[_row[index]] | units[_column[index]] | units[_box[index]]);
        if (candidates == 0) return;
        final candidateCount = _bitCount[candidates];
        if (forcedCell < 0 && candidateCount == 1) {
          forcedCell = index;
          forcedBits = candidates;
        }
        if (candidateCount < branchCount) {
          branchCell = index;
          branchCandidates = candidates;
          branchCount = candidateCount;
        }
      }
      if (forcedCell < 0) break;
      cells[forcedCell] = _bitCount[forcedBits - 1] + 1;
      units[_row[forcedCell]] |= forcedBits;
      units[_column[forcedCell]] |= forcedBits;
      units[_box[forcedCell]] |= forcedBits;
    }

    if (branchCell < 0) {
      count++;
      firstSolution ??= List<int>.of(cells);
      return;
    }

    for (var digit = 1; digit <= 9; digit++) {
      final bit = 1 << (digit - 1);
      if (branchCandidates & bit == 0) continue;
      final nextCells = Int8List.fromList(cells)..[branchCell] = digit;
      final nextUnits = Int32List.fromList(units);
      nextUnits[_row[branchCell]] |= bit;
      nextUnits[_column[branchCell]] |= bit;
      nextUnits[_box[branchCell]] |= bit;
      _search(nextCells, nextUnits);
      if (count >= _limit) return;
    }
  }
}
