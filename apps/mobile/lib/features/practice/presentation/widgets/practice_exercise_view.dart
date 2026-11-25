import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_digit_pad.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/focused_unit_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/practice/application/practice_cubit.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// One instructional exercise shared by Practice and the lesson's "Try it":
/// where I am (supplied [header]), the board, and the next action.
///
/// The HumanSolver deduction in [PracticeState] is the only source of truth.
/// On success the board shows the Coach plan's result hint, so the learner
/// sees the proof cells, the highlighted candidates and the placed digit or
/// removed candidates rather than only a "correct" label.
final class PracticeExerciseView extends StatelessWidget {
  const PracticeExerciseView({
    required this.state,
    required this.cubit,
    required this.header,
    required this.continueLabel,
    required this.onContinue,
    super.key,
  });

  final PracticeState state;
  final PracticeCubit cubit;
  final Widget header;

  /// The action after a correct answer: next exercise, or Practice.
  final String continueLabel;
  final VoidCallback onContinue;

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
          child: header,
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
                child: header,
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

  BoardViewState _view() {
    final engine = state.engineState;
    if (state.status == PracticeStatus.correct) {
      // The proof: Coach's result hint over the unchanged position.
      return BoardViewState.educational(
        state: engine,
        coachHint: state.coachPlan.hints.last,
      );
    }
    final cell = state.selectedCell;
    final digit = state.selectedDigit;
    if (state.isPlacement &&
        cell != null &&
        digit != null &&
        engine.board.isEmpty(cell)) {
      // Show the pending answer where it would go, before checking.
      final board = engine.board.withValue(cell, digit);
      return BoardViewState(
        givens: engine.board,
        board: board,
        solution: board,
        notes: engine.candidates,
        selectedCell: cell,
        coachHint: state.visibleHint,
      );
    }
    return BoardViewState.educational(
      state: engine,
      selectedCell: cell,
      coachHint: state.visibleHint,
      selectedEliminations: state.selectedEliminations,
    );
  }

  Widget _board(BuildContext context) {
    final view = _view();
    final focusedUnit = FocusedUnitWidget.unitFor(
      state.deduction,
      state: state.engineState,
    );
    void select(CellRef cell) {
      unawaited(HapticFeedback.selectionClick());
      cubit.selectCell(cell);
    }

    final onTap = state.status == PracticeStatus.answering ? select : null;
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
                  onCellTap: onTap,
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
              onCellTap: onTap,
            ),
          ),
        );
      },
    );
  }

  Widget _actions(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final mode = state.visibleHint != null ? 'hint' : state.status.name;
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
          child: switch (state.status) {
            _ when state.visibleHint != null => _coach(context),
            PracticeStatus.answering => _PracticeControls(
              state: state,
              cubit: cubit,
            ),
            PracticeStatus.correct => _SuccessSheet(
              state: state,
              continueLabel: continueLabel,
              onContinue: onContinue,
            ),
            _ => _AlmostSheet(state: state, cubit: cubit),
          },
        ),
      ),
    );
  }

  // Here the sheet floats above the screen edge, so it reads as a card.
  Widget _coach(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(MichiRadius.card),
    child: SizedBox(
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
            // Coach's removals become the learner's selected answer.
            cubit.dismissHint();
            for (final removal in state.deduction.eliminations) {
              if (!state.selectedEliminations.contains(removal)) {
                cubit.toggleElimination(removal.cell, removal.digit);
              }
            }
          }
        },
      ),
    ),
  );
}

/// Exercise progress as discrete steps, as in the approved practice header.
final class PracticeSegments extends StatelessWidget {
  const PracticeSegments({
    required this.total,
    required this.current,
    this.label,
    super.key,
  });

  final int total;
  final int current;

  /// Optional counter shown at the end, such as "Exercise 1 of 5".
  final String? label;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final segments = ExcludeSemantics(
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
    final text = label;
    if (text == null) return segments;
    return Row(
      children: [
        Expanded(child: segments),
        const SizedBox(width: MichiSpacing.md),
        Text(text, style: MichiTypography.meta),
      ],
    );
  }
}

final class _PracticeControls extends StatelessWidget {
  const _PracticeControls({required this.state, required this.cubit});

  final PracticeState state;
  final PracticeCubit cubit;

