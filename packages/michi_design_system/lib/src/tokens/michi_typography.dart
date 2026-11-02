import 'package:flutter/material.dart';

import 'michi_colors.dart';

abstract final class MichiTypography {
  // The approved families are bundled with this package for offline use.
  static const functionalFamily = 'packages/michi_design_system/Manrope';
  static const editorialFamily = 'packages/michi_design_system/Lora';

  static const display = TextStyle(
    fontFamily: editorialFamily,
    fontSize: 34,
    height: 40 / 34,
    fontWeight: FontWeight.w500,
    color: MichiColors.textPrimary,
  );
  static const editorialTitle = TextStyle(
    fontFamily: editorialFamily,
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w500,
    color: MichiColors.textPrimary,
  );
  static const functionalTitle = TextStyle(
    fontFamily: functionalFamily,
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w800,
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
