import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
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
      child: BlocConsumer<PracticeCubit, PracticeState>(
        listenWhen: (a, b) => a.status != b.status,
        listener: (_, state) {
          switch (state.status) {
            case PracticeStatus.correct:
              unawaited(HapticFeedback.lightImpact());
            case PracticeStatus.incorrect:
              unawaited(HapticFeedback.mediumImpact());
            case PracticeStatus.completed:
              unawaited(HapticFeedback.heavyImpact());
            case PracticeStatus.answering:
              break;
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: MichiColors.paper,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close_rounded),
              tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              onPressed: () => context.router.maybePop(),
            ),
            centerTitle: true,
            title: Text(
              '${context.t.learn.practiceTitle} · '
              '${TechniqueCopy.name(context.t, widget.technique)}',
              style: MichiTypography.body.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          body: SafeArea(
            top: false,
            child: state.status == PracticeStatus.completed
                ? MichiContentFrame(
                    maxWidth: MichiLayout.focusedWidth,
                    expandedMaxHeight: MichiLayout.taskMaxHeight,
                    child: MichiReveal(child: _PracticeSummary(state: state)),
                  )
                : _PracticeExercise(
                    state: state,
                    cubit: cubit,
                    technique: widget.technique,
                  ),
          ),
        ),
      ),
    );
  }
}

/// One instructional composition: where I am, what to find, the board, and
/// the next action. The action area keeps a stable height so the board never
/// jumps when feedback or Coach replaces the answer controls.
final class _PracticeExercise extends StatelessWidget {
  const _PracticeExercise({
    required this.state,
    required this.cubit,
    required this.technique,
  });

  final PracticeState state;
  final PracticeCubit cubit;
  final SudokuTechnique technique;

  static const double _actionMinHeight = 240;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, window) {
      final twoPane =
          MichiLayout.classify(window.maxWidth) == MichiWindowClass.expanded;
      return MichiContentFrame(
        maxWidth: twoPane ? 960 : MichiLayout.readableWidth,
        expandedMaxHeight: MichiLayout.taskMaxHeight,
        child: twoPane ? _twoPane(context) : _singleColumn(context),
      );
    },
  );

  Widget _singleColumn(BuildContext context) {
    // The board keeps the space above the answer controls. Taller feedback
    // or Coach rises over the board's lower edge like the approved sheet,
    // so the exercise never jumps or shrinks after an answer.
    final reserve =
        (MediaQuery.sizeOf(context).height >= 720 ? _actionMinHeight : 180) +
        MichiSpacing.lg * 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            MichiSpacing.xl,
            MichiSpacing.sm,
            MichiSpacing.xl,
            0,
          ),
          child: _header(context),
        ),
        const SizedBox(height: MichiSpacing.xl),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(bottom: reserve, child: _board(context)),
              Positioned(
                left: MichiLayout.cardGutter,
                right: MichiLayout.cardGutter,
                bottom: MichiSpacing.lg,
                child: _actions(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _twoPane(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: MichiSpacing.xl),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MichiLayout.textInset,
                ),
                child: _header(context),
              ),
              const Spacer(),
              _actions(context),
            ],
          ),
        ),
        const SizedBox(width: MichiSpacing.huge),
        Expanded(flex: 6, child: _board(context)),
      ],
    ),
  );

  Widget _header(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(
            child: _PracticeSegments(
              total: state.scenarios.length,
              current: state.index,
            ),
          ),
          const SizedBox(width: MichiSpacing.md),
          Text(
            context.t.learn.exercise(
              current: state.index + 1,
              total: state.scenarios.length,
            ),
            style: MichiTypography.meta,
          ),
        ],
      ),
      const SizedBox(height: MichiSpacing.lg),
      MichiReveal(
        key: ValueKey(state.index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.t.learn.findTechnique(
                technique: TechniqueCopy.name(context.t, technique),
              ),
              style: MichiTypography.editorialTitle,
            ),
            const SizedBox(height: MichiSpacing.xs),
            Text(
              state.isPlacement
                  ? context.t.learn.placementPrompt
                  : context.t.learn.eliminationPrompt,
              style: MichiTypography.secondary,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _board(BuildContext context) {
    final view = BoardViewState.educational(
      state: state.engineState,
      selectedCell: state.selectedCell,
      coachHint: state.visibleHint,
      selectedEliminations: state.selectedEliminations,
    );
    final focusedUnit = FocusedUnitWidget.unitFor(state.deduction);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact =
            MichiLayout.classify(MediaQuery.sizeOf(context).width) ==
            MichiWindowClass.compact;
        final available = math.min(
          constraints.maxWidth - MichiSpacing.xl * 2,
          constraints.maxHeight,
        );
        if (focusedUnit case final unit?) {
          // An excerpt reads as an exercise card, not a stretched grid.
          final side = math.min(available, compact ? 280.0 : 320.0);
          return Center(
            child: MichiReveal(
              key: ValueKey(state.index),
              child: SizedBox.square(
                dimension: side,
                child: FocusedUnitWidget(
                  unit: unit,
                  view: view,
                  onCellTap: cubit.selectCell,
                ),
              ),
            ),
          );
        }
        final cellSize = (available / 9).clamp(24.0, compact ? 40.0 : 46.0);
        return Center(
          child: MichiReveal(
            key: ValueKey(state.index),
            child: SudokuBoardWidget(
              view: view,
              cellSize: cellSize,
              onCellTap: cubit.selectCell,
            ),
          ),
        );
      },
    );
  }

  Widget _actions(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final mode = state.visibleHint != null ? 'hint' : state.status.name;
    // A stable action height keeps the board still between states; short
    // phones give that space back to the board instead.
    final stable = MediaQuery.sizeOf(context).height >= 720;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: stable ? _actionMinHeight : 0),
      child: AnimatedSwitcher(
        duration: reduceMotion ? Duration.zero : MichiMotion.enter,
        switchInCurve: MichiMotion.curve,
        switchOutCurve: Curves.easeIn,
        layoutBuilder: (current, previous) => Stack(
          alignment: Alignment.bottomCenter,
          children: [...previous, ?current],
        ),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.06),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: KeyedSubtree(
          key: ValueKey(mode),
          child: state.visibleHint != null
              ? _coach(context)
              : _PracticeControls(state: state, cubit: cubit),
        ),
      ),
    );
  }

  Widget _coach(BuildContext context) => SizedBox(
    height: _actionMinHeight,
    child: CoachPanel(
      model: CoachPresenter.presentPlan(
        context.t,
        state.coachPlan,
        state.hintIndex!,
      ),
      onNext: cubit.requestHint,
      onDismiss: cubit.dismissHint,
      onApply: () {
        final placements = state.deduction.placements;
        if (placements.length == 1) {
          cubit
            ..dismissHint()
            ..selectCell(placements.single.cell)
            ..selectDigit(placements.single.digit);
        } else {
          cubit.dismissHint();
        }
      },
    ),
  );
}

