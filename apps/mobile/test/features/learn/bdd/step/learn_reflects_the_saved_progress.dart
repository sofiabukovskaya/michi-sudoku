import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> learnReflectsTheSavedProgress(WidgetTester tester) async {
  // Practice closes like the approved sheet; the lesson goes back.
  await tester.tap(find.byTooltip('Close'));
  await tester.pumpAndSettle();
  await tester.tap(find.byTooltip('Back'));
  await LearningDriver.settleUntil(
    tester,
    find.byKey(const ValueKey('learn-hiddenSingle')),
  );
  final progress = await LearningDriver.current!.progress.load(
    SudokuTechnique.hiddenSingle,
  );
  expect(find.text('${progress.masteryPercent}%'), findsOneWidget);
}
