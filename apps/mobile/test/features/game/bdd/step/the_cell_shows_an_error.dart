import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: the cell shows an error
Future<void> theCellShowsAnError(WidgetTester tester) async {
  expectError(tester);
}
