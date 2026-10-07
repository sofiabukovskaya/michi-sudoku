import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';

void main() {
  testWidgets('app boots and navigates from splash to welcome', (
    tester,
  ) async {
    bootstrap();
    final router = getIt<AppRouter>();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    await tester.pumpAndSettle();
    expect(find.text('Вчися бачити наступний хід.'), findsOneWidget);

    await tester.tap(find.text('Почати'));
    await tester.pumpAndSettle();
    expect(find.text('Твій шлях у судоку.'), findsOneWidget);
  });
}
