import 'package:drift/drift.dart';
import 'package:michi_mobile/core/sync/cloud_sync_repository.dart';
import 'package:michi_mobile/features/game/data/game_codec.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Pull, deterministic local merge, then drain the transactional outbox.
/// Every local write remains usable when this method fails or is cancelled.
final class SyncEngine {
  const SyncEngine(this.database, this.remote);

  final GameDatabase database;
  final CloudSyncRepository remote;

  Future<int> pendingCount(String uid) async {
    final profileId = 'firebase:$uid';
    final rows = await (database.select(
      database.syncOutbox,
    )..where((row) => row.profileId.equals(profileId))).get();
    return rows.length;
  }

  Future<void> sync(String uid, {required bool Function() isCurrent}) async {
    if (uid.isEmpty) throw ArgumentError.value(uid, 'uid');
    final profileId = 'firebase:$uid';
    final snapshot = await remote.pull(uid);
    if (!isCurrent()) return;
    await database.transaction(() => _merge(profileId, snapshot));
    if (!isCurrent()) return;
    final outbox =
        await (database.select(database.syncOutbox)
              ..where((row) => row.profileId.equals(profileId))
              ..orderBy([(row) => OrderingTerm.asc(row.createdAtMs)]))
            .get();
    for (final item in outbox) {
      if (!isCurrent()) return;
      try {
        await _push(uid, profileId, item);
        if (!isCurrent()) return;
        await (database.delete(database.syncOutbox)..where(
              (row) =>
                  row.profileId.equals(profileId) &
                  row.entityType.equals(item.entityType) &
                  row.entityId.equals(item.entityId) &
                  row.revision.equals(item.revision),
            ))
            .go();
      } on Object {
        await (database.update(database.syncOutbox)..where(
              (row) =>
                  row.profileId.equals(profileId) &
                  row.entityType.equals(item.entityType) &
                  row.entityId.equals(item.entityId),
            ))
            .write(
              SyncOutboxCompanion(
                attemptCount: Value(item.attemptCount + 1),
                lastAttemptAtMs: Value(
                  DateTime.now().toUtc().millisecondsSinceEpoch,
                ),
              ),
            );
        rethrow;
      }
    }
    if (!isCurrent()) return;
    await database
        .into(database.syncMetadata)
        .insertOnConflictUpdate(
          SyncMetadataCompanion.insert(
            key: 'lastSynced:$profileId',
            value: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
          ),
        );
  }

