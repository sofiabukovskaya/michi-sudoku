import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: MichiColors.paper,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MichiColors.indigo,
      surface: MichiColors.ivory,
      error: MichiColors.error,
    ),
    textTheme: const TextTheme(
      displayLarge: MichiTypography.display,
      headlineMedium: MichiTypography.heading,
      bodyLarge: MichiTypography.body,
      bodyMedium: MichiTypography.secondary,
      labelSmall: MichiTypography.meta,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MichiColors.paper,
      foregroundColor: MichiColors.textPrimary,
      elevation: 0,
    ),
  );
}
