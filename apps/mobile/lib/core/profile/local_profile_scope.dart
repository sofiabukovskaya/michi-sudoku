import 'package:flutter/foundation.dart';

/// Selects the owner of user data in Drift. Email addresses are never IDs.
/// A scope change invalidates cached feature views through [ValueListenable].
final class LocalProfileScope extends ValueNotifier<String> {
  LocalProfileScope() : super(guest);

  static const guest = 'guest';

  String get profileId => value;
  int _viewEpoch = 0;

  /// Guest→account claim keeps the current tab mounted; leaving an account
  /// invalidates all feature views before another owner can be selected.
  int get viewEpoch => _viewEpoch;

  void selectAccount(String uid) {
    if (uid.isEmpty) throw ArgumentError.value(uid, 'uid');
    value = 'firebase:$uid';
  }

  void selectGuest() {
    if (value == guest) return;
    _viewEpoch++;
    value = guest;
  }
}
