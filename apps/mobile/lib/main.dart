import 'dart:async';

import 'package:flutter/material.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';

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
  unawaited(getIt<FirebaseRuntime>().initialize());
  getIt<SyncCoordinator>().start();
  runApp(
    MichiApp(
      router: getIt<AppRouter>(),
      profileScope: getIt<LocalProfileScope>(),
      syncCoordinator: getIt<SyncCoordinator>(),
    ),
  );
}
