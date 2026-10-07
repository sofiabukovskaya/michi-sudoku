import 'package:flutter/material.dart';

import '../theme/michi_palette.dart';
import '../tokens/michi_radius.dart';
import '../tokens/michi_spacing.dart';
import '../tokens/michi_typography.dart';

enum MichiBannerVariant { information, error }

final class MichiBanner extends StatelessWidget {
  const MichiBanner({
    required this.message,
    this.variant = MichiBannerVariant.information,
    super.key,
  });

  final String message;
  final MichiBannerVariant variant;

  @override
  Widget build(BuildContext context) {
    final palette = MichiPalette.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: variant == MichiBannerVariant.error
            ? palette.error.withValues(alpha: 0.12)
            : palette.cream,
        borderRadius: BorderRadius.circular(MichiRadius.small),
      ),
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.lg),
        child: Text(
          message,
          style: MichiTypography.secondary.copyWith(
            color: palette.textSecondary,
          ),
        ),
      ),
    );
  }
}
