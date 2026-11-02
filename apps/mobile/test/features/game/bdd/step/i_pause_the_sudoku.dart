import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: I pause the Sudoku
Future<void> iPauseTheSudoku(WidgetTester tester) async {
  await LifecycleDriver.current!.pause(tester);
}
