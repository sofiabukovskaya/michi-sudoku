import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:michi_mobile/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Optional Firebase startup. Local gameplay never waits for this future.
final class FirebaseRuntime {
  static bool get useEmulators =>
      kDebugMode && const bool.fromEnvironment('MICHI_USE_FIREBASE_EMULATORS');

  static const _crashPreference = 'shareCrashReports';
  late final _preferences = SharedPreferencesAsync();
  bool _reportCrashes = false;

  Future<bool> shareCrashReports() async =>
      await _preferences.getBool(_crashPreference) ?? true;

  Future<void> setShareCrashReports({required bool enabled}) async {
    // Gate Dart reports immediately, even if Firebase is still starting.
    if (!enabled) _reportCrashes = false;
    await _preferences.setBool(_crashPreference, enabled);
    if (!_started || !await ready || useEmulators) return;
    if (!kReleaseMode) return;
    await _applyCrashPreference(enabled);
  }

  Future<void> _applyCrashPreference(bool enabled) async {
    final crashlytics = FirebaseCrashlytics.instance;
    if (!enabled) _reportCrashes = false;
    await crashlytics.setCrashlyticsCollectionEnabled(enabled);
    if (!enabled) await crashlytics.deleteUnsentReports();
    _reportCrashes = enabled && await shareCrashReports();
  }

  final Completer<bool> _ready = Completer<bool>();
  bool _started = false;
  bool _appCheckActive = false;
  late final FirebaseApp _app;
  FirebaseApp get app => _app;

  FirebaseAuth get auth => FirebaseAuth.instanceFor(app: _app);
  FirebaseFirestore get firestore => FirebaseFirestore.instanceFor(app: _app);
  FirebaseFunctions get functions => FirebaseFunctions.instanceFor(app: _app);

  Future<bool> get ready => _ready.future;

  Future<bool> get appCheckReady async => await ready && _appCheckActive;

  Future<void> initialize() async {
    if (_started) return;
    _started = true;
    try {
      if (useEmulators) {
        _app = await Firebase.initializeApp(demoProjectId: 'demo-michi');
        final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
        await auth.useAuthEmulator(host, 9099);
        firestore.useFirestoreEmulator(host, 8080);
        functions.useFunctionsEmulator(host, 5001);
      } else {
        _app = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        await _configureObservability();
        await _activateAppCheck();
      }
      _ready.complete(true);
    } on Object {
      _ready.complete(false);
      debugPrint('Firebase unavailable; MICHI continues in guest mode.');
    }
  }

  Future<void> _activateAppCheck() async {
    try {
      await FirebaseAppCheck.instance.activate(
        providerAndroid: kDebugMode
            ? const AndroidDebugProvider()
            : const AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? const AppleDebugProvider()
            : const AppleAppAttestWithDeviceCheckFallbackProvider(),
      );
      _appCheckActive = true;
    } on Object {
      // App Check enforcement stays disabled until provider registration is
      // verified; a setup failure cannot stop account or local features.
    }
  }

  Future<void> _configureObservability() async {
    try {
      // A consent decision has not been introduced, so analytics remains off.
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    } on Object {
      // Native configuration also keeps Analytics deactivated.
    }
    try {
      await _applyCrashPreference(kReleaseMode && await shareCrashReports());
      FirebaseRemoteConfig.instance;
      if (!kReleaseMode) return;
      final priorFlutterHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        priorFlutterHandler?.call(details);
        if (_reportCrashes) {
          unawaited(
            FirebaseCrashlytics.instance.recordFlutterFatalError(details),
          );
        }
      };
      final priorPlatformHandler = PlatformDispatcher.instance.onError;
      PlatformDispatcher.instance.onError = (error, stack) {
        if (_reportCrashes) {
          unawaited(
            FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
          );
        }
        return priorPlatformHandler?.call(error, stack) ?? true;
      };
    } on Object {
      // Observability is optional and must never gate guest play.
    }
  }
}
