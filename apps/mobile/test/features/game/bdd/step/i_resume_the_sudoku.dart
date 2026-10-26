import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: I resume the Sudoku
Future<void> iResumeTheSudoku(WidgetTester tester) async {
  await LifecycleDriver.current!.resume(tester);
}
