import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> independentPracticeProgressIsSaved(WidgetTester tester) async {
  final progress = await LearningDriver.current!.progress.load(
    SudokuTechnique.nakedSingle,
  );
  expect(progress.firstTryCorrect, 1);
  expect(progress.independentStreak, 1);
}
