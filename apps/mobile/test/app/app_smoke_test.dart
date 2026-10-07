import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

void main() {
  testWidgets('app boots and navigates from splash to welcome', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.uk);
    bootstrap();
    final router = getIt<AppRouter>();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    await tester.pumpAndSettle();
    expect(find.text('Вчися бачити наступний хід.'), findsOneWidget);

    await tester.tap(find.text('Почати'));
    await tester.pumpAndSettle();
    expect(find.text('Твій шлях у судоку.'), findsOneWidget);

    await LocaleSettings.setLocale(AppLocale.cs);
    await tester.pumpAndSettle();
    expect(find.text('Tvoje cesta sudoku.'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).locale?.languageCode,
      'cs',
    );
    LocaleSettings.setLocaleSync(AppLocale.uk);
  });
}
