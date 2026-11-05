import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> aLowconfidenceCellIsSelectedAndCorrected(
  WidgetTester tester,
) async {
  await correctReviewClue(tester);
}
