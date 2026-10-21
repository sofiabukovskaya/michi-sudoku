import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/coach_overlay_painter.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

GameCubit _game() => GameCubit(
  puzzle: DemoPuzzle.standard,
  exactSolver: const BacktrackingExactSolver(),
  humanSolver: const DeterministicHumanSolver(),
  coachEngine: const StructuredCoachEngine(),
);

Future<void> _pumpGame(
  WidgetTester tester,
  GameCubit cubit, {
  Size size = const Size(390, 844),
  AppLocale locale = AppLocale.en,
}) async {
  tester.view
    ..devicePixelRatio = 1
    ..physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  LocaleSettings.setLocaleSync(locale);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: AppTheme.light,
        home: GamePage(cubit: cubit),
      ),
    ),
  );
}

void main() {
  testWidgets('board taps select the correct zero-based cell', (tester) async {
    final cubit = _game();
    addTearDown(cubit.close);
    await _pumpGame(tester, cubit);
    expect(find.byType(SudokuBoardWidget), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('cell-2')));
    await tester.pump();
    expect(cubit.state.selectedCell, CellRef(row: 0, column: 2));
    final board = tester.widget<SudokuBoardWidget>(
      find.byType(SudokuBoardWidget),
    );
    expect(board.view.selectedCell, CellRef(row: 0, column: 2));
  });

  testWidgets('given, entered, related, same digit and notes reach the board', (
    tester,
  ) async {
    final cubit = _game();
    addTearDown(cubit.close);
    await _pumpGame(tester, cubit);
    await tester.tap(find.byKey(const ValueKey('cell-2')));
    await tester.tap(find.byKey(const ValueKey('notes-control')));
    await tester.tap(find.byKey(const ValueKey('keypad-2')));
    await tester.tap(find.byKey(const ValueKey('notes-control')));
    await tester.tap(find.byKey(const ValueKey('keypad-4')));
    await tester.pump();
    final view = tester
        .widget<SudokuBoardWidget>(
          find.byType(SudokuBoardWidget),
        )
        .view;
    expect(view.isGiven(CellRef(row: 0, column: 0)), isTrue);
    expect(view.isGiven(CellRef(row: 0, column: 2)), isFalse);
    expect(view.board.valueAt(CellRef(row: 0, column: 2)), 4);
    expect(view.selectedCell, CellRef(row: 0, column: 2));
    expect(cubit.state.notes[CellRef(row: 0, column: 2)], isNull);
    expect(view, isA<BoardViewState>());
  });

  testWidgets('wrong entry remains visible and is announced as an error', (
    tester,
  ) async {
    final cubit = _game();
    addTearDown(cubit.close);
    final handle = tester.ensureSemantics();
    await _pumpGame(tester, cubit);
    await tester.tap(find.byKey(const ValueKey('cell-2')));
    await tester.tap(find.byKey(const ValueKey('keypad-1')));
    await tester.pump();
    final cell = CellRef(row: 0, column: 2);
    final board = tester.widget<SudokuBoardWidget>(
      find.byType(SudokuBoardWidget),
    );
    expect(board.view.board.valueAt(cell), 1);
    expect(board.view.isWrong(cell), isTrue);
    expect(cubit.state.mistakes, 1);
    expect(
      tester.getSemantics(find.byKey(const ValueKey('cell-2'))).label,
      contains('incorrect'),
    );
    handle.dispose();
  });

  testWidgets('Coach focus and result data reach the overlay painter', (
    tester,
  ) async {
    final cubit = _game();
    addTearDown(cubit.close);
    await _pumpGame(tester, cubit);
    await tester.tap(find.byKey(const ValueKey('hint-control')));
    await tester.pump();
    expect(find.byKey(const ValueKey('coach-instruction')), findsOneWidget);
    final boardPaint = find.descendant(
      of: find.byType(SudokuBoardWidget),
      matching: find.byType(CustomPaint),
    );
    var paint = tester.widget<CustomPaint>(boardPaint);
    expect(
      (paint.foregroundPainter! as CoachOverlayPainter).hint,
      cubit.state.coach!.hint,
    );
    for (var index = 0; index < 3; index++) {
      cubit.requestNextHint();
    }
    await tester.pump();
    paint = tester.widget<CustomPaint>(boardPaint);
    final hint = (paint.foregroundPainter! as CoachOverlayPainter).hint!;
    expect(hint.level, CoachHintLevel.result);
    expect(hint.revealedPlacements, cubit.state.coach!.deduction.placements);
  });

  testWidgets('wrong-board hint shows a fix-first panel on a compact screen', (
    tester,
  ) async {
    final cubit = _game();
    addTearDown(cubit.close);
    await _pumpGame(tester, cubit, size: const Size(375, 667));
    await tester.tap(find.byKey(const ValueKey('cell-2')));
    await tester.tap(find.byKey(const ValueKey('keypad-1')));
    await tester.tap(find.byKey(const ValueKey('hint-control')));
    await tester.pump();
    expect(find.text('Fix the mistake first.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final size in [
    const Size(375, 667),
    const Size(390, 844),
    const Size(430, 930),
  ]) {
    testWidgets('game and Coach fit at ${size.width}×${size.height}', (
      tester,
    ) async {
      final cubit = _game();
      addTearDown(cubit.close);
      await _pumpGame(tester, cubit, size: size);
      expect(tester.takeException(), isNull);
      final board = tester.getSize(find.byType(SudokuBoardWidget));
      expect(board.width, lessThan(size.width));
      await tester.tap(find.byKey(const ValueKey('hint-control')));
      await tester.pump();
      expect(tester.takeException(), isNull);
      for (var index = 0; index < 3; index++) {
        cubit.requestNextHint();
        await tester.pump();
        expect(tester.takeException(), isNull);
      }
    });
  }

  for (final locale in AppLocale.values) {
    testWidgets('Coach fits compact layout in ${locale.languageCode}', (
      tester,
    ) async {
      final cubit = _game();
      addTearDown(cubit.close);
      await _pumpGame(
        tester,
        cubit,
        size: const Size(375, 667),
        locale: locale,
      );
      await tester.tap(find.byKey(const ValueKey('hint-control')));
      await tester.pump();
      for (var index = 0; index < 4; index++) {
        expect(tester.takeException(), isNull);
        cubit.requestNextHint();
        await tester.pump();
      }
      expect(tester.takeException(), isNull);
    });
  }
}
