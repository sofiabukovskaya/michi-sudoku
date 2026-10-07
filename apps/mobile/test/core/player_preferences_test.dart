import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/persistence/player_preferences.dart';

void main() {
  test('generated JSON model retains defaults and immutable updates', () {
    final defaults = PlayerPreferences.fromJson({});
    expect(defaults.hapticsEnabled, isTrue);
    expect(defaults.timerVisible, isFalse);

    final changed = defaults.copyWith(timerVisible: true);
    expect(changed.toJson()['timerVisible'], isTrue);
    expect(defaults.timerVisible, isFalse);
  });
}
