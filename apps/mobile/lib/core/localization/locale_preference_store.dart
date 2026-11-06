import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores only the player's explicit language choice. A missing value means
/// MICHI should continue to follow the device language.
final class LocalePreferenceStore {
  LocalePreferenceStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const _key = 'michi.locale';

  final SharedPreferencesAsync _preferences;

  Future<AppLocale?> load() async {
    final code = await _preferences.getString(_key);
    for (final locale in AppLocale.values) {
      if (locale.name == code) return locale;
    }
    return null;
  }

  Future<void> save(AppLocale locale) =>
      _preferences.setString(_key, locale.name);
}
