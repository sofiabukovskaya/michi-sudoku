import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_mobile/core/errors/app_failure.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/application/game_timer.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Owns an offline game session and serializes its persistence operations.
final class GameCubit extends Cubit<GameState> {
  factory GameCubit({
    required SudokuPuzzle puzzle,
    required ExactSolver exactSolver,
    required HumanSolver humanSolver,
    required CoachEngine coachEngine,
    String? dailyChallengeKey,
    GameRepository? repository,
    GameClock? clock,
  }) {
    final gameClock = clock ?? SystemGameClock();
    final now = gameClock.now();
    return GameCubit._(
      state: GameState(
        gameId:
            '${puzzle.id}-${now.microsecondsSinceEpoch}-'
            '${Random.secure().nextInt(0x7fffffff)}',
        startedAt: now,
        puzzle: puzzle,
        dailyChallengeKey: dailyChallengeKey,
        solution: _solve(puzzle, exactSolver),
        board: puzzle.givens,
        notes: const {},
        history: const [],
      ),
      timer: GameTimer.start(gameClock),
      clock: gameClock,
      repository: repository,
      humanSolver: humanSolver,
      coachEngine: coachEngine,
      saveOnCreate: true,
    );
  }

  /// Restored games reopen paused. Selection and Coach UI are transient.
  factory GameCubit.restore({
    required StoredGame stored,
    required ExactSolver exactSolver,
    required HumanSolver humanSolver,
    required CoachEngine coachEngine,
    GameRepository? repository,
    GameClock? clock,
  }) {
    final gameClock = clock ?? SystemGameClock();
    _validateStored(stored);
    final puzzle = SudokuPuzzle(
      id: stored.puzzleId,
      givens: stored.initialBoard,
    );
    final solution = _solve(puzzle, exactSolver);
    if (stored.currentBoard == solution) {
      throw const FormatException('Completed board stored as active.');
    }
    return GameCubit._(
      state: GameState(
        gameId: stored.gameId,
        startedAt: stored.startedAt,
        puzzle: puzzle,
        dailyChallengeKey: stored.dailyChallengeKey,
        solution: solution,
        board: stored.currentBoard,
        notes: stored.notes,
        reasoning: stored.reasoning,
        history: [
          for (final item in stored.undoHistory)
            GameSnapshot(
              board: item.board,
              notes: item.notes,
              reasoning: item.reasoning,
            ),
        ],
        mistakes: stored.mistakes,
        isPaused: true,
        hintsRequested: stored.hintsRequested,
        highestHintLevelUsed: stored.highestHintLevelUsed,
        techniqueHelp: stored.techniqueHelp,
      ),
      timer: GameTimer.restore(
        clock: gameClock,
        elapsedBeforeRun: stored.elapsedBeforeRun,
        runningSince: stored.runningSince,
      ),
      clock: gameClock,
      repository: repository,
      humanSolver: humanSolver,
      coachEngine: coachEngine,
      saveOnCreate: !stored.isPaused,
    );
  }

  GameCubit._({
    required GameState state,
    required GameTimer timer,
    required GameClock clock,
    required GameRepository? repository,
    required HumanSolver humanSolver,
    required CoachEngine coachEngine,
    required bool saveOnCreate,
  }) : _timer = timer,
       _clock = clock,
       _repository = repository,
       _humanSolver = humanSolver,
       _coachEngine = coachEngine,
       super(state) {
    if (saveOnCreate) _scheduleSave();
  }

  final HumanSolver _humanSolver;
  final CoachEngine _coachEngine;
  final GameRepository? _repository;
  final GameClock _clock;
  GameTimer _timer;
  Future<void> _writes = Future<void>.value();

  static SudokuBoard _solve(SudokuPuzzle puzzle, ExactSolver solver) {
    if (solver.countSolutions(puzzle.givens) != 1) {
      throw StateError('Puzzle ${puzzle.id} must have one solution.');
    }
    return solver.solve(puzzle.givens)!;
  }

