import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  test('selected language survives a new store instance', () async {
    final original = SharedPreferencesAsyncPlatform.instance;
    addTearDown(() => SharedPreferencesAsyncPlatform.instance = original);
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    expect(await LocalePreferenceStore().load(), isNull);
    await LocalePreferenceStore().save(AppLocale.cs);
    expect(await LocalePreferenceStore().load(), AppLocale.cs);
  });

  test('unknown saved language falls back to device choice', () async {
    final original = SharedPreferencesAsyncPlatform.instance;
    addTearDown(() => SharedPreferencesAsyncPlatform.instance = original);
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData({'michi.locale': 'unknown'});

    expect(await LocalePreferenceStore().load(), isNull);
  });
}
