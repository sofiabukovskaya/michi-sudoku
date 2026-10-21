import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../bdd_game_driver.dart';

/// Usage: Coach level Result is visible
Future<void> coachLevelResultIsVisible(WidgetTester tester) async {
  expectCoachLevel(tester, CoachHintLevel.result);
}
