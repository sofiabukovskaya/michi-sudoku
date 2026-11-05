import 'package:flutter_test/flutter_test.dart';

import '../scanner_bdd_driver.dart';

Future<void> theBoardRemainsEditableInReviewWithASpecificIssue(
  WidgetTester tester,
) async {
  expectInvalidReview(tester);
}
