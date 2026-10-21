import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: Coach is showing level {2}
Future<void> coachIsShowingLevel(WidgetTester tester, num param1) async {
  await showCoachLevel(tester, param1.toInt());
}
