import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../bdd_game_driver.dart';

/// Usage: Coach level Focus is visible
Future<void> coachLevelFocusIsVisible(WidgetTester tester) async {
  expectCoachLevel(tester, CoachHintLevel.focus);
}
