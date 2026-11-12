// Drift's table rebuild API is marked experimental in 2.31, but it preserves
// all existing rows while changing primary keys in the v6-to-v7 migration.
// ignore_for_file: experimental_member_use

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'game_database.g.dart';

class ActiveGames extends Table {
  TextColumn get profileId => text().withDefault(const Constant('guest'))();
  IntColumn get slot => integer()();
  TextColumn get gameId => text()();
  TextColumn get puzzleId => text()();
  TextColumn get dailyChallengeKey => text().nullable()();
  TextColumn get initialBoard => text()();
  TextColumn get currentBoard => text()();
  TextColumn get notesJson => text()();
  TextColumn get undoJson => text()();
  TextColumn get reasoningJson => text().withDefault(const Constant('{}'))();
  IntColumn get mistakes => integer()();
  IntColumn get elapsedMs => integer()();
  IntColumn get runningSinceMs => integer().nullable()();
  IntColumn get startedAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isPaused => boolean()();
  IntColumn get hintsRequested => integer()();
  IntColumn get highestHintLevelUsed => integer()();
  TextColumn get techniqueHelpJson =>
      text().withDefault(const Constant('{}'))();
  IntColumn get correctEditableCells => integer()();
  IntColumn get editableCells => integer()();

  @override
  Set<Column> get primaryKey => {profileId, slot};
}

@DataClassName('CompletedGameRow')
class CompletedGames extends Table {
  TextColumn get profileId => text().withDefault(const Constant('guest'))();
  TextColumn get gameId => text()();
  TextColumn get puzzleId => text()();
  TextColumn get dailyChallengeKey => text().nullable()();
  TextColumn get initialBoard => text()();
  TextColumn get completedBoard => text()();
  IntColumn get startedAtMs => integer()();
  IntColumn get completedAtMs => integer()();
  IntColumn get elapsedMs => integer()();
  IntColumn get mistakes => integer()();
  IntColumn get hintsRequested => integer()();
  IntColumn get highestHintLevelUsed => integer()();
  TextColumn get techniqueHelpJson =>
      text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId, gameId};
}

@DataClassName('TechniqueProgressRow')
class TechniqueProgressEntries extends Table {
  TextColumn get profileId => text().withDefault(const Constant('guest'))();
  TextColumn get techniqueId => text()();
  IntColumn get attempts => integer()();
  IntColumn get correctAttempts => integer()();
  IntColumn get firstTryCorrect => integer()();
  IntColumn get independentStreak => integer()();
  BoolColumn get masteredEver => boolean().withDefault(const Constant(false))();
  IntColumn get directionHintSuccesses => integer()();
  IntColumn get focusHintSuccesses => integer()();
  IntColumn get reasoningHintSuccesses => integer()();
  IntColumn get resultHintSuccesses => integer()();
  IntColumn get lastPracticedAtMs => integer().nullable()();

  @override
  Set<Column> get primaryKey => {profileId, techniqueId};
}

@DataClassName('DailyLearningFocusRow')
class DailyLearningFocuses extends Table {
  TextColumn get profileId => text().withDefault(const Constant('guest'))();
  TextColumn get localDate => text()();
  TextColumn get techniqueId => text()();
  TextColumn get actionId => text()();
  TextColumn get reasonId => text()();
  IntColumn get estimatedMinutes => integer()();
  TextColumn get evidenceJson => text()();

  @override
  Set<Column> get primaryKey => {profileId, localDate};
}

@DataClassName('ImportedPuzzleRow')
class ImportedPuzzles extends Table {
  TextColumn get profileId => text().withDefault(const Constant('guest'))();
  TextColumn get puzzleId => text()();
  TextColumn get initialBoard => text()();
  BoolColumn get humanSolverFullySupported => boolean()();
  TextColumn get requiredTechniquesJson => text()();
  IntColumn get importedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {profileId, puzzleId};
}

class SyncMetadata extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

class SyncOutbox extends Table {
  TextColumn get profileId => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  IntColumn get revision => integer().withDefault(const Constant(1))();
  IntColumn get createdAtMs => integer()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  IntColumn get lastAttemptAtMs => integer().nullable()();

  @override
  Set<Column> get primaryKey => {profileId, entityType, entityId};
}

class TechniqueContributions extends Table {
  TextColumn get profileId => text()();
  TextColumn get techniqueId => text()();
  TextColumn get sourceId => text()();
  IntColumn get attempts => integer()();
  IntColumn get correctAttempts => integer()();
  IntColumn get firstTryCorrect => integer()();
  IntColumn get independentStreak => integer()();
  IntColumn get bestIndependentStreak => integer()();
  IntColumn get directionHintSuccesses => integer()();
  IntColumn get focusHintSuccesses => integer()();
  IntColumn get reasoningHintSuccesses => integer()();
  IntColumn get resultHintSuccesses => integer()();
  IntColumn get lastPracticedAtMs => integer().nullable()();

  @override
  Set<Column> get primaryKey => {profileId, techniqueId, sourceId};
}

class DailyCompletions extends Table {
  TextColumn get profileId => text()();
  TextColumn get challengeKey => text()();
  TextColumn get puzzleId => text()();
  TextColumn get gameId => text()();
  IntColumn get completedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {profileId, challengeKey};
}

