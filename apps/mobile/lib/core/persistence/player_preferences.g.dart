// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerPreferences _$PlayerPreferencesFromJson(Map<String, dynamic> json) =>
    _PlayerPreferences(
      hapticsEnabled: json['hapticsEnabled'] as bool? ?? true,
      timerVisible: json['timerVisible'] as bool? ?? false,
    );

Map<String, dynamic> _$PlayerPreferencesToJson(_PlayerPreferences instance) =>
    <String, dynamic>{
      'hapticsEnabled': instance.hapticsEnabled,
      'timerVisible': instance.timerVisible,
    };
