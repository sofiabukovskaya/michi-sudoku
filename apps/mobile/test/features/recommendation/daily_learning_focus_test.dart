import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_lesson_page.dart';
import 'package:michi_mobile/features/practice/presentation/practice_page.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_profile_provider.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/data/drift_daily_learning_focus_repository.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _Clock implements GameClock {
  DateTime wall = DateTime(2026, 11, 2, 12);

  @override
  DateTime now() => wall;

  @override
  Duration monotonic() => Duration.zero;
}

final class _Puzzles implements PuzzleRepository {
  final definition = PuzzleDefinition(
    id: DemoPuzzle.standard.id,
    initialBoard: DemoPuzzle.standard.givens,
    difficulty: PuzzleDifficulty.medium,
    requiredTechniques: const {SudokuTechnique.nakedPair},
    contentVersion: 1,
    dailyEligible: true,
  );

  @override
  Future<PuzzleDefinition> getPuzzle(String id) async => definition;

  @override
  Future<PuzzleDefinition> selectPuzzle({
    required PuzzleDifficulty difficulty,
  }) async => definition;

  @override
  Future<DailyPuzzle> getDailyPuzzle(LocalDate date) async => DailyPuzzle(
    date: date,
    challengeKey: '$date|test',
    puzzle: definition,
  );
}

