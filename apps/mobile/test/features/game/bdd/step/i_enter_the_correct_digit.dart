import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: I enter the correct digit
Future<void> iEnterTheCorrectDigit(WidgetTester tester) async {
  await enterDigit(tester, 4);
}
