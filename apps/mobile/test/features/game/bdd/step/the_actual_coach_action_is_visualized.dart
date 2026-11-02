import 'package:flutter_test/flutter_test.dart';

import '../bdd_game_driver.dart';

/// Usage: the actual Coach action is visualized
Future<void> theActualCoachActionIsVisualized(WidgetTester tester) async {
  expectActualActionVisualized(tester);
}
