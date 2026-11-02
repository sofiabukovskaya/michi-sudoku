import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/coach_overlay_painter.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final _cell = CellRef(row: 0, column: 2);

Future<void> openPlayableGame(WidgetTester tester) async {
  tester.view
    ..devicePixelRatio = 1
    ..physicalSize = const Size(390, 844);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  LocaleSettings.setLocaleSync(AppLocale.en);
  final cubit = GameCubit(
    puzzle: DemoPuzzle.standard,
    exactSolver: const BacktrackingExactSolver(),
    humanSolver: const DeterministicHumanSolver(),
    coachEngine: const StructuredCoachEngine(),
  );
  addTearDown(cubit.close);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: AppTheme.light,
        home: GamePage(cubit: cubit),
      ),
    ),
  );
  expect(find.byType(SudokuBoardWidget), findsOneWidget);
}

GameCubit game(WidgetTester tester) => BlocProvider.of<GameCubit>(
  tester.element(find.byType(SudokuBoardWidget)),
);

Future<void> tapHint(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('hint-control')));
  await tester.pump();
}

Future<void> tapNextHint(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('coach-primary-action')));
  await tester.pump();
}

Future<void> showCoachLevel(WidgetTester tester, int level) async {
  await tapHint(tester);
  for (var index = 0; index < level; index++) {
    await tapNextHint(tester);
  }
  expect(game(tester).state.coach!.hintIndex, level);
}

void expectCoachLevel(WidgetTester tester, CoachHintLevel level) {
  expect(game(tester).state.coach!.hint.level, level);
  expect(find.byKey(const ValueKey('coach-instruction')), findsOneWidget);
}

void expectNoFinalAction(WidgetTester tester) {
  final state = game(tester).state;
  expect(state.coach!.hint.revealedPlacements, isEmpty);
  expect(state.coach!.hint.revealedEliminations, isEmpty);
  expect(state.board, state.puzzle.givens);
}

void expectActualActionVisualized(WidgetTester tester) {
  final state = game(tester).state;
  final paint = tester.widget<CustomPaint>(
    find.descendant(
      of: find.byType(SudokuBoardWidget),
      matching: find.byType(CustomPaint),
    ),
  );
  final hint = (paint.foregroundPainter! as CoachOverlayPainter).hint!;
  expect(hint.revealedPlacements, state.coach!.deduction.placements);
  expect(hint.revealedEliminations, state.coach!.deduction.eliminations);
  expect(state.board, state.puzzle.givens);
}

Future<void> selectEditableCell(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('cell-2')));
  await tester.pump();
  expect(game(tester).state.selectedCell, _cell);
}

Future<void> enterDigit(WidgetTester tester, int digit) async {
  await tester.tap(find.byKey(ValueKey('keypad-$digit')));
  await tester.pump();
}

void expectPlayerDigit(WidgetTester tester) {
  final view = tester
      .widget<SudokuBoardWidget>(
        find.byType(SudokuBoardWidget),
      )
      .view;
  expect(view.board.valueAt(_cell), 4);
  expect(view.isGiven(_cell), isFalse);
  expect(view.isWrong(_cell), isFalse);
}

void expectError(WidgetTester tester) {
  final view = tester
      .widget<SudokuBoardWidget>(
        find.byType(SudokuBoardWidget),
      )
      .view;
  expect(view.board.valueAt(_cell), 1);
  expect(view.isWrong(_cell), isTrue);
}

void expectMistakeCount(WidgetTester tester) {
  expect(game(tester).state.mistakes, 1);
  expect(find.text('Mistakes: 1 of 3'), findsOneWidget);
}
