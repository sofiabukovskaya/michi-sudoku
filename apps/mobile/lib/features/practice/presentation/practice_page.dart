import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_page_state.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/practice/application/practice_cubit.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/practice/domain/practice_session_order.dart';
import 'package:michi_mobile/features/practice/presentation/widgets/practice_exercise_view.dart';
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
      final ordered = practiceSessionOrder(scenarios);
      final cubit = PracticeCubit(
        scenarios: ordered.take(5).toList(),
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
        body: _failed
            ? MichiProblemState(
                message: context.t.learn.unavailable,
                actionLabel: MaterialLocalizations.of(
                  context,
                ).backButtonTooltip,
                onAction: () => Navigator.of(context).maybePop(),
              )
            : MichiLoadingState(label: context.t.learn.loading),
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
                : PracticeExerciseView(
                    state: state,
                    cubit: cubit,
                    continueLabel: state.isLast
                        ? context.t.learn.finishPractice
                        : context.t.learn.nextScenario,
                    onContinue: cubit.next,
                    header: _PracticeHeader(
                      state: state,
                      technique: widget.technique,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
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
        // Mastery is a genuine milestone (celebrate); a finished session
        // without it is still a good moment (happy). Plays once on arrival.
        Center(
          child: MichiMotionMascot(
            asset: state.progress.mastery == TechniqueMastery.mastered
                ? MichiMotionAsset.celebrating
                : MichiMotionAsset.happy,
            size: 176,
            fallback: const MichiMascot(
              state: MichiMascotState.happy,
              size: 160,
            ),
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

final class _PracticeHeader extends StatelessWidget {
  const _PracticeHeader({required this.state, required this.technique});

  final PracticeState state;
  final SudokuTechnique technique;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      PracticeSegments(
        total: state.scenarios.length,
        current: state.index,
        label: context.t.learn.exercise(
          current: state.index + 1,
          total: state.scenarios.length,
        ),
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
}
