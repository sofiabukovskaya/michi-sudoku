import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../content_driver.dart';

Future<void> iFinishTodaysDaily(WidgetTester tester) async {
  final driver = ContentDriver.current!;
  await tester.tap(find.byKey(const ValueKey('daily-action')));
  await ContentDriver.settleUntil(tester, find.text('Resume'));
  await tester.tap(find.text('Resume').last);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(ValueKey('cell-${driver.finalCell!.index}')));
  await tester.tap(find.byKey(ValueKey('keypad-${driver.finalDigit}')));
  await tester.pumpAndSettle();
  expect(find.text('Solved.'), findsOneWidget);
  await tester.tap(find.text('Back to home'));
  await ContentDriver.settleUntil(tester, find.text('Completed today'));
}
