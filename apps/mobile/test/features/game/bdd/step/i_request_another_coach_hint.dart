import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: I request another Coach hint
Future<void> iRequestAnotherCoachHint(WidgetTester tester) async {
  await tapNextHint(tester);
}
