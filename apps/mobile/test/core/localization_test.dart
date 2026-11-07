import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  test('Slang generates complete copy for six supported languages', () {
    expect(
      AppLocaleUtils.supportedLocales.map((locale) => locale.languageCode),
      unorderedEquals(['en', 'uk', 'cs', 'es', 'fr', 'de']),
    );
    for (final locale in AppLocale.values) {
      final translations = locale.buildSync();
      expect(translations.home.game, isNotEmpty);
      expect(translations.scanner.noCamera, isNotEmpty);
      expect(translations.recommendation.repeatedCoachHelp, isNotEmpty);
      expect(translations.learn.minutes(count: 2), isNot('2'));
      expect(translations.learn.tasks(count: 5), isNot('5'));
      expect(translations.home.scanSourceDetail, isNotEmpty);
      expect(
        translations.week.completedDay(n: 1),
        isNot(translations.week.completedDay(n: 2)),
      );
      expect(
        translations.week.activeDays(n: 1),
        isNot(translations.week.activeDays(n: 2)),
      );
      expect(
        translations.recommendation.focusTitle(technique: 'Test'),
        contains('Test'),
      );
    }
    expect(
      TechniqueCopy.name(AppLocale.uk.buildSync(), SudokuTechnique.nakedPair),
      'Відкрита пара',
    );
    expect(
      AppLocale.en.buildSync().week.completedDay(n: 1),
      '1 puzzle completed',
    );
    expect(AppLocale.en.buildSync().week.activeDays(n: 1), '1 active day');
  });
}
