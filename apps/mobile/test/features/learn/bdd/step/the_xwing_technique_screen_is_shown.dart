import 'package:flutter_test/flutter_test.dart';

Future<void> theXwingTechniqueScreenIsShown(WidgetTester tester) async {
  expect(find.text('X-Wing'), findsWidgets);
  expect(find.text('Lesson plan'), findsOneWidget);
  expect(find.text('Start lesson'), findsOneWidget);
}
