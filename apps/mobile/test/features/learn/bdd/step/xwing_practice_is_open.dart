import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> xwingPracticeIsOpen(WidgetTester tester) async {
  await LearningDriver.open(tester, practice: SudokuTechnique.xWing);
}
