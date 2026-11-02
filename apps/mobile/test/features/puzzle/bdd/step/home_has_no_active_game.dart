import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../content_driver.dart';

Future<void> homeHasNoActiveGame(WidgetTester tester) async {
  await ContentDriver.create(tester);
  expect(find.byKey(const ValueKey('continue-game')), findsNothing);
}
