import 'dart:async';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/profile/local_profile_manager.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/cloud_sync_repository.dart';
import 'package:michi_mobile/core/sync/sync_engine.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _FakeCloud implements CloudSyncRepository {
  final games = <String, Map<String, Object?>>{};
  final daily = <String, Map<String, Object?>>{};
  final contributions = <String, Map<String, Map<String, Object?>>>{};
  bool failWrites = false;

  @override
  Future<CloudSnapshot> pull(String uid) async => CloudSnapshot(
    completedGames: games,
    daily: daily,
    contributions: contributions,
  );

  @override
  Future<void> putCompletedGame(
    String uid,
    String gameId,
    Map<String, Object?> payload,
  ) async {
    if (failWrites) throw StateError('offline');
    final prior = games[gameId];
    if (prior != null && prior['completedBoard'] != payload['completedBoard']) {
      throw CloudRecordConflict('completedGame', gameId);
    }
    games.putIfAbsent(gameId, () => {...payload, 'schemaVersion': 1});
  }

  @override
  Future<void> putDaily(
    String uid,
    String challengeKey,
    Map<String, Object?> payload,
  ) async {
    if (failWrites) throw StateError('offline');
    daily.putIfAbsent(challengeKey, () => {...payload, 'schemaVersion': 1});
  }

  @override
  Future<void> putContribution(
    String uid,
    String techniqueId,
    String sourceId,
    Map<String, Object?> payload,
  ) async {
    if (failWrites) throw StateError('offline');
    final devices = contributions.putIfAbsent(techniqueId, () => {});
    final prior = devices[sourceId];
    final merged = <String, Object?>{...payload, 'schemaVersion': 1};
    if (prior != null) {
      for (final key in payload.keys) {
        if (key == 'independentStreak') continue;
        if (payload[key] is int &&
            prior[key] is int &&
            (prior[key]! as int) > (payload[key]! as int)) {
          merged[key] = prior[key];
        }
      }
      if ((prior['attempts']! as int) > (payload['attempts']! as int)) {
        merged['independentStreak'] = prior['independentStreak'];
      }
    }
    devices[sourceId] = merged;
  }
}

CompletedGame _game(String id, {String? dailyKey}) {
  final board = DemoPuzzle.standard.givens;
  return CompletedGame(
    gameId: id,
    puzzleId: DemoPuzzle.standard.id,
    dailyChallengeKey: dailyKey,
    initialBoard: board,
    completedBoard: const BacktrackingExactSolver().solve(board)!,
    startedAt: DateTime.utc(2026, 11),
    completedAt: DateTime.utc(2026, 11, 1, 0, 10),
    elapsed: const Duration(minutes: 10),
    mistakes: 0,
    hintsRequested: 0,
    highestHintLevelUsed: 0,
  );
}

StoredGame _active(String id) {
  final board = DemoPuzzle.standard.givens;
  final now = DateTime.utc(2026, 11);
  return StoredGame(
    gameId: id,
    puzzleId: DemoPuzzle.standard.id,
    initialBoard: board,
    currentBoard: board,
    notes: const {},
    undoHistory: const [],
    mistakes: 0,
    elapsedBeforeRun: Duration.zero,
    runningSince: null,
    startedAt: now,
    updatedAt: now,
    isPaused: true,
    hintsRequested: 0,
    highestHintLevelUsed: 0,
    correctEditableCells: 0,
    editableCells: board.emptyCellCount,
  );
}

