import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iAdvanceThroughTheLesson(WidgetTester tester) async {
  for (final step in ['concept', 'example', 'tryIt']) {
    await tester.tap(find.byKey(const ValueKey('lesson-primary')));
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey('lesson-step-$step')), findsOneWidget);
  }
}
