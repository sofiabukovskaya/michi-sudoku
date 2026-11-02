import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation_engine.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

const engine = LearningRecommendationEngine();
final day = LocalDate(2026, 11, 2);

TechniqueProgress mastered(SudokuTechnique technique, {DateTime? at}) =>
    TechniqueProgress(
      technique: technique,
      attempts: 5,
      correctAttempts: 5,
      firstTryCorrect: 5,
      independentStreak: 5,
      lastPracticedAt: at,
    );

LearningProfileSnapshot profile({
  Map<SudokuTechnique, TechniqueProgress> progress = const {},
  List<GameLearningEvidence> games = const [],
}) => LearningProfileSnapshot(
  date: day,
  techniqueProgress: progress,
  recentNormalGames: games,
);

GameLearningEvidence game(
  String id,
  SudokuTechnique technique,
  int level,
) => GameLearningEvidence(gameId: id, techniqueHelp: {technique: level});

void main() {
  test('brand-new player starts with the first supported technique', () {
    final result = engine.recommend(profile());
    expect(result.technique, SudokuTechnique.nakedSingle);
    expect(result.action, RecommendationAction.learnTechnique);
    expect(result.reason, RecommendationReason.startWithBasics);
  });

  test(
    'two recent helped games recommend practice without changing mastery',
    () {
      final result = engine.recommend(
        profile(
          games: [
            game('one', SudokuTechnique.nakedPair, 1),
            game('two', SudokuTechnique.nakedPair, 2),
          ],
        ),
      );
      expect(result.technique, SudokuTechnique.nakedPair);
      expect(result.action, RecommendationAction.practiceTechnique);
      expect(result.reason, RecommendationReason.repeatedCoachHelp);
      expect(result.evidence.recentHelpGames, 2);
      expect(result.evidence.recentDeepHelpGames, 0);
    },
  );

  test(
    'one isolated mistake is ignored; weak independent practice is used',
    () {
      const weak = TechniqueProgress(
        technique: SudokuTechnique.hiddenPair,
        attempts: 4,
        correctAttempts: 2,
        firstTryCorrect: 1,
      );
      final result = engine.recommend(
        profile(progress: {weak.technique: weak}),
      );
      expect(result.technique, SudokuTechnique.hiddenPair);
      expect(result.reason, RecommendationReason.weakIndependentPractice);
      expect(result.evidence.independentSuccesses, 1);
    },
  );

  test('learning or practicing technique is continued', () {
    const learning = TechniqueProgress(
      technique: SudokuTechnique.pointingPair,
      attempts: 2,
      correctAttempts: 2,
      firstTryCorrect: 2,
    );
    final result = engine.recommend(
      profile(progress: {learning.technique: learning}),
    );
    expect(result.technique, SudokuTechnique.pointingPair);
    expect(result.reason, RecommendationReason.continuePractice);
  });

  test('next technique follows authoritative order after prior mastery', () {
    final previous = TechniqueLessons.supported.take(5);
    final result = engine.recommend(
      profile(
        progress: {
          for (final technique in previous) technique: mastered(technique),
        },
      ),
    );
    expect(result.technique, SudokuTechnique.boxLineReduction);
    expect(result.action, RecommendationAction.learnTechnique);
    expect(result.reason, RecommendationReason.nextTechnique);
  });

  test('mastered but repeatedly deep-helped technique becomes review', () {
    final result = engine.recommend(
      profile(
        progress: {
          for (final technique in TechniqueLessons.supported)
            technique: mastered(technique),
        },
        games: [
          game('one', SudokuTechnique.hiddenSingle, 3),
          game('two', SudokuTechnique.hiddenSingle, 4),
        ],
      ),
    );
    expect(result.technique, SudokuTechnique.hiddenSingle);
    expect(result.action, RecommendationAction.reviewTechnique);
    expect(result.reason, RecommendationReason.masteredNeedsReview);
    expect(result.evidence.mastery, TechniqueMastery.mastered);
  });

  test('all mastered reviews the oldest practiced technique', () {
    final results = {
      for (final technique in TechniqueLessons.supported)
        technique: mastered(technique, at: DateTime.utc(2026, 11)),
      SudokuTechnique.xWing: mastered(
        SudokuTechnique.xWing,
        at: DateTime.utc(2026),
      ),
    };
    final result = engine.recommend(profile(progress: results));
    expect(result.technique, SudokuTechnique.xWing);
    expect(result.reason, RecommendationReason.allMasteredReview);
  });

  test('equal evidence breaks ties by authoritative technique order', () {
    final games = [
      game('one', SudokuTechnique.hiddenPair, 2),
      game('two', SudokuTechnique.hiddenPair, 1),
      game('three', SudokuTechnique.pointingPair, 2),
      game('four', SudokuTechnique.pointingPair, 1),
    ];
    final first = engine.recommend(profile(games: games));
    final second = engine.recommend(profile(games: games));
    expect(first.technique, SudokuTechnique.pointingPair);
    expect(second.technique, first.technique);
    expect(second.reason, first.reason);
  });

  test('more helped games win before technique-order tie break', () {
    final result = engine.recommend(
      profile(
        games: [
          game('one', SudokuTechnique.nakedPair, 1),
          game('two', SudokuTechnique.nakedPair, 1),
          game('three', SudokuTechnique.hiddenPair, 1),
          game('four', SudokuTechnique.hiddenPair, 2),
          game('five', SudokuTechnique.hiddenPair, 3),
        ],
      ),
    );
    expect(result.technique, SudokuTechnique.hiddenPair);
    expect(result.evidence.recentHelpGames, 3);
  });

  test('post-game deep help immediately targets that technique', () {
    final result = engine.recommend(
      profile(),
      justFinished: game('new', SudokuTechnique.nakedTriple, 4),
    );
    expect(result.technique, SudokuTechnique.nakedTriple);
    expect(result.action, RecommendationAction.practiceTechnique);
    expect(result.evidence.recentDeepHelpGames, 1);
  });

  test('post-game light help alone does not invent a weakness', () {
    final result = engine.recommend(
      profile(),
      justFinished: game('new', SudokuTechnique.nakedTriple, 1),
    );
    expect(result.technique, SudokuTechnique.nakedSingle);
    expect(result.reason, RecommendationReason.startWithBasics);
  });

  test('just-finished game is not counted twice when already in history', () {
    final finished = game('same', SudokuTechnique.nakedPair, 1);
    final result = engine.recommend(
      profile(games: [finished]),
      justFinished: finished,
    );
    expect(result.evidence.recentHelpGames, 0);
  });

  test('unsupported future techniques are never recommended', () {
    final result = engine.recommend(
      profile(
        games: [
          game('one', SudokuTechnique.xyWing, 4),
          game('two', SudokuTechnique.xyWing, 4),
        ],
      ),
    );
    expect(result.technique, SudokuTechnique.nakedSingle);
  });
}
