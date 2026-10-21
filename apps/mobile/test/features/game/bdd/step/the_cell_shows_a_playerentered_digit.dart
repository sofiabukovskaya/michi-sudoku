import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: the cell shows a player-entered digit
Future<void> theCellShowsAPlayerenteredDigit(WidgetTester tester) async {
  expectPlayerDigit(tester);
}
