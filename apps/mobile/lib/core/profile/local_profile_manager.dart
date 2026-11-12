import 'package:drift/drift.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/sync_outbox_writer.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Claims only the current guest profile. The transaction makes an interrupted
/// claim retryable without uploading progress twice.
final class LocalProfileManager {
  const LocalProfileManager(this.database, this.scope);

  final GameDatabase database;
  final LocalProfileScope scope;

  Future<void> markAccountForDeletion(String uid) => database
      .into(database.syncMetadata)
      .insertOnConflictUpdate(
        SyncMetadataCompanion.insert(key: 'pendingDelete:$uid', value: '1'),
      );

  Future<void> purgeAccount(String uid) async {
    final profileId = 'firebase:$uid';
    await database.transaction(() async {
      for (final table in [
        'active_games',
        'completed_games',
        'technique_progress_entries',
        'daily_learning_focuses',
        'imported_puzzles',
        'technique_contributions',
        'daily_completions',
        'sync_outbox',
      ]) {
        await database.customStatement(
          'DELETE FROM $table WHERE profile_id = ?',
          [profileId],
        );
      }
      await database.customStatement(
        'DELETE FROM sync_metadata WHERE key IN (?, ?, ?)',
        ['lastSynced:$profileId', 'pendingDelete:$uid', 'reminderEnabled:$uid'],
      );
    });
    if (scope.profileId == profileId) scope.selectGuest();
  }

  Future<void> purgePendingDeletedAccounts({String? currentUid}) async {
    final rows = await database
        .customSelect(
          "SELECT key FROM sync_metadata WHERE key LIKE 'pendingDelete:%'",
        )
        .get();
    for (final row in rows) {
      final uid = row.read<String>('key').substring('pendingDelete:'.length);
      if (uid != currentUid) await purgeAccount(uid);
    }
  }

  Future<void> claimGuest(String uid) async {
    if (uid.isEmpty) throw ArgumentError.value(uid, 'uid');
    final profileId = 'firebase:$uid';
    await database.transaction(() async {
      final guestData = await database.customSelect('''
        SELECT EXISTS(SELECT 1 FROM active_games WHERE profile_id = 'guest')
          OR EXISTS(SELECT 1 FROM completed_games WHERE profile_id = 'guest')
          OR EXISTS(SELECT 1 FROM technique_progress_entries WHERE profile_id = 'guest')
          OR EXISTS(SELECT 1 FROM daily_learning_focuses WHERE profile_id = 'guest')
          OR EXISTS(SELECT 1 FROM imported_puzzles WHERE profile_id = 'guest')
          OR EXISTS(SELECT 1 FROM technique_contributions WHERE profile_id = 'guest')
          OR EXISTS(SELECT 1 FROM daily_completions WHERE profile_id = 'guest')
          AS has_data
      ''').getSingle();
      if (guestData.read<int>('has_data') == 0) return;
      final conflictingGame = await database
          .customSelect(
            '''
        SELECT guest.game_id FROM completed_games AS guest
        JOIN completed_games AS account
          ON account.profile_id = ? AND account.game_id = guest.game_id
        WHERE guest.profile_id = 'guest'
          AND (guest.puzzle_id != account.puzzle_id
            OR guest.initial_board != account.initial_board
            OR guest.completed_board != account.completed_board)
        LIMIT 1
      ''',
            variables: [Variable.withString(profileId)],
          )
          .getSingleOrNull();
      if (conflictingGame != null) {
        throw StateError(
          'Completed-game ID conflict: '
          "${conflictingGame.read<String>('game_id')}",
        );
      }
      final existingActive = await (database.select(
        database.activeGames,
      )..where((row) => row.profileId.equals(profileId))).getSingleOrNull();
      for (final table in [
        'active_games',
        'completed_games',
        'technique_progress_entries',
        'daily_learning_focuses',
        'imported_puzzles',
        'technique_contributions',
        'daily_completions',
      ]) {
        final columns = await database
            .customSelect(
              'PRAGMA table_info($table)',
            )
            .get();
        final ownedColumns = columns
            .map((row) => row.read<String>('name'))
            .where((name) => name != 'profile_id')
            .join(', ');
        await database.customStatement(
          'INSERT OR IGNORE INTO $table (profile_id, $ownedColumns) '
          'SELECT ?, $ownedColumns FROM $table WHERE profile_id = ?',
          [profileId, LocalProfileScope.guest],
        );
      }
      final progress = await (database.select(
        database.techniqueContributions,
      )..where((row) => row.profileId.equals(profileId))).get();
      final techniques = progress
          .map((row) => row.techniqueId)
          .where((name) => SudokuTechnique.values.any((t) => t.name == name))
          .toSet();
      final progressRepository = DriftTechniqueProgressRepository(database);
      for (final name in techniques) {
        await progressRepository.rebuildAggregate(
          profileId,
          SudokuTechnique.values.byName(name),
        );
      }
      final games = await (database.select(
        database.completedGames,
      )..where((row) => row.profileId.equals(profileId))).get();
      final daily = await (database.select(
        database.dailyCompletions,
      )..where((row) => row.profileId.equals(profileId))).get();
      final outbox = SyncOutboxWriter(database);
      for (final game in games) {
        await outbox.enqueue(profileId, 'completedGame', game.gameId);
      }
      for (final row in daily) {
        await outbox.enqueue(profileId, 'daily', row.challengeKey);
      }
      for (final row in progress) {
        await outbox.enqueue(
          profileId,
          'technique',
          '${row.techniqueId}/${row.sourceId}',
        );
      }
      for (final table in [
        'completed_games',
        'technique_progress_entries',
        'daily_learning_focuses',
        'imported_puzzles',
        'technique_contributions',
        'daily_completions',
      ]) {
        await database.customStatement(
          'DELETE FROM $table WHERE profile_id = ?',
          [LocalProfileScope.guest],
        );
      }
      if (existingActive == null) {
        await database.customStatement(
          'DELETE FROM active_games WHERE profile_id = ?',
          [LocalProfileScope.guest],
        );
      }
      await database.customStatement('''
        UPDATE sync_metadata SET value = lower(hex(randomblob(16)))
        WHERE key = 'guestImportId'
      ''');
    });
  }
}
