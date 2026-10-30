import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  late GameDatabase database;
  late DriftTechniqueProgressRepository repository;
  final now = DateTime.utc(2026, 10, 29);

  setUp(() {
    database = GameDatabase(NativeDatabase.memory());
    repository = DriftTechniqueProgressRepository(database);
  });
  tearDown(() => database.close());

  Future<TechniqueProgress> check({
    bool correct = true,
    bool firstTry = true,
    CoachHintLevel? hint,
  }) => repository.recordCheck(
    technique: SudokuTechnique.hiddenSingle,
    correct: correct,
    firstTry: firstTry,
    highestHint: hint,
    at: now,
  );

  test('new technique has a meaningful New state', () async {
    final progress = await repository.load(SudokuTechnique.hiddenSingle);
    expect(progress.attempts, 0);
    expect(progress.mastery, TechniqueMastery.newTechnique);
    expect(await repository.loadAll(), isEmpty);
  });

  test('wrong checks reset the independent streak', () async {
    await check();
    final wrong = await check(correct: false);
    expect(wrong.attempts, 2);
    expect(wrong.correctAttempts, 1);
    expect(wrong.firstTryCorrect, 1);
    expect(wrong.independentStreak, 0);
    expect(wrong.mastery, TechniqueMastery.learning);
  });

  test(
    'hint-assisted success records its deepest level and resets streak',
    () async {
      await check();
      final assisted = await check(hint: CoachHintLevel.result);
      expect(assisted.resultHintSuccesses, 1);
      expect(assisted.hintAssistedSuccesses, 1);
      expect(assisted.firstTryCorrect, 1);
      expect(assisted.independentStreak, 0);
      final restored = DriftTechniqueProgressRepository(database);
      expect(
        (await restored.load(SudokuTechnique.hiddenSingle)).resultHintSuccesses,
        1,
      );
    },
  );

  test(
    'five completions with four first tries and a streak of three master',
    () async {
      await check(firstTry: false);
      await check();
      await check();
      await check();
      final mastered = await check();
      expect(mastered.correctAttempts, 5);
      expect(mastered.firstTryCorrect, 4);
      expect(mastered.independentStreak, 4);
      expect(mastered.mastery, TechniqueMastery.mastered);
      expect(mastered.lastPracticedAt, now);
    },
  );

  test(
    'all four hint levels remain distinguishable in persisted totals',
    () async {
      for (final level in CoachHintLevel.values) {
        await check(hint: level);
      }
      final progress = await repository.load(SudokuTechnique.hiddenSingle);
      expect(progress.directionHintSuccesses, 1);
      expect(progress.focusHintSuccesses, 1);
      expect(progress.reasoningHintSuccesses, 1);
      expect(progress.resultHintSuccesses, 1);
      expect(progress.mastery, TechniqueMastery.practicing);
    },
  );
}
