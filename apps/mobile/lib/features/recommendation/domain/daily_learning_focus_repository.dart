import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';

abstract interface class DailyLearningFocusRepository {
  Future<LearningRecommendation?> load(LocalDate date);

  /// First writer wins if two Home loads race on the same local day.
  Future<LearningRecommendation> saveIfAbsent(
    LocalDate date,
    LearningRecommendation recommendation,
  );
}