void main() {
  setUpAll(bootstrap);

  test(
    'focus remains fixed today, survives recreation, changes on new date',
    () async {
      final db = GameDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final clock = _Clock();
      final progress = DriftTechniqueProgressRepository(db);
      final games = DriftGameRepository(db);
      final provider = LearningProfileProvider(progress, games, _Puzzles());
      final focus = DriftDailyLearningFocusRepository(db);
      LearningRecommendationService service() => LearningRecommendationService(
        profileProvider: provider,
        focusRepository: focus,
        clock: clock,
      );
      final first = await service().today();
      expect(first.technique, SudokuTechnique.nakedSingle);
      expect(first.action, RecommendationAction.learnTechnique);
      final afterGame = await service().afterGame(
        GameLearningEvidence(
          gameId: 'just-finished',
          techniqueHelp: const {SudokuTechnique.nakedTriple: 4},
        ),
      );
      expect(afterGame.technique, SudokuTechnique.nakedTriple);
      expect((await service().today()).technique, first.technique);
      for (var index = 0; index < 5; index++) {
        await progress.recordCheck(
          technique: SudokuTechnique.nakedSingle,
          correct: true,
          firstTry: true,
          highestHint: null,
          at: clock.now(),
        );
      }
      expect((await service().today()).technique, SudokuTechnique.nakedSingle);
      clock.wall = DateTime(2026, 11, 3, 12);
      final tomorrow = await service().today();
      expect(tomorrow.technique, SudokuTechnique.hiddenSingle);
      expect(tomorrow.reason, RecommendationReason.nextTechnique);
    },
  );

  test(
    'profile uses recent completed normal games and recorded Coach depth',
    () async {
      final db = GameDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final games = DriftGameRepository(db);
      final now = DateTime.utc(2026, 11, 2);
      final solved = const BacktrackingExactSolver().solve(
        DemoPuzzle.standard.givens,
      )!;
      Future<void> add(String id, int level, {bool daily = false}) =>
          games.completeGame(
            CompletedGame(
              gameId: id,
              puzzleId: DemoPuzzle.standard.id,
              initialBoard: DemoPuzzle.standard.givens,
              completedBoard: solved,
              startedAt: now,
              completedAt: now,
              elapsed: const Duration(minutes: 10),
              mistakes: 0,
              hintsRequested: 1,
              highestHintLevelUsed: level,
              dailyChallengeKey: daily ? '$id|daily' : null,
              techniqueHelp: {SudokuTechnique.nakedPair: level},
            ),
          );
      await add('normal-1', 1);
      await add('normal-2', 4);
      await add('daily', 4, daily: true);
      final provider = LearningProfileProvider(
        DriftTechniqueProgressRepository(db),
        games,
        _Puzzles(),
      );
      final snapshot = await provider.load(LocalDate(2026, 11, 2));
      expect(snapshot.recentNormalGames, hasLength(2));
      expect(
        snapshot.recentNormalGames.first.requiredTechniques,
        contains(SudokuTechnique.nakedPair),
      );
      final result = await LearningRecommendationService(
        profileProvider: provider,
        focusRepository: DriftDailyLearningFocusRepository(db),
        clock: _Clock(),
      ).today();
      expect(result.technique, SudokuTechnique.nakedPair);
      expect(result.action, RecommendationAction.practiceTechnique);
      expect(result.evidence.recentHelpGames, 2);
    },
  );

  test('schema 4 data survives the daily-focus table migration', () async {
    final directory = await Directory.systemTemp.createTemp('michi-focus-v4-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/games.sqlite');
    final before = GameDatabase(NativeDatabase(file));
    final games = DriftGameRepository(before);
    final progress = DriftTechniqueProgressRepository(before);
    final now = DateTime.utc(2026, 11, 2);
    final target = CellRef(row: 0, column: 2);
    final givens = DemoPuzzle.standard.givens;
    await games.saveActiveGame(
      StoredGame(
        gameId: 'active-v4',
        puzzleId: DemoPuzzle.standard.id,
        initialBoard: givens,
        currentBoard: givens.withValue(target, 4),
        notes: const {},
        undoHistory: const [],
        mistakes: 0,
        elapsedBeforeRun: Duration.zero,
        runningSince: null,
        startedAt: now,
        updatedAt: now,
        isPaused: true,
        hintsRequested: 0,
        highestHintLevelUsed: 0,
        correctEditableCells: 1,
        editableCells: givens.emptyCellCount,
        reasoning: {
          target: MoveReasoningContext(
            preMoveBoard: givens,
            cell: target,
            digit: 4,
            technique: SudokuTechnique.nakedSingle,
            source: MoveReasoningSource.manual,
          ),
        },
      ),
    );
    await games.completeGame(
      CompletedGame(
        gameId: 'completed-v4',
        puzzleId: DemoPuzzle.standard.id,
        initialBoard: givens,
        completedBoard: const BacktrackingExactSolver().solve(givens)!,
        startedAt: now,
        completedAt: now,
        elapsed: const Duration(minutes: 9),
        mistakes: 0,
        hintsRequested: 1,
        highestHintLevelUsed: 3,
        techniqueHelp: const {SudokuTechnique.nakedPair: 3},
      ),
    );
    await progress.recordCheck(
      technique: SudokuTechnique.nakedSingle,
      correct: true,
      firstTry: true,
      highestHint: null,
      at: now,
    );
    await before.customStatement('DROP TABLE daily_learning_focuses');
    await before.customStatement('PRAGMA user_version = 4');
    await before.close();

    final after = GameDatabase(NativeDatabase(file));
    addTearDown(after.close);
    final restored = DriftGameRepository(after);
    expect((await restored.loadActiveGame())?.reasoning, hasLength(1));
    expect(
      (await restored.loadRecentCompletedGames()).single.techniqueHelp,
      {SudokuTechnique.nakedPair: 3},
    );
    expect(
      (await DriftTechniqueProgressRepository(
        after,
      ).load(SudokuTechnique.nakedSingle)).attempts,
      1,
    );
    final focus = DriftDailyLearningFocusRepository(after);
    expect(await focus.load(LocalDate(2026, 11, 2)), isNull);
    final service = LearningRecommendationService(
      profileProvider: LearningProfileProvider(
        DriftTechniqueProgressRepository(after),
        restored,
        _Puzzles(),
      ),
      focusRepository: focus,
      clock: _Clock(),
    );
    expect((await service.today()).technique, isNotNull);
  });

  test(
    'persisted daily focus and its evidence survive database reopening',
    () async {
      final directory = await Directory.systemTemp.createTemp('michi-focus-');
      addTearDown(() => directory.delete(recursive: true));
      final file = File('${directory.path}/games.sqlite');
      final clock = _Clock();
      final before = GameDatabase(NativeDatabase(file));
      final firstService = LearningRecommendationService(
        profileProvider: LearningProfileProvider(
          DriftTechniqueProgressRepository(before),
          DriftGameRepository(before),
          _Puzzles(),
        ),
        focusRepository: DriftDailyLearningFocusRepository(before),
        clock: clock,
      );
      final first = await firstService.today();
      for (var index = 0; index < 5; index++) {
        await DriftTechniqueProgressRepository(before).recordCheck(
          technique: SudokuTechnique.nakedSingle,
          correct: true,
          firstTry: true,
          highestHint: null,
          at: clock.now(),
        );
      }
      await before.close();
      final after = GameDatabase(NativeDatabase(file));
      addTearDown(after.close);
      final second = await LearningRecommendationService(
        profileProvider: LearningProfileProvider(
          DriftTechniqueProgressRepository(after),
          DriftGameRepository(after),
          _Puzzles(),
        ),
        focusRepository: DriftDailyLearningFocusRepository(after),
        clock: clock,
      ).today();
      expect(second.technique, first.technique);
      expect(second.action, first.action);
      expect(second.reason, first.reason);
      expect(second.evidence.practiceAttempts, first.evidence.practiceAttempts);
    },
  );

  for (final size in [
    const Size(375, 667),
    const Size(390, 844),
    const Size(430, 930),
  ]) {
    testWidgets('Home focus opens recommended Practice at ${size.width}', (
      tester,
    ) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      LocaleSettings.setLocaleSync(AppLocale.en);
      final db = GameDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      final games = DriftGameRepository(db);
      final now = DateTime.utc(2026, 11, 2);
      final solved = const BacktrackingExactSolver().solve(
        DemoPuzzle.standard.givens,
      )!;
      for (final id in ['one', 'two']) {
        await games.completeGame(
          CompletedGame(
            gameId: id,
            puzzleId: DemoPuzzle.standard.id,
            initialBoard: DemoPuzzle.standard.givens,
            completedBoard: solved,
            startedAt: now,
            completedAt: now,
            elapsed: const Duration(minutes: 10),
            mistakes: 0,
            hintsRequested: 1,
            highestHintLevelUsed: 3,
            techniqueHelp: const {SudokuTechnique.nakedPair: 3},
          ),
        );
      }
      final puzzles = _Puzzles();
      final clock = _Clock();
      final service = LearningRecommendationService(
        profileProvider: LearningProfileProvider(
          DriftTechniqueProgressRepository(db),
          games,
          puzzles,
        ),
        focusRepository: DriftDailyLearningFocusRepository(db),
        clock: clock,
      );
      final router = AppRouter();
      addTearDown(router.dispose);
      await tester.pumpWidget(MichiApp(router: router));
      router.replaceAll([
        HomeRoute(
          repository: games,
          puzzleRepository: puzzles,
          clock: clock,
          recommendationService: service,
        ),
      ]).ignore();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('daily-learning-focus')),
        findsOneWidget,
      );
      expect(find.textContaining('Naked pair'), findsWidgets);
      final focus = find.byKey(const ValueKey('daily-learning-focus'));
      final semantics = tester.ensureSemantics();
      expect(tester.getSemantics(focus).label, contains('Practice Naked pair'));
      semantics.dispose();
      await tester.ensureVisible(focus);
      await tester.tap(focus);
      await tester.pumpAndSettle();
      expect(find.byType(PracticePage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Learn current emphasis opens the recommended next lesson', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final db = GameDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final progress = DriftTechniqueProgressRepository(db);
    for (var index = 0; index < 5; index++) {
      await progress.recordCheck(
        technique: SudokuTechnique.nakedSingle,
        correct: true,
        firstTry: true,
        highestHint: null,
        at: DateTime.utc(2026, 11, 2),
      );
    }
    final service = LearningRecommendationService(
      profileProvider: LearningProfileProvider(
        progress,
        DriftGameRepository(db),
        _Puzzles(),
      ),
      focusRepository: DriftDailyLearningFocusRepository(db),
      clock: _Clock(),
    );
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    router.replaceAll([
      LearnRoute(progressRepository: progress, recommendationService: service),
    ]).ignore();
    await tester.pumpAndSettle();
    final current = find.ancestor(
      of: find.text('Now'),
      matching: find.byKey(const ValueKey('learn-hiddenSingle')),
    );
    expect(current, findsOneWidget);
    expect(find.text('Now'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('learn-hiddenSingle')));
    await tester.pumpAndSettle();
    expect(find.byType(TechniqueLessonPage), findsOneWidget);
  });

  testWidgets('post-game deep Coach help fills the one next-step row', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final db = GameDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final service = LearningRecommendationService(
      profileProvider: LearningProfileProvider(
        DriftTechniqueProgressRepository(db),
        DriftGameRepository(db),
        _Puzzles(),
      ),
      focusRepository: DriftDailyLearningFocusRepository(db),
      clock: _Clock(),
    );
    final solution = const BacktrackingExactSolver().solve(
      DemoPuzzle.standard.givens,
    )!;
    final cell = CellRef(row: 0, column: 0);
    final oneMissing = solution.withValue(cell, 0);
    final now = DateTime.utc(2026, 11, 2);
    final cubit = GameCubit.restore(
      stored: StoredGame(
        gameId: 'post-game-focus',
        puzzleId: 'one-missing',
        initialBoard: oneMissing,
        currentBoard: oneMissing,
        notes: const {},
        undoHistory: const [],
        mistakes: 0,
        elapsedBeforeRun: Duration.zero,
        runningSince: null,
        startedAt: now,
        updatedAt: now,
        isPaused: true,
        hintsRequested: 1,
        highestHintLevelUsed: 4,
        techniqueHelp: const {SudokuTechnique.nakedTriple: 4},
        correctEditableCells: 0,
        editableCells: 1,
      ),
      exactSolver: const BacktrackingExactSolver(),
      humanSolver: const DeterministicHumanSolver(),
      coachEngine: const StructuredCoachEngine(),
    );
    addTearDown(cubit.close);
    cubit.resume();
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: GamePage(cubit: cubit, recommendationService: service),
        ),
      ),
    );
    cubit
      ..selectCell(cell)
      ..enterDigit(solution.valueAt(cell));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('post-game-next-step')), findsOneWidget);
    expect(find.textContaining('Practice Naked triple'), findsOneWidget);
    expect(find.text('Techniques in this puzzle'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