void main() {
  late GameDatabase firstDb;
  late GameDatabase secondDb;
  late LocalProfileScope firstScope;
  late LocalProfileScope secondScope;
  late _FakeCloud cloud;

  setUpAll(() {
    // Two independent in-memory executors intentionally emulate two devices.
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  setUp(() {
    firstDb = GameDatabase(NativeDatabase.memory());
    secondDb = GameDatabase(NativeDatabase.memory());
    firstScope = LocalProfileScope();
    secondScope = LocalProfileScope();
    cloud = _FakeCloud();
  });
  tearDown(() async {
    await firstDb.close();
    await secondDb.close();
    firstScope.dispose();
    secondScope.dispose();
  });

  test('guest claim keeps the view epoch; sign-out invalidates it', () {
    expect(firstScope.viewEpoch, 0);
    firstScope.selectAccount('alice');
    expect(firstScope.viewEpoch, 0);
    firstScope.selectGuest();
    expect(firstScope.viewEpoch, 1);
    firstScope.selectAccount('bob');
    expect(firstScope.viewEpoch, 1);
  });

  test(
    'guest claim is atomic, idempotent and isolated from another UID',
    () async {
      final games = DriftGameRepository(firstDb, firstScope);
      final progress = DriftTechniqueProgressRepository(firstDb, firstScope);
      await games.completeGame(_game('guest-game', dailyKey: '2026-11-01|v1'));
      await progress.recordCheck(
        technique: SudokuTechnique.hiddenSingle,
        correct: true,
        firstTry: true,
        highestHint: null,
        at: DateTime.utc(2026, 11),
      );
      final manager = LocalProfileManager(firstDb, firstScope);
      await manager.claimGuest('alice');
      await manager.claimGuest('alice');
      firstScope.selectAccount('alice');
      expect(
        (await games.loadRecentCompletedGames()).single.gameId,
        'guest-game',
      );
      expect((await progress.load(SudokuTechnique.hiddenSingle)).attempts, 1);
      expect(await games.isDailyCompleted('2026-11-01|v1'), isTrue);
      expect(await SyncEngine(firstDb, cloud).pendingCount('alice'), 3);
      firstScope.selectGuest();
      expect(await games.loadRecentCompletedGames(), isEmpty);
      expect((await progress.load(SudokuTechnique.hiddenSingle)).attempts, 0);
      firstScope.selectAccount('bob');
      expect(await games.loadRecentCompletedGames(), isEmpty);
      firstScope.selectAccount('alice');
      expect(
        (await games.loadRecentCompletedGames()).single.gameId,
        'guest-game',
      );
    },
  );

  test(
    'device B pulls completed, Daily and technique progress from A',
    () async {
      firstScope.selectAccount('alice');
      await DriftGameRepository(firstDb, firstScope).completeGame(
        _game('game-a', dailyKey: '2026-11-01|v1'),
      );
      await DriftTechniqueProgressRepository(firstDb, firstScope).recordCheck(
        technique: SudokuTechnique.hiddenSingle,
        correct: true,
        firstTry: true,
        highestHint: null,
        at: DateTime.utc(2026, 11),
      );
      final firstEngine = SyncEngine(firstDb, cloud);
      await firstEngine.sync('alice', isCurrent: () => true);
      expect(await firstEngine.pendingCount('alice'), 0);
      secondScope.selectAccount('alice');
      await SyncEngine(secondDb, cloud).sync('alice', isCurrent: () => true);
      final secondGames = DriftGameRepository(secondDb, secondScope);
      expect(
        (await secondGames.loadRecentCompletedGames()).single.gameId,
        'game-a',
      );
      expect(await secondGames.isDailyCompleted('2026-11-01|v1'), isTrue);
      expect(
        (await DriftTechniqueProgressRepository(
          secondDb,
          secondScope,
        ).load(SudokuTechnique.hiddenSingle)).attempts,
        1,
      );
      expect(await secondGames.loadActiveGame(), isNull);
    },
  );

  test(
    'two offline devices converge without doubling repeated uploads',
    () async {
      firstScope.selectAccount('alice');
      secondScope.selectAccount('alice');
      final first = DriftTechniqueProgressRepository(firstDb, firstScope);
      final second = DriftTechniqueProgressRepository(secondDb, secondScope);
      for (var i = 0; i < 2; i++) {
        await first.recordCheck(
          technique: SudokuTechnique.nakedSingle,
          correct: true,
          firstTry: true,
          highestHint: null,
          at: DateTime.utc(2026, 11, 1, i),
        );
        await second.recordCheck(
          technique: SudokuTechnique.nakedSingle,
          correct: true,
          firstTry: true,
          highestHint: null,
          at: DateTime.utc(2026, 11, 2, i),
        );
      }
      final firstEngine = SyncEngine(firstDb, cloud);
      final secondEngine = SyncEngine(secondDb, cloud);
      await firstEngine.sync('alice', isCurrent: () => true);
      await secondEngine.sync('alice', isCurrent: () => true);
      await firstEngine.sync('alice', isCurrent: () => true);
      await secondEngine.sync('alice', isCurrent: () => true);
      expect((await first.load(SudokuTechnique.nakedSingle)).attempts, 4);
      expect((await second.load(SudokuTechnique.nakedSingle)).attempts, 4);
      expect(cloud.contributions['nakedSingle']!.length, 2);
    },
  );

  test('offline push retains the outbox and a retry succeeds', () async {
    firstScope.selectAccount('alice');
    await DriftGameRepository(
      firstDb,
      firstScope,
    ).completeGame(_game('offline'));
    final engine = SyncEngine(firstDb, cloud);
    cloud.failWrites = true;
    await expectLater(
      engine.sync('alice', isCurrent: () => true),
      throwsStateError,
    );
    expect(await engine.pendingCount('alice'), 1);
    cloud.failWrites = false;
    await engine.sync('alice', isCurrent: () => true);
    expect(await engine.pendingCount('alice'), 0);
    expect(cloud.games, contains('offline'));
  });

  test(
    'a wrong check resets current streak without downgrading mastery',
    () async {
      firstScope.selectAccount('alice');
      final progress = DriftTechniqueProgressRepository(firstDb, firstScope);
      for (var i = 0; i < 5; i++) {
        await progress.recordCheck(
          technique: SudokuTechnique.hiddenSingle,
          correct: true,
          firstTry: true,
          highestHint: null,
          at: DateTime.utc(2026, 11, 1, i),
        );
      }
      final engine = SyncEngine(firstDb, cloud);
      await engine.sync('alice', isCurrent: () => true);
      await progress.recordCheck(
        technique: SudokuTechnique.hiddenSingle,
        correct: false,
        firstTry: false,
        highestHint: null,
        at: DateTime.utc(2026, 11, 2),
      );
      await engine.sync('alice', isCurrent: () => true);
      final current = await progress.load(SudokuTechnique.hiddenSingle);
      expect(current.independentStreak, 0);
      expect(current.mastery, TechniqueMastery.mastered);
      secondScope.selectAccount('alice');
      await SyncEngine(secondDb, cloud).sync('alice', isCurrent: () => true);
      final recovered = await DriftTechniqueProgressRepository(
        secondDb,
        secondScope,
      ).load(SudokuTechnique.hiddenSingle);
      expect(recovered.independentStreak, 0);
      expect(recovered.mastery, TechniqueMastery.mastered);
    },
  );

  test('conflicting completed-game IDs retain guest data', () async {
    final games = DriftGameRepository(firstDb, firstScope);
    await games.completeGame(_game('same-id'));
    firstScope.selectAccount('alice');
    await games.completeGame(_game('same-id'));
    await firstDb.customStatement(
      "UPDATE completed_games SET puzzle_id = 'other' "
      "WHERE profile_id = 'firebase:alice' AND game_id = 'same-id'",
    );
    await expectLater(
      LocalProfileManager(firstDb, firstScope).claimGuest('alice'),
      throwsStateError,
    );
    firstScope.selectGuest();
    expect((await games.loadRecentCompletedGames()).single.gameId, 'same-id');
  });

  test('guest active game survives account active game conflict', () async {
    final games = DriftGameRepository(firstDb, firstScope);
    await games.saveActiveGame(_active('guest-active'));
    firstScope.selectAccount('alice');
    await games.saveActiveGame(_active('account-active'));
    await LocalProfileManager(firstDb, firstScope).claimGuest('alice');
    expect((await games.loadActiveGame())?.gameId, 'account-active');
    firstScope.selectGuest();
    expect((await games.loadActiveGame())?.gameId, 'guest-active');
  });

  test('confirmed account deletion purges only that local profile', () async {
    final games = DriftGameRepository(firstDb, firstScope);
    await games.completeGame(_game('guest-record'));
    firstScope.selectAccount('alice');
    await games.completeGame(_game('alice-record'));
    final manager = LocalProfileManager(firstDb, firstScope);
    await manager.markAccountForDeletion('alice');
    await manager.purgeAccount('alice');
    expect(firstScope.profileId, LocalProfileScope.guest);
    expect(
      (await games.loadRecentCompletedGames()).single.gameId,
      'guest-record',
    );
    firstScope.selectAccount('alice');
    expect(await games.loadRecentCompletedGames(), isEmpty);
    expect(await SyncEngine(firstDb, cloud).pendingCount('alice'), 0);
  });

  test('queued game writes keep the profile selected at invocation', () async {
    final gate = Completer<void>();
    final transaction = firstDb.transaction(() => gate.future);
    await Future<void>.delayed(Duration.zero);
    final games = DriftGameRepository(firstDb, firstScope);
    firstScope.selectAccount('alice');
    final save = games.saveActiveGame(_active('alice-active'));
    firstScope.selectAccount('bob');
    gate.complete();
    await transaction;
    await save;
    expect(await games.loadActiveGame(), isNull);
    firstScope.selectAccount('alice');
    expect((await games.loadActiveGame())?.gameId, 'alice-active');
  });
}
