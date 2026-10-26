import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: a running Sudoku is shown
Future<void> aRunningSudokuIsShown(WidgetTester tester) async {
  LifecycleDriver.current = LifecycleDriver.create(tester);
  await LifecycleDriver.current!.prepareRunning(tester);
}
