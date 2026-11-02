import 'dart:async';
import 'dart:developer' as developer;

import 'package:drift/drift.dart';
import 'package:michi_mobile/features/game/data/game_codec.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';

/// Serializes writes from all game sessions sharing this repository instance.
final class DriftGameRepository implements GameRepository {
  DriftGameRepository(this.database);

  final GameDatabase database;
  Future<void> _writeTail = Future<void>.value();

  Future<T> _write<T>(Future<T> Function() action) {
    final result = Completer<T>();
    _writeTail = _writeTail.then((_) async {
      try {
        result.complete(await action());
      } on Object catch (error, stackTrace) {
        result.completeError(error, stackTrace);
      }
    });
    return result.future;
  }

  @override
  Future<StoredGame?> loadActiveGame() async {
    await _writeTail;
    final row = await (database.select(
      database.activeGames,
    )..where((table) => table.slot.equals(1))).getSingleOrNull();
    if (row == null) return null;
    try {
      final game = StoredGame(
        gameId: row.gameId,
        puzzleId: row.puzzleId,
        dailyChallengeKey: row.dailyChallengeKey,
        initialBoard: GameCodec.parseBoard(row.initialBoard),
        currentBoard: GameCodec.parseBoard(row.currentBoard),
        notes: GameCodec.parseNotes(
          row.notesJson,
          GameCodec.parseBoard(row.currentBoard),
        ),
        undoHistory: GameCodec.parseHistory(row.undoJson),
        reasoning: GameCodec.parseReasoningOrEmpty(
          row.reasoningJson,
          GameCodec.parseBoard(row.currentBoard),
        ),
        mistakes: row.mistakes,
        elapsedBeforeRun: Duration(milliseconds: row.elapsedMs),
        runningSince: row.runningSinceMs == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                row.runningSinceMs!,
                isUtc: true,
              ),
        startedAt: DateTime.fromMillisecondsSinceEpoch(
          row.startedAtMs,
          isUtc: true,
        ),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(
          row.updatedAtMs,
          isUtc: true,
        ),
        isPaused: row.isPaused,
        hintsRequested: row.hintsRequested,
        highestHintLevelUsed: row.highestHintLevelUsed,
        techniqueHelp: GameCodec.parseTechniqueHelp(row.techniqueHelpJson),
        correctEditableCells: row.correctEditableCells,
        editableCells: row.editableCells,
      );
      GameCodec.validate(game);
      return game;
    } on Object catch (error, stackTrace) {
      developer.log(
        'Discarding a corrupt active game record',
        name: 'michi.persistence',
        error: error,
        stackTrace: stackTrace,
      );
      await deleteActiveGame(row.gameId);
      return null;
    }
  }

  @override
  Future<ActiveGameSummary?> loadActiveSummary() async {
    final game = await loadActiveGame();
    if (game == null) return null;
    return ActiveGameSummary(
      gameId: game.gameId,
      puzzleId: game.puzzleId,
      dailyChallengeKey: game.dailyChallengeKey,
      correctEditableCells: game.correctEditableCells,
      editableCells: game.editableCells,
      elapsed: game.elapsedBeforeRun,
      startedAt: game.startedAt,
    );
  }

  @override
  Future<void> saveActiveGame(StoredGame game) => _write(() async {
    GameCodec.validate(game);
    await database
        .into(database.activeGames)
        .insertOnConflictUpdate(
          ActiveGamesCompanion.insert(
            slot: const Value(1),
            gameId: game.gameId,
            puzzleId: game.puzzleId,
            dailyChallengeKey: Value(game.dailyChallengeKey),
            initialBoard: GameCodec.board(game.initialBoard),
            currentBoard: GameCodec.board(game.currentBoard),
            notesJson: GameCodec.notes(game.notes),
            undoJson: GameCodec.history(game.undoHistory),
            reasoningJson: Value(GameCodec.reasoning(game.reasoning)),
            mistakes: game.mistakes,
            elapsedMs: game.elapsedBeforeRun.inMilliseconds,
            runningSinceMs: Value(game.runningSince?.millisecondsSinceEpoch),
            startedAtMs: game.startedAt.millisecondsSinceEpoch,
            updatedAtMs: game.updatedAt.millisecondsSinceEpoch,
            isPaused: game.isPaused,
            hintsRequested: game.hintsRequested,
            highestHintLevelUsed: game.highestHintLevelUsed,
            techniqueHelpJson: Value(
              GameCodec.techniqueHelp(game.techniqueHelp),
            ),
            correctEditableCells: game.correctEditableCells,
            editableCells: game.editableCells,
          ),
        );
  });

  @override
  Future<void> deleteActiveGame(String gameId) => _write(() async {
    await (database.delete(
      database.activeGames,
    )..where((table) => table.gameId.equals(gameId))).go();
  });

  @override
  Future<void> completeGame(CompletedGame game) => _write(() async {
    await database.transaction(() async {
      await database
          .into(database.completedGames)
          .insert(
            CompletedGamesCompanion.insert(
              gameId: game.gameId,
              puzzleId: game.puzzleId,
              dailyChallengeKey: Value(game.dailyChallengeKey),
              initialBoard: GameCodec.board(game.initialBoard),
              completedBoard: GameCodec.board(game.completedBoard),
              startedAtMs: game.startedAt.millisecondsSinceEpoch,
              completedAtMs: game.completedAt.millisecondsSinceEpoch,
              elapsedMs: game.elapsed.inMilliseconds,
              mistakes: game.mistakes,
              hintsRequested: game.hintsRequested,
              highestHintLevelUsed: game.highestHintLevelUsed,
              techniqueHelpJson: Value(
                GameCodec.techniqueHelp(game.techniqueHelp),
              ),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await (database.delete(
        database.activeGames,
      )..where((table) => table.gameId.equals(game.gameId))).go();
    });
  });

  @override
  Future<List<CompletedGame>> loadRecentCompletedGames({
    int limit = 20,
    bool normalOnly = false,
  }) async {
    RangeError.checkValueInInterval(limit, 1, 1000, 'limit');
    await _writeTail;
    final query = database.select(database.completedGames);
    if (normalOnly) {
      query.where((table) => table.dailyChallengeKey.isNull());
    }
    final rows =
        await (query
              ..orderBy([
                (table) => OrderingTerm.desc(table.completedAtMs),
                (table) => OrderingTerm.desc(table.gameId),
              ])
              ..limit(limit))
            .get();
    return [
      for (final row in rows)
        CompletedGame(
          gameId: row.gameId,
          puzzleId: row.puzzleId,
          dailyChallengeKey: row.dailyChallengeKey,
          initialBoard: GameCodec.parseBoard(row.initialBoard),
          completedBoard: GameCodec.parseBoard(row.completedBoard),
          startedAt: DateTime.fromMillisecondsSinceEpoch(
            row.startedAtMs,
            isUtc: true,
          ),
          completedAt: DateTime.fromMillisecondsSinceEpoch(
            row.completedAtMs,
            isUtc: true,
          ),
          elapsed: Duration(milliseconds: row.elapsedMs),
          mistakes: row.mistakes,
          hintsRequested: row.hintsRequested,
          highestHintLevelUsed: row.highestHintLevelUsed,
          techniqueHelp: GameCodec.parseTechniqueHelp(row.techniqueHelpJson),
        ),
    ];
  }

  @override
  Future<List<String>> recentCompletedPuzzleIds({int limit = 20}) async {
    RangeError.checkValueInInterval(limit, 1, 1000, 'limit');
    await _writeTail;
    final query = database.selectOnly(database.completedGames)
      ..addColumns([database.completedGames.puzzleId])
      ..orderBy([
        OrderingTerm.desc(database.completedGames.completedAtMs),
        OrderingTerm.desc(database.completedGames.gameId),
      ])
      ..limit(limit);
    final rows = await query.get();
    return [
      for (final row in rows) row.read(database.completedGames.puzzleId)!,
    ];
  }

  @override
  Future<bool> isDailyCompleted(String challengeKey) async {
    if (challengeKey.isEmpty) throw ArgumentError.value(challengeKey);
    await _writeTail;
    final row =
        await (database.select(database.completedGames)
              ..where((table) => table.dailyChallengeKey.equals(challengeKey))
              ..limit(1))
            .getSingleOrNull();
    return row != null;
  }
}
