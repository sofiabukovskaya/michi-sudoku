import 'package:flutter_test/flutter_test.dart';

import '../lifecycle_driver.dart';

/// Usage: Home no longer offers Continue
Future<void> homeNoLongerOffersContinue(WidgetTester tester) async {
  await LifecycleDriver.current!.verifyHomeWithoutContinue(tester);
}
