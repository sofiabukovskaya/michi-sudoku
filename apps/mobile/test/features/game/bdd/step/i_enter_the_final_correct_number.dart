import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: I enter the final correct number
Future<void> iEnterTheFinalCorrectNumber(WidgetTester tester) async {
  await LifecycleDriver.current!.finish(tester);
}
