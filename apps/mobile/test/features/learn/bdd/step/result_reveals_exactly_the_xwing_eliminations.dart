import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../learning_driver.dart';

Future<void> resultRevealsExactlyTheXwingEliminations(
  WidgetTester tester,
) async {
  final expected = (await tester.runAsync(
    () => LearningDriver.current!.eliminations(SudokuTechnique.xWing),
  ))!;
  final board = tester.widget<SudokuBoardWidget>(
    find.byType(SudokuBoardWidget),
  );
  final hint = board.view.coachHint;
  expect(hint?.level, CoachHintLevel.result);
  expect(hint?.revealedEliminations.toSet(), expected);
}
