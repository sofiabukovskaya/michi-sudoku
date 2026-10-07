import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';

abstract final class AppTheme {
  static ThemeData get light => fromPalette(MichiPalette.light);

  static ThemeData fromPalette(MichiPalette palette) => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: palette.paper,
    colorScheme: ColorScheme.fromSeed(
      seedColor: palette.indigo,
      surface: palette.ivory,
      error: palette.error,
    ),
    extensions: [palette],
    textTheme: TextTheme(
      displayLarge: MichiTypography.display.copyWith(
        color: palette.textPrimary,
      ),
      headlineMedium: MichiTypography.heading.copyWith(
        color: palette.textPrimary,
      ),
      bodyLarge: MichiTypography.body.copyWith(color: palette.textPrimary),
      bodyMedium: MichiTypography.secondary.copyWith(
        color: palette.textSecondary,
      ),
      labelSmall: MichiTypography.meta.copyWith(color: palette.textSecondary),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.paper,
      foregroundColor: palette.textPrimary,
      elevation: 0,
    ),
  );
}
