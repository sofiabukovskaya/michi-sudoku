import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> thePlayerConfirmsTheBoard(WidgetTester tester) async {
  await confirmInvalidReview(tester);
}
