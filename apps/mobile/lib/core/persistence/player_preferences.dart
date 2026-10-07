import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_preferences.freezed.dart';
part 'player_preferences.g.dart';

/// Local settings model; persistence implementation is deferred.
@freezed
abstract class PlayerPreferences with _$PlayerPreferences {
  const factory PlayerPreferences({
    @Default(true) bool hapticsEnabled,
    @Default(false) bool timerVisible,
  }) = _PlayerPreferences;

  factory PlayerPreferences.fromJson(Map<String, dynamic> json) =>
      _$PlayerPreferencesFromJson(json);
}
