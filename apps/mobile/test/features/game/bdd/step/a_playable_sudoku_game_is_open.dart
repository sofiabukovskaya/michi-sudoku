import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: a playable Sudoku game is open
Future<void> aPlayableSudokuGameIsOpen(WidgetTester tester) async {
  await openPlayableGame(tester);
}
