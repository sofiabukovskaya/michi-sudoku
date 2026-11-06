import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/coach/presentation/coach_hint_ui_model.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';

final class CoachPanel extends StatelessWidget {
  const CoachPanel({
    required this.model,
    required this.onNext,
    required this.onDismiss,
    required this.onApply,
    super.key,
  });

  final CoachHintUiModel model;
  final VoidCallback onNext;
  final VoidCallback onDismiss;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final palette = MichiPalette.of(context);
    final compact = MediaQuery.sizeOf(context).height < 720;
    return MichiBottomSheet(
      child: Semantics(
        liveRegion: true,
        label: '${model.stepLabel}. ${model.instruction}',
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: compact ? -16 : -6,
              right: compact ? 0 : -12,
              child: IgnorePointer(
                child: MichiMascot(
                  state: MichiMascotState.pointing,
                  size: compact ? 40 : 72,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final gap = constraints.maxHeight < 260
                    ? MichiSpacing.xs
                    : MichiSpacing.lg;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        for (var index = 0; index < 4; index++) ...[
                          Icon(
                            Icons.pets,
                            size: 17,
                            color: index <= model.stepIndex
                                ? palette.coral
                                : MichiColors.boardBoxLine,
                          ),
                          const SizedBox(width: MichiSpacing.sm),
                        ],
                        const SizedBox(width: MichiSpacing.sm),
                        Text(model.stepLabel, style: MichiTypography.meta),
                      ],
                    ),
                    SizedBox(height: gap),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: compact ? 0 : 80),
                              child: Text(
                                model.instruction,
                                key: const ValueKey('coach-instruction'),
                                style: MichiTypography.heading,
                              ),
                            ),
                            if (model.techniqueLabel != null) ...[
                              SizedBox(height: gap),
                              const Divider(
                                height: 1,
                                color: MichiColors.hairline,
                              ),
                              SizedBox(height: gap),
                              Text(
                                model.techniqueLabel!,
                                style: MichiTypography.secondary,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: gap),
                    Row(
                      children: [
                        if (model.secondaryActionLabel != null) ...[
                          Expanded(
                            child: MichiButton(
                              label: model.secondaryActionLabel!,
                              variant: MichiButtonVariant.secondary,
                              onPressed: onDismiss,
                            ),
                          ),
                          const SizedBox(width: MichiSpacing.sm),
                        ],
                        Expanded(
                          child: MichiButton(
                            key: const ValueKey('coach-primary-action'),
                            label: model.primaryActionLabel,
                            onPressed: model.placementDigit != null
                                ? onApply
                                : model.secondaryActionLabel == null
                                ? onDismiss
                                : onNext,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final class HintUnavailablePanel extends StatelessWidget {
  const HintUnavailablePanel({
    required this.reason,
    required this.onDismiss,
    required this.onShowMistake,
    super.key,
  });

  final HintUnavailableReason reason;
  final VoidCallback onDismiss;
  final VoidCallback onShowMistake;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final wrong = reason == HintUnavailableReason.wrongEntry;
    final compact = MediaQuery.sizeOf(context).height < 720;
    return MichiBottomSheet(
      child: Semantics(
        liveRegion: true,
        label: wrong ? t.coach.wrongTitle : t.coach.stuckTitle,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(t.coach.unavailable, style: MichiTypography.meta),
                SizedBox(height: compact ? MichiSpacing.sm : MichiSpacing.lg),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          wrong ? t.coach.wrongTitle : t.coach.stuckTitle,
                          style: MichiTypography.heading,
                        ),
                        const SizedBox(height: MichiSpacing.sm),
                        Text(
                          wrong ? t.coach.wrongBody : t.coach.stuckBody,
                          style: MichiTypography.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: MichiSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: MichiButton(
                        label: t.coach.close,
                        variant: MichiButtonVariant.secondary,
                        onPressed: onDismiss,
                      ),
                    ),
                    if (wrong) ...[
                      const SizedBox(width: MichiSpacing.sm),
                      Expanded(
                        child: MichiButton(
                          label: t.coach.showMistake,
                          onPressed: onShowMistake,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const Positioned(
              top: 0,
              right: 0,
              child: IgnorePointer(
                child: MichiMascot(
                  state: MichiMascotState.calm,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
