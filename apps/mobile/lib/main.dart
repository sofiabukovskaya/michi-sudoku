import 'package:flutter/material.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final savedLocale = await LocalePreferenceStore().load();
    if (savedLocale == null) {
      await LocaleSettings.useDeviceLocale();
    } else {
      await LocaleSettings.setLocale(savedLocale);
    }
  } on Object {
    await LocaleSettings.useDeviceLocale();
  }
  bootstrap();
  runApp(MichiApp(router: getIt<AppRouter>()));
}
