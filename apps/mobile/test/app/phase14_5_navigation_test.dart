import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/navigation/michi_bottom_nav.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_profile_provider.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/data/drift_daily_learning_focus_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

Finder tab(String name) => find.descendant(
  of: find.byType(MichiBottomNav),
  matching: find.text(name),
);

void main() {
  setUpAll(bootstrap);

  testWidgets('four tabs preserve their roots and Week uses local history', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final games = DriftGameRepository(database);
    final progress = DriftTechniqueProgressRepository(database);
    final puzzles = LocalPuzzleRepository(LocalPuzzleCatalogLoader(), games);
    final clock = getIt<GameClock>();
    final service = LearningRecommendationService(
      profileProvider: LearningProfileProvider(progress, games, puzzles),
      focusRepository: DriftDailyLearningFocusRepository(database),
      clock: clock,
    );
    await getIt.unregister<GameRepository>();
    getIt.registerSingleton<GameRepository>(games);
    await getIt.unregister<TechniqueProgressRepository>();
    getIt.registerSingleton<TechniqueProgressRepository>(progress);
    await getIt.unregister<PuzzleRepository>();
    getIt.registerSingleton<PuzzleRepository>(puzzles);
    await getIt.unregister<LearningRecommendationService>();
    getIt.registerSingleton<LearningRecommendationService>(service);

    final now = clock.now();
    final solution = const BacktrackingExactSolver().solve(
      DemoPuzzle.standard.givens,
    )!;
    await games.completeGame(
      CompletedGame(
        gameId: 'week-seed',
        puzzleId: DemoPuzzle.standard.id,
        initialBoard: DemoPuzzle.standard.givens,
        completedBoard: solution,
        startedAt: now.subtract(const Duration(minutes: 12)),
        completedAt: now,
        elapsed: const Duration(minutes: 12),
        mistakes: 0,
        hintsRequested: 0,
        highestHintLevelUsed: 0,
      ),
    );
    for (var index = 0; index < 5; index++) {
      await progress.recordCheck(
        technique: SudokuTechnique.nakedSingle,
        correct: true,
        firstTry: true,
        highestHint: null,
        at: now,
      );
    }
    expect((await games.loadRecentCompletedGames(limit: 1000)).length, 1);
    expect((await progress.loadAll()).isNotEmpty, isTrue);

    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    await router.replaceAll([AppShellRoute()]);
    await tester.pumpAndSettle();
    expect(find.text('Good morning'), findsOneWidget);
    await tester.tap(tab('Learn'));
    await tester.pumpAndSettle();
    expect(find.text('Learn'), findsWidgets);
    await tester.tap(tab('Progress'));
    await tester.pumpAndSettle();
    expect(find.text('What is going well'), findsOneWidget);
    expect(find.text('What you are learning now'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    await tester.tap(tab('Profile'));
    await tester.pumpAndSettle();
    expect(
      tester.widgetList<Text>(find.byType(Text)).map((item) => item.data),
      contains('Guest'),
    );
    expect(find.text('Puzzles'), findsOneWidget);
    expect(find.text('1'), findsWidgets);
    await tester.tap(tab('Play'));
    await tester.pumpAndSettle();
    expect(find.text('Good morning'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('week-details')));
    await tester.tap(find.byKey(const ValueKey('week-details')));
    await tester.pumpAndSettle();
    expect(find.text('This week'), findsOneWidget);
    expect(find.text('12'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(MichiBottomNav), findsOneWidget);

    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    for (final size in [
      const Size(375, 667),
      const Size(390, 844),
      const Size(440, 956),
    ]) {
      tester.view.physicalSize = size;
      await tester.pumpAndSettle();
      for (final label in ['Learn', 'Progress', 'Profile', 'Play']) {
        await tester.tap(tab(label));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    }

    await tester.tap(tab('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Choose the language for MICHI.'), findsOneWidget);
    expect(find.byType(MichiBottomNav), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Guest'), findsOneWidget);
    await tester.tap(find.text('Techniques and practice'));
    await tester.pumpAndSettle();
    expect(find.text('Basics'), findsOneWidget);
    await tester.tap(tab('Learn'));
    await tester.pumpAndSettle();
    expect(router.stack.length, 1);

    await tester.tap(tab('Play'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Another puzzle'));
    await tester.tap(find.text('Another puzzle'));
    await tester.pumpAndSettle();
    expect(find.text('Scan Sudoku'), findsOneWidget);
    await tester.tap(find.text('Scan Sudoku'));
    await tester.pumpAndSettle();
    expect(
      find.text('Frame the whole grid, then take a photo or choose one.'),
      findsOneWidget,
    );
    expect(find.byType(MichiBottomNav), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(MichiBottomNav), findsOneWidget);

    tester.view.physicalSize = const Size(375, 667);
    tester.platformDispatcher.textScaleFactorTestValue = 1.3;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    for (final locale in AppLocale.values) {
      await LocaleSettings.setLocale(locale);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      router.push(const SettingsRoute()).ignore();
      await tester.pumpAndSettle();
      expect(find.text('Français'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await router.maybePop();
      await tester.pumpAndSettle();
    }
  });
}
