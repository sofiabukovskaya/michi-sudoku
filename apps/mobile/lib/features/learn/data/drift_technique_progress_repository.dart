import 'package:drift/drift.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class DriftTechniqueProgressRepository
    implements TechniqueProgressRepository {
  const DriftTechniqueProgressRepository(this.database);

  final GameDatabase database;

  @override
  Future<TechniqueProgress> load(SudokuTechnique technique) async {
    final row =
        await (database.select(database.techniqueProgressEntries)
              ..where((table) => table.techniqueId.equals(technique.name)))
            .getSingleOrNull();
    return row == null
        ? TechniqueProgress(technique: technique)
        : _fromRow(row);
  }

  @override
  Future<Map<SudokuTechnique, TechniqueProgress>> loadAll() async {
    final rows = await database.select(database.techniqueProgressEntries).get();
    return {
      for (final row in rows)
        if (SudokuTechnique.values.any((item) => item.name == row.techniqueId))
          SudokuTechnique.values.byName(row.techniqueId): _fromRow(row),
    };
  }

  @override
  Future<TechniqueProgress> recordCheck({
    required SudokuTechnique technique,
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  }) => database.transaction(() async {
    final updated = (await load(technique)).afterCheck(
      correct: correct,
      firstTry: firstTry,
      highestHint: highestHint,
      at: at,
    );
    await database
        .into(database.techniqueProgressEntries)
        .insertOnConflictUpdate(
          TechniqueProgressEntriesCompanion.insert(
            techniqueId: technique.name,
            attempts: updated.attempts,
            correctAttempts: updated.correctAttempts,
            firstTryCorrect: updated.firstTryCorrect,
            independentStreak: updated.independentStreak,
            directionHintSuccesses: updated.directionHintSuccesses,
            focusHintSuccesses: updated.focusHintSuccesses,
            reasoningHintSuccesses: updated.reasoningHintSuccesses,
            resultHintSuccesses: updated.resultHintSuccesses,
            lastPracticedAtMs: Value(at.millisecondsSinceEpoch),
          ),
        );
    return updated;
  });

  TechniqueProgress _fromRow(TechniqueProgressRow row) => TechniqueProgress(
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
