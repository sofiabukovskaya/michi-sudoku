import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';
import 'package:michi_mobile/features/legal/domain/legal_document.dart';
import 'package:michi_mobile/features/legal/presentation/legal_about_section.dart';
import 'package:michi_mobile/features/legal/presentation/legal_page.dart';
import 'package:michi_mobile/features/profile/presentation/settings_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

class _AuthRepository extends Mock implements AuthRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders headings, bullets, emphasis and safe links', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LegalMarkdownView(
            source:
                '# Title\n## Heading\n- **Bold** item\n\n'
                '[Help](https://example.com/help) [Unsafe](javascript:alert)',
          ),
        ),
      ),
    );
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Heading'), findsOneWidget);
    final bullet = tester.widget<Text>(find.text('•  Bold item'));
    expect(
      (bullet.textSpan! as TextSpan).children![1].style!.fontWeight,
      FontWeight.w700,
    );
    expect(find.widgetWithText(InkWell, 'Help'), findsOneWidget);
    expect(find.widgetWithText(InkWell, 'Unsafe'), findsNothing);
  });

  test(
    'all locales bundle both drafts with only approved placeholders',
    () async {
      expect(
        LegalVersion.languages.toSet(),
        AppLocale.values.map((locale) => locale.languageCode).toSet(),
      );
      for (final locale in LegalVersion.languages) {
        for (final document in LegalDocument.values) {
          final source = await rootBundle.loadString(
            LegalVersion.asset(locale, document),
          );
          expect(source, startsWith('# '));
          final markers = RegExp(
            r'\{\{([^}]+)\}\}',
          ).allMatches(source).map((match) => match[1]).toSet();
          expect(markers, {
            'CONTROLLER',
            'EMAIL',
            'COUNTRY',
            if (document == LegalDocument.privacy) ...[
              'RETENTION',
              'LEGAL_BASIS_TRANSFERS',
            ],
          });
          expect(
            source.replaceAll(RegExp(r'\{\{[A-Z_]+\}\}'), ''),
            isNot(contains('{{')),
          );
        }
      }
    },
  );

  testWidgets('Settings About shows the build and persists the switch', (
    tester,
  ) async {
    final previous = SharedPreferencesAsyncPlatform.instance;
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    addTearDown(() => SharedPreferencesAsyncPlatform.instance = previous);
    bootstrap();
    PackageInfo.setMockInitialValues(
      appName: 'MICHI',
      packageName: 'michi.test',
      version: '1.0',
      buildNumber: '214',
      buildSignature: '',
    );
    LocaleSettings.setLocaleSync(AppLocale.en);
    final repo = _AuthRepository();
    when(repo.watchSession).thenAnswer((_) => const Stream.empty());
    final cubit = AuthCubit(repo);
    addTearDown(cubit.close);

    Future<void> open() async {
      await tester.pumpWidget(
        TranslationProvider(
          child: BlocProvider.value(
            value: cubit,
            child: const MaterialApp(home: SettingsPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await open();
    expect(find.byType(LegalAboutSection), findsOneWidget);
    expect(find.text('About MICHI'), findsOneWidget);
    expect(find.text('MICHI 1.0 (214)'), findsOneWidget);
    final toggle = find.byKey(const ValueKey('share-crash-reports'));
    await tester.drag(find.byType(ListView).first, const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(tester.widget<SwitchListTile>(toggle).value, isTrue);
    await tester.tap(toggle);
    await tester.pumpAndSettle();
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
    await tester.pumpWidget(const SizedBox.shrink());
    await open();
    expect(tester.widget<SwitchListTile>(toggle).value, isFalse);
  });
}
