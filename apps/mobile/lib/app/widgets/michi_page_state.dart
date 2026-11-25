import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';

/// A screen whose content is being prepared: MICHI's paw loader, centred.
/// It stays invisible for a perceptible instant, so quick local loads never
/// flash, and stops animating on its own if a load ever runs long.
final class MichiLoadingState extends StatelessWidget {
  const MichiLoadingState({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Center(
    child: MichiPawLoader(label: label, size: MichiPawLoaderSize.screen),
  );
}

/// Something could not be shown: what happened, and one clear way forward.
final class MichiProblemState extends StatelessWidget {
  const MichiProblemState({
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: MichiLayout.focusedWidth),
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MichiMascot(state: MichiMascotState.calm, size: 112),
            const SizedBox(height: MichiSpacing.lg),
            Text(
              message,
              style: MichiTypography.body,
              textAlign: TextAlign.center,
            ),
            if (actionLabel case final label?) ...[
              const SizedBox(height: MichiSpacing.xl),
              MichiButton(
                label: label,
                variant: MichiButtonVariant.secondary,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
