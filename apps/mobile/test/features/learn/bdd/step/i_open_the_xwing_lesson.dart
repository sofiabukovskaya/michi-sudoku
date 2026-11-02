import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iOpenTheXwingLesson(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('lesson-primary')));
  await tester.pumpAndSettle();
}
