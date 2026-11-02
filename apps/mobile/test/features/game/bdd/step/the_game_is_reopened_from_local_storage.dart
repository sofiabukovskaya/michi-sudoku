import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: the game is reopened from local storage
Future<void> theGameIsReopenedFromLocalStorage(WidgetTester tester) async {
  await LifecycleDriver.current!.reopenFromHome(tester);
}
