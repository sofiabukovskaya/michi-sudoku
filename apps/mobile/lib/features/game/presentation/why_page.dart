import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_geometry.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Screen 17 / C2 / C3: the same board and numbered proof for any supported
/// placement technique, or the compact original-clue explanation.
@RoutePage()
final class WhyPage extends StatelessWidget {
  const WhyPage({
    required this.game,
    required this.selection,
    required this.cell,
    super.key,
  });

  final GameState game;
  final WhySelection selection;
  final CellRef cell;

  @override
  Widget build(BuildContext context) {
    final plan = selection.plan;
    final t = context.t.why;
    return Scaffold(
      backgroundColor: MichiColors.paper,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final sheetGap = selection.availability == WhyAvailability.given
                ? constraints.maxHeight * 0.08
                : MichiSpacing.lg;
            final cellSize = math
                .min(
                  ((constraints.maxWidth - 30) / 9).floorToDouble(),
                  ((constraints.maxHeight * 0.51 - 14) / 9).floorToDouble(),
                )
                .clamp(28.0, 44.0);
            final geometry = BoardGeometry(cellSize);
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              t.title,
                              style: MichiTypography.body.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              tooltip: MaterialLocalizations.of(
                                context,
                              ).backButtonTooltip,
                              onPressed: () => context.router.maybePop(),
                              icon: const Icon(Icons.arrow_back_ios_new),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox.square(
                        dimension: geometry.size,
                        child: Stack(
                          children: [
                            SudokuBoardWidget(
                              view: BoardViewState(
                                givens: game.puzzle.givens,
                                board: game.board,
                                solution: game.solution,
                                notes: game.notes,
                                selectedCell: plan == null ? cell : null,
                                coachHint: null,
                              ),
                              cellSize: cellSize,
                              onCellTap: null,
                            ),
                            if (plan != null)
                              ExcludeSemantics(
                                child: IgnorePointer(
                                  child: _WhyMarkers(
                                    plan: plan,
                                    geometry: geometry,
                                    board: game.board,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: sheetGap),
                    SizedBox(
                      width: double.infinity,
                      height: math.max(
                        265,
                        constraints.maxHeight - geometry.size - 52 - sheetGap,
                      ),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: MichiColors.ivory,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(MichiRadius.hero),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (selection.availability ==
                                  WhyAvailability.given) ...[
                                Center(
                                  child: Container(
                                    width: 36,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: MichiColors.cream,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: MichiSpacing.lg),
                              ],
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (selection.availability ==
                                          WhyAvailability.given) ...[
                                        Text(
                                          t.givenTitle,
                                          style: MichiTypography.heading,
                                        ),
                                        const SizedBox(height: MichiSpacing.sm),
                                        Text(
                                          t.givenBody,
                                          style: MichiTypography.secondary,
                                        ),
                                      ] else if (plan != null) ...[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Semantics(
                                                header: true,
                                                child: Text(
                                                  t.whyHere(
                                                    digit: plan.target.digit,
                                                  ),
                                                  style:
                                                      MichiTypography.heading,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              TechniqueCopy.name(
                                                context.t,
                                                plan.technique,
                                              ),
                                              style: MichiTypography.meta,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: MichiSpacing.lg),
                                        for (final step in plan.steps)
                                          _WhyStepRow(
                                            step: step,
                                            text: _stepText(context, step),
                                          ),
                                      ] else ...[
                                        Text(
                                          t.unavailableTitle,
                                          style: MichiTypography.heading,
                                        ),
                                        const SizedBox(height: MichiSpacing.sm),
                                        Text(
                                          t.unavailableBody,
                                          style: MichiTypography.secondary,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: MichiSpacing.sm),
                              Row(
                                children: [
                                  if (plan != null) ...[
                                    Expanded(
                                      child: MichiButton(
                                        label: t.lesson,
                                        variant: MichiButtonVariant.secondary,
                                        onPressed: () => context.router.push(
                                          TechniqueLessonRoute(
                                            technique: plan.technique,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: MichiSpacing.sm),
                                  ],
                                  Expanded(
                                    child: MichiButton(
                                      label: t.gotIt,
                                      onPressed: () =>
                                          context.router.maybePop(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _stepText(BuildContext context, WhyStep step) {
    final t = context.t.why;
    final unit = step.unit;
    final label = unit == null
        ? ''
        : switch (unit.type) {
            SudokuUnitType.row => t.unitRow(index: unit.index + 1),
            SudokuUnitType.column => t.unitColumn(index: unit.index + 1),
            SudokuUnitType.box => t.unitBox(index: unit.index + 1),
          };
    return switch (step.kind) {
      WhyStepKind.unitRestrictions => t.unitRestrictions(
        unit: label,
        digits:
            (step.filledCells
                    .map((placement) => placement.digit)
                    .toSet()
                    .toList()
                  ..sort())
                .join(', '),
      ),
      WhyStepKind.onlyCandidate => t.onlyCandidate(digit: step.digit),
      WhyStepKind.unitSearch => t.unitSearch(
        digit: step.digit,
        unit: label,
      ),
      WhyStepKind.solePosition => t.solePosition(
        digit: step.digit,
        unit: label,
      ),
      WhyStepKind.placement => t.placement(digit: step.digit),
    };
  }
}

final class _WhyStepRow extends StatelessWidget {
  const _WhyStepRow({required this.step, required this.text});

  final WhyStep step;
  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${step.number}. $text',
    child: ExcludeSemantics(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MichiSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 11,
                  backgroundColor: MichiColors.textPrimary,
                  child: Text(
                    '${step.number}',
                    style: MichiTypography.meta.copyWith(
                      color: MichiColors.ivory,
                    ),
                  ),
                ),
                const SizedBox(width: MichiSpacing.sm),
                Expanded(child: Text(text, style: MichiTypography.body)),
              ],
            ),
          ),
          const Divider(height: 1, color: MichiColors.hairline),
        ],
      ),
    ),
  );
}

final class _WhyMarkers extends StatelessWidget {
  const _WhyMarkers({
    required this.plan,
    required this.geometry,
    required this.board,
  });

  final WhyPlan plan;
  final BoardGeometry geometry;
  final SudokuBoard board;

  @override
  Widget build(BuildContext context) {
    final used = <CellRef>{};
    final collisions = <CellRef, int>{};
    final unit = plan.steps
        .where((step) => step.kind == WhyStepKind.unitSearch)
        .firstOrNull
        ?.unit;
    final excluded = plan.steps
        .where((step) => step.kind == WhyStepKind.solePosition)
        .firstOrNull
        ?.markerCells;
    return Stack(
      children: [
        if (unit != null)
          Positioned.fromRect(
            rect: unit.cells
                .map(geometry.rectFor)
                .reduce((left, right) => left.expandToInclude(right)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: MichiColors.coral, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        if (excluded != null)
          for (final cell in excluded)
            if (board.isEmpty(cell))
              Positioned.fromRect(
                rect: geometry.rectFor(cell).deflate(8),
                child: Center(
                  child: Text(
                    '${plan.target.digit}',
                    style: MichiTypography.body.copyWith(
                      color: MichiColors.coralText,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
        Positioned.fromRect(
          rect: geometry.rectFor(plan.target.cell),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: MichiColors.success, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        for (final step in plan.steps)
          if (step.markerCells.isNotEmpty)
            Builder(
              builder: (context) {
                final cell = step.markerCells.firstWhere(
                  (candidate) => !used.contains(candidate),
                  orElse: () => step.markerCells.first,
                );
                used.add(cell);
                final offset = collisions.update(
                  cell,
                  (value) => value + 1,
                  ifAbsent: () => 0,
                );
                final rect = geometry.rectFor(cell);
                return Positioned(
                  left: rect.right - 13 - offset * 12,
                  top: rect.top - 4,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: MichiColors.textPrimary,
                    child: Text(
                      '${step.number}',
                      style: MichiTypography.meta.copyWith(
                        color: MichiColors.ivory,
                      ),
                    ),
                  ),
                );
              },
            ),
      ],
    );
  }
}
