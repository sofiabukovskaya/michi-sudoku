import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../content_driver.dart';

Future<void> homeHasTodaysUnfinishedDaily(WidgetTester tester) async {
  await ContentDriver.create(tester);
  expect(find.byKey(const ValueKey('daily-action')), findsOneWidget);
}
