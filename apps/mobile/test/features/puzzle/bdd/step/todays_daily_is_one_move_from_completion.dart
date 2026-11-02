import 'package:flutter_test/flutter_test.dart';
import '../content_driver.dart';

Future<void> todaysDailyIsOneMoveFromCompletion(WidgetTester tester) async {
  await ContentDriver.create(tester, nearlyCompleted: true);
  expect(find.text('Continue today’s Sudoku'), findsOneWidget);
}
