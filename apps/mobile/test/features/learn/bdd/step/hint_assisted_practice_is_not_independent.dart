import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/practice/presentation/widgets/practice_exercise_view.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> hintAssistedPracticeIsNotIndependent(WidgetTester tester) async {
  final eliminations = (await tester.runAsync(
    () => LearningDriver.current!.eliminations(SudokuTechnique.nakedPair),
  ))!;
  // Coach's "Remove them" hands its removals back as the selected answer.
  await tester.tap(find.byKey(const ValueKey('coach-primary-action')));
  await tester.pumpAndSettle();
  final view = tester.widget<PracticeExerciseView>(
    find.byType(PracticeExerciseView),
  );
  expect(view.state.selectedEliminations, eliminations.toSet());
  // Check enables once an answer exists.
  await tester.pump();
  await tester.tap(find.byKey(const ValueKey('practice-check')));
  await tester.pumpAndSettle();
  expect(find.byKey(const ValueKey('practice-correct')), findsOneWidget);
  final progress = await LearningDriver.current!.progress.load(
    SudokuTechnique.nakedPair,
  );
  expect(progress.correctAttempts, 1);
  expect(progress.independentStreak, 0);
  expect(progress.resultHintSuccesses, 1);
}
