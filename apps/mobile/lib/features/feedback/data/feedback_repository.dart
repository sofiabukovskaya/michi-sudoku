import 'dart:convert';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/features/feedback/domain/feedback_draft.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FeedbackFailure implements Exception {
  unavailable,
  limited,
  retry,
  tooLarge,
}

class FeedbackRepository {
  FeedbackRepository(this._runtime, this._database);

  static const _draftKey = 'michi.feedback.draft';
  static const _device = MethodChannel('michi/device');
  final FirebaseRuntime _runtime;
  final GameDatabase _database;
  late final _preferences = SharedPreferencesAsync();
  Future<void> _draftWrites = Future<void>.value();

  Future<FeedbackDraft> loadDraft() async {
    await _draftWrites;
    final raw = await _preferences.getString(_draftKey);
    if (raw == null) return const FeedbackDraft();
    try {
      return FeedbackDraft.fromJson(jsonDecode(raw) as Map<String, Object?>);
    } on Object {
      return const FeedbackDraft();
    }
  }

  Future<void> saveDraft(FeedbackDraft draft) => _queueDraftWrite(
    () => _preferences.setString(_draftKey, jsonEncode(draft.toJson())),
  );

  Future<void> clearSentDraft(FeedbackDraft sent) => _queueDraftWrite(() async {
    if (await _preferences.getString(_draftKey) == jsonEncode(sent.toJson())) {
      await _preferences.remove(_draftKey);
    }
  });

  Future<void> _queueDraftWrite(Future<void> Function() write) {
    final next = _draftWrites.then((_) => write());
    _draftWrites = next.catchError((Object _) {});
    return next;
  }

  Future<bool> get available async => _runtime.appCheckReady.timeout(
    const Duration(seconds: 8),
    onTimeout: () => false,
  );

  Future<Map<String, Object>> details({
    required String language,
    required bool signedIn,
  }) async {
    String? model;
    PackageInfo? info;
    try {
      model = await _device.invokeMethod<String>('model');
    } on PlatformException {
      // Device metadata is optional.
    } on MissingPluginException {
      // Tests and unsupported platforms may not have the channel.
    }
    try {
      info = await PackageInfo.fromPlatform();
    } on Object {
      // Feedback remains available without package metadata.
    }
    return {
      if (info != null) 'appVersion': _detail(info.version),
      if (info != null) 'build': _detail(info.buildNumber),
      if (Platform.isIOS || Platform.isAndroid)
        'platform': Platform.operatingSystem,
      'osVersion': _detail(Platform.operatingSystemVersion),
      if (model != null && model.isNotEmpty) 'deviceModel': _detail(model),
      'language': language,
      'signedIn': signedIn,
    };
  }

  String _detail(String raw) {
    final clean = raw.replaceAll(RegExp(r'[\x00-\x1f\x7f]'), ' ').trim();
    return clean.isEmpty ? '—' : clean.substring(0, clean.length.clamp(0, 200));
  }

  Future<void> submit(FeedbackDraft draft, Map<String, Object> details) async {
    if (!await available) throw FeedbackFailure.unavailable;
    try {
      final id = await _database.installationId();
      final callable =
          FirebaseFunctions.instanceFor(
            app: _runtime.app,
            region: 'europe-west1',
          ).httpsCallable(
            'submitFeedback',
            options: HttpsCallableOptions(timeout: const Duration(seconds: 45)),
          );
      final payload = <String, Object>{
        'installationId': id,
        'category': draft.category!.name,
        'message': draft.message.trim(),
        if (draft.replyEmail.trim().isNotEmpty)
          'replyEmail': draft.replyEmail.trim(),
        if (draft.includeDetails && details.isNotEmpty) 'details': details,
      };
      if (utf8.encode(jsonEncode(payload)).length >= 8192) {
        throw FeedbackFailure.tooLarge;
      }
      await callable.call<Object?>(payload);
    } on FirebaseFunctionsException catch (error) {
      throw switch (error.code) {
        'resource-exhausted' => FeedbackFailure.limited,
        'not-found' ||
        'permission-denied' ||
        'unauthenticated' => FeedbackFailure.unavailable,
        _ => FeedbackFailure.retry,
      };
    }
  }
}
