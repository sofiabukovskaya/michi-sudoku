import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> theGameAndCoachSessionCanBeRestoredLocally(
  WidgetTester tester,
) async {
  await expectRestoredImportedGame(tester);
}
