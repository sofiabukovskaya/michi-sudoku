import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../learning_driver.dart';

Future<void> iSelectHiddenSingle(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('learn-hiddenSingle')));
  await LearningDriver.settleUntil(
    tester,
    find.byKey(const ValueKey('lesson-primary')),
  );
}
