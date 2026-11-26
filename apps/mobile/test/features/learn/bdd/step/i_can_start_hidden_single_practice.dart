import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/solve_exercise.dart';
import '../learning_driver.dart';

Future<void> iCanStartHiddenSinglePractice(WidgetTester tester) async {
  // "Try it" is interactive: solving it leads straight into Practice.
  await solveVisibleExercise(tester);
  expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
  await tester.tap(find.byKey(const ValueKey('practice-next')));
  await LearningDriver.settleUntil(
    tester,
    find.byKey(const ValueKey('practice-check')),
  );
}
