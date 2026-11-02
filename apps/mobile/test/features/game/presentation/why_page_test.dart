import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/game/presentation/why_page.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/presentation/technique_lesson_page.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  setUpAll(bootstrap);
  const exact = BacktrackingExactSolver();
  const human = DeterministicHumanSolver();
  const coach = StructuredCoachEngine();
  final first = CellRef(row: 0, column: 0);
  final second = CellRef(row: 0, column: 1);
  final solved = exact.solve(DemoPuzzle.standard.givens)!;
  final puzzle = SudokuPuzzle(
    id: 'why-widget',
    givens: solved.withValue(first, 0).withValue(second, 0),
  );

  Future<AppRouter> pumpWhy(
    WidgetTester tester, {
    required GameCubit game,
    required WhySelection selection,
    required CellRef cell,
    Size size = const Size(390, 844),
    AppLocale locale = AppLocale.en,
  }) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = size;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    LocaleSettings.setLocaleSync(locale);
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router.config(),
        ),
      ),
    );
    router.replaceAll([
      GameRoute(cubit: game),
      WhyRoute(game: game.state, selection: selection, cell: cell),
    ]).ignore();
    await tester.pumpAndSettle();
    return router;
  }

  for (final locale in AppLocale.values) {
    testWidgets('Why wraps ${locale.languageCode} copy on a compact phone', (
      tester,
    ) async {
      final game = GameCubit(
        puzzle: puzzle,
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
      );
      addTearDown(game.close);
      game
        ..selectCell(first)
        ..enterDigit(5);
      await pumpWhy(
        tester,
        game: game,
        selection: game.whyForCell(first),
        cell: first,
        size: const Size(375, 667),
        locale: locale,
      );
      expect(find.byType(WhyPage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final size in [
    const Size(375, 667),
    const Size(390, 844),
    const Size(440, 956),
  ]) {
    testWidgets('Naked Single explanation fits ${size.width}×${size.height}', (
      tester,
    ) async {
      final game = GameCubit(
        puzzle: puzzle,
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
      );
      addTearDown(game.close);
      game
        ..selectCell(first)
        ..enterDigit(5);
      await pumpWhy(
        tester,
        game: game,
        selection: game.whyForCell(first),
        cell: first,
        size: size,
      );
      expect(find.byType(WhyPage), findsOneWidget);
      expect(find.byType(SudokuBoardWidget), findsOneWidget);
      expect(find.text('Why does 5 go here?'), findsOneWidget);
      expect(find.text('Naked single'), findsOneWidget);
      expect(find.text('Lesson'), findsOneWidget);
      expect(find.text('Got it'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Hidden Single uses three numbered facts', (tester) async {
    final game = GameCubit(
      puzzle: puzzle,
      exactSolver: exact,
      humanSolver: human,
      coachEngine: coach,
    );
    addTearDown(game.close);
    game
      ..selectCell(first)
      ..enterDigit(5);
    final preBoard = puzzle.givens;
    final deduction = const HiddenSingleTechnique()
        .find(
          HumanSolverState.initial(preBoard),
        )
        .firstWhere(
          (item) => item.placements.contains(DigitPlacement(first, 5)),
        );
    final plan = const StructuredWhyEngine().createPlan(
      deduction,
      DigitPlacement(first, 5),
    )!;
    await pumpWhy(
      tester,
      game: game,
      selection: WhySelection(WhyAvailability.available, plan: plan),
      cell: first,
    );
    expect(find.text('Hidden single'), findsOneWidget);
    expect(find.text('Therefore 5 goes here.'), findsOneWidget);
    expect(find.text('4'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('given digit has no technique or fabricated proof', (
    tester,
  ) async {
    final game = GameCubit(
      puzzle: puzzle,
      exactSolver: exact,
      humanSolver: human,
      coachEngine: coach,
    );
    addTearDown(game.close);
    final given = CellRef(row: 0, column: 2);
    await pumpWhy(
      tester,
      game: game,
      selection: game.whyForCell(given),
      cell: given,
    );
    expect(find.text('This is a given digit of the puzzle'), findsOneWidget);
    expect(find.text('Lesson'), findsNothing);
    expect(find.text('Got it'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Lesson opens the matching flow and Got it returns to Game', (
    tester,
  ) async {
    final game = GameCubit(
      puzzle: puzzle,
      exactSolver: exact,
      humanSolver: human,
      coachEngine: coach,
    );
    addTearDown(game.close);
    game
      ..selectCell(first)
      ..enterDigit(5);
    final router = await pumpWhy(
      tester,
      game: game,
      selection: game.whyForCell(first),
      cell: first,
    );
    final handle = tester.ensureSemantics();
    expect(find.bySemanticsLabel(RegExp(r'^1\. ')), findsOneWidget);
    expect(find.bySemanticsLabel('Lesson'), findsOneWidget);
    await tester.tap(find.text('Lesson'));
    await tester.pumpAndSettle();
    expect(find.byType(TechniqueLessonPage), findsOneWidget);
    expect(router.current.name, TechniqueLessonRoute.name);
    await router.maybePop();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.byType(GamePage), findsOneWidget);
    expect(find.byType(WhyPage), findsNothing);
    handle.dispose();
  });
}
