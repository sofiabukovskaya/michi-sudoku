import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';

/// Safe local defaults keep guest/offline play functional.
final class ContentFlags {
  ContentFlags(this.runtime);

  ContentFlags.offline() : runtime = null;

  final FirebaseRuntime? runtime;
  bool remoteContentEnabled = true;
  bool dailyRemoteEnabled = true;
  bool notificationsEnabled = true;
  int dailyFutureCacheDays = 2;

  Future<void> refresh() async {
    final currentRuntime = runtime;
    if (currentRuntime == null ||
        FirebaseRuntime.useEmulators ||
        !await currentRuntime.ready) {
      return;
    }
    try {
      final config = FirebaseRemoteConfig.instanceFor(app: currentRuntime.app);
      await config.setDefaults({
        'remoteContentEnabled': true,
        'dailyRemoteEnabled': true,
        'notificationsEnabled': true,
        'dailyFutureCacheDays': 2,
      });
      await config.fetchAndActivate();
      remoteContentEnabled = config.getBool('remoteContentEnabled');
      dailyRemoteEnabled = config.getBool('dailyRemoteEnabled');
      notificationsEnabled = config.getBool('notificationsEnabled');
      dailyFutureCacheDays = config.getInt('dailyFutureCacheDays').clamp(0, 3);
    } on Object {
      // Keep last-known or safe defaults.
    }
  }
}
