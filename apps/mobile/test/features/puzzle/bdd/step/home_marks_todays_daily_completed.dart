import 'package:flutter_test/flutter_test.dart';

Future<void> homeMarksTodaysDailyCompleted(WidgetTester tester) async {
  expect(find.text('Completed today'), findsOneWidget);
}
