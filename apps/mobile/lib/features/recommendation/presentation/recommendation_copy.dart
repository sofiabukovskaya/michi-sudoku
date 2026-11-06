import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';

abstract final class RecommendationCopy {
  static String action(Translations t, LearningRecommendation value) {
    final name = TechniqueCopy.name(t, value.technique);
    return switch (value.action) {
      RecommendationAction.learnTechnique => t.recommendation.learnAction(
        technique: name,
      ),
      RecommendationAction.practiceTechnique => t.recommendation.practiceAction(
        technique: name,
      ),
      RecommendationAction.reviewTechnique => t.recommendation.reviewAction(
        technique: name,
      ),
    };
  }

  static String reason(
    Translations t,
    LearningRecommendation value,
  ) => switch (value.reason) {
    RecommendationReason.startWithBasics => t.recommendation.startWithBasics,
    RecommendationReason.repeatedCoachHelp =>
      t.recommendation.repeatedCoachHelp,
    RecommendationReason.weakIndependentPractice =>
      t.recommendation.weakIndependentPractice,
    RecommendationReason.continuePractice => t.recommendation.continuePractice,
    RecommendationReason.nextTechnique => t.recommendation.nextTechnique,
    RecommendationReason.masteredNeedsReview =>
      t.recommendation.masteredNeedsReview,
    RecommendationReason.allMasteredReview =>
      t.recommendation.allMasteredReview,
  };

  static String duration(Translations t, LearningRecommendation value) =>
      t.recommendation.duration(minutes: value.estimatedMinutes);

  static String detail(Translations t, LearningRecommendation value) =>
      '${reason(t, value)} · ${duration(t, value)}';
}

Future<void> openRecommendation(
  BuildContext context,
  LearningRecommendation recommendation,
) async {
  switch (recommendation.action) {
    case RecommendationAction.learnTechnique:
      await context.router.root.push(
        TechniqueLessonRoute(technique: recommendation.technique),
      );
    case RecommendationAction.practiceTechnique:
    case RecommendationAction.reviewTechnique:
      await context.router.root.push(
        PracticeRoute(technique: recommendation.technique),
      );
  }
}
