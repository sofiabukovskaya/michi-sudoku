import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: I enter an incorrect digit
Future<void> iEnterAnIncorrectDigit(WidgetTester tester) async {
  await enterDigit(tester, 1);
}
