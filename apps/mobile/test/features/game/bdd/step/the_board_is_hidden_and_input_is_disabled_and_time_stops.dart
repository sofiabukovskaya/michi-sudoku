import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: the board is hidden and input is disabled and time stops
Future<void> theBoardIsHiddenAndInputIsDisabledAndTimeStops(
  WidgetTester tester,
) async {
  LifecycleDriver.current!.verifyPaused(tester);
}
