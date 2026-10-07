// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'michi_palette.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$MichiPaletteTailorMixin on ThemeExtension<MichiPalette> {
  Color get paper;
  Color get ivory;
  Color get cream;
  Color get textPrimary;
  Color get textSecondary;
  Color get hairline;
  Color get inputLine;
  Color get indigo;
  Color get indigoPressed;
  Color get coral;
  Color get coralText;
  Color get success;
  Color get error;
  Color get disabledBackground;
  Color get disabledText;

  @override
  MichiPalette copyWith({
    Color? paper,
    Color? ivory,
    Color? cream,
    Color? textPrimary,
    Color? textSecondary,
    Color? hairline,
    Color? inputLine,
    Color? indigo,
    Color? indigoPressed,
    Color? coral,
    Color? coralText,
    Color? success,
    Color? error,
    Color? disabledBackground,
    Color? disabledText,
  }) {
    return MichiPalette(
      paper: paper ?? this.paper,
      ivory: ivory ?? this.ivory,
      cream: cream ?? this.cream,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      hairline: hairline ?? this.hairline,
      inputLine: inputLine ?? this.inputLine,
      indigo: indigo ?? this.indigo,
      indigoPressed: indigoPressed ?? this.indigoPressed,
      coral: coral ?? this.coral,
      coralText: coralText ?? this.coralText,
      success: success ?? this.success,
      error: error ?? this.error,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledText: disabledText ?? this.disabledText,
    );
  }

  @override
  MichiPalette lerp(covariant ThemeExtension<MichiPalette>? other, double t) {
    if (other is! MichiPalette) return this as MichiPalette;
    return MichiPalette(
      paper: Color.lerp(paper, other.paper, t)!,
      ivory: Color.lerp(ivory, other.ivory, t)!,
      cream: Color.lerp(cream, other.cream, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      inputLine: Color.lerp(inputLine, other.inputLine, t)!,
      indigo: Color.lerp(indigo, other.indigo, t)!,
      indigoPressed: Color.lerp(indigoPressed, other.indigoPressed, t)!,
      coral: Color.lerp(coral, other.coral, t)!,
      coralText: Color.lerp(coralText, other.coralText, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      disabledBackground: Color.lerp(
        disabledBackground,
        other.disabledBackground,
        t,
      )!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MichiPalette &&
            const DeepCollectionEquality().equals(paper, other.paper) &&
            const DeepCollectionEquality().equals(ivory, other.ivory) &&
            const DeepCollectionEquality().equals(cream, other.cream) &&
            const DeepCollectionEquality().equals(
              textPrimary,
              other.textPrimary,
            ) &&
            const DeepCollectionEquality().equals(
              textSecondary,
              other.textSecondary,
            ) &&
            const DeepCollectionEquality().equals(hairline, other.hairline) &&
            const DeepCollectionEquality().equals(inputLine, other.inputLine) &&
            const DeepCollectionEquality().equals(indigo, other.indigo) &&
            const DeepCollectionEquality().equals(
              indigoPressed,
              other.indigoPressed,
            ) &&
            const DeepCollectionEquality().equals(coral, other.coral) &&
            const DeepCollectionEquality().equals(coralText, other.coralText) &&
            const DeepCollectionEquality().equals(success, other.success) &&
            const DeepCollectionEquality().equals(error, other.error) &&
            const DeepCollectionEquality().equals(
              disabledBackground,
              other.disabledBackground,
            ) &&
            const DeepCollectionEquality().equals(
              disabledText,
              other.disabledText,
            ));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(paper),
      const DeepCollectionEquality().hash(ivory),
      const DeepCollectionEquality().hash(cream),
      const DeepCollectionEquality().hash(textPrimary),
      const DeepCollectionEquality().hash(textSecondary),
      const DeepCollectionEquality().hash(hairline),
      const DeepCollectionEquality().hash(inputLine),
      const DeepCollectionEquality().hash(indigo),
      const DeepCollectionEquality().hash(indigoPressed),
      const DeepCollectionEquality().hash(coral),
      const DeepCollectionEquality().hash(coralText),
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(disabledBackground),
      const DeepCollectionEquality().hash(disabledText),
    );
  }
}