  bool get _hasAnswer => state.isPlacement
      ? state.selectedCell != null && state.selectedDigit != null
      : state.selectedEliminations.isNotEmpty;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (state.isPlacement)
        MichiDigitPad(
          digits: const [1, 2, 3, 4, 5, 6, 7, 8, 9],
          selected: {?state.selectedDigit},
          keyFor: (digit) => 'practice-digit-$digit',
          onDigit: cubit.selectDigit,
        )
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
              onPressed: state.saving || !_hasAnswer ? null : cubit.checkAnswer,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _candidateChoices(BuildContext context) {
    final cell = state.selectedCell;
    if (cell == null || state.engineState.board.isFilled(cell)) {
      // Tell the learner what to do instead of leaving a blank gap.
      return SizedBox(
        height: MichiDigitPad.height,
        child: Center(
          child: Text(
            context.t.learn.pickCellFirst,
            style: MichiTypography.secondary,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final digits = state.engineState.candidatesFor(cell).digits.toList();
    final chosen = {
      for (final digit in digits)
        if (state.selectedEliminations.contains(
          CandidateElimination(cell, digit),
        ))
          digit,
    };
    return MichiDigitPad(
      digits: digits,
      selected: chosen,
      strikeSelected: true,
      keyFor: (digit) => 'candidate-${cell.index}-$digit',
      semanticsFor: (digit) {
        final marked = chosen.contains(digit)
            ? ', ${context.t.learn.selectedForElimination}'
            : '';
        return '${context.t.game.row} ${cell.row + 1}, '
            '${context.t.game.column} ${cell.column + 1}, '
            '${context.t.game.candidates} $digit$marked';
      },
      onDigit: (digit) => cubit.toggleElimination(cell, digit),
    );
  }
}

/// The approved success treatment: a clear check, the concrete reason taken
/// from this deduction, the general idea in one line, and a calm mascot pop.
final class _SuccessSheet extends StatelessWidget {
  const _SuccessSheet({
    required this.state,
    required this.continueLabel,
    required this.onContinue,
  });

  final PracticeState state;
  final String continueLabel;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final hints = state.coachPlan.hints;
    // Reasoning names the unit; the result names the move.
    final why = CoachPresenter.presentPlan(t, state.coachPlan, 2).instruction;
    final result = CoachPresenter.presentPlan(
      t,
      state.coachPlan,
      hints.length - 1,
    ).instruction;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: MichiColors.successTint,
            borderRadius: BorderRadius.circular(MichiRadius.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(MichiSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 72),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: MichiColors.success,
                      ),
                      const SizedBox(width: MichiSpacing.sm),
                      Expanded(
                        child: Text(
                          t.learn.correctTitle,
                          key: const ValueKey('practice-correct'),
                          style: MichiTypography.heading.copyWith(
                            color: MichiColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: MichiSpacing.sm),
                Text('$why $result', style: MichiTypography.body),
                const SizedBox(height: MichiSpacing.lg),
                MichiButton(
                  key: const ValueKey('practice-next'),
                  label: continueLabel,
                  onPressed: onContinue,
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          right: MichiSpacing.md,
          top: -MichiSpacing.xxl,
          child: _FeedbackMascot(correct: true),
        ),
      ],
    );
  }
}

/// "Almost": what went wrong, and two ways forward.
final class _AlmostSheet extends StatelessWidget {
  const _AlmostSheet({required this.state, required this.cubit});

  final PracticeState state;
  final PracticeCubit cubit;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: MichiColors.almostTint,
      borderRadius: BorderRadius.circular(MichiRadius.card),
    ),
    child: Padding(
      padding: const EdgeInsets.all(MichiSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.t.learn.incorrectTitle,
                  key: const ValueKey('practice-wrong'),
                  style: MichiTypography.heading.copyWith(
                    color: MichiColors.almostText,
                  ),
                ),
              ),
              const _FeedbackMascot(correct: false),
            ],
          ),
          const SizedBox(height: MichiSpacing.sm),
          Text(_explanation(context), style: MichiTypography.body),
          const SizedBox(height: MichiSpacing.lg),
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
                  key: const ValueKey('practice-retry'),
                  label: context.t.learn.tryAgain,
                  onPressed: cubit.tryAgain,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  String _explanation(BuildContext context) {
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

/// The mascot reacts to the answer: a small pop for success, a calm look for
/// "almost". Static when Reduce Motion is on.
final class _FeedbackMascot extends StatelessWidget {
  const _FeedbackMascot({required this.correct});

  final bool correct;

  @override
  Widget build(BuildContext context) {
    final mascot = MichiMascot(
      state: correct ? MichiMascotState.happy : MichiMascotState.pointing,
      size: correct ? 80 : 64,
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

/// Consistent answer haptics for every exercise surface.
final class PracticeFeedbackHaptics extends StatelessWidget {
  const PracticeFeedbackHaptics({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<PracticeCubit, PracticeState>(
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
        child: child,
      );
}
