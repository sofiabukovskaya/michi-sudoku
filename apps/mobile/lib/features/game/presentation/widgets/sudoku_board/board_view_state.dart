import 'package:flutter/foundation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../../../application/game_state.dart';

/// Only the state needed to paint and announce board cells.
@immutable
final class BoardViewState {
  const BoardViewState({
    required this.givens,
    required this.board,
    required this.solution,
    required this.notes,
    required this.selectedCell,
    required this.coachHint,
    this.selectedEliminations = const {},
  });

  factory BoardViewState.educational({
    required HumanSolverState state,
    CellRef? selectedCell,
    CoachHint? coachHint,
    Set<CandidateElimination> selectedEliminations = const {},
  }) => BoardViewState(
    givens: state.board,
    board: state.board,
    solution: state.board,
    notes: state.candidates,
    selectedCell: selectedCell,
    coachHint: coachHint,
    selectedEliminations: selectedEliminations,
  );

  factory BoardViewState.fromGame(GameState game) => BoardViewState(
    givens: game.puzzle.givens,
    board: game.board,
    solution: game.solution,
    notes: game.notes,
    selectedCell: game.selectedCell,
    coachHint: game.coach?.hint,
  );

  final SudokuBoard givens;
  final SudokuBoard board;
  final SudokuBoard solution;
  final Map<CellRef, CandidateMask> notes;
  final CellRef? selectedCell;
  final CoachHint? coachHint;
  final Set<CandidateElimination> selectedEliminations;

  bool isGiven(CellRef cell) => givens.isFilled(cell);
  bool isWrong(CellRef cell) =>
      !isGiven(cell) &&
      board.isFilled(cell) &&
      board.valueAt(cell) != solution.valueAt(cell);

  @override
  bool operator ==(Object other) =>
      other is BoardViewState &&
      givens == other.givens &&
      board == other.board &&
      solution == other.solution &&
      selectedCell == other.selectedCell &&
      coachHint == other.coachHint &&
      setEquals(selectedEliminations, other.selectedEliminations) &&
      mapEquals(notes, other.notes);

  @override
  int get hashCode => Object.hash(
    givens,
    board,
    solution,
    selectedCell,
    coachHint,
    Object.hashAllUnordered(selectedEliminations),
    Object.hashAllUnordered(
      notes.entries.map((entry) => Object.hash(entry.key, entry.value)),
    ),
  );
}