/// Exercise progress as discrete steps, as in the approved practice header.
final class _PracticeSegments extends StatelessWidget {
  const _PracticeSegments({required this.total, required this.current});

  final int total;
  final int current;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return ExcludeSemantics(
      child: Row(
        children: [
          for (var index = 0; index < total; index++) ...[
            if (index > 0) const SizedBox(width: MichiSpacing.xs),
            Expanded(
              child: AnimatedContainer(
                duration: reduceMotion ? Duration.zero : MichiMotion.emphasis,
                curve: MichiMotion.curve,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: index < current
                      ? MichiColors.indigo
                      : index == current
                      ? MichiColors.indigo.withValues(alpha: 0.45)
                      : MichiColors.cream,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

final class _PracticeControls extends StatelessWidget {
  const _PracticeControls({required this.state, required this.cubit});

  final PracticeState state;
  final PracticeCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (state.status != PracticeStatus.answering) return _feedback(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.isPlacement)
          _digitChoices(context)
        else
          _candidateChoices(context),
        const SizedBox(height: MichiSpacing.lg),
        if (state.persistenceFailed) ...[
          Text(
            context.t.learn.saveFailed,
            style: MichiTypography.secondary.copyWith(color: MichiColors.error),
          ),
          const SizedBox(height: MichiSpacing.sm),
        ],
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
      ],
    );
  }

  Widget _digitChoices(BuildContext context) => Wrap(
    spacing: MichiSpacing.sm,
    runSpacing: MichiSpacing.sm,
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
      return const SizedBox.shrink();
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
        padding: const EdgeInsets.all(MichiSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
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
                    _FeedbackMascot(correct: correct),
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
              ],
            ),
            const SizedBox(height: MichiSpacing.lg),
            Row(
              children: [
                if (!correct) ...[
                  Expanded(
                    child: MichiButton(
                      label: context.t.learn.askMichi,
                      variant: MichiButtonVariant.secondary,
                      onPressed: cubit.requestHint,
                    ),
                  ),
                  const SizedBox(width: MichiSpacing.sm),
                ],
                Expanded(
                  child: MichiButton(
                    key: ValueKey(correct ? 'practice-next' : 'practice-retry'),
                    label: correct
                        ? context.t.learn.nextScenario
                        : context.t.learn.tryAgain,
                    onPressed: correct ? cubit.next : cubit.tryAgain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _incorrectExplanation(BuildContext context) {
    if (state.isPlacement) {
      final placement = state.deduction.placements.singleOrNull;
      if (placement == null) return context.t.learn.wrongCellAndDigit;
      if (state.selectedCell != placement.cell) {
        return context.t.learn.wrongCell;
      }
      if (state.selectedDigit != placement.digit) {
        return context.t.learn.wrongDigit;
      }
      return context.t.learn.wrongCellAndDigit;
    }
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
        const Center(
          child: MichiMascot(
            state: MichiMascotState.happy,
            size: 160,
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

/// The mascot reacts to the answer: a small pop for success, a calm look for
/// "almost". Static when Reduce Motion is on.
final class _FeedbackMascot extends StatelessWidget {
  const _FeedbackMascot({required this.correct});

  final bool correct;

  @override
  Widget build(BuildContext context) {
    final mascot = MichiMascot(
      state: correct ? MichiMascotState.happy : MichiMascotState.pointing,
      size: 64,
    );
    if (MediaQuery.disableAnimationsOf(context)) return mascot;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: MichiMotion.emphasis,
      curve: correct ? Curves.easeOutBack : MichiMotion.curve,
      builder: (context, value, child) => Transform.scale(
        scale: 0.7 + 0.3 * value,
        child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
      ),
      child: mascot,
    );
  }
}
