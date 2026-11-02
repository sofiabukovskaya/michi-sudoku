import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Uses catalog metadata and the persisted Coach ledger; no puzzle reanalysis.
final class PostGameTechniqueFeedback extends StatelessWidget {
  const PostGameTechniqueFeedback({
    required this.requiredTechniques,
    required this.techniqueHelp,
    super.key,
  });

  final Set<SudokuTechnique> requiredTechniques;
  final Map<SudokuTechnique, int> techniqueHelp;

  @override
  Widget build(BuildContext context) {
    final required = [
      for (final technique in TechniqueLessons.supported)
        if (requiredTechniques.contains(technique)) technique,
    ];
    final helped = [
      for (final technique in TechniqueLessons.supported)
        if (techniqueHelp.containsKey(technique)) technique,
    ];
    if (required.isEmpty && helped.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (required.isNotEmpty) ...[
          Text(
            context.t.learn.requiredTechniques,
            style: MichiTypography.heading,
          ),
          const SizedBox(height: MichiSpacing.sm),
          Wrap(
            spacing: MichiSpacing.xs,
            runSpacing: MichiSpacing.xs,
            children: [
              for (final technique in required)
                _TechniqueLabel(
                  technique: technique,
                  key: ValueKey('required-${technique.name}'),
                ),
            ],
          ),
        ],
        const SizedBox(height: MichiSpacing.lg),
        Text(context.t.learn.helpedTechniques, style: MichiTypography.heading),
        const SizedBox(height: MichiSpacing.sm),
        if (helped.isEmpty)
          Text(context.t.learn.noHints, style: MichiTypography.secondary)
        else
          Wrap(
            spacing: MichiSpacing.xs,
            runSpacing: MichiSpacing.xs,
            children: [
              for (final technique in helped)
                _TechniqueLabel(
                  technique: technique,
                  key: ValueKey('helped-${technique.name}'),
                ),
            ],
          ),
      ],
    );
  }
}

final class _TechniqueLabel extends StatelessWidget {
  const _TechniqueLabel({required this.technique, super.key});

  final SudokuTechnique technique;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: MichiColors.cream,
      borderRadius: BorderRadius.circular(MichiRadius.control),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MichiSpacing.md,
        vertical: MichiSpacing.sm,
      ),
      child: Text(
        TechniqueCopy.name(context.t, technique),
        style: MichiTypography.meta,
      ),
    ),
  );
}
