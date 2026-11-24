import 'package:flutter/material.dart';

import '../tokens/michi_colors.dart';
import '../tokens/michi_radius.dart';
import '../tokens/michi_spacing.dart';
import '../tokens/michi_typography.dart';
import 'michi_press_feedback.dart';

/// Visual treatment of a row's leading tile.
enum MichiRowTone { neutral, coral, indigo }

/// One list-row geometry for every tappable MICHI row.
///
/// The leading tile, title, subtitle and chevron share one vertical center.
/// Rows sit inside the 16 card gutter; the 8 inner inset puts text at the
/// approved 24 from the phone edge.
final class MichiListRow extends StatelessWidget {
  const MichiListRow({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
    this.leading,
    this.tone = MichiRowTone.neutral,
    this.semanticLabel,
    super.key,
  });

  static const double tileSize = 44;
  static const double minHeight = 72;

  final String title;
  final String? subtitle;
  final IconData? icon;

  /// Custom tile content, used instead of [icon].
  final Widget? leading;
  final MichiRowTone tone;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, border) = switch (tone) {
      MichiRowTone.neutral => (
        MichiColors.ivory,
        MichiColors.indigo,
        MichiColors.hairline,
      ),
      MichiRowTone.coral => (
        MichiColors.coralTint,
        MichiColors.coralText,
        MichiColors.coralTint,
      ),
      MichiRowTone.indigo => (
        MichiColors.indigoTint,
        MichiColors.indigo,
        MichiColors.indigoTint,
      ),
    };
    final enabled = onTap != null;
    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: MichiSpacing.sm,
          vertical: MichiSpacing.md,
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(MichiRadius.small + 2),
                border: Border.all(color: border),
              ),
              child: SizedBox.square(
                dimension: tileSize,
                child: Center(
                  child:
                      leading ??
                      Icon(icon ?? Icons.grid_on_rounded, color: foreground),
                ),
              ),
            ),
            const SizedBox(width: MichiSpacing.lg),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MichiTypography.body.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: enabled
                          ? MichiColors.textPrimary
                          : MichiColors.disabledText,
                    ),
                  ),
                  if (subtitle case final detail?) ...[
                    const SizedBox(height: MichiSpacing.xxs),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MichiTypography.secondary.copyWith(height: 1.35),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: MichiSpacing.sm),
            const Icon(
              Icons.chevron_right_rounded,
              color: MichiColors.textSecondary,
            ),
          ],
        ),
      ),
    );
    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: MichiPressFeedback(
        enabled: enabled,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(MichiRadius.control),
            child: row,
          ),
        ),
      ),
    );
  }
}
