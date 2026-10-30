import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iAskMichiAndAdvanceThroughCoach(WidgetTester tester) async {
  await tester.tap(find.text('Ask MICHI'));
  await tester.pumpAndSettle();
  expect(find.text('Hint 1 of 4'), findsOneWidget);
  for (var level = 2; level <= 4; level++) {
    await tester.tap(find.byKey(const ValueKey('coach-primary-action')));
    await tester.pumpAndSettle();
    expect(find.text('Hint $level of 4'), findsOneWidget);
  }
}
