import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: I request the first Coach hint
Future<void> iRequestTheFirstCoachHint(WidgetTester tester) async {
  await tapHint(tester);
}
