import 'package:flutter/material.dart';

import '../tokens/michi_colors.dart';
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
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: variant == MichiBannerVariant.error
          ? MichiColors.error.withValues(alpha: 0.12)
          : MichiColors.cream,
      borderRadius: BorderRadius.circular(MichiRadius.small),
    ),
    child: Padding(
      padding: const EdgeInsets.all(MichiSpacing.lg),
      child: Text(message, style: MichiTypography.secondary),
    ),
  );
}