/// Published content is shared by every profile on this installation.
class RemotePuzzles extends Table {
  TextColumn get puzzleId => text()();
  TextColumn get releaseId => text()();
  TextColumn get board => text()();
  TextColumn get difficulty => text()();
  TextColumn get requiredTechniquesJson => text()();
  IntColumn get contentVersion => integer()();
  BoolColumn get dailyEligible => boolean()();
  IntColumn get fetchedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {puzzleId};
}

class RemoteContentReleases extends Table {
  TextColumn get releaseId => text()();
  IntColumn get contentVersion => integer()();
  TextColumn get status => text()();
  TextColumn get puzzleIdsJson => text()();
  IntColumn get fetchedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {releaseId};
}

/// `locked` prevents an offline fallback changing later the same day.
class DailyChallengeCache extends Table {
  TextColumn get localDate => text()();
  TextColumn get challengeKey => text()();
  TextColumn get puzzleId => text()();
  TextColumn get source => text()();
  BoolColumn get locked => boolean()();
  IntColumn get fetchedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {localDate};
}

@DriftDatabase(
  tables: [
    ActiveGames,
    CompletedGames,
    TechniqueProgressEntries,
    DailyLearningFocuses,
    ImportedPuzzles,
    SyncMetadata,
    SyncOutbox,
    TechniqueContributions,
    DailyCompletions,
    RemotePuzzles,
    RemoteContentReleases,
    DailyChallengeCache,
  ],
)
final class GameDatabase extends _$GameDatabase {
  GameDatabase(super.e);

  factory GameDatabase.open() =>
      GameDatabase(driftDatabase(name: 'michi_games'));

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _createInstallationId();
    },
    onUpgrade: (migrator, from, to) async {
      if (from == 1 && to >= 2) {
        await migrator.addColumn(activeGames, activeGames.dailyChallengeKey);
        await migrator.addColumn(
          completedGames,
          completedGames.dailyChallengeKey,
        );
      }
      if (from <= 2 && to >= 3) {
        await migrator.addColumn(activeGames, activeGames.techniqueHelpJson);
        await migrator.addColumn(
          completedGames,
          completedGames.techniqueHelpJson,
        );
        await migrator.createTable(techniqueProgressEntries);
      }
      if (from <= 3 && to >= 4) {
        await migrator.addColumn(activeGames, activeGames.reasoningJson);
      }
      if (from <= 4 && to >= 5) {
        await migrator.createTable(dailyLearningFocuses);
      }
      if (from <= 5 && to >= 6) {
        await migrator.createTable(importedPuzzles);
      }
      if (from <= 6 && to >= 7) {
        await migrator.alterTable(
          TableMigration(
            activeGames,
            newColumns: [activeGames.profileId],
          ),
        );
        await migrator.alterTable(
          TableMigration(
            completedGames,
            newColumns: [completedGames.profileId],
          ),
        );
        await migrator.alterTable(
          TableMigration(
            techniqueProgressEntries,
            newColumns: [
              techniqueProgressEntries.profileId,
              techniqueProgressEntries.masteredEver,
            ],
          ),
        );
        await migrator.alterTable(
          TableMigration(
            dailyLearningFocuses,
            newColumns: [dailyLearningFocuses.profileId],
          ),
        );
        await migrator.alterTable(
          TableMigration(
            importedPuzzles,
            newColumns: [importedPuzzles.profileId],
          ),
        );
        await migrator.createTable(syncMetadata);
        await migrator.createTable(syncOutbox);
        await migrator.createTable(techniqueContributions);
        await migrator.createTable(dailyCompletions);
        await _createInstallationId();
        await customStatement('''
          INSERT INTO technique_contributions
          (profile_id, technique_id, source_id, attempts, correct_attempts,
          first_try_correct, independent_streak, best_independent_streak,
          direction_hint_successes,
           focus_hint_successes, reasoning_hint_successes,
           result_hint_successes, last_practiced_at_ms)
          SELECT profile_id, technique_id,
                 'legacy:' || (SELECT value FROM sync_metadata
                              WHERE key = 'installationId'),
                 attempts, correct_attempts, first_try_correct,
                 independent_streak, independent_streak,
                 direction_hint_successes,
                 focus_hint_successes, reasoning_hint_successes,
                 result_hint_successes, last_practiced_at_ms
          FROM technique_progress_entries
        ''');
        await customStatement('''
          INSERT OR IGNORE INTO daily_completions
          (profile_id, challenge_key, puzzle_id, game_id, completed_at_ms)
          SELECT profile_id, daily_challenge_key, puzzle_id, game_id,
                 completed_at_ms FROM completed_games
          WHERE daily_challenge_key IS NOT NULL
          ORDER BY completed_at_ms, game_id
        ''');
      }
      if (from <= 7 && to >= 8) {
        await migrator.createTable(remotePuzzles);
        await migrator.createTable(remoteContentReleases);
        await migrator.createTable(dailyChallengeCache);
      }
    },
  );

  Future<void> _createInstallationId() =>
      customStatement('''
    INSERT OR IGNORE INTO sync_metadata (key, value)
    VALUES ('installationId', lower(hex(randomblob(16))))
  ''').then(
        (_) => customStatement('''
    INSERT OR IGNORE INTO sync_metadata (key, value)
    VALUES ('guestImportId', lower(hex(randomblob(16))))
  '''),
      );
}
