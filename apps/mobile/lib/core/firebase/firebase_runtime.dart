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

/// Optional Firebase startup. Local gameplay never waits for this future.
final class FirebaseRuntime {
  static bool get useEmulators =>
      kDebugMode && const bool.fromEnvironment('MICHI_USE_FIREBASE_EMULATORS');

  final Completer<bool> _ready = Completer<bool>();
  bool _started = false;

  Future<bool> get ready => _ready.future;

  Future<void> initialize() async {
    if (_started) return;
    _started = true;
    try {
      if (useEmulators) {
        await Firebase.initializeApp(demoProjectId: 'demo-michi');
        final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
        await FirebaseAuth.instance.useAuthEmulator(host, 9099);
        FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
        FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
      } else {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        await _activateAppCheck();
        await _configureObservability();
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
    } on Object {
      // App Check enforcement stays disabled until provider registration is
      // verified; a setup failure cannot stop account or local features.
    }
  }

  Future<void> _configureObservability() async {
    try {
      // A consent decision has not been introduced, so analytics remains off.
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
        !kDebugMode,
      );
      FirebaseRemoteConfig.instance;
      if (kDebugMode) return;
      final priorFlutterHandler = FlutterError.onError;
      FlutterError.onError = (details) {
        priorFlutterHandler?.call(details);
        unawaited(
          FirebaseCrashlytics.instance.recordFlutterFatalError(details),
        );
      };
      final priorPlatformHandler = PlatformDispatcher.instance.onError;
      PlatformDispatcher.instance.onError = (error, stack) {
        unawaited(
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
        );
        return priorPlatformHandler?.call(error, stack) ?? true;
      };
    } on Object {
      // Observability is optional and must never gate guest play.
    }
  }
}
