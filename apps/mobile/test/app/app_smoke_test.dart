import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/home/presentation/home_page.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_profile_provider.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/data/drift_daily_learning_focus_repository.dart';

final class _StartupRepository implements GameRepository {
  StoredGame? active;

  @override
  Future<StoredGame?> loadActiveGame() async => active;

  @override
  Future<ActiveGameSummary?> loadActiveSummary() async {
    final game = active;
    if (game == null) return null;
    return ActiveGameSummary(
      gameId: game.gameId,
      puzzleId: game.puzzleId,
      correctEditableCells: game.correctEditableCells,
      editableCells: game.editableCells,
      elapsed: game.elapsedBeforeRun,
      startedAt: game.startedAt,
    );
  }

  @override
  Future<void> saveActiveGame(StoredGame game) async => active = game;

  @override
  Future<void> deleteActiveGame(String gameId) async {
    if (active?.gameId == gameId) active = null;
  }

  @override
  Future<void> completeGame(CompletedGame game) async => active = null;

  @override
  Future<List<CompletedGame>> loadRecentCompletedGames({
    int limit = 20,
    bool normalOnly = false,
  }) async => const [];

  @override
  Future<List<String>> recentCompletedPuzzleIds({int limit = 20}) async => [];

  @override
  Future<bool> isDailyCompleted(String challengeKey) async => false;
}

void main() {
  late _StartupRepository startupRepository;

  setUpAll(bootstrap);
  setUp(() async {
    startupRepository = _StartupRepository();
    await getIt.unregister<GameRepository>();
    getIt.registerSingleton<GameRepository>(startupRepository);
    await getIt.unregister<PuzzleRepository>();
    getIt.registerSingleton<PuzzleRepository>(
      LocalPuzzleRepository(LocalPuzzleCatalogLoader(), startupRepository),
    );
  });

  testWidgets('app boots and navigates from splash to welcome', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.uk);
    final router = getIt<AppRouter>();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    await tester.pumpAndSettle();
    expect(find.text('Вчися бачити наступний хід.'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
    await tester.pumpAndSettle();
    expect(find.text('Знайди свій шлях крізь логіку.'), findsOneWidget);

    await LocaleSettings.setLocale(AppLocale.cs);
    await tester.pumpAndSettle();
    expect(find.text('Najdi svou cestu logikou.'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).locale?.languageCode,
      'cs',
    );
    LocaleSettings.setLocaleSync(AppLocale.uk);
  });

  testWidgets('home route opens a playable catalog game', (tester) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftGameRepository(database);
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    unawaited(router.push(HomeRoute(repository: repository)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Another puzzle'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('difficulty-easy')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('cell-0')), findsOneWidget);
    expect(find.byKey(const ValueKey('hint-control')), findsOneWidget);
    LocaleSettings.setLocaleSync(AppLocale.uk);
  });

  testWidgets('saved game bypasses onboarding at startup', (tester) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final focusDatabase = GameDatabase(NativeDatabase.memory());
    addTearDown(focusDatabase.close);
    await getIt.unregister<LearningRecommendationService>();
    getIt.registerSingleton<LearningRecommendationService>(
      LearningRecommendationService(
        profileProvider: LearningProfileProvider(
          DriftTechniqueProgressRepository(focusDatabase),
          startupRepository,
          getIt<PuzzleRepository>(),
        ),
        focusRepository: DriftDailyLearningFocusRepository(focusDatabase),
        clock: getIt<GameClock>(),
      ),
    );
    final now = DateTime.utc(2026, 10);
    await startupRepository.saveActiveGame(
      StoredGame(
        gameId: 'startup-game',
        puzzleId: DemoPuzzle.standard.id,
        initialBoard: DemoPuzzle.standard.givens,
        currentBoard: DemoPuzzle.standard.givens,
        notes: const {},
        undoHistory: const [],
        mistakes: 0,
        elapsedBeforeRun: const Duration(minutes: 2),
        runningSince: null,
        startedAt: now,
        updatedAt: now,
        isPaused: true,
        hintsRequested: 0,
        highestHintLevelUsed: 0,
        correctEditableCells: 0,
        editableCells: DemoPuzzle.standard.givens.emptyCellCount,
      ),
    );
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();
    expect(find.text('Good morning'), findsOneWidget);
    expect(
      tester.widget<HomePage>(find.byType(HomePage)).repository,
      same(startupRepository),
    );
    expect(
      tester.widget<HomePage>(find.byType(HomePage)).recommendationService,
      isNotNull,
    );
    expect(await startupRepository.loadActiveSummary(), isNotNull);
    expect(find.byKey(const ValueKey('continue-game')), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Focus of the day: Naked single'), findsOneWidget);
    expect(find.text('Your path through Sudoku.'), findsNothing);
    LocaleSettings.setLocaleSync(AppLocale.uk);
  });
}
