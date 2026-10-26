import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: the board returns and time continues
Future<void> theBoardReturnsAndTimeContinues(WidgetTester tester) async {
  LifecycleDriver.current!.verifyResumed(tester);
}
