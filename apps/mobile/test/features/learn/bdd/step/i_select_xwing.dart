import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> iSelectXwing(WidgetTester tester) async {
  await tester.runAsync(
    () => LearningDriver.catalog.forTechnique(SudokuTechnique.xWing),
  );
  final target = find.byKey(const ValueKey('learn-xWing'));
  for (var attempt = 0; attempt < 5; attempt++) {
    if (target.evaluate().isNotEmpty) break;
    await tester.drag(find.byType(ListView), const Offset(0, -350));
    await tester.pumpAndSettle();
  }
  expect(target, findsOneWidget);
  await tester.ensureVisible(target);
  await tester.tap(target);
  for (var attempt = 0; attempt < 30; attempt++) {
    await tester.pumpAndSettle();
    if (find.byKey(const ValueKey('lesson-primary')).evaluate().isNotEmpty) {
      return;
    }
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
  }
  expect(
    find.byKey(const ValueKey('lesson-primary')),
    findsOneWidget,
    reason: tester
        .widgetList<Text>(find.byType(Text))
        .map((widget) => widget.data)
        .join(' | '),
  );
}
