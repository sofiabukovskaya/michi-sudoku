import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/practice/presentation/widgets/practice_exercise_view.dart';

/// Answers the visible exercise exactly as a learner would, using the
/// HumanSolver deduction the screen itself is built from.
Future<void> solveVisibleExercise(WidgetTester tester) async {
  final view = tester.widget<PracticeExerciseView>(
    find.byType(PracticeExerciseView),
  );
  final deduction = view.state.deduction;
  if (deduction.placements.isNotEmpty) {
    final placement = deduction.placements.single;
    await tester.tap(find.byKey(ValueKey('cell-${placement.cell.index}')));
    await tester.pump();
    await tester.tap(find.byKey(ValueKey('practice-digit-${placement.digit}')));
  } else {
    for (final action in deduction.eliminations) {
      await tester.tap(find.byKey(ValueKey('cell-${action.cell.index}')));
      await tester.pump();
      await tester.tap(
        find.byKey(ValueKey('candidate-${action.cell.index}-${action.digit}')),
      );
      await tester.pump();
    }
  }
  await tester.pump();
  await tester.tap(find.byKey(const ValueKey('practice-check')));
  await tester.pumpAndSettle();
}
