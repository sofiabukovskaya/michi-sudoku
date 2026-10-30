import 'dart:io';

import 'package:drift/drift.dart'
    show OpeningDetails, QueryExecutor, QueryExecutorUser;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  test(
    'schema 1 active and completed games survive both later migrations',
    () async {
      final directory = await Directory.systemTemp.createTemp('michi-v1-');
      addTearDown(() => directory.delete(recursive: true));
      final file = File('${directory.path}/games.sqlite');
      final legacy = NativeDatabase(file);
      await legacy.ensureOpen(const _LegacySchemaUser(1));
      await legacy.runCustom('''
      CREATE TABLE active_games (
        slot INTEGER NOT NULL PRIMARY KEY,
        game_id TEXT NOT NULL,
        puzzle_id TEXT NOT NULL,
        initial_board TEXT NOT NULL,
        current_board TEXT NOT NULL,
        notes_json TEXT NOT NULL,
        undo_json TEXT NOT NULL,
        mistakes INTEGER NOT NULL,
        elapsed_ms INTEGER NOT NULL,
        running_since_ms INTEGER,
        started_at_ms INTEGER NOT NULL,
        updated_at_ms INTEGER NOT NULL,
        is_paused INTEGER NOT NULL,
        hints_requested INTEGER NOT NULL,
        highest_hint_level_used INTEGER NOT NULL,
        correct_editable_cells INTEGER NOT NULL,
        editable_cells INTEGER NOT NULL
      )
    ''');
      await legacy.runCustom('''
      CREATE TABLE completed_games (
        game_id TEXT NOT NULL PRIMARY KEY,
        puzzle_id TEXT NOT NULL,
        initial_board TEXT NOT NULL,
        completed_board TEXT NOT NULL,
        started_at_ms INTEGER NOT NULL,
        completed_at_ms INTEGER NOT NULL,
        elapsed_ms INTEGER NOT NULL,
        mistakes INTEGER NOT NULL,
        hints_requested INTEGER NOT NULL,
        highest_hint_level_used INTEGER NOT NULL
      )
    ''');
      final givens = DemoPuzzle.standard.givens.values.join();
      final solution = const BacktrackingExactSolver()
          .solve(DemoPuzzle.standard.givens)!
          .values
          .join();
      final now = DateTime.utc(2026, 10, 26).millisecondsSinceEpoch;
      await legacy.runCustom(
        'INSERT INTO active_games VALUES '
        '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          1,
          'active-v1',
          'legacy-puzzle',
          givens,
          givens,
          '{}',
          '[]',
          1,
          60000,
          null,
          now,
          now,
          1,
          2,
          3,
          0,
          DemoPuzzle.standard.givens.emptyCellCount,
        ],
      );
      await legacy.runCustom(
        'INSERT INTO completed_games VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          'completed-v1',
          'legacy-complete',
          givens,
          solution,
          now,
          now,
          500000,
          0,
          1,
          2,
        ],
      );
      await legacy.runCustom('PRAGMA user_version = 1');
      await legacy.close();

      final database = GameDatabase(NativeDatabase(file));
      addTearDown(database.close);
      final games = DriftGameRepository(database);
      final active = await games.loadActiveGame();
      expect(active?.gameId, 'active-v1');
      expect(active?.puzzleId, 'legacy-puzzle');
      expect(active?.dailyChallengeKey, isNull);
      expect(active?.techniqueHelp, isEmpty);
      final completed = await games.loadRecentCompletedGames();
      expect(completed.single.gameId, 'completed-v1');
      expect(completed.single.dailyChallengeKey, isNull);
      expect(completed.single.techniqueHelp, isEmpty);
      expect(await games.isDailyCompleted('2026-10-26|catalog-v1'), isFalse);
    },
  );

  test('schema 2 preserves Daily identity and game rows in schema 3', () async {
    final directory = await Directory.systemTemp.createTemp('michi-v2-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/games.sqlite');
    final legacy = NativeDatabase(file);
    await legacy.ensureOpen(const _LegacySchemaUser(2));
    await legacy.runCustom('''
      CREATE TABLE active_games (
        slot INTEGER NOT NULL PRIMARY KEY,
        game_id TEXT NOT NULL,
        puzzle_id TEXT NOT NULL,
        daily_challenge_key TEXT,
        initial_board TEXT NOT NULL,
        current_board TEXT NOT NULL,
        notes_json TEXT NOT NULL,
        undo_json TEXT NOT NULL,
        mistakes INTEGER NOT NULL,
        elapsed_ms INTEGER NOT NULL,
        running_since_ms INTEGER,
        started_at_ms INTEGER NOT NULL,
        updated_at_ms INTEGER NOT NULL,
        is_paused INTEGER NOT NULL,
        hints_requested INTEGER NOT NULL,
        highest_hint_level_used INTEGER NOT NULL,
        correct_editable_cells INTEGER NOT NULL,
        editable_cells INTEGER NOT NULL
      )
    ''');
    await legacy.runCustom('''
      CREATE TABLE completed_games (
        game_id TEXT NOT NULL PRIMARY KEY,
        puzzle_id TEXT NOT NULL,
        daily_challenge_key TEXT,
        initial_board TEXT NOT NULL,
        completed_board TEXT NOT NULL,
        started_at_ms INTEGER NOT NULL,
        completed_at_ms INTEGER NOT NULL,
        elapsed_ms INTEGER NOT NULL,
        mistakes INTEGER NOT NULL,
        hints_requested INTEGER NOT NULL,
        highest_hint_level_used INTEGER NOT NULL
      )
    ''');
    final givens = DemoPuzzle.standard.givens.values.join();
    final solution = const BacktrackingExactSolver()
        .solve(DemoPuzzle.standard.givens)!
        .values
        .join();
    final now = DateTime.utc(2026, 10, 29).millisecondsSinceEpoch;
    await legacy.runCustom(
      'INSERT INTO active_games VALUES '
      '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        1,
        'active-v2',
        'puzzle-active',
        '2026-10-29|catalog-v1',
        givens,
        givens,
        '{}',
        '[]',
        0,
        0,
        null,
        now,
        now,
        1,
        0,
        0,
        0,
        DemoPuzzle.standard.givens.emptyCellCount,
      ],
    );
    await legacy.runCustom(
      'INSERT INTO completed_games VALUES '
      '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        'completed-v2',
        'puzzle-complete',
        '2026-10-28|catalog-v1',
        givens,
        solution,
        now,
        now,
        1000,
        0,
        0,
        0,
      ],
    );
    await legacy.runCustom('PRAGMA user_version = 2');
    await legacy.close();

    final database = GameDatabase(NativeDatabase(file));
    addTearDown(database.close);
    final games = DriftGameRepository(database);
    final active = await games.loadActiveGame();
    expect(active?.gameId, 'active-v2');
    expect(active?.puzzleId, 'puzzle-active');
    expect(active?.dailyChallengeKey, '2026-10-29|catalog-v1');
    expect(active?.techniqueHelp, isEmpty);
    final completed = (await games.loadRecentCompletedGames()).single;
    expect(completed.gameId, 'completed-v2');
    expect(completed.puzzleId, 'puzzle-complete');
    expect(completed.techniqueHelp, isEmpty);
    expect(await games.isDailyCompleted('2026-10-28|catalog-v1'), isTrue);
    final tables = await database
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'table'",
        )
        .get();
    expect(
      tables.map((row) => row.read<String>('name')),
      contains('technique_progress_entries'),
    );
  });
}

final class _LegacySchemaUser implements QueryExecutorUser {
  const _LegacySchemaUser(this.schemaVersion);

  @override
  final int schemaVersion;

  @override
  Future<void> beforeOpen(
    QueryExecutor executor,
    OpeningDetails details,
  ) async {}
}
