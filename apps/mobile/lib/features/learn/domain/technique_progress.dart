import 'package:sudoku_engine/sudoku_engine.dart';

enum TechniqueMastery { newTechnique, learning, practicing, mastered }

/// Transparent practice aggregates. A wrong check is an attempt; a completed
/// exercise is one correct answer, possibly after earlier wrong checks.
final class TechniqueProgress {
  const TechniqueProgress({
    required this.technique,
    this.attempts = 0,
    this.correctAttempts = 0,
    this.firstTryCorrect = 0,
    this.independentStreak = 0,
    this.masteredEver = false,
    this.directionHintSuccesses = 0,
    this.focusHintSuccesses = 0,
    this.reasoningHintSuccesses = 0,
    this.resultHintSuccesses = 0,
    this.lastPracticedAt,
  });

  final SudokuTechnique technique;
  final int attempts;
  final int correctAttempts;
  final int firstTryCorrect;
  final int independentStreak;
  final bool masteredEver;
  final int directionHintSuccesses;
  final int focusHintSuccesses;
  final int reasoningHintSuccesses;
  final int resultHintSuccesses;
  final DateTime? lastPracticedAt;

  int get hintAssistedSuccesses =>
      directionHintSuccesses +
      focusHintSuccesses +
      reasoningHintSuccesses +
      resultHintSuccesses;

  /// Progress toward the three explicit mastery conditions, capped at 100%.
  int get masteryPercent => masteredEver
      ? 100
      : ((correctAttempts / 5).clamp(0, 1) * 40 +
                (firstTryCorrect / 4).clamp(0, 1) * 35 +
                (independentStreak / 3).clamp(0, 1) * 25)
            .round();

  TechniqueMastery get mastery {
    if (masteredEver) return TechniqueMastery.mastered;
    if (correctAttempts >= 5 &&
        firstTryCorrect >= 4 &&
        independentStreak >= 3) {
      return TechniqueMastery.mastered;
    }
    if (correctAttempts >= 3) return TechniqueMastery.practicing;
    if (attempts > 0) return TechniqueMastery.learning;
    return TechniqueMastery.newTechnique;
  }

  TechniqueProgress afterCheck({
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  }) {
    final independent = correct && firstTry && highestHint == null;
    return TechniqueProgress(
      technique: technique,
      attempts: attempts + 1,
      correctAttempts: correctAttempts + (correct ? 1 : 0),
      firstTryCorrect: firstTryCorrect + (independent ? 1 : 0),
      independentStreak: independent ? independentStreak + 1 : 0,
      masteredEver: masteredEver || mastery == TechniqueMastery.mastered,
      directionHintSuccesses:
          directionHintSuccesses +
          (correct && highestHint == CoachHintLevel.direction ? 1 : 0),
      focusHintSuccesses:
          focusHintSuccesses +
          (correct && highestHint == CoachHintLevel.focus ? 1 : 0),
      reasoningHintSuccesses:
          reasoningHintSuccesses +
          (correct && highestHint == CoachHintLevel.reasoning ? 1 : 0),
      resultHintSuccesses:
          resultHintSuccesses +
          (correct && highestHint == CoachHintLevel.result ? 1 : 0),
      lastPracticedAt: at,
    );
  }
}
