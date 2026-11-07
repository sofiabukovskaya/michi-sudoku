import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> thePlayerConfirmsIt(WidgetTester tester) async {
  await confirmUniqueImport(tester);
}
