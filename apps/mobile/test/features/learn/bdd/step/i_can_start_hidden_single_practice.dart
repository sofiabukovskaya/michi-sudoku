import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../learning_driver.dart';

Future<void> iCanStartHiddenSinglePractice(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('lesson-primary')));
  await LearningDriver.settleUntil(
    tester,
    find.byKey(const ValueKey('practice-check')),
  );
}
