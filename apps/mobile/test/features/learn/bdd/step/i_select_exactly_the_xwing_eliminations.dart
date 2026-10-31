import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> iSelectExactlyTheXwingEliminations(WidgetTester tester) async {
  final actions = (await tester.runAsync(
    () => LearningDriver.current!.eliminations(SudokuTechnique.xWing),
  ))!;
  expect(actions, isNotEmpty);
  for (final action in actions) {
    await tester.tap(find.byKey(ValueKey('cell-${action.cell.index}')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(ValueKey('candidate-${action.cell.index}-${action.digit}')),
    );
    await tester.pumpAndSettle();
  }
  await tester.tap(find.byKey(const ValueKey('practice-check')));
  await tester.pumpAndSettle();
}
