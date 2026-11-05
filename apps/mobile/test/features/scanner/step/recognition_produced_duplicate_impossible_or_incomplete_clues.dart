import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> recognitionProducedDuplicateImpossibleOrIncompleteClues(
  WidgetTester tester,
) async {
  await openInvalidReview(tester);
}
