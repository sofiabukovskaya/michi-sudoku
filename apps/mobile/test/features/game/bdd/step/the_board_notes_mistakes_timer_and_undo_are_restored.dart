import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: the board notes mistakes timer and undo are restored
Future<void> theBoardNotesMistakesTimerAndUndoAreRestored(
  WidgetTester tester,
) async {
  await LifecycleDriver.current!.verifyRestore(tester);
}
