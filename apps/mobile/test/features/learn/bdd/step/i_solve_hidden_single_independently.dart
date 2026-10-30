import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> iSolveHiddenSingleIndependently(WidgetTester tester) async {
  final placement = (await tester.runAsync(
    () => LearningDriver.current!.placement(SudokuTechnique.hiddenSingle),
  ))!;
  await tester.tap(find.byKey(ValueKey('cell-${placement.cell.index}')));
  await tester.tap(
    find.byKey(ValueKey('practice-digit-${placement.digit}')),
  );
  await tester.tap(find.byKey(const ValueKey('practice-check')));
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
}
