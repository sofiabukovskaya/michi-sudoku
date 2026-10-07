import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

void main() {
  test('Slang generates complete copy for six supported languages', () {
    expect(
      AppLocaleUtils.supportedLocales.map((locale) => locale.languageCode),
      unorderedEquals(['en', 'uk', 'cs', 'es', 'fr', 'de']),
    );
    for (final locale in AppLocale.values) {
      final translations = locale.buildSync();
      expect(translations.home.game, isNotEmpty);
      expect(translations.scanner.unavailable, isNotEmpty);
    }
  });
}
