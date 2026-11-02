import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: an editable empty cell is selected
Future<void> anEditableEmptyCellIsSelected(WidgetTester tester) async {
  await selectEditableCell(tester);
}
