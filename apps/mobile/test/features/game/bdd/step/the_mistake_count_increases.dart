import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: the mistake count increases
Future<void> theMistakeCountIncreases(WidgetTester tester) async {
  expectMistakeCount(tester);
}
