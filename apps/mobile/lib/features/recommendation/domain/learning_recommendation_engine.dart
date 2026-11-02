import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Deterministic rules over existing practice and the last ten normal games.
/// A deep hint is Reasoning or Result (level 3 or 4). Direction/Focus are light.
final class LearningRecommendationEngine {
  const LearningRecommendationEngine();

  LearningRecommendation recommend(
    LearningProfileSnapshot profile, {
    GameLearningEvidence? justFinished,
  }) {
    const order = TechniqueLessons.supported;
    final games = <GameLearningEvidence>[
      ?justFinished,
      for (final game in profile.recentNormalGames)
        if (game.gameId != justFinished?.gameId) game,
    ].take(10).toList();

    RecommendationEvidence evidence(SudokuTechnique technique) {
      final progress =
          profile.techniqueProgress[technique] ??
          TechniqueProgress(technique: technique);
      return RecommendationEvidence(
        mastery: progress.mastery,
        practiceAttempts: progress.attempts,
        independentSuccesses: progress.firstTryCorrect,
        independentStreak: progress.independentStreak,
        recentHelpGames: games
            .where((game) => (game.techniqueHelp[technique] ?? 0) > 0)
            .length,
        recentDeepHelpGames: games
            .where((game) => (game.techniqueHelp[technique] ?? 0) >= 3)
            .length,
        recentPuzzleExposure: games
            .where((game) => game.requiredTechniques.contains(technique))
            .length,
        lastPracticedAt: progress.lastPracticedAt,
      );
    }

    LearningRecommendation choice(
      SudokuTechnique technique,
      RecommendationAction action,
      RecommendationReason reason,
    ) => LearningRecommendation(
      technique: technique,
      action: action,
      reason: reason,
      estimatedMinutes: action == RecommendationAction.learnTechnique ? 6 : 5,
      evidence: evidence(technique),
    );

    // A Result/Reasoning hint in the just-finished game is immediate,
    // technique-specific evidence. A Direction/Focus hint alone is not.
    if (justFinished != null) {
      for (final technique in order) {
        if ((justFinished.techniqueHelp[technique] ?? 0) >= 3) {
          return choice(
            technique,
            evidence(technique).mastery == TechniqueMastery.mastered
                ? RecommendationAction.reviewTechnique
                : RecommendationAction.practiceTechnique,
            RecommendationReason.repeatedCoachHelp,
          );
        }
      }
    }

    final repeatedlyHelped =
        [
          for (final technique in order)
            if (evidence(technique).mastery != TechniqueMastery.mastered &&
                evidence(technique).recentHelpGames >= 2)
              technique,
        ]..sort((a, b) {
          final strength = evidence(b).recentHelpGames.compareTo(
            evidence(a).recentHelpGames,
          );
          return strength != 0
              ? strength
              : order.indexOf(a).compareTo(order.indexOf(b));
        });
    if (repeatedlyHelped.isNotEmpty) {
      return choice(
        repeatedlyHelped.first,
        RecommendationAction.practiceTechnique,
        RecommendationReason.repeatedCoachHelp,
      );
    }
    // Three checks avoid reacting to a single error. First-try independent
    // success below 50% is evidence of a practice gap.
    final weakPractice =
        [
          for (final technique in order)
            if (evidence(technique).mastery != TechniqueMastery.mastered &&
                evidence(technique).practiceAttempts >= 3 &&
                evidence(technique).independentSuccesses * 2 <
                    evidence(technique).practiceAttempts)
              technique,
        ]..sort((a, b) {
          final aGap =
              evidence(a).practiceAttempts -
              2 * evidence(a).independentSuccesses;
          final bGap =
              evidence(b).practiceAttempts -
              2 * evidence(b).independentSuccesses;
          final strength = bGap.compareTo(aGap);
          return strength != 0
              ? strength
              : order.indexOf(a).compareTo(order.indexOf(b));
        });
    if (weakPractice.isNotEmpty) {
      return choice(
        weakPractice.first,
        RecommendationAction.practiceTechnique,
        RecommendationReason.weakIndependentPractice,
      );
    }
    for (final technique in order) {
      final item = evidence(technique);
      if (item.mastery != TechniqueMastery.mastered &&
          item.practiceAttempts > 0) {
        return choice(
          technique,
          RecommendationAction.practiceTechnique,
          RecommendationReason.continuePractice,
        );
      }
    }
    for (final technique in order) {
      final item = evidence(technique);
      if (item.mastery != TechniqueMastery.newTechnique) continue;
      final earlier = order.take(order.indexOf(technique));
      if (earlier.every(
        (previous) => evidence(previous).mastery == TechniqueMastery.mastered,
      )) {
        return choice(
          technique,
          RecommendationAction.learnTechnique,
          technique == order.first
              ? RecommendationReason.startWithBasics
              : RecommendationReason.nextTechnique,
        );
      }
    }
    for (final technique in order) {
      final item = evidence(technique);
      if (item.mastery == TechniqueMastery.mastered &&
          item.recentDeepHelpGames >= 2) {
        return choice(
          technique,
          RecommendationAction.reviewTechnique,
          RecommendationReason.masteredNeedsReview,
        );
      }
    }
    for (final technique in order) {
      if (evidence(technique).mastery != TechniqueMastery.mastered) {
        return choice(
          technique,
          RecommendationAction.learnTechnique,
          RecommendationReason.nextTechnique,
        );
      }
    }
    final oldest = order.reduce((a, b) {
      final aDate = evidence(a).lastPracticedAt;
      final bDate = evidence(b).lastPracticedAt;
      if (aDate == null) return a;
      if (bDate == null) return b;
      return aDate.isAfter(bDate) ? b : a;
    });
    return choice(
      oldest,
      RecommendationAction.reviewTechnique,
      RecommendationReason.allMasteredReview,
    );
  }
}
