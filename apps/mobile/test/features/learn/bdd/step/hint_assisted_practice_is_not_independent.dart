import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> hintAssistedPracticeIsNotIndependent(WidgetTester tester) async {
  final eliminations = (await tester.runAsync(
    () => LearningDriver.current!.eliminations(SudokuTechnique.nakedPair),
  ))!;
  await tester.tap(find.byKey(const ValueKey('coach-primary-action')));
  await tester.pumpAndSettle();
  for (final elimination in eliminations) {
    await tester.tap(find.byKey(ValueKey('cell-${elimination.cell.index}')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(
        ValueKey('candidate-${elimination.cell.index}-${elimination.digit}'),
      ),
    );
    await tester.pumpAndSettle();
  }
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
