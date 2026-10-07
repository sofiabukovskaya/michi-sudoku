// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerPreferences {

 bool get hapticsEnabled; bool get timerVisible;
/// Create a copy of PlayerPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerPreferencesCopyWith<PlayerPreferences> get copyWith => _$PlayerPreferencesCopyWithImpl<PlayerPreferences>(this as PlayerPreferences, _$identity);

  /// Serializes this PlayerPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerPreferences&&(identical(other.hapticsEnabled, hapticsEnabled) || other.hapticsEnabled == hapticsEnabled)&&(identical(other.timerVisible, timerVisible) || other.timerVisible == timerVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hapticsEnabled,timerVisible);

@override
String toString() {
  return 'PlayerPreferences(hapticsEnabled: $hapticsEnabled, timerVisible: $timerVisible)';
}


}

/// @nodoc
abstract mixin class $PlayerPreferencesCopyWith<$Res>  {
  factory $PlayerPreferencesCopyWith(PlayerPreferences value, $Res Function(PlayerPreferences) _then) = _$PlayerPreferencesCopyWithImpl;
@useResult
$Res call({
 bool hapticsEnabled, bool timerVisible
});




}
/// @nodoc
class _$PlayerPreferencesCopyWithImpl<$Res>
    implements $PlayerPreferencesCopyWith<$Res> {
  _$PlayerPreferencesCopyWithImpl(this._self, this._then);

  final PlayerPreferences _self;
  final $Res Function(PlayerPreferences) _then;

/// Create a copy of PlayerPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hapticsEnabled = null,Object? timerVisible = null,}) {
  return _then(_self.copyWith(
hapticsEnabled: null == hapticsEnabled ? _self.hapticsEnabled : hapticsEnabled // ignore: cast_nullable_to_non_nullable
as bool,timerVisible: null == timerVisible ? _self.timerVisible : timerVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerPreferences].
extension PlayerPreferencesPatterns on PlayerPreferences {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerPreferences() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerPreferences value)  $default,){
final _that = this;
switch (_that) {
case _PlayerPreferences():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerPreferences() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hapticsEnabled,  bool timerVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerPreferences() when $default != null:
return $default(_that.hapticsEnabled,_that.timerVisible);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hapticsEnabled,  bool timerVisible)  $default,) {final _that = this;
switch (_that) {
case _PlayerPreferences():
return $default(_that.hapticsEnabled,_that.timerVisible);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hapticsEnabled,  bool timerVisible)?  $default,) {final _that = this;
switch (_that) {
case _PlayerPreferences() when $default != null:
return $default(_that.hapticsEnabled,_that.timerVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerPreferences implements PlayerPreferences {
  const _PlayerPreferences({this.hapticsEnabled = true, this.timerVisible = false});
  factory _PlayerPreferences.fromJson(Map<String, dynamic> json) => _$PlayerPreferencesFromJson(json);

@override@JsonKey() final  bool hapticsEnabled;
@override@JsonKey() final  bool timerVisible;

/// Create a copy of PlayerPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerPreferencesCopyWith<_PlayerPreferences> get copyWith => __$PlayerPreferencesCopyWithImpl<_PlayerPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerPreferences&&(identical(other.hapticsEnabled, hapticsEnabled) || other.hapticsEnabled == hapticsEnabled)&&(identical(other.timerVisible, timerVisible) || other.timerVisible == timerVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hapticsEnabled,timerVisible);

@override
String toString() {
  return 'PlayerPreferences(hapticsEnabled: $hapticsEnabled, timerVisible: $timerVisible)';
}


}

/// @nodoc
abstract mixin class _$PlayerPreferencesCopyWith<$Res> implements $PlayerPreferencesCopyWith<$Res> {
  factory _$PlayerPreferencesCopyWith(_PlayerPreferences value, $Res Function(_PlayerPreferences) _then) = __$PlayerPreferencesCopyWithImpl;
@override @useResult
$Res call({
 bool hapticsEnabled, bool timerVisible
});




}
/// @nodoc
class __$PlayerPreferencesCopyWithImpl<$Res>
    implements _$PlayerPreferencesCopyWith<$Res> {
  __$PlayerPreferencesCopyWithImpl(this._self, this._then);

  final _PlayerPreferences _self;
  final $Res Function(_PlayerPreferences) _then;

/// Create a copy of PlayerPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hapticsEnabled = null,Object? timerVisible = null,}) {
  return _then(_PlayerPreferences(
hapticsEnabled: null == hapticsEnabled ? _self.hapticsEnabled : hapticsEnabled // ignore: cast_nullable_to_non_nullable
as bool,timerVisible: null == timerVisible ? _self.timerVisible : timerVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
