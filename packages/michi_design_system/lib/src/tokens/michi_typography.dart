import 'package:flutter/material.dart';

import 'michi_colors.dart';

abstract final class MichiTypography {
  // Font files are not embedded in the supplied flattened PDF. Add licensed
  // Manrope/Lora assets here when the original font files are available.
  static const functionalFamily = 'Manrope';
  static const editorialFamily = 'Lora';

  static const display = TextStyle(
    fontFamily: editorialFamily,
    fontSize: 34,
    height: 40 / 34,
    fontWeight: FontWeight.w500,
    color: MichiColors.textPrimary,
  );
  static const heading = TextStyle(
    fontFamily: functionalFamily,
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.w800,
    color: MichiColors.textPrimary,
  );
  static const body = TextStyle(
    fontFamily: functionalFamily,
    fontSize: 16,
    height: 1.5,
    color: MichiColors.textPrimary,
  );
  static const secondary = TextStyle(
    fontFamily: functionalFamily,
    fontSize: 14,
    height: 20 / 14,
    color: MichiColors.textSecondary,
  );
  static const meta = TextStyle(
    fontFamily: functionalFamily,
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    color: MichiColors.textSecondary,
  );
}
