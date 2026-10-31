import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> xwingPracticeIsCorrectAndProgressIsSaved(
  WidgetTester tester,
) async {
  expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
  final progress = await LearningDriver.current!.progress.load(
    SudokuTechnique.xWing,
  );
  expect(progress.correctAttempts, 1);
  expect(progress.firstTryCorrect, 1);
  expect(progress.independentStreak, 1);
}
