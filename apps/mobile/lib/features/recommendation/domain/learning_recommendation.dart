import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

enum RecommendationAction { learnTechnique, practiceTechnique, reviewTechnique }

enum RecommendationReason {
  startWithBasics,
  repeatedCoachHelp,
  weakIndependentPractice,
  continuePractice,
  nextTechnique,
  masteredNeedsReview,
  allMasteredReview,
}

/// One completed normal game. Help values are highest Coach levels (1–4),
/// already recorded by Game; they are not request counts.
final class GameLearningEvidence {
  GameLearningEvidence({
    required this.gameId,
    required Map<SudokuTechnique, int> techniqueHelp,
    Set<SudokuTechnique> requiredTechniques = const {},
  }) : techniqueHelp = Map.unmodifiable(techniqueHelp),
       requiredTechniques = Set.unmodifiable(requiredTechniques);

  final String gameId;
  final Map<SudokuTechnique, int> techniqueHelp;
  final Set<SudokuTechnique> requiredTechniques;
}

final class LearningProfileSnapshot {
  LearningProfileSnapshot({
    required this.date,
    required Map<SudokuTechnique, TechniqueProgress> techniqueProgress,
    required List<GameLearningEvidence> recentNormalGames,
  }) : techniqueProgress = Map.unmodifiable(techniqueProgress),
       recentNormalGames = List.unmodifiable(recentNormalGames);

  final LocalDate date;
  final Map<SudokuTechnique, TechniqueProgress> techniqueProgress;
  final List<GameLearningEvidence> recentNormalGames;
}

/// Inspectable facts behind one decision. No user-facing copy lives here.
final class RecommendationEvidence {
  const RecommendationEvidence({
    required this.mastery,
    required this.practiceAttempts,
    required this.independentSuccesses,
    required this.independentStreak,
    required this.recentHelpGames,
    required this.recentDeepHelpGames,
    required this.recentPuzzleExposure,
    this.lastPracticedAt,
  });

  final TechniqueMastery mastery;
  final int practiceAttempts;
  final int independentSuccesses;
  final int independentStreak;
  final int recentHelpGames;
  final int recentDeepHelpGames;
  final int recentPuzzleExposure;
  final DateTime? lastPracticedAt;
}

final class LearningRecommendation {
  const LearningRecommendation({
    required this.technique,
    required this.action,
    required this.reason,
    required this.estimatedMinutes,
    required this.evidence,
  });

  final SudokuTechnique technique;
  final RecommendationAction action;
  final RecommendationReason reason;
  final int estimatedMinutes;
  final RecommendationEvidence evidence;
}