  Future<void> _merge(String profileId, CloudSnapshot snapshot) async {
    for (final entry in snapshot.completedGames.entries) {
      final data = entry.value;
      if (data['schemaVersion'] != 1) {
        throw UnsupportedError('Completed-game schema version');
      }
      final existing =
          await (database.select(database.completedGames)..where(
                (row) =>
                    row.profileId.equals(profileId) &
                    row.gameId.equals(entry.key),
              ))
              .getSingleOrNull();
      if (existing != null) {
        if (existing.completedBoard != data['completedBoard'] ||
            existing.initialBoard != data['initialBoard'] ||
            existing.puzzleId != data['puzzleId']) {
          throw CloudRecordConflict('completedGame', entry.key);
        }
        continue;
      }
      final initial = _string(data, 'initialBoard');
      final completed = _string(data, 'completedBoard');
      GameCodec.parseBoard(initial);
      final completedBoard = GameCodec.parseBoard(completed);
      if (!completedBoard.isComplete ||
          !SudokuConstraints.validate(completedBoard).isValid) {
        throw FormatException('Invalid completed game ${entry.key}');
      }
      await database
          .into(database.completedGames)
          .insert(
            CompletedGamesCompanion.insert(
              profileId: Value(profileId),
              gameId: entry.key,
              puzzleId: _string(data, 'puzzleId'),
              dailyChallengeKey: Value(data['dailyChallengeKey'] as String?),
              initialBoard: initial,
              completedBoard: completed,
              startedAtMs: _int(data, 'startedAtMs'),
              completedAtMs: _int(data, 'completedAtMs'),
              elapsedMs: _int(data, 'elapsedMs'),
              mistakes: _int(data, 'mistakes'),
              hintsRequested: _int(data, 'hintsRequested'),
              highestHintLevelUsed: _int(data, 'highestHintLevelUsed'),
              techniqueHelpJson: Value(_string(data, 'techniqueHelpJson')),
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
    for (final entry in snapshot.daily.entries) {
      final data = entry.value;
      if (data['schemaVersion'] != 1) {
        throw UnsupportedError('Daily schema version');
      }
      await database
          .into(database.dailyCompletions)
          .insertOnConflictUpdate(
            DailyCompletionsCompanion.insert(
              profileId: profileId,
              challengeKey: entry.key,
              puzzleId: _string(data, 'puzzleId'),
              gameId: _string(data, 'gameId'),
              completedAtMs: _int(data, 'completedAtMs'),
            ),
          );
    }
    final progress = DriftTechniqueProgressRepository(database);
    for (final techniqueEntry in snapshot.contributions.entries) {
      final name = techniqueEntry.key;
      if (!SudokuTechnique.values.any((item) => item.name == name)) continue;
      for (final sourceEntry in techniqueEntry.value.entries) {
        final data = sourceEntry.value;
        if (data['schemaVersion'] != 1) {
          throw UnsupportedError('Technique schema version');
        }
        final prior =
            await (database.select(database.techniqueContributions)..where(
                  (row) =>
                      row.profileId.equals(profileId) &
                      row.techniqueId.equals(name) &
                      row.sourceId.equals(sourceEntry.key),
                ))
                .getSingleOrNull();
        int max(String key, int? old) {
          final fresh = _int(data, key);
          return old != null && old > fresh ? old : fresh;
        }

        final remoteLast = data['lastPracticedAtMs'];
        if (remoteLast != null && remoteLast is! int) {
          throw const FormatException('Invalid lastPracticedAtMs');
        }
        final last = remoteLast is int ? remoteLast : null;
        final priorLast = prior?.lastPracticedAtMs;
        await database
            .into(database.techniqueContributions)
            .insertOnConflictUpdate(
              TechniqueContributionsCompanion.insert(
                profileId: profileId,
                techniqueId: name,
                sourceId: sourceEntry.key,
                attempts: max('attempts', prior?.attempts),
                correctAttempts: max('correctAttempts', prior?.correctAttempts),
                firstTryCorrect: max('firstTryCorrect', prior?.firstTryCorrect),
                independentStreak:
                    prior != null && prior.attempts > _int(data, 'attempts')
                    ? prior.independentStreak
                    : _int(data, 'independentStreak'),
                bestIndependentStreak: max(
                  'bestIndependentStreak',
                  prior?.bestIndependentStreak,
                ),
                directionHintSuccesses: max(
                  'directionHintSuccesses',
                  prior?.directionHintSuccesses,
                ),
                focusHintSuccesses: max(
                  'focusHintSuccesses',
                  prior?.focusHintSuccesses,
                ),
                reasoningHintSuccesses: max(
                  'reasoningHintSuccesses',
                  prior?.reasoningHintSuccesses,
                ),
                resultHintSuccesses: max(
                  'resultHintSuccesses',
                  prior?.resultHintSuccesses,
                ),
                lastPracticedAtMs: Value(
                  priorLast != null && (last == null || priorLast > last)
                      ? priorLast
                      : last,
                ),
              ),
            );
      }
      await progress.rebuildAggregate(
        profileId,
        SudokuTechnique.values.byName(name),
      );
    }
  }

  Future<void> _push(String uid, String profileId, SyncOutboxData item) async {
    switch (item.entityType) {
      case 'completedGame':
        final row =
            await (database.select(database.completedGames)..where(
                  (r) =>
                      r.profileId.equals(profileId) &
                      r.gameId.equals(item.entityId),
                ))
                .getSingleOrNull();
        if (row == null) return;
        await remote.putCompletedGame(uid, row.gameId, {
          'puzzleId': row.puzzleId,
          'dailyChallengeKey': row.dailyChallengeKey,
          'initialBoard': row.initialBoard,
          'completedBoard': row.completedBoard,
          'startedAtMs': row.startedAtMs,
          'completedAtMs': row.completedAtMs,
          'elapsedMs': row.elapsedMs,
          'mistakes': row.mistakes,
          'hintsRequested': row.hintsRequested,
          'highestHintLevelUsed': row.highestHintLevelUsed,
          'techniqueHelpJson': row.techniqueHelpJson,
        });
      case 'daily':
        final row =
            await (database.select(database.dailyCompletions)..where(
                  (r) =>
                      r.profileId.equals(profileId) &
                      r.challengeKey.equals(item.entityId),
                ))
                .getSingleOrNull();
        if (row == null) return;
        await remote.putDaily(uid, row.challengeKey, {
          'puzzleId': row.puzzleId,
          'gameId': row.gameId,
          'completedAtMs': row.completedAtMs,
        });
      case 'technique':
        final divider = item.entityId.indexOf('/');
        if (divider < 1) {
          throw const FormatException('Invalid technique outbox ID');
        }
        final technique = item.entityId.substring(0, divider);
        final source = item.entityId.substring(divider + 1);
        final row =
            await (database.select(database.techniqueContributions)..where(
                  (r) =>
                      r.profileId.equals(profileId) &
                      r.techniqueId.equals(technique) &
                      r.sourceId.equals(source),
                ))
                .getSingleOrNull();
        if (row == null) return;
        await remote.putContribution(uid, technique, source, {
          'attempts': row.attempts,
          'correctAttempts': row.correctAttempts,
          'firstTryCorrect': row.firstTryCorrect,
          'independentStreak': row.independentStreak,
          'bestIndependentStreak': row.bestIndependentStreak,
          'directionHintSuccesses': row.directionHintSuccesses,
          'focusHintSuccesses': row.focusHintSuccesses,
          'reasoningHintSuccesses': row.reasoningHintSuccesses,
          'resultHintSuccesses': row.resultHintSuccesses,
          'lastPracticedAtMs': row.lastPracticedAtMs,
        });
      default:
        throw FormatException('Unknown outbox type ${item.entityType}');
    }
  }

  static String _string(Map<String, Object?> data, String key) {
    final value = data[key];
    if (value is! String) throw FormatException('Invalid $key');
    return value;
  }

  static int _int(Map<String, Object?> data, String key) {
    final value = data[key];
    if (value is! int || value < 0) throw FormatException('Invalid $key');
    return value;
  }
}
