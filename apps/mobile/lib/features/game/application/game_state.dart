import 'package:flutter/foundation.dart';
import 'package:michi_mobile/core/errors/app_failure.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

enum GameStatus { playing, completed }

enum HintUnavailableReason { wrongEntry, unsupportedStep }

/// An application snapshot for undo. Mistakes are a cumulative session count.
@immutable
final class GameSnapshot {
  GameSnapshot({
    required this.board,
    required Map<CellRef, CandidateMask> notes,
  }) : notes = Map<CellRef, CandidateMask>.unmodifiable(notes);

  final SudokuBoard board;
  final Map<CellRef, CandidateMask> notes;
}

@immutable
final class ActiveCoachSession {
  const ActiveCoachSession({required this.plan, required this.hintIndex});

  final CoachPlan plan;
  final int hintIndex;

  Deduction get deduction => plan.deduction;
  CoachHint get hint => plan.hints[hintIndex];

  ActiveCoachSession next() => ActiveCoachSession(
    plan: plan,
    hintIndex: hintIndex < plan.length - 1 ? hintIndex + 1 : hintIndex,
  );
}

/// Immutable game data. User notes are intentionally separate from engine
/// candidates and never supplied to HumanSolver.
@immutable
final class GameState {
  GameState({
    required this.gameId,
    required this.startedAt,
    required this.puzzle,
    required this.solution,
    required this.board,
    required Map<CellRef, CandidateMask> notes,
    required List<GameSnapshot> history,
    this.dailyChallengeKey,
    this.selectedCell,
    this.notesMode = false,
    this.mistakes = 0,
    this.status = GameStatus.playing,
    this.isPaused = false,
    this.hintsRequested = 0,
    this.highestHintLevelUsed = 0,
    Map<SudokuTechnique, int> techniqueHelp = const {},
    this.storageFailure,
    this.coach,
    this.hintUnavailable,
  }) : techniqueHelp = Map<SudokuTechnique, int>.unmodifiable(techniqueHelp),
       notes = Map<CellRef, CandidateMask>.unmodifiable(notes),
       history = List<GameSnapshot>.unmodifiable(history);

  final String gameId;
  final DateTime startedAt;
  final SudokuPuzzle puzzle;
  final String? dailyChallengeKey;
  final SudokuBoard solution;
  final SudokuBoard board;
  final Map<CellRef, CandidateMask> notes;
  final List<GameSnapshot> history;
  final CellRef? selectedCell;
  final bool notesMode;
  final int mistakes;
  final GameStatus status;
  final bool isPaused;
  final int hintsRequested;
  final int highestHintLevelUsed;
  final Map<SudokuTechnique, int> techniqueHelp;
  final StorageFailure? storageFailure;
  final ActiveCoachSession? coach;
  final HintUnavailableReason? hintUnavailable;

  bool isGiven(CellRef cell) => puzzle.givens.isFilled(cell);

  bool isWrong(CellRef cell) =>
      !isGiven(cell) &&
      board.isFilled(cell) &&
      board.valueAt(cell) != solution.valueAt(cell);

  Iterable<CellRef> get wrongCells =>
      Iterable<CellRef>.generate(81, CellRef.fromIndex).where(isWrong);

  int remainingCount(int digit) =>
      9 -
      Iterable<CellRef>.generate(
        81,
        CellRef.fromIndex,
      ).where((cell) => board.valueAt(cell) == digit && !isWrong(cell)).length;

  int get editableCells => puzzle.givens.emptyCellCount;

  int get correctEditableCells =>
      Iterable<CellRef>.generate(
            81,
            CellRef.fromIndex,
          )
          .where(
            (cell) =>
                !isGiven(cell) &&
                board.isFilled(cell) &&
                board.valueAt(cell) == solution.valueAt(cell),
          )
          .length;

  bool get canUndo => history.isNotEmpty;

  bool get canErase {
    final cell = selectedCell;
    return cell != null &&
        !isGiven(cell) &&
        (board.isFilled(cell) || (notes[cell]?.isEmpty == false));
  }

  GameState copyWith({
    SudokuBoard? board,
    Map<CellRef, CandidateMask>? notes,
    List<GameSnapshot>? history,
    CellRef? selectedCell,
    bool keepSelection = true,
    bool? notesMode,
    int? mistakes,
    GameStatus? status,
    bool? isPaused,
    int? hintsRequested,
    int? highestHintLevelUsed,
    Map<SudokuTechnique, int>? techniqueHelp,
    StorageFailure? storageFailure,
    bool keepStorageFailure = true,
    ActiveCoachSession? coach,
    bool keepCoach = true,
    HintUnavailableReason? hintUnavailable,
    bool keepHintUnavailable = true,
  }) => GameState(
    gameId: gameId,
    startedAt: startedAt,
    puzzle: puzzle,
    dailyChallengeKey: dailyChallengeKey,
    solution: solution,
    board: board ?? this.board,
    notes: notes ?? this.notes,
    history: history ?? this.history,
    selectedCell: keepSelection
        ? selectedCell ?? this.selectedCell
        : selectedCell,
    notesMode: notesMode ?? this.notesMode,
    mistakes: mistakes ?? this.mistakes,
    status: status ?? this.status,
    isPaused: isPaused ?? this.isPaused,
    hintsRequested: hintsRequested ?? this.hintsRequested,
    highestHintLevelUsed: highestHintLevelUsed ?? this.highestHintLevelUsed,
    techniqueHelp: techniqueHelp ?? this.techniqueHelp,
    storageFailure: keepStorageFailure
        ? storageFailure ?? this.storageFailure
        : storageFailure,
    coach: keepCoach ? coach ?? this.coach : coach,
    hintUnavailable: keepHintUnavailable
        ? hintUnavailable ?? this.hintUnavailable
        : hintUnavailable,
  );
}