  static void _validateStored(StoredGame stored) {
    if (stored.gameId.isEmpty ||
        stored.mistakes < 0 ||
        stored.undoHistory.length > 100 ||
        stored.isPaused != (stored.runningSince == null)) {
      throw const FormatException('Incoherent stored game.');
    }
    for (var index = 0; index < 81; index++) {
      final cell = CellRef.fromIndex(index);
      if (stored.initialBoard.isFilled(cell) &&
          stored.initialBoard.valueAt(cell) !=
              stored.currentBoard.valueAt(cell)) {
        throw const FormatException('A given cell was changed.');
      }
    }
  }

  Duration get elapsed => _timer.elapsed;

  Future<void> flushPersistence() => _writes;

  void pause() {
    if (state.isPaused || state.status == GameStatus.completed) return;
    _timer = _timer.pause();
    emit(state.copyWith(isPaused: true));
    _scheduleSave();
  }

  void resume() {
    if (!state.isPaused || state.status == GameStatus.completed) return;
    _timer = _timer.resume();
    emit(state.copyWith(isPaused: false));
    _scheduleSave();
  }

  Future<void> onAppBackground() async {
    pause();
    await flushPersistence();
  }

  void selectCell(CellRef cell) {
    if (state.isPaused || state.status == GameStatus.completed) return;
    emit(state.copyWith(selectedCell: cell));
  }

  WhySelection whyForCell(CellRef cell) {
    if (state.board.isEmpty(cell)) {
      return const WhySelection(WhyAvailability.empty);
    }
    if (state.isGiven(cell)) {
      return const WhySelection(WhyAvailability.given);
    }
    if (state.isWrong(cell)) {
      return const WhySelection(WhyAvailability.wrong);
    }
    final record = state.reasoning[cell];
    if (record == null ||
        record.cell != cell ||
        record.digit != state.board.valueAt(cell) ||
        record.preMoveBoard.isFilled(cell)) {
      return const WhySelection(WhyAvailability.unsupported);
    }
    for (var index = 0; index < 81; index++) {
      final given = CellRef.fromIndex(index);
      if (state.isGiven(given) &&
          record.preMoveBoard.valueAt(given) !=
              state.puzzle.givens.valueAt(given)) {
        return const WhySelection(WhyAvailability.unsupported);
      }
    }
    final deduction = _humanSolver.findDeductionForPlacement(
      HumanSolverState.initial(record.preMoveBoard),
      record.placement,
    );
    if (deduction == null || deduction.technique != record.technique) {
      return const WhySelection(WhyAvailability.unsupported);
    }
    final plan = const StructuredWhyEngine().createPlan(
      deduction,
      record.placement,
    );
    return plan == null
        ? const WhySelection(WhyAvailability.unsupported)
        : WhySelection(WhyAvailability.available, plan: plan);
  }

  void toggleNotesMode() {
    if (state.isPaused || state.status == GameStatus.completed) return;
    emit(state.copyWith(notesMode: !state.notesMode));
  }

  void enterDigit(int digit) => _enterDigit(digit);

