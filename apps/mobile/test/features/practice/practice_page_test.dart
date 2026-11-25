import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/focused_unit_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/practice/domain/practice_session_order.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

Future<void> _settleUntil(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 30; attempt++) {
    await tester.pumpAndSettle();
    if (finder.evaluate().isNotEmpty) return;
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
  }
  expect(finder, findsWidgets);
}

void main() {
  setUpAll(bootstrap);
  late GameDatabase database;
  late DriftTechniqueProgressRepository progress;
  late AppRouter router;
  final catalog = LocalPracticeCatalog();

  setUp(() async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    database = GameDatabase(NativeDatabase.memory());
    progress = DriftTechniqueProgressRepository(database);
    await getIt.unregister<TechniqueProgressRepository>();
    getIt.registerSingleton<TechniqueProgressRepository>(progress);
    router = AppRouter();
  });
  tearDown(() async {
    router.dispose();
    await database.close();
  });

  Future<void> pumpPractice(
    WidgetTester tester,
    SudokuTechnique technique, {
    Size size = const Size(390, 844),
  }) async {
    await tester.runAsync(catalog.load);
    await tester.pumpWidget(const SizedBox.shrink());
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = size;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MichiApp(router: router));
    router.replaceAll([
      PracticeRoute(technique: technique, catalog: catalog),
    ]).ignore();
    await _settleUntil(
      tester,
      find.byKey(const ValueKey('practice-check')),
    );
  }

  for (final size in [
    const Size(360, 640),
    const Size(390, 844),
    const Size(430, 932),
    const Size(601, 1007),
    const Size(1024, 768),
  ]) {
    testWidgets('Hidden Single controls stay usable at $size', (tester) async {
      await pumpPractice(tester, SudokuTechnique.hiddenSingle, size: size);
      final board = find.byType(FocusedUnitWidget);
      expect(board, findsOneWidget);
      // Phone keeps the approved excerpt size; tablets get a deliberate,
      // bounded step up instead of a board stretched to the window.
      expect(
        tester.getSize(board).height,
        lessThanOrEqualTo(size.width < 600 ? 280 : 320),
      );
      final check = find.byKey(const ValueKey('practice-check'));
      expect(check.hitTestable(), findsOneWidget);
      final first = practiceSessionOrder(
        (await tester.runAsync(
          () => catalog.forTechnique(SudokuTechnique.hiddenSingle),
        ))!,
      ).first;
      final answer = const DeterministicHumanSolver()
          .findNextDeduction(first.initialState)!
          .placements
          .single;
      await tester.tap(find.byKey(ValueKey('cell-${answer.cell.index}')));
      await tester.tap(find.byKey(ValueKey('practice-digit-${answer.digit}')));
      // Check enables once an answer exists.
      await tester.pump();
      await tester.tap(check);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
      // Success proves the move: the digit lands in its cell.
      expect(
        find.byKey(ValueKey('proof-digit-${answer.cell.index}')),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Naked Single placement checks and advances', (tester) async {
    final nakedSingles = (await tester.runAsync(
      () => catalog.forTechnique(SudokuTechnique.nakedSingle),
    ))!;
    final scenario = practiceSessionOrder(nakedSingles).first;
    final placement = const DeterministicHumanSolver()
        .findNextDeduction(HumanSolverState.initial(scenario.board))!
        .placements
        .single;
    await pumpPractice(tester, SudokuTechnique.nakedSingle);
    await tester.tap(find.byKey(ValueKey('cell-${placement.cell.index}')));
    await tester.tap(find.byKey(ValueKey('practice-digit-${placement.digit}')));
    // Check enables once an answer exists.
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('practice-check')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
    expect(
      (await progress.load(SudokuTechnique.nakedSingle)).firstTryCorrect,
      1,
    );
    await tester.tap(find.byKey(const ValueKey('practice-next')));
    await tester.pumpAndSettle();
    expect(find.text('Exercise 2 of 5'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Naked Pair candidate selection, partial answer and Coach', (
    tester,
  ) async {
    final nakedPairs = (await tester.runAsync(
      () => catalog.forTechnique(SudokuTechnique.nakedPair),
    ))!;
    final scenario = practiceSessionOrder(nakedPairs).first;
    final elimination = const DeterministicHumanSolver()
        .findNextDeduction(HumanSolverState.initial(scenario.board))!
        .eliminations
        .first;
    await pumpPractice(
      tester,
      SudokuTechnique.nakedPair,
      size: const Size(375, 667),
    );
    final semantics = tester.ensureSemantics();
    await tester.tap(find.byKey(ValueKey('cell-${elimination.cell.index}')));
    await tester.pumpAndSettle();
    final candidate = find.byKey(
      ValueKey('candidate-${elimination.cell.index}-${elimination.digit}'),
    );
    expect(candidate, findsOneWidget);
    await tester.tap(candidate);
    await tester.pumpAndSettle();
    final board = tester.widget<FocusedUnitWidget>(
      find.byType(FocusedUnitWidget),
    );
    expect(board.view.selectedEliminations, contains(elimination));
    // Check enables once an answer exists.
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('practice-check')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('practice-wrong')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('practice-retry')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ask MICHI'));
    await tester.pumpAndSettle();
    expect(find.text('Hint 1 of 4'), findsOneWidget);
    for (var level = 2; level <= 4; level++) {
      await tester.tap(find.byKey(const ValueKey('coach-primary-action')));
      await tester.pumpAndSettle();
      expect(find.text('Hint $level of 4'), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });

  testWidgets('row-based Hidden Pair keeps full board context', (tester) async {
    await pumpPractice(tester, SudokuTechnique.hiddenPair);
    expect(find.byType(SudokuBoardWidget), findsOneWidget);
    expect(find.byType(FocusedUnitWidget), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('five Hidden Single exercises show a saved summary', (
    tester,
  ) async {
    final scenarios = (await tester.runAsync(
      () => catalog.forTechnique(SudokuTechnique.hiddenSingle),
    ))!;
    await pumpPractice(tester, SudokuTechnique.hiddenSingle);
    for (final scenario in practiceSessionOrder(scenarios).take(5)) {
      final placement = const DeterministicHumanSolver()
          .findNextDeduction(HumanSolverState.initial(scenario.board))!
          .placements
          .single;
      await tester.tap(find.byKey(ValueKey('cell-${placement.cell.index}')));
      await tester.tap(
        find.byKey(ValueKey('practice-digit-${placement.digit}')),
      );
      // Check enables once an answer exists.
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('practice-check')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('practice-next')));
      await tester.pumpAndSettle();
    }
    expect(find.byKey(const ValueKey('practice-summary')), findsOneWidget);
    expect(
      (await progress.load(SudokuTechnique.hiddenSingle)).correctAttempts,
      5,
    );
    expect(tester.takeException(), isNull);
  });
}
