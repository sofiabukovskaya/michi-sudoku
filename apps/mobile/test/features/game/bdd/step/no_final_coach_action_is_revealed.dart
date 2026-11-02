import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: no final Coach action is revealed
Future<void> noFinalCoachActionIsRevealed(WidgetTester tester) async {
  expectNoFinalAction(tester);
}