  void _enterDigit(int digit, {Deduction? coachDeduction}) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
    final cell = state.selectedCell;
    if (cell == null ||
        state.isGiven(cell) ||
        state.isPaused ||
        state.status != GameStatus.playing) {
      return;
    }
    if (state.notesMode) {
      _toggleNote(cell, digit);
      return;
    }
    if (state.board.valueAt(cell) == digit) return;
    final nextReasoning = Map<CellRef, MoveReasoningContext>.of(state.reasoning)
      ..remove(cell);
    if (digit == state.solution.valueAt(cell)) {
      var preMoveBoard = state.board.withValue(cell, 0);
      for (final wrong in state.wrongCells) {
        preMoveBoard = preMoveBoard.withValue(wrong, 0);
      }
      final target = DigitPlacement(cell, digit);
      final deduction = coachDeduction?.placements.contains(target) == true
          ? coachDeduction
          : _humanSolver.findDeductionForPlacement(
              HumanSolverState.initial(preMoveBoard),
              target,
            );
      if (deduction != null) {
        nextReasoning[cell] = MoveReasoningContext(
          preMoveBoard: preMoveBoard,
          cell: cell,
          digit: digit,
          technique: deduction.technique,
          source: coachDeduction == deduction
              ? MoveReasoningSource.coach
              : MoveReasoningSource.manual,
        );
      }
    }
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
      reasoning: nextReasoning,
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
    if (cell == null ||
        state.isPaused ||
        !state.canErase ||
        state.status != GameStatus.playing) {
      return;
    }
    final nextNotes = Map<CellRef, CandidateMask>.of(state.notes);
    if (state.board.isFilled(cell)) {
      _commit(
        state.board.withValue(cell, 0),
        nextNotes,
        reasoning: Map<CellRef, MoveReasoningContext>.of(state.reasoning)
          ..remove(cell),
      );
    } else {
      nextNotes.remove(cell);
      _commit(state.board, nextNotes, invalidateCoach: false);
    }
  }

  void undo() {
    if (!state.canUndo ||
        state.isPaused ||
        state.status == GameStatus.completed) {
      return;
    }
    final previous = state.history.last;
    final boardChanged = previous.board != state.board;
    emit(
      state.copyWith(
        board: previous.board,
        notes: previous.notes,
        reasoning: previous.reasoning,
        history: state.history.sublist(0, state.history.length - 1),
        keepCoach: !boardChanged,
        keepHintUnavailable: !boardChanged,
      ),
    );
    _scheduleSave();
  }

  void requestHint() {
    if (state.isPaused || state.status != GameStatus.playing) return;
    if (state.wrongCells.isNotEmpty) {
      emit(
        state.copyWith(
          keepCoach: false,
          hintUnavailable: HintUnavailableReason.wrongEntry,
        ),
      );
      return;
    }
    final deduction = _humanSolver.findNextDeduction(
      HumanSolverState.initial(state.board),
    );
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
    final help = Map<SudokuTechnique, int>.of(state.techniqueHelp)
      ..update(
        deduction.technique,
        (level) => level < 1 ? 1 : level,
        ifAbsent: () => 1,
      );
    emit(
      state.copyWith(
        coach: ActiveCoachSession(plan: plan, hintIndex: 0),
        keepHintUnavailable: false,
        hintsRequested: state.hintsRequested + 1,
        techniqueHelp: help,
        highestHintLevelUsed: state.highestHintLevelUsed < 1
            ? 1
            : state.highestHintLevelUsed,
      ),
    );
    _scheduleSave();
  }

  void requestNextHint() {
    final current = state.coach;
    if (state.isPaused || current == null) return;
    final next = current.next();
    if (next.hintIndex == current.hintIndex) return;
    final level = next.hintIndex + 1;
    final help = Map<SudokuTechnique, int>.of(state.techniqueHelp)
      ..update(
        current.plan.technique,
        (previous) => previous < level ? level : previous,
        ifAbsent: () => level,
      );
    emit(
      state.copyWith(
        coach: next,
        techniqueHelp: help,
        highestHintLevelUsed: next.hintIndex + 1 > state.highestHintLevelUsed
            ? next.hintIndex + 1
            : state.highestHintLevelUsed,
      ),
    );
    _scheduleSave();
  }

  void dismissHint() {
    if (state.isPaused) return;
    emit(state.copyWith(keepCoach: false, keepHintUnavailable: false));
  }

  void selectWrongCell() {
    if (state.isPaused) return;
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

  /// Placement results require an explicit action; eliminations stay visual.
  void applyCoachResult() {
    final coach = state.coach;
    if (state.isPaused ||
        coach == null ||
        coach.hint.level != CoachHintLevel.result) {
      return;
    }
    final placements = coach.hint.revealedPlacements;
    if (placements.length != 1) return;
    final move = placements.single;
    if (state.isGiven(move.cell)) return;
    selectCell(move.cell);
    if (state.notesMode) emit(state.copyWith(notesMode: false));
    _enterDigit(move.digit, coachDeduction: coach.deduction);
  }

  void retryPersistence() {
    if (state.status == GameStatus.completed) {
      _scheduleCompletion();
    } else {
      _scheduleSave();
    }
  }

  void _commit(
    SudokuBoard board,
    Map<CellRef, CandidateMask> notes, {
    Map<CellRef, MoveReasoningContext>? reasoning,
    int? mistakes,
    bool invalidateCoach = true,
  }) {
    final history = [
      ...state.history,
      GameSnapshot(
        board: state.board,
        notes: state.notes,
        reasoning: state.reasoning,
      ),
    ];
    if (history.length > 100) history.removeAt(0);
    final completed = board == state.solution;
    if (completed) _timer = _timer.pause();
    emit(
      state.copyWith(
        board: board,
        notes: notes,
        reasoning: reasoning,
        history: history,
        mistakes: mistakes,
        status: completed ? GameStatus.completed : GameStatus.playing,
        keepCoach: !invalidateCoach,
        keepHintUnavailable: !invalidateCoach,
      ),
    );
    if (completed) {
      _scheduleCompletion();
    } else {
      _scheduleSave();
    }
  }

  void _scheduleSave() {
    final repository = _repository;
    if (repository == null || state.status == GameStatus.completed) return;
    final snapshot = state;
    final timer = _timer;
    final game = StoredGame(
      gameId: snapshot.gameId,
      puzzleId: snapshot.puzzle.id,
      dailyChallengeKey: snapshot.dailyChallengeKey,
      initialBoard: snapshot.puzzle.givens,
      currentBoard: snapshot.board,
      notes: snapshot.notes,
      reasoning: snapshot.reasoning,
      undoHistory: [
        for (final item in snapshot.history)
          StoredGameSnapshot(
            board: item.board,
            notes: item.notes,
            reasoning: item.reasoning,
          ),
      ],
      mistakes: snapshot.mistakes,
      elapsedBeforeRun: timer.elapsedBeforeRun,
      runningSince: timer.runningSince,
      startedAt: snapshot.startedAt,
      updatedAt: _clock.now(),
      isPaused: timer.isPaused,
      hintsRequested: snapshot.hintsRequested,
      highestHintLevelUsed: snapshot.highestHintLevelUsed,
      techniqueHelp: snapshot.techniqueHelp,
      correctEditableCells: snapshot.correctEditableCells,
      editableCells: snapshot.editableCells,
    );
    _enqueue(() => repository.saveActiveGame(game));
  }

  void _scheduleCompletion() {
    final repository = _repository;
    if (repository == null) return;
    final snapshot = state;
    final completed = CompletedGame(
      gameId: snapshot.gameId,
      puzzleId: snapshot.puzzle.id,
      dailyChallengeKey: snapshot.dailyChallengeKey,
      initialBoard: snapshot.puzzle.givens,
      completedBoard: snapshot.board,
      startedAt: snapshot.startedAt,
      completedAt: _clock.now(),
      elapsed: _timer.elapsed,
      mistakes: snapshot.mistakes,
      hintsRequested: snapshot.hintsRequested,
      highestHintLevelUsed: snapshot.highestHintLevelUsed,
      techniqueHelp: snapshot.techniqueHelp,
    );
    _enqueue(() => repository.completeGame(completed));
  }

  void _enqueue(Future<void> Function() action) {
    _writes = _writes.then((_) async {
      try {
        await action();
        if (!isClosed && state.storageFailure != null) {
          emit(state.copyWith(keepStorageFailure: false));
        }
      } on Object catch (error, stackTrace) {
        developer.log(
          'Game persistence failed',
          name: 'michi.game',
          error: error,
          stackTrace: stackTrace,
        );
        if (!isClosed) {
          emit(
            state.copyWith(
              storageFailure: const StorageFailure('Game could not be saved.'),
              keepStorageFailure: false,
            ),
          );
        }
      }
    });
  }
}
