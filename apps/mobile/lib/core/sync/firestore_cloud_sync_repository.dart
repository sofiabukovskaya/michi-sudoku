import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/sync/cloud_sync_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Server reads make a completed pull meaningful. Local Drift is still the
/// feature database and retains every write while the network is unavailable.
final class FirestoreCloudSyncRepository implements CloudSyncRepository {
  FirestoreCloudSyncRepository(this.runtime);

  final FirebaseRuntime runtime;

  void _assertUid(String uid) {
    if (runtime.auth.currentUser?.uid != uid) {
      throw StateError('Sync session changed');
    }
  }

  Future<CollectionReference<Map<String, dynamic>>> _collection(
    String uid,
    String name,
  ) async {
    if (!await runtime.ready) {
      throw StateError('Sync session changed');
    }
    _assertUid(uid);
    return runtime.firestore
        .collection('users')
        .doc(uid)
        .collection(name);
  }

  @override
  Future<CloudSnapshot> pull(String uid) async {
    final games = await (await _collection(uid, 'completedGames')).get(
      const GetOptions(source: Source.server),
    );
    final daily = await (await _collection(uid, 'daily')).get(
      const GetOptions(source: Source.server),
    );
    final contributions = <String, Map<String, Map<String, Object?>>>{};
    for (final technique in SudokuTechnique.values) {
      final base = await _collection(uid, 'techniqueProgress');
      final devices = await base
          .doc(technique.name)
          .collection('devices')
          .get(
            const GetOptions(source: Source.server),
          );
      if (devices.docs.isNotEmpty) {
        contributions[technique.name] = {
          for (final doc in devices.docs) doc.id: doc.data(),
        };
      }
    }
    return CloudSnapshot(
      completedGames: {for (final doc in games.docs) doc.id: doc.data()},
      daily: {for (final doc in daily.docs) doc.id: doc.data()},
      contributions: contributions,
    );
  }

  @override
  Future<void> putCompletedGame(
    String uid,
    String gameId,
    Map<String, Object?> payload,
  ) async {
    final ref = (await _collection(uid, 'completedGames')).doc(gameId);
    await runtime.firestore.runTransaction((transaction) async {
      final existing = await transaction.get(ref);
      _assertUid(uid);
      if (existing.exists) {
        final data = existing.data()!;
        for (final entry in payload.entries) {
          if (data[entry.key] != entry.value) {
            throw CloudRecordConflict('completedGame', gameId);
          }
        }
        return;
      }
      transaction.set(ref, {
        ...payload,
        'schemaVersion': 1,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> putDaily(
    String uid,
    String challengeKey,
    Map<String, Object?> payload,
  ) async {
    final ref = (await _collection(uid, 'daily')).doc(challengeKey);
    await runtime.firestore.runTransaction((transaction) async {
      final existing = await transaction.get(ref);
      _assertUid(uid);
      if (!existing.exists) {
        transaction.set(ref, {
          ...payload,
          'schemaVersion': 1,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  @override
  Future<void> putContribution(
    String uid,
    String techniqueId,
    String sourceId,
    Map<String, Object?> payload,
  ) async {
    final base = await _collection(uid, 'techniqueProgress');
    final ref = base.doc(techniqueId).collection('devices').doc(sourceId);
    await runtime.firestore.runTransaction((transaction) async {
      final existing = await transaction.get(ref);
      _assertUid(uid);
      final prior = existing.data();
      final merged = <String, Object?>{...payload};
      if (prior?['attempts'] is int &&
          payload['attempts'] is int &&
          (prior!['attempts']! as int) > (payload['attempts']! as int)) {
        merged['independentStreak'] = prior['independentStreak'];
      }
      for (final key in _counters) {
        final oldValue = prior?[key];
        final newValue = payload[key];
        if (oldValue is int && newValue is int && oldValue > newValue) {
          merged[key] = oldValue;
        }
      }
      final oldTime = prior?['lastPracticedAtMs'];
      final newTime = payload['lastPracticedAtMs'];
      if (oldTime is int && (newTime is! int || oldTime > newTime)) {
        merged['lastPracticedAtMs'] = oldTime;
      }
      transaction.set(ref, {
        ...merged,
        'schemaVersion': 1,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  static const _counters = [
    'attempts',
    'correctAttempts',
    'firstTryCorrect',
    'bestIndependentStreak',
    'directionHintSuccesses',
    'focusHintSuccesses',
    'reasoningHintSuccesses',
    'resultHintSuccesses',
  ];
}
