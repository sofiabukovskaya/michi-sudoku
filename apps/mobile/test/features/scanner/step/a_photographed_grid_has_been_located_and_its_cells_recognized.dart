import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> aPhotographedGridHasBeenLocatedAndItsCellsRecognized(
  WidgetTester tester,
) async {
  await openRecognizedReview(tester);
}
