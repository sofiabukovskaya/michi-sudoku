import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../content_driver.dart';

Future<void> iChooseMediumAndStartAPuzzle(WidgetTester tester) async {
  await tester.tap(find.text('Play'));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('difficulty-medium')));
  await ContentDriver.settleUntil(tester, find.byKey(const ValueKey('cell-0')));
}
