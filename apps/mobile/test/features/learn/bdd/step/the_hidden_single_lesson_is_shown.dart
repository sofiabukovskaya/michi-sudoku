import 'package:flutter_test/flutter_test.dart';

Future<void> theHiddenSingleLessonIsShown(WidgetTester tester) async {
  expect(find.text('Hidden single'), findsWidgets);
  expect(find.text('Lesson plan'), findsOneWidget);
}
