import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/diagnostics/frame_stats.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/notifications/notification_coordinator.dart';
import 'package:michi_mobile/core/notifications/reminder_registration.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/review/data/review_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _lockPhonesToPortrait();
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
  final review = getIt<ReviewService>();
  unawaited(review.initialize());
  AppLifecycleListener(onResume: () => unawaited(review.recordActiveDay()));
  FirebaseMessaging.onBackgroundMessage(michiBackgroundMessage);
  unawaited(getIt<FirebaseRuntime>().initialize());
  getIt<SyncCoordinator>().start();
  installFrameStats();
  runApp(
    MichiApp(
      router: getIt<AppRouter>(),
      profileScope: getIt<LocalProfileScope>(),
      syncCoordinator: getIt<SyncCoordinator>(),
    ),
  );
  unawaited(getIt<NotificationCoordinator>().start());
  getIt<ReminderRegistration>().start(getIt<AuthCubit>());
}

/// Product decision: phones are portrait-only (a 9×9 board and keypad do not
/// fit a landscape phone). Tablets keep every orientation for multitasking.
Future<void> _lockPhonesToPortrait() async {
  final view = WidgetsBinding.instance.platformDispatcher.views.firstOrNull;
  if (view == null) return;
  final size = view.physicalSize / view.devicePixelRatio;
  if (size.shortestSide >= 600) return;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
