import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class FixedContentClock implements GameClock {
  @override
  DateTime now() => DateTime(2026, 10, 26, 12);

  @override
  Duration monotonic() => Duration.zero;
}

final class ContentDriver {
  ContentDriver._(this.database)
    : games = DriftGameRepository(database),
      clock = FixedContentClock() {
    puzzles = LocalPuzzleRepository(LocalPuzzleCatalogLoader(), games);
  }

  static ContentDriver? current;
  static bool _bootstrapped = false;

  final GameDatabase database;
  final DriftGameRepository games;
  final FixedContentClock clock;
  late final LocalPuzzleRepository puzzles;
  AppRouter? router;
  DailyPuzzle? daily;
  CellRef? finalCell;
  int? finalDigit;

  static Future<ContentDriver> create(
    WidgetTester tester, {
    bool nearlyCompleted = false,
  }) async {
    if (!_bootstrapped) {
      bootstrap();
      _bootstrapped = true;
    }
    LocaleSettings.setLocaleSync(AppLocale.en);
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final driver = ContentDriver._(GameDatabase(NativeDatabase.memory()));
    addTearDown(driver.database.close);
    current = driver;
    await getIt.unregister<GameRepository>();
    getIt.registerSingleton<GameRepository>(driver.games);
    await getIt.unregister<PuzzleRepository>();
    getIt.registerSingleton<PuzzleRepository>(driver.puzzles);
    driver.daily = await tester.runAsync(
      () => driver.puzzles.getDailyPuzzle(LocalDate(2026, 10, 26)),
    );
    if (nearlyCompleted) {
      await tester.runAsync(driver.seedNearlyCompletedDaily);
    }
    driver.router = AppRouter();
    addTearDown(driver.router!.dispose);
    await tester.pumpWidget(MichiApp(router: driver.router!));
    await tester.pumpAndSettle();
    driver.router!.replaceAll([
      HomeRoute(
        repository: driver.games,
        puzzleRepository: driver.puzzles,
        clock: driver.clock,
      ),
    ]).ignore();
    await tester.pumpAndSettle();
    await settleUntil(tester, find.byKey(const ValueKey('daily-action')));
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
    });
    return driver;
  }

  static Future<void> settleUntil(WidgetTester tester, Finder finder) async {
    for (var attempt = 0; attempt < 30; attempt++) {
      await tester.pumpAndSettle();
      if (finder.evaluate().isNotEmpty) return;
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
    }
    expect(finder, findsWidgets);
  }

  Future<void> seedNearlyCompletedDaily() async {
    final challenge = daily!;
    final board = challenge.puzzle.initialBoard;
    final solution = const BacktrackingExactSolver().solve(board)!;
    final missing = Iterable<CellRef>.generate(
      81,
      CellRef.fromIndex,
    ).firstWhere(board.isEmpty);
    finalCell = missing;
    finalDigit = solution.valueAt(missing);
    final nearComplete = solution.withValue(missing, 0);
    final now = clock.now().toUtc();
    await games.saveActiveGame(
      StoredGame(
        gameId: 'daily-game-session',
        puzzleId: challenge.puzzle.id,
        dailyChallengeKey: challenge.challengeKey,
        initialBoard: board,
        currentBoard: nearComplete,
        notes: const {},
        undoHistory: const [],
        mistakes: 0,
        elapsedBeforeRun: const Duration(minutes: 8),
        runningSince: null,
        startedAt: now,
        updatedAt: now,
        isPaused: true,
        hintsRequested: 0,
        highestHintLevelUsed: 0,
        correctEditableCells: board.emptyCellCount - 1,
        editableCells: board.emptyCellCount,
      ),
    );
  }
}
