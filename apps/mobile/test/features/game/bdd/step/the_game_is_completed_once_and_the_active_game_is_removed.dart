import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: the game is completed once and the active game is removed
Future<void> theGameIsCompletedOnceAndTheActiveGameIsRemoved(
  WidgetTester tester,
) async {
  await LifecycleDriver.current!.verifyCompletion(tester);
}
