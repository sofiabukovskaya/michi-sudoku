import 'package:sudoku_engine/sudoku_engine.dart';

/// One bounded, meaningful undo action. Mistakes are cumulative and are not
/// rolled back by undo, matching the existing game behavior.
final class StoredGameSnapshot {
  StoredGameSnapshot({
    required this.board,
    required Map<CellRef, CandidateMask> notes,
  }) : notes = Map<CellRef, CandidateMask>.unmodifiable(notes);

  final SudokuBoard board;
  final Map<CellRef, CandidateMask> notes;
}

final class StoredGame {
  StoredGame({
    required this.gameId,
    required this.puzzleId,
    required this.initialBoard,
    required this.currentBoard,
    required Map<CellRef, CandidateMask> notes,
    required List<StoredGameSnapshot> undoHistory,
    required this.mistakes,
    required this.elapsedBeforeRun,
    required this.runningSince,
    required this.startedAt,
    required this.updatedAt,
    required this.isPaused,
    required this.hintsRequested,
    required this.highestHintLevelUsed,
    required this.correctEditableCells,
    required this.editableCells,
  }) : notes = Map<CellRef, CandidateMask>.unmodifiable(notes),
       undoHistory = List<StoredGameSnapshot>.unmodifiable(undoHistory);

  final String gameId;
  final String puzzleId;
  final SudokuBoard initialBoard;
  final SudokuBoard currentBoard;
  final Map<CellRef, CandidateMask> notes;
  final List<StoredGameSnapshot> undoHistory;
  final int mistakes;
  final Duration elapsedBeforeRun;
  final DateTime? runningSince;
  final DateTime startedAt;
  final DateTime updatedAt;
  final bool isPaused;
  final int hintsRequested;
  final int highestHintLevelUsed;
  final int correctEditableCells;
  final int editableCells;
}

final class ActiveGameSummary {
  const ActiveGameSummary({
    required this.gameId,
    required this.puzzleId,
    required this.correctEditableCells,
    required this.editableCells,
    required this.elapsed,
    required this.startedAt,
  });

  final String gameId;
  final String puzzleId;
  final int correctEditableCells;
  final int editableCells;
  final Duration elapsed;
  final DateTime startedAt;

  /// Wrong entries do not count as progress.
  double get progress =>
      editableCells == 0 ? 1 : correctEditableCells / editableCells;
}

final class CompletedGame {
  const CompletedGame({
    required this.gameId,
    required this.puzzleId,
    required this.initialBoard,
    required this.completedBoard,
    required this.startedAt,
    required this.completedAt,
    required this.elapsed,
    required this.mistakes,
    required this.hintsRequested,
    required this.highestHintLevelUsed,
  });

  final String gameId;
  final String puzzleId;
  final SudokuBoard initialBoard;
  final SudokuBoard completedBoard;
  final DateTime startedAt;
  final DateTime completedAt;
  final Duration elapsed;
  final int mistakes;
  final int hintsRequested;
  final int highestHintLevelUsed;
}

/// The application-facing local game boundary. One unfinished game is active.
abstract interface class GameRepository {
  Future<StoredGame?> loadActiveGame();

  Future<ActiveGameSummary?> loadActiveSummary();

  Future<void> saveActiveGame(StoredGame game);

  Future<void> deleteActiveGame(String gameId);

  /// Inserts the history record and removes its active copy atomically.
  /// Repeating the same completion must not create another record.
  Future<void> completeGame(CompletedGame game);

  Future<List<CompletedGame>> loadRecentCompletedGames({int limit = 20});
}
