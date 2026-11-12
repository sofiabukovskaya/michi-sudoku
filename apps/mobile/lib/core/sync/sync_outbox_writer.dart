import 'package:drift/drift.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';

/// Called inside the same Drift transaction as the domain mutation.
final class SyncOutboxWriter {
  const SyncOutboxWriter(this.database);

  final GameDatabase database;

  Future<void> enqueue(String profileId, String type, String id) async {
    if (profileId == 'guest') return;
    final existing =
        await (database.select(database.syncOutbox)..where(
              (row) =>
                  row.profileId.equals(profileId) &
                  row.entityType.equals(type) &
                  row.entityId.equals(id),
            ))
            .getSingleOrNull();
    await database
        .into(database.syncOutbox)
        .insertOnConflictUpdate(
          SyncOutboxCompanion.insert(
            profileId: profileId,
            entityType: type,
            entityId: id,
            revision: Value((existing?.revision ?? 0) + 1),
            createdAtMs: DateTime.now().toUtc().millisecondsSinceEpoch,
          ),
        );
  }
}
