import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../tokens/michi_colors.dart';

part 'michi_palette.tailor.dart';

/// Theme-driven MICHI colors. Theme Tailor generates copyWith and lerp.
@TailorMixin(themeGetter: ThemeGetter.none)
class MichiPalette extends ThemeExtension<MichiPalette>
    with _$MichiPaletteTailorMixin {
  const MichiPalette({
    required this.paper,
    required this.ivory,
    required this.cream,
    required this.textPrimary,
    required this.textSecondary,
    required this.hairline,
    required this.inputLine,
    required this.indigo,
    required this.indigoPressed,
    required this.coral,
    required this.coralText,
    required this.success,
    required this.error,
    required this.disabledBackground,
    required this.disabledText,
  });

  @override
  final Color paper;
  @override
  final Color ivory;
  @override
  final Color cream;
  @override
  final Color textPrimary;
  @override
  final Color textSecondary;
  @override
  final Color hairline;
  @override
  final Color inputLine;
  @override
  final Color indigo;
  @override
  final Color indigoPressed;
  @override
  final Color coral;
  @override
  final Color coralText;
  @override
  final Color success;
  @override
  final Color error;
  @override
  final Color disabledBackground;
  @override
  final Color disabledText;

  static const light = MichiPalette(
    paper: MichiColors.paper,
    ivory: MichiColors.ivory,
    cream: MichiColors.cream,
    textPrimary: MichiColors.textPrimary,
    textSecondary: MichiColors.textSecondary,
    hairline: MichiColors.hairline,
    inputLine: MichiColors.inputLine,
    indigo: MichiColors.indigo,
    indigoPressed: MichiColors.indigoPressed,
    coral: MichiColors.coral,
    coralText: MichiColors.coralText,
    success: MichiColors.success,
    error: MichiColors.error,
    disabledBackground: MichiColors.disabledBackground,
    disabledText: MichiColors.disabledText,
  );

  static MichiPalette of(BuildContext context) =>
      Theme.of(context).extension<MichiPalette>() ?? light;
}
