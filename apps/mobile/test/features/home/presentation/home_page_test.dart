import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/home/presentation/home_page.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _MutableClock implements GameClock {
  DateTime wall = DateTime(2026, 10, 26, 12);

  @override
  DateTime now() => wall;

  @override
  Duration monotonic() => Duration.zero;
}

final class _DailyTestPuzzles implements PuzzleRepository {
  final PuzzleDefinition definition = PuzzleDefinition(
    id: 'date-test',
    initialBoard: DemoPuzzle.standard.givens,
    difficulty: PuzzleDifficulty.easy,
    requiredTechniques: const {SudokuTechnique.nakedSingle},
    contentVersion: 1,
    dailyEligible: true,
  );

  @override
  Future<DailyPuzzle> getDailyPuzzle(LocalDate date) async => DailyPuzzle(
    date: date,
    challengeKey: '$date|catalog-v1',
    puzzle: definition,
  );

  @override
  Future<PuzzleDefinition> getPuzzle(String id) async => definition;

  @override
  Future<PuzzleDefinition> selectPuzzle({
    required PuzzleDifficulty difficulty,
  }) async => definition;
}

void main() {
  setUpAll(bootstrap);

  testWidgets('Home shows Continue only for an unfinished local game', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftGameRepository(database);
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    router
        .push(
          HomeRoute(
            repository: repository,
            puzzleRepository: LocalPuzzleRepository(
              LocalPuzzleCatalogLoader(),
              repository,
            ),
          ),
        )
        .ignore();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(
      tester.widget<HomePage>(find.byType(HomePage)).repository,
      same(repository),
    );
    expect(find.byKey(const ValueKey('continue-game')), findsNothing);

    final now = DateTime.utc(2026, 10);
    final game = StoredGame(
      gameId: 'saved',
      puzzleId: DemoPuzzle.standard.id,
      initialBoard: DemoPuzzle.standard.givens,
      currentBoard: DemoPuzzle.standard.givens,
      notes: const {},
      undoHistory: const [],
      mistakes: 0,
      elapsedBeforeRun: const Duration(minutes: 18, seconds: 4),
      runningSince: null,
      startedAt: now,
      updatedAt: now,
      isPaused: true,
      hintsRequested: 0,
      highestHintLevelUsed: 0,
      correctEditableCells: 0,
      editableCells: DemoPuzzle.standard.givens.emptyCellCount,
    );
    await repository.saveActiveGame(game);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('continue-game')), findsOneWidget);
    expect(find.textContaining('18:04'), findsOneWidget);

    await tester.tap(find.text('Another puzzle'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('difficulty-easy')));
    await tester.pumpAndSettle();
    expect(find.textContaining('replace'), findsWidgets);
    await tester.tap(find.text('Keep playing'));
    await tester.pumpAndSettle();
    expect((await repository.loadActiveGame())!.gameId, 'saved');
  });

  testWidgets('Home refreshes the local Daily after midnight on resume', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final games = DriftGameRepository(database);
    final puzzles = _DailyTestPuzzles();
    final clock = _MutableClock();
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: HomePage(
            repository: games,
            puzzleRepository: puzzles,
            clock: clock,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('2026-10-26'), findsOneWidget);

    clock.wall = DateTime(2026, 10, 27, 12);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(find.textContaining('2026-10-27'), findsOneWidget);
    expect(find.textContaining('2026-10-26'), findsNothing);
  });

  testWidgets('Scan Sudoku remains reachable in a compact puzzle sheet', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    tester.view.physicalSize = const Size(375, 667);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: HomePage(
            repository: DriftGameRepository(database),
            puzzleRepository: _DailyTestPuzzles(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Another puzzle'));
    await tester.pumpAndSettle();

    final scan = find.byKey(const ValueKey('scan-sudoku'));
    expect(scan, findsOneWidget);
    await tester.ensureVisible(scan);
    await tester.pumpAndSettle();
    expect(scan.hitTestable(), findsOneWidget);
  });
}
