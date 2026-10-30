import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> theResultShowsCandidateEliminations(WidgetTester tester) async {
  final eliminations = (await tester.runAsync(
    () => LearningDriver.current!.eliminations(SudokuTechnique.nakedPair),
  ))!;
  expect(eliminations, isNotEmpty);
  expect(find.textContaining('Remove'), findsWidgets);
}
