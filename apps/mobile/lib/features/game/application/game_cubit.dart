import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Owns one offline game session. Sudoku reasoning stays in sudoku_engine.
final class GameCubit extends Cubit<GameState> {
  GameCubit({
    required SudokuPuzzle puzzle,
    required ExactSolver exactSolver,
    required HumanSolver humanSolver,
    required CoachEngine coachEngine,
  }) : _humanSolver = humanSolver,
       _coachEngine = coachEngine,
       super(_initialState(puzzle, exactSolver));

  final HumanSolver _humanSolver;
  final CoachEngine _coachEngine;

  static GameState _initialState(SudokuPuzzle puzzle, ExactSolver solver) {
    if (solver.countSolutions(puzzle.givens) != 1) {
      throw StateError('Puzzle ${puzzle.id} must have one solution.');
    }
    final solution = solver.solve(puzzle.givens);
    if (solution == null) {
      throw StateError('Puzzle ${puzzle.id} has no solution.');
    }
    return GameState(
      puzzle: puzzle,
      solution: solution,
      board: puzzle.givens,
      notes: const {},
      history: const [],
    );
  }

  void selectCell(CellRef cell) {
    if (state.status == GameStatus.completed) return;
    emit(state.copyWith(selectedCell: cell));
  }

  void toggleNotesMode() {
    if (state.status == GameStatus.completed) return;
    emit(state.copyWith(notesMode: !state.notesMode));
  }

  void enterDigit(int digit) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
    final cell = state.selectedCell;
    if (cell == null ||
        state.isGiven(cell) ||
        state.status != GameStatus.playing) {
      return;
    }
    if (state.notesMode) {
      _toggleNote(cell, digit);
      return;
    }
    if (state.board.valueAt(cell) == digit) return;

    final nextBoard = state.board.withValue(cell, digit);
    final nextNotes = Map<CellRef, CandidateMask>.of(state.notes)..remove(cell);
    if (digit == state.solution.valueAt(cell)) {
      for (final peer in SudokuConstraints.peersOf(cell)) {
        final mask = nextNotes[peer];
        if (mask == null) continue;
        final reduced = mask.remove(digit);
        if (reduced.isEmpty) {
          nextNotes.remove(peer);
        } else {
          nextNotes[peer] = reduced;
        }
      }
    }
    _commit(
      nextBoard,
      nextNotes,
      mistakes:
          state.mistakes + (digit != state.solution.valueAt(cell) ? 1 : 0),
    );
  }

  void _toggleNote(CellRef cell, int digit) {
    if (state.board.isFilled(cell)) return;
    final nextNotes = Map<CellRef, CandidateMask>.of(state.notes);
    final current = nextNotes[cell] ?? CandidateMask.empty;
    final next = current.contains(digit)
        ? current.remove(digit)
        : current.add(digit);
    if (next.isEmpty) {
      nextNotes.remove(cell);
    } else {
      nextNotes[cell] = next;
    }
    _commit(state.board, nextNotes, invalidateCoach: false);
  }

  void erase() {
    final cell = state.selectedCell;
    if (cell == null || !state.canErase || state.status != GameStatus.playing) {
      return;
    }
    final nextNotes = Map<CellRef, CandidateMask>.of(state.notes);
    if (state.board.isFilled(cell)) {
      _commit(state.board.withValue(cell, 0), nextNotes);
    } else {
      nextNotes.remove(cell);
      _commit(state.board, nextNotes, invalidateCoach: false);
    }
  }

  void undo() {
    if (!state.canUndo || state.status == GameStatus.completed) return;
    final previous = state.history.last;
    final boardChanged = previous.board != state.board;
    emit(
      state.copyWith(
        board: previous.board,
        notes: previous.notes,
        history: state.history.sublist(0, state.history.length - 1),
        keepCoach: !boardChanged,
        keepHintUnavailable: !boardChanged,
      ),
    );
  }

  void requestHint() {
    if (state.status != GameStatus.playing) return;
    if (state.wrongCells.isNotEmpty) {
      emit(
        state.copyWith(
          keepCoach: false,
          hintUnavailable: HintUnavailableReason.wrongEntry,
        ),
      );
      return;
    }
    final solverState = HumanSolverState.initial(state.board);
    final deduction = _humanSolver.findNextDeduction(solverState);
    if (deduction == null) {
      emit(
        state.copyWith(
          keepCoach: false,
          hintUnavailable: HintUnavailableReason.unsupportedStep,
        ),
      );
      return;
    }
    final plan = _coachEngine.createPlan(deduction);
    emit(
      state.copyWith(
        coach: ActiveCoachSession(plan: plan, hintIndex: 0),
        keepHintUnavailable: false,
      ),
    );
  }

  void requestNextHint() {
    final current = state.coach;
    if (current == null) return;
    emit(state.copyWith(coach: current.next()));
  }

  void dismissHint() => emit(
    state.copyWith(
      keepCoach: false,
      keepHintUnavailable: false,
    ),
  );

  void selectWrongCell() {
    final wrong = state.wrongCells.firstOrNull;
    if (wrong == null) return;
    emit(
      state.copyWith(
        selectedCell: wrong,
        keepCoach: false,
        keepHintUnavailable: false,
      ),
    );
  }

  /// Placement results require explicit user action; eliminations are visual.
  void applyCoachResult() {
    final coach = state.coach;
    if (coach == null || coach.hint.level != CoachHintLevel.result) return;
    final placements = coach.hint.revealedPlacements;
    if (placements.length != 1) return;
    final move = placements.single;
    if (state.isGiven(move.cell)) return;
    selectCell(move.cell);
    final wasNotesMode = state.notesMode;
    if (wasNotesMode) emit(state.copyWith(notesMode: false));
    enterDigit(move.digit);
  }

  void _commit(
    SudokuBoard board,
    Map<CellRef, CandidateMask> notes, {
    int? mistakes,
    bool invalidateCoach = true,
  }) {
    final previous = GameSnapshot(board: state.board, notes: state.notes);
    emit(
      state.copyWith(
        board: board,
        notes: notes,
        history: [...state.history, previous],
        mistakes: mistakes,
        status: board == state.solution
            ? GameStatus.completed
            : GameStatus.playing,
        keepCoach: !invalidateCoach,
        keepHintUnavailable: !invalidateCoach,
      ),
    );
  }
}
