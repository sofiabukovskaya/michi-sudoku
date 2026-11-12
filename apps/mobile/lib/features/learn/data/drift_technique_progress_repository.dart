import 'package:drift/drift.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/sync_outbox_writer.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Per-installation counters project into the existing local aggregate.
final class DriftTechniqueProgressRepository
    implements TechniqueProgressRepository {
  DriftTechniqueProgressRepository(this.database, [LocalProfileScope? scope])
    : scope = scope ?? LocalProfileScope();

  final GameDatabase database;
  final LocalProfileScope scope;

  @override
  Future<TechniqueProgress> load(SudokuTechnique technique) async {
    final row =
        await (database.select(database.techniqueProgressEntries)..where(
              (table) =>
                  table.profileId.equals(scope.profileId) &
                  table.techniqueId.equals(technique.name),
            ))
            .getSingleOrNull();
    return row == null
        ? TechniqueProgress(technique: technique)
        : _fromAggregate(row);
  }

  @override
  Future<Map<SudokuTechnique, TechniqueProgress>> loadAll() async {
    final rows = await (database.select(
      database.techniqueProgressEntries,
    )..where((table) => table.profileId.equals(scope.profileId))).get();
    return {
      for (final row in rows)
        if (SudokuTechnique.values.any((item) => item.name == row.techniqueId))
          SudokuTechnique.values.byName(row.techniqueId): _fromAggregate(row),
    };
  }

  @override
  Future<TechniqueProgress> recordCheck({
    required SudokuTechnique technique,
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  }) async {
    final profileId = scope.profileId;
    return database.transaction(() async {
      final installation = await database
          .customSelect(
            "SELECT value FROM sync_metadata WHERE key = 'installationId'",
          )
          .getSingle();
      var sourceId = installation.read<String>('value');
      if (profileId == LocalProfileScope.guest) {
        final guestImport = await database
            .customSelect(
              "SELECT value FROM sync_metadata WHERE key = 'guestImportId'",
            )
            .getSingle();
        sourceId = 'guest:${guestImport.read<String>('value')}:$sourceId';
      }
      final prior =
          await (database.select(database.techniqueContributions)..where(
                (row) =>
                    row.profileId.equals(profileId) &
                    row.techniqueId.equals(technique.name) &
                    row.sourceId.equals(sourceId),
              ))
              .getSingleOrNull();
      final updated =
          (prior == null
                  ? TechniqueProgress(technique: technique)
                  : _fromContribution(prior))
              .afterCheck(
                correct: correct,
                firstTry: firstTry,
                highestHint: highestHint,
                at: at,
              );
      await database
          .into(database.techniqueContributions)
          .insertOnConflictUpdate(
            TechniqueContributionsCompanion.insert(
              profileId: profileId,
              techniqueId: technique.name,
              sourceId: sourceId,
              attempts: updated.attempts,
              correctAttempts: updated.correctAttempts,
              firstTryCorrect: updated.firstTryCorrect,
              independentStreak: updated.independentStreak,
              bestIndependentStreak:
                  prior == null ||
                      updated.independentStreak > prior.bestIndependentStreak
                  ? updated.independentStreak
                  : prior.bestIndependentStreak,
              directionHintSuccesses: updated.directionHintSuccesses,
              focusHintSuccesses: updated.focusHintSuccesses,
              reasoningHintSuccesses: updated.reasoningHintSuccesses,
              resultHintSuccesses: updated.resultHintSuccesses,
              lastPracticedAtMs: Value(at.millisecondsSinceEpoch),
            ),
          );
      final aggregate = await rebuildAggregate(profileId, technique);
      await SyncOutboxWriter(database).enqueue(
        profileId,
        'technique',
        '${technique.name}/$sourceId',
      );
      return aggregate;
    });
  }

  /// Called by sync after merging a remote contribution into Drift.
  Future<TechniqueProgress> rebuildAggregate(
    String profileId,
    SudokuTechnique technique,
  ) async {
    final rows =
        await (database.select(database.techniqueContributions)..where(
              (row) =>
                  row.profileId.equals(profileId) &
                  row.techniqueId.equals(technique.name),
            ))
            .get();
    int sum(int Function(TechniqueContribution) read) =>
        rows.fold(0, (total, row) => total + read(row));
    final lastMs = rows
        .map((row) => row.lastPracticedAtMs)
        .whereType<int>()
        .fold<int?>(
          null,
          (latest, time) => latest == null || time > latest ? time : latest,
        );
    final correctAttempts = sum((row) => row.correctAttempts);
    final firstTryCorrect = sum((row) => row.firstTryCorrect);
    final bestStreak = rows.fold(
      0,
      (max, row) =>
          row.bestIndependentStreak > max ? row.bestIndependentStreak : max,
    );
    final result = TechniqueProgress(
      technique: technique,
      attempts: sum((row) => row.attempts),
      correctAttempts: correctAttempts,
      firstTryCorrect: firstTryCorrect,
      masteredEver:
          correctAttempts >= 5 && firstTryCorrect >= 4 && bestStreak >= 3,
      independentStreak: rows.fold(
        0,
        (max, row) => row.independentStreak > max ? row.independentStreak : max,
      ),
      directionHintSuccesses: sum((row) => row.directionHintSuccesses),
      focusHintSuccesses: sum((row) => row.focusHintSuccesses),
      reasoningHintSuccesses: sum((row) => row.reasoningHintSuccesses),
      resultHintSuccesses: sum((row) => row.resultHintSuccesses),
      lastPracticedAt: lastMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(lastMs, isUtc: true),
    );
    await database
        .into(database.techniqueProgressEntries)
        .insertOnConflictUpdate(
          TechniqueProgressEntriesCompanion.insert(
            profileId: Value(profileId),
            techniqueId: technique.name,
            attempts: result.attempts,
            correctAttempts: result.correctAttempts,
            firstTryCorrect: result.firstTryCorrect,
            independentStreak: result.independentStreak,
            masteredEver: Value(result.masteredEver),
            directionHintSuccesses: result.directionHintSuccesses,
            focusHintSuccesses: result.focusHintSuccesses,
            reasoningHintSuccesses: result.reasoningHintSuccesses,
            resultHintSuccesses: result.resultHintSuccesses,
            lastPracticedAtMs: Value(lastMs),
          ),
        );
    return result;
  }

  TechniqueProgress _fromAggregate(TechniqueProgressRow row) =>
      TechniqueProgress(
        technique: SudokuTechnique.values.byName(row.techniqueId),
        attempts: row.attempts,
        correctAttempts: row.correctAttempts,
        firstTryCorrect: row.firstTryCorrect,
        independentStreak: row.independentStreak,
        masteredEver: row.masteredEver,
        directionHintSuccesses: row.directionHintSuccesses,
        focusHintSuccesses: row.focusHintSuccesses,
        reasoningHintSuccesses: row.reasoningHintSuccesses,
        resultHintSuccesses: row.resultHintSuccesses,
        lastPracticedAt: row.lastPracticedAtMs == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                row.lastPracticedAtMs!,
                isUtc: true,
              ),
      );

  TechniqueProgress _fromContribution(TechniqueContribution row) =>
      TechniqueProgress(
        technique: SudokuTechnique.values.byName(row.techniqueId),
        attempts: row.attempts,
        correctAttempts: row.correctAttempts,
        firstTryCorrect: row.firstTryCorrect,
        independentStreak: row.independentStreak,
        directionHintSuccesses: row.directionHintSuccesses,
        focusHintSuccesses: row.focusHintSuccesses,
        reasoningHintSuccesses: row.reasoningHintSuccesses,
        resultHintSuccesses: row.resultHintSuccesses,
        lastPracticedAt: row.lastPracticedAtMs == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(
                row.lastPracticedAtMs!,
                isUtc: true,
              ),
      );
}
