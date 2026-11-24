import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// A solution can only be created after checking the puzzle's uniqueness.
final class PreparedGame {
  const PreparedGame._(this.givens, this.solution);

  final SudokuBoard givens;
  final SudokuBoard solution;

  SudokuBoard solutionFor(SudokuBoard board) {
    if (board != givens) {
      throw ArgumentError('Prepared solution belongs to a different board.');
    }
    return solution;
  }
}

/// Keeps mathematical search off the UI isolate. Only the latest puzzle is
/// retained; this contains no account data or mutable game progress.
@lazySingleton
final class GamePreparation {
  GamePreparation(this._solver) : _offMainIsolate = true;

  /// The same uniqueness check and solve, run synchronously. Widget tests use
  /// it so fake-async time never waits on a real background isolate.
  @visibleForTesting
  GamePreparation.inline(this._solver) : _offMainIsolate = false;

  final ExactSolver _solver;
  final bool _offMainIsolate;
  SudokuBoard? _board;
  Future<PreparedGame>? _pending;

  Future<PreparedGame> prepare(SudokuBoard board) {
    if (_board == board && _pending != null) return _pending!;
    _board = board;
    // Capture only pure Dart values, never this service or platform resources.
    final solver = _solver;
    PreparedGame solve() {
      if (solver.countSolutions(board) != 1) {
        throw StateError('A game must have exactly one solution.');
      }
      return PreparedGame._(board, solver.solve(board)!);
    }

    final pending = _offMainIsolate
        ? Isolate.run(solve, debugName: 'michi.game.prepare')
        : Future.sync(solve);
    _pending = pending;
    return pending;
  }
}
