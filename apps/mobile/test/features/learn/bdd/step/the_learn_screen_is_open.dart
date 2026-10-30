import 'package:flutter_test/flutter_test.dart';

import '../learning_driver.dart';

Future<void> theLearnScreenIsOpen(WidgetTester tester) async {
  await LearningDriver.open(tester);
}
