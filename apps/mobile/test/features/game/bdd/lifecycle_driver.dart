import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_top_bar.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/home/presentation/home_page.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class TestGameClock implements GameClock {
  DateTime wall = DateTime.utc(2026, 10);
  Duration ticks = Duration.zero;

  @override
  DateTime now() => wall;

  @override
  Duration monotonic() => ticks;

  void advance(Duration amount) {
    wall = wall.add(amount);
    ticks += amount;
  }
}

final class LifecycleDriver {
  LifecycleDriver._(this.database)
    : repository = DriftGameRepository(database),
      clock = TestGameClock();

  factory LifecycleDriver.create(WidgetTester tester) {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    LocaleSettings.setLocaleSync(AppLocale.en);
    final driver = LifecycleDriver._(GameDatabase(NativeDatabase.memory()));
    addTearDown(driver.database.close);
    return driver;
  }

  static LifecycleDriver? current;

  final GameDatabase database;
  final DriftGameRepository repository;
  final TestGameClock clock;
  GameCubit? cubit;
  AppRouter? router;
  String? gameId;

  GameCubit newGame({SudokuPuzzle? puzzle}) {
    final created = GameCubit(
      puzzle: puzzle ?? DemoPuzzle.standard,
      exactSolver: const BacktrackingExactSolver(),
      humanSolver: const DeterministicHumanSolver(),
      coachEngine: const StructuredCoachEngine(),
      repository: repository,
      clock: clock,
    );
    cubit = created;
    gameId = created.state.gameId;
    addTearDown(() async {
      if (!created.isClosed) await created.close();
    });
    return created;
  }

  Future<void> showDirect(WidgetTester tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: GamePage(cubit: cubit),
        ),
      ),
    );
  }

  Future<void> prepareSavedGame() async {
    final game = newGame()
      ..selectCell(CellRef(row: 0, column: 2))
      ..enterDigit(1)
      ..toggleNotesMode()
      ..selectCell(CellRef(row: 0, column: 3))
      ..enterDigit(2)
      ..enterDigit(5)
      ..undo();
    clock.advance(const Duration(seconds: 37));
    game.pause();
    await game.flushPersistence();
    await game.close();
  }

  Future<void> reopenFromHome(WidgetTester tester) async {
    bootstrap();
    await getIt.unregister<PuzzleRepository>();
    getIt.registerSingleton<PuzzleRepository>(
      LocalPuzzleRepository(LocalPuzzleCatalogLoader(), repository),
    );
    final appRouter = AppRouter();
    router = appRouter;
    addTearDown(appRouter.dispose);
    await tester.pumpWidget(MichiApp(router: appRouter));
    // Ignore the navigation future: it completes only after Home is popped.
    appRouter.push(HomeRoute(repository: repository)).ignore();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('continue-game')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('continue-game')));
    await tester.pumpAndSettle();
    cubit = BlocProvider.of<GameCubit>(tester.element(find.byType(GameTopBar)));
  }

  Future<void> verifyRestore(WidgetTester tester) async {
    final state = cubit!.state;
    expect(state.gameId, gameId);
    expect(state.board.valueAt(CellRef(row: 0, column: 2)), 1);
    expect(state.puzzle.givens.valueAt(CellRef(row: 0, column: 2)), 0);
    expect(state.notes[CellRef(row: 0, column: 3)]!.digits, [2]);
    expect(state.mistakes, 1);
    expect(state.history, hasLength(2));
    expect(cubit!.elapsed, const Duration(seconds: 37));
    expect(state.isPaused, isTrue);
    expect(find.byType(SudokuBoardWidget), findsNothing);
    cubit!.resume();
    cubit!.undo();
    expect(cubit!.state.notes, isEmpty);
    cubit!.requestHint();
    expect(cubit!.state.hintUnavailable, isNotNull);
    await cubit!.flushPersistence();
    await tester.pumpWidget(const SizedBox.shrink());
  }

  Future<void> prepareRunning(WidgetTester tester) async {
    newGame();
    await showDirect(tester);
    clock.advance(const Duration(seconds: 9));
    await tester.pump();
  }

  Future<void> pause(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Pause'));
    await tester.pump();
  }

  void verifyPaused(WidgetTester tester) {
    expect(cubit!.state.isPaused, isTrue);
    expect(find.byType(SudokuBoardWidget), findsNothing);
    expect(find.byKey(const ValueKey('cell-2')), findsNothing);
    final before = cubit!.elapsed;
    clock.advance(const Duration(minutes: 4));
    expect(cubit!.elapsed, before);
    cubit!
      ..selectCell(CellRef(row: 0, column: 2))
      ..enterDigit(4)
      ..requestHint();
    expect(cubit!.state.board, DemoPuzzle.standard.givens);
    expect(cubit!.state.coach, isNull);
  }

  Future<void> resume(WidgetTester tester) async {
    await tester.tap(find.text('Resume'));
    await tester.pump();
  }

  void verifyResumed(WidgetTester tester) {
    expect(find.byType(SudokuBoardWidget), findsOneWidget);
    expect(cubit!.state.isPaused, isFalse);
    clock.advance(const Duration(seconds: 3));
    expect(cubit!.elapsed, const Duration(seconds: 12));
  }

  Future<void> prepareCompletion(WidgetTester tester) async {
    final solution = const BacktrackingExactSolver().solve(
      DemoPuzzle.standard.givens,
    )!;
    final last = CellRef(row: 0, column: 0);
    final puzzle = SudokuPuzzle(
      id: 'one-away',
      givens: solution.withValue(last, 0),
    );
    newGame(puzzle: puzzle);
    await cubit!.flushPersistence();
    await showDirect(tester);
  }

  Future<void> finish(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('cell-0')));
    await tester.tap(find.byKey(const ValueKey('keypad-5')));
    await tester.pump();
    await cubit!.flushPersistence();
    await tester.pump();
  }

  Future<void> verifyCompletion(WidgetTester tester) async {
    expect(cubit!.state.status, GameStatus.completed);
    expect(find.text('Solved.'), findsOneWidget);
    expect(await repository.loadActiveGame(), isNull);
    final completed = await repository.loadRecentCompletedGames();
    expect(completed, hasLength(1));
    expect(completed.single.gameId, gameId);
    cubit!.enterDigit(5);
    cubit!.retryPersistence();
    await cubit!.flushPersistence();
    expect(await repository.loadRecentCompletedGames(), hasLength(1));
  }

  Future<void> verifyHomeWithoutContinue(WidgetTester tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: HomePage(repository: repository),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('continue-game')), findsNothing);
  }
}
