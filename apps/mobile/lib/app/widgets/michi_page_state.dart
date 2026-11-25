import 'dart:async';

import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';

/// Quiet loading: nothing for a perceptible instant, then a paw mark and what
/// MICHI is preparing. Local loads are short, so a calm static mark fits
/// better than an endless spinner (and never keeps the frame pipeline busy).
final class MichiLoadingState extends StatefulWidget {
  const MichiLoadingState({required this.label, super.key});

  final String label;

  @override
  State<MichiLoadingState> createState() => _MichiLoadingStateState();
}

final class _MichiLoadingStateState extends State<MichiLoadingState> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 250), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: widget.label,
    liveRegion: true,
    child: AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : MichiMotion.standard,
      child: Center(
        child: ExcludeSemantics(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.pets, size: 16, color: MichiColors.coral),
              const SizedBox(width: MichiSpacing.sm),
              Text(widget.label, style: MichiTypography.secondary),
            ],
          ),
        ),
      ),
    ),
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
