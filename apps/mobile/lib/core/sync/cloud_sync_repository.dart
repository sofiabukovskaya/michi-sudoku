/// Network boundary for sync. Feature repositories never call Firestore.
abstract interface class CloudSyncRepository {
  Future<CloudSnapshot> pull(String uid);

  /// Creates an append-only record or verifies an identical existing record.
  Future<void> putCompletedGame(
    String uid,
    String gameId,
    Map<String, Object?> payload,
  );

  Future<void> putDaily(
    String uid,
    String challengeKey,
    Map<String, Object?> payload,
  );

  /// Merges monotonic counters for one stable source installation.
  Future<void> putContribution(
    String uid,
    String techniqueId,
    String sourceId,
    Map<String, Object?> payload,
  );
}

final class CloudSnapshot {
  const CloudSnapshot({
    required this.completedGames,
    required this.daily,
    required this.contributions,
  });

  final Map<String, Map<String, Object?>> completedGames;
  final Map<String, Map<String, Object?>> daily;
  final Map<String, Map<String, Map<String, Object?>>> contributions;
}

final class CloudRecordConflict implements Exception {
  const CloudRecordConflict(this.entityType, this.id);

  final String entityType;
  final String id;
}
