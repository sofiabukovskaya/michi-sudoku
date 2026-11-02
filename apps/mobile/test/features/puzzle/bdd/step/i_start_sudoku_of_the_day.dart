import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../content_driver.dart';

Future<void> iStartSudokuOfTheDay(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('daily-action')));
  await ContentDriver.settleUntil(tester, find.byKey(const ValueKey('cell-0')));
}
