import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/feedback/data/feedback_repository.dart';
import 'package:michi_mobile/features/feedback/domain/feedback_draft.dart';
import 'package:michi_mobile/features/feedback/presentation/feedback_page.dart';
import 'package:mocktail/mocktail.dart';

class _Repository extends Mock implements FeedbackRepository {}

void main() {
  late _Repository repository;
  late FeedbackDraft draft;
  late bool fail;

  setUpAll(() => registerFallbackValue(const FeedbackDraft()));
  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    repository = _Repository();
    draft = const FeedbackDraft();
    fail = true;
    getIt.registerSingleton<FeedbackRepository>(repository);
    when(() => repository.available).thenAnswer((_) async => true);
    when(() => repository.loadDraft()).thenAnswer((_) async => draft);
    when(() => repository.saveDraft(any())).thenAnswer((call) async {
      draft = call.positionalArguments.first as FeedbackDraft;
    });
    when(() => repository.clearSentDraft(any())).thenAnswer((_) async {
      draft = const FeedbackDraft();
    });
    when(() => repository.details(language: 'en', signedIn: false)).thenAnswer(
      (_) async => {
        'appVersion': '1.0',
        'deviceModel': 'Test phone',
        'signedIn': false,
      },
    );
    when(() => repository.submit(any(), any())).thenAnswer((_) async {
      if (fail) throw FeedbackFailure.retry;
    });
  });
  tearDown(getIt.reset);

  testWidgets(
    'scanner preselects, validates, previews, retains draft and retries',
    (tester) async {
      final list = find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first;

      Future<void> scrollTo(Finder target, double delta) =>
          tester.scrollUntilVisible(target, delta, scrollable: list);

      final send = find.byKey(const ValueKey('feedback-send'));
      final message = find.byKey(const ValueKey('feedback-message'));
      final email = find.byKey(const ValueKey('feedback-email'));

      Future<void> open({FeedbackCategory? category}) async {
        await tester.pumpWidget(
          TranslationProvider(
            child: MaterialApp(home: FeedbackPage(category: category)),
          ),
        );
        await tester.pumpAndSettle();
      }

      Future<void> submit() async {
        await scrollTo(send, 250);
        await tester.tap(send);
        await tester.pumpAndSettle();
      }

      await open(category: FeedbackCategory.scanner);
      final scanner = find.widgetWithText(ChoiceChip, 'Scanner');
      expect(tester.widget<ChoiceChip>(scanner).selected, isTrue);
      await submit();
      await scrollTo(message, -250);
      expect(find.text('Enter 10–2000 characters.'), findsOneWidget);
      const note = 'Scanner read the wrong digit.';
      await tester.enterText(message, note);
      await tester.pumpAndSettle();
      expect(find.text('${note.length} / 2000'), findsOneWidget);
      await scrollTo(email, 200);
      await tester.enterText(email, 'wrong');
      await submit();
      await scrollTo(email, -150);
      expect(find.text('Enter a valid email address.'), findsOneWidget);
      await tester.enterText(email, '');
      final preview = find.text('What’s included');
      await scrollTo(preview, 150);
      await tester.tap(preview);
      await tester.pumpAndSettle();
      expect(find.text('Device model: Test phone'), findsOneWidget);
      expect(find.text('Account status: Guest'), findsOneWidget);
      await submit();
      expect(
        find.textContaining('We couldn’t send your feedback'),
        findsOneWidget,
      );
      expect(draft.message, note);

      await tester.pumpWidget(const SizedBox.shrink());
      await open();
      expect(find.text(note), findsOneWidget);
      fail = false;
      await submit();
      expect(find.text('Thank you. MICHI reads every note.'), findsOneWidget);
      expect(draft.message, isEmpty);
    },
  );
}
