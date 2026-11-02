import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: a locally saved Sudoku one move from completion
Future<void> aLocallySavedSudokuOneMoveFromCompletion(
  WidgetTester tester,
) async {
  LifecycleDriver.current = LifecycleDriver.create(tester);
  await LifecycleDriver.current!.prepareCompletion(tester);
}
