import 'dart:developer' as developer;

import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/recommendation/application/learning_profile_provider.dart';
import 'package:michi_mobile/features/recommendation/domain/daily_learning_focus_repository.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation_engine.dart';

final class LearningRecommendationService {
  const LearningRecommendationService({
    required this.profileProvider,
    required this.focusRepository,
    required this.clock,
    this.engine = const LearningRecommendationEngine(),
  });

  final LearningProfileProvider profileProvider;
  final DailyLearningFocusRepository focusRepository;
  final GameClock clock;
  final LearningRecommendationEngine engine;

  Future<LearningRecommendation> today() async {
    final date = LocalDate.fromDateTime(clock.now());
    try {
      final existing = await focusRepository.load(date);
      if (existing != null) return existing;
      final chosen = engine.recommend(await profileProvider.load(date));
      return await focusRepository.saveIfAbsent(date, chosen);
    } on Object catch (error, stackTrace) {
      developer.log(
        'Daily focus unavailable; using local progress if possible',
        name: 'michi.recommendation',
        error: error,
        stackTrace: stackTrace,
      );
      try {
        return engine.recommend(await profileProvider.load(date));
      } on Object {
        return engine.recommend(
          LearningProfileSnapshot(
            date: date,
            techniqueProgress: const {},
            recentNormalGames: const [],
          ),
        );
      }
    }
  }

  Future<LearningRecommendation> afterGame(
    GameLearningEvidence game,
  ) async {
    final date = LocalDate.fromDateTime(clock.now());
    try {
      return engine.recommend(
        await profileProvider.load(date),
        justFinished: game,
      );
    } on Object {
      return engine.recommend(
        LearningProfileSnapshot(
          date: date,
          techniqueProgress: const {},
          recentNormalGames: const [],
        ),
        justFinished: game,
      );
    }
  }
}
