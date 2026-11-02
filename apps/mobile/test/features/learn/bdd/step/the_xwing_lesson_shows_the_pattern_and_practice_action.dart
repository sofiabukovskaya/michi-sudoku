import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';

Future<void> theXwingLessonShowsThePatternAndPracticeAction(
  WidgetTester tester,
) async {
  expect(find.byType(SudokuBoardWidget), findsOneWidget);
  expect(find.byKey(const ValueKey('lesson-step-concept')), findsOneWidget);
  for (var step = 0; step < 2; step++) {
    await tester.tap(find.byKey(const ValueKey('lesson-primary')));
    await tester.pumpAndSettle();
  }
  expect(find.byKey(const ValueKey('lesson-step-tryIt')), findsOneWidget);
  expect(find.text('Start practice'), findsOneWidget);
}
