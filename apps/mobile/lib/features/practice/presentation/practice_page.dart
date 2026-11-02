import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/focused_unit_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/practice/application/practice_cubit.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class PracticePage extends StatefulWidget {
  const PracticePage({
    required this.technique,
    this.catalog,
    this.progressRepository,
    this.humanSolver,
    this.coachEngine,
    super.key,
  });

  final SudokuTechnique technique;
  final LocalPracticeCatalog? catalog;
  final TechniqueProgressRepository? progressRepository;
  final HumanSolver? humanSolver;
  final CoachEngine? coachEngine;

  @override
  State<PracticePage> createState() => _PracticePageState();
}

final class _PracticePageState extends State<PracticePage> {
  PracticeCubit? _cubit;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final scenarios = await (widget.catalog ?? getIt<LocalPracticeCatalog>())
          .forTechnique(widget.technique);
      if (scenarios.isEmpty) throw StateError('No practice scenarios.');
      final progressRepository =
          widget.progressRepository ?? getIt<TechniqueProgressRepository>();
      final progress = await progressRepository.load(widget.technique);
      final cubit = PracticeCubit(
        scenarios: scenarios.take(5).toList(),
        humanSolver: widget.humanSolver ?? getIt<HumanSolver>(),
        coachEngine: widget.coachEngine ?? getIt<CoachEngine>(),
        progressRepository: progressRepository,
        initialProgress: progress,
      );
      if (!mounted) {
        await cubit.close();
        return;
      }
      setState(() {
        _cubit = cubit;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _failed = true;
        });
      }
    }
  }

  @override
  void dispose() {
    if (_cubit case final cubit?) unawaited(cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = _cubit;
    if (cubit == null) {
      return Scaffold(
        backgroundColor: MichiColors.paper,
        appBar: AppBar(title: Text(context.t.learn.practiceTitle)),
        body: Center(
          child: Text(
            _failed ? context.t.learn.unavailable : context.t.learn.loading,
          ),
        ),
      );
    }
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<PracticeCubit, PracticeState>(
        builder: (context, state) => Scaffold(
          backgroundColor: MichiColors.paper,
          appBar: AppBar(
            backgroundColor: MichiColors.paper,
            title: Text(
              '${context.t.learn.practiceTitle} · '
              '${TechniqueCopy.name(context.t, widget.technique)}',
            ),
          ),
          body: SafeArea(
            child: state.status == PracticeStatus.completed
                ? _PracticeSummary(state: state)
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final cellSize = math
                          .min(
                            (constraints.maxWidth - 32) / 9,
                            math.max(25, (constraints.maxHeight - 270) / 9),
                          )
                          .toDouble();
                      final focusedUnit = FocusedUnitWidget.unitFor(
                        state.deduction,
                      );
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: MichiSpacing.md,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  context.t.learn.exercise(
                                    current: state.index + 1,
                                    total: state.scenarios.length,
                                  ),
                                  style: MichiTypography.meta,
                                ),
                                const SizedBox(height: MichiSpacing.xs),
                                LinearProgressIndicator(
                                  value:
                                      (state.index + 1) /
                                      state.scenarios.length,
                                  color: MichiColors.indigo,
                                  backgroundColor: MichiColors.cream,
                                ),
                                const SizedBox(height: MichiSpacing.sm),
                                Text(
                                  state.isPlacement
                                      ? context.t.learn.placementPrompt
                                      : context.t.learn.eliminationPrompt,
                                  style: MichiTypography.secondary,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: MichiSpacing.sm),
                          if (focusedUnit case final unit?)
                            SizedBox(
                              height: math.min(constraints.maxWidth - 32, 310),
                              child: FocusedUnitWidget(
                                unit: unit,
                                view: BoardViewState.educational(
                                  state: state.engineState,
                                  selectedCell: state.selectedCell,
                                  coachHint: state.visibleHint,
                                  selectedEliminations:
                                      state.selectedEliminations,
                                ),
                                onCellTap: cubit.selectCell,
                              ),
                            )
                          else
                            SudokuBoardWidget(
                              view: BoardViewState.educational(
                                state: state.engineState,
                                selectedCell: state.selectedCell,
                                coachHint: state.visibleHint,
                                selectedEliminations:
                                    state.selectedEliminations,
                              ),
                              cellSize: cellSize,
                              onCellTap: cubit.selectCell,
                            ),
                          const SizedBox(height: MichiSpacing.sm),
                          Expanded(
                            child: state.visibleHint != null
                                ? CoachPanel(
                                    model: CoachPresenter.presentPlan(
                                      context.t,
                                      state.coachPlan,
                                      state.hintIndex!,
                                    ),
                                    onNext: cubit.requestHint,
                                    onDismiss: cubit.dismissHint,
                                    onApply: () {
                                      final placements =
                                          state.deduction.placements;
                                      if (placements.length == 1) {
                                        cubit
                                          ..dismissHint()
                                          ..selectCell(placements.single.cell)
                                          ..selectDigit(
                                            placements.single.digit,
                                          );
                                      } else {
                                        cubit.dismissHint();
                                      }
                                    },
                                  )
                                : _PracticeControls(
                                    state: state,
                                    cubit: cubit,
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

final class _PracticeControls extends StatelessWidget {
  const _PracticeControls({required this.state, required this.cubit});

  final PracticeState state;
  final PracticeCubit cubit;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: MichiSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.status == PracticeStatus.answering) ...[
          Expanded(
            child: SingleChildScrollView(
              child: state.isPlacement
                  ? _digitChoices(context)
                  : _candidateChoices(context),
            ),
          ),
          if (state.persistenceFailed)
            Text(
              context.t.learn.saveFailed,
              style: MichiTypography.secondary.copyWith(
                color: MichiColors.error,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: MichiButton(
                  label: context.t.learn.askMichi,
                  variant: MichiButtonVariant.secondary,
                  onPressed: cubit.requestHint,
                ),
              ),
              const SizedBox(width: MichiSpacing.sm),
              Expanded(
                child: MichiButton(
                  key: const ValueKey('practice-check'),
                  label: context.t.learn.checkAnswer,
                  onPressed: state.saving ? null : cubit.checkAnswer,
                ),
              ),
            ],
          ),
          const SizedBox(height: MichiSpacing.sm),
        ] else ...[
          Expanded(child: _feedback(context)),
          MichiButton(
            key: ValueKey(
              state.status == PracticeStatus.correct
                  ? 'practice-next'
                  : 'practice-retry',
            ),
            label: state.status == PracticeStatus.correct
                ? context.t.learn.nextScenario
                : context.t.learn.tryAgain,
            onPressed: state.status == PracticeStatus.correct
                ? cubit.next
                : cubit.tryAgain,
          ),
          const SizedBox(height: MichiSpacing.sm),
        ],
      ],
    ),
  );

  Widget _digitChoices(BuildContext context) => Wrap(
    spacing: MichiSpacing.xs,
    runSpacing: MichiSpacing.xs,
    alignment: WrapAlignment.center,
    children: [
      for (var digit = 1; digit <= 9; digit++)
        _DigitChoice(
          key: ValueKey('practice-digit-$digit'),
          digit: digit,
          selected: state.selectedDigit == digit,
          onTap: () => cubit.selectDigit(digit),
        ),
    ],
  );

  Widget _candidateChoices(BuildContext context) {
    final cell = state.selectedCell;
    if (cell == null || state.engineState.board.isFilled(cell)) {
      return Text(
        context.t.learn.eliminationPrompt,
        style: MichiTypography.secondary,
      );
    }
    return Wrap(
      spacing: MichiSpacing.xs,
      runSpacing: MichiSpacing.xs,
      alignment: WrapAlignment.center,
      children: [
        for (final digit in state.engineState.candidatesFor(cell).digits)
          Semantics(
            label: _candidateSemanticsLabel(
              context,
              cell,
              digit,
              state.selectedEliminations.contains(
                CandidateElimination(cell, digit),
              ),
            ),
            selected: state.selectedEliminations.contains(
              CandidateElimination(cell, digit),
            ),
            button: true,
            onTap: () => cubit.toggleElimination(cell, digit),
            child: ExcludeSemantics(
              child: _DigitChoice(
                key: ValueKey('candidate-${cell.index}-$digit'),
                digit: digit,
                selected: state.selectedEliminations.contains(
                  CandidateElimination(cell, digit),
                ),
                onTap: () => cubit.toggleElimination(cell, digit),
              ),
            ),
          ),
      ],
    );
  }

  String _candidateSemanticsLabel(
    BuildContext context,
    CellRef cell,
    int digit,
    bool selected,
  ) =>
      '${context.t.game.row} ${cell.row + 1}, '
      '${context.t.game.column} ${cell.column + 1}, '
      '${context.t.game.candidates} $digit'
      '${selected ? ', ${context.t.learn.selectedForElimination}' : ''}';

  Widget _feedback(BuildContext context) {
    final correct = state.status == PracticeStatus.correct;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: correct ? MichiColors.successTint : MichiColors.almostTint,
        borderRadius: BorderRadius.circular(MichiRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.md),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      correct
                          ? context.t.learn.correctTitle
                          : context.t.learn.incorrectTitle,
                      key: ValueKey(
                        correct ? 'practice-correct' : 'practice-wrong',
                      ),
                      style: MichiTypography.heading.copyWith(
                        color: correct
                            ? MichiColors.success
                            : MichiColors.almostText,
                      ),
                    ),
                  ),
                  if (correct)
                    Image.asset(
                      'assets/images/coach_mascot.png',
                      width: 64,
                      height: 64,
                      excludeFromSemantics: true,
                    ),
                ],
              ),
              const SizedBox(height: MichiSpacing.sm),
              Text(
                correct
                    ? TechniqueCopy.step(
                        context.t,
                        state.scenario.technique,
                        LessonStepKind.reasoning,
                      )
                    : _incorrectExplanation(context),
                style: MichiTypography.body,
              ),
              if (!correct) ...[
                const SizedBox(height: MichiSpacing.sm),
                MichiButton(
                  label: context.t.learn.askMichi,
                  variant: MichiButtonVariant.text,
                  onPressed: cubit.requestHint,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _incorrectExplanation(BuildContext context) {
    if (state.isPlacement) return context.t.learn.wrongPlacement;
    final expected = state.deduction.eliminations.toSet();
    if (state.selectedEliminations.difference(expected).isNotEmpty) {
      return context.t.learn.extraElimination;
    }
    return context.t.learn.missingElimination;
  }
}

final class _DigitChoice extends StatelessWidget {
  const _DigitChoice({
    required this.digit,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final int digit;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: '$digit',
    onTap: onTap,
    child: ExcludeSemantics(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MichiRadius.small),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? MichiColors.indigo : MichiColors.ivory,
            borderRadius: BorderRadius.circular(MichiRadius.small),
            border: Border.all(color: MichiColors.hairline),
          ),
          child: SizedBox.square(
            dimension: 44,
            child: Center(
              child: Text(
                '$digit',
                style: MichiTypography.body.copyWith(
                  color: selected ? MichiColors.ivory : MichiColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

final class _PracticeSummary extends StatelessWidget {
  const _PracticeSummary({required this.state});

  final PracticeState state;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(MichiSpacing.xl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Center(
          child: Image.asset(
            'assets/images/coach_mascot.png',
            height: 160,
            excludeFromSemantics: true,
          ),
        ),
        const SizedBox(height: MichiSpacing.xl),
        Text(
          context.t.learn.sessionSummary,
          key: const ValueKey('practice-summary'),
          style: MichiTypography.display,
        ),
        const SizedBox(height: MichiSpacing.md),
        Text(
          TechniqueCopy.name(context.t, state.scenario.technique),
          style: MichiTypography.heading,
        ),
        Text(
          context.t.learn.summaryStats(
            correct: state.sessionCorrect,
            attempts: state.sessionAttempts,
          ),
          style: MichiTypography.body,
        ),
        Text(
          context.t.learn.hintsUsed(count: state.sessionHintAssisted),
          style: MichiTypography.secondary,
        ),
        Text(
          TechniqueCopy.mastery(context.t, state.progress.mastery),
          style: MichiTypography.meta,
        ),
        const Spacer(),
        MichiButton(
          label: context.t.learn.done,
          onPressed: () => context.router.maybePop(),
        ),
      ],
    ),
  );
}
