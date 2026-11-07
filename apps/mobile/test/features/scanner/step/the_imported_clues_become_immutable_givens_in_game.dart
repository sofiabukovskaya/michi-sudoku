import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> theImportedCluesBecomeImmutableGivensInGame(
  WidgetTester tester,
) async {
  await expectImportedGame(tester);
}
