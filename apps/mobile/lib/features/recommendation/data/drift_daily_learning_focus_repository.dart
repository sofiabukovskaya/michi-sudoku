import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/recommendation/domain/daily_learning_focus_repository.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class DriftDailyLearningFocusRepository
    implements DailyLearningFocusRepository {
  const DriftDailyLearningFocusRepository(this.database);

  final GameDatabase database;

  @override
  Future<LearningRecommendation?> load(LocalDate date) async {
    final row =
        await (database.select(database.dailyLearningFocuses)
              ..where((table) => table.localDate.equals(date.toString())))
            .getSingleOrNull();
    if (row == null) return null;
    final technique = SudokuTechnique.values.byName(row.techniqueId);
    return LearningRecommendation(
      technique: technique,
      action: RecommendationAction.values.byName(row.actionId),
      reason: RecommendationReason.values.byName(row.reasonId),
      estimatedMinutes: row.estimatedMinutes,
      evidence: _parseEvidence(row.evidenceJson),
    );
  }

  @override
  Future<LearningRecommendation> saveIfAbsent(
    LocalDate date,
    LearningRecommendation recommendation,
  ) => database.transaction(() async {
    await database
        .into(database.dailyLearningFocuses)
        .insert(
          DailyLearningFocusesCompanion.insert(
            localDate: date.toString(),
            techniqueId: recommendation.technique.name,
            actionId: recommendation.action.name,
            reasonId: recommendation.reason.name,
            estimatedMinutes: recommendation.estimatedMinutes,
            evidenceJson: _encodeEvidence(recommendation.evidence),
          ),
          mode: InsertMode.insertOrIgnore,
        );
    return (await load(date))!;
  });

  String _encodeEvidence(RecommendationEvidence evidence) => jsonEncode({
    'mastery': evidence.mastery.name,
    'attempts': evidence.practiceAttempts,
    'independent': evidence.independentSuccesses,
    'streak': evidence.independentStreak,
    'help': evidence.recentHelpGames,
    'deepHelp': evidence.recentDeepHelpGames,
    'exposure': evidence.recentPuzzleExposure,
    'lastPracticedAt': evidence.lastPracticedAt?.millisecondsSinceEpoch,
  });

  RecommendationEvidence _parseEvidence(String source) {
    final data = jsonDecode(source) as Map<String, dynamic>;
    final last = data['lastPracticedAt'] as int?;
    return RecommendationEvidence(
      mastery: TechniqueMastery.values.byName(data['mastery'] as String),
      practiceAttempts: data['attempts'] as int,
      independentSuccesses: data['independent'] as int,
      independentStreak: data['streak'] as int,
      recentHelpGames: data['help'] as int,
      recentDeepHelpGames: data['deepHelp'] as int,
      recentPuzzleExposure: data['exposure'] as int,
      lastPracticedAt: last == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(last, isUtc: true),
    );
  }
}
