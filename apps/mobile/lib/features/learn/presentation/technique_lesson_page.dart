import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_page_state.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/focused_unit_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/practice/application/practice_cubit.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/practice/domain/technique_practice_scenario.dart';
import 'package:michi_mobile/features/practice/presentation/widgets/practice_exercise_view.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class TechniqueLessonPage extends StatefulWidget {
  const TechniqueLessonPage({
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
  State<TechniqueLessonPage> createState() => _TechniqueLessonPageState();
}

final class _LessonData {
  const _LessonData(
    this.scenario,
    this.progress,
    this.engineState,
    this.plan,
    this.tryScenario,
  );

  final TechniquePracticeScenario scenario;
  final TechniqueProgress progress;
  final HumanSolverState engineState;
  final CoachPlan plan;

  /// A different board for "Try it", so the learner applies the idea rather
  /// than repeating the example they just watched.
  final TechniquePracticeScenario tryScenario;
}

/// "Try it" is a guided attempt, not scored practice: it uses the real
/// Practice checks and Coach but leaves mastery untouched.
final class _GuidedAttemptProgress implements TechniqueProgressRepository {
  const _GuidedAttemptProgress(this._progress);

  final TechniqueProgress _progress;

  @override
  Future<TechniqueProgress> load(SudokuTechnique technique) async => _progress;

  @override
  Future<Map<SudokuTechnique, TechniqueProgress>> loadAll() async => {
    _progress.technique: _progress,
  };

  @override
  Future<TechniqueProgress> recordCheck({
    required SudokuTechnique technique,
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  }) async => _progress;
}

final class _TechniqueLessonPageState extends State<TechniqueLessonPage> {
  late final Future<_LessonData> _data = _load();
  int _step = -1;

  Future<_LessonData> _load() async {
    final catalog = widget.catalog ?? getIt<LocalPracticeCatalog>();
    final scenarios = await catalog.forTechnique(widget.technique);
    if (scenarios.isEmpty) throw StateError('No lesson example available.');
    final scenario = scenarios.first;
    final engineState = scenario.initialState;
    final deduction = (widget.humanSolver ?? getIt<HumanSolver>())
        .findNextDeduction(engineState);
    if (deduction?.technique != widget.technique) {
      throw StateError('Lesson example does not match the technique.');
    }
    final plan = (widget.coachEngine ?? getIt<CoachEngine>()).createPlan(
      deduction!,
    );
    final progress =
        await (widget.progressRepository ??
                getIt<TechniqueProgressRepository>())
            .load(widget.technique);
    return _LessonData(
      scenario,
      progress,
      engineState,
      plan,
      scenarios.length > 1 ? scenarios[1] : scenario,
    );
  }

  PracticeCubit? _tryCubit;

  PracticeCubit _tryItCubit(_LessonData data) => _tryCubit ??= PracticeCubit(
    scenarios: [data.tryScenario],
    humanSolver: widget.humanSolver ?? getIt<HumanSolver>(),
    coachEngine: widget.coachEngine ?? getIt<CoachEngine>(),
    progressRepository: _GuidedAttemptProgress(data.progress),
    initialProgress: data.progress,
  );

  @override
  void dispose() {
    if (_tryCubit case final cubit?) unawaited(cubit.close());
    super.dispose();
  }

  Future<void> _openPractice() =>
      context.router.push(PracticeRoute(technique: widget.technique));

  @override
  Widget build(BuildContext context) {
    final lesson = TechniqueLessons.forTechnique(widget.technique);
    return Scaffold(
      backgroundColor: MichiColors.paper,
      // The step's editorial title names the technique; the approved lesson
      // header carries only navigation and progress.
      appBar: AppBar(
        backgroundColor: MichiColors.paper,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: MichiContentFrame(
          expandedMaxHeight: 800,
          child: FutureBuilder<_LessonData>(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return MichiProblemState(
                  message: context.t.learn.unavailable,
                  actionLabel: MaterialLocalizations.of(
                    context,
                  ).backButtonTooltip,
                  onAction: () => Navigator.of(context).maybePop(),
                );
              }
              if (!snapshot.hasData) {
                return MichiLoadingState(label: context.t.learn.loading);
              }
              final data = snapshot.data!;
              final tryIt =
                  _step >= 0 && lesson.steps[_step] == LessonStepKind.tryIt;
              if (tryIt) return _tryItStep(context, lesson, data);
              return LayoutBuilder(
                builder: (context, constraints) {
                  final cellSize = math
                      .min(
                        (constraints.maxWidth - 48) / 9,
                        36,
                      )
                      .toDouble();
                  return Column(
                    children: [
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: MediaQuery.disableAnimationsOf(context)
                              ? Duration.zero
                              : MichiMotion.standard,
                          child: ListView(
                            key: ValueKey(_step),
                            padding: const EdgeInsets.all(MichiSpacing.xl),
                            children: _step < 0
                                ? _overview(context, lesson, data)
                                : _lessonStep(context, lesson, data, cellSize),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(MichiSpacing.xl),
                        child: SizedBox(
                          width: double.infinity,
                          child: MichiButton(
                            key: const ValueKey('lesson-primary'),
                            label: _step < 0
                                ? context.t.learn.lessonStart
                                : _step == lesson.steps.length - 1
                                ? context.t.learn.practiceStart
                                : context.t.learn.next,
                            onPressed: () async {
                              if (_step == lesson.steps.length - 1) {
                                await _openPractice();
                                return;
                              }
                              setState(() => _step++);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// The learner selects the cell and answers with the same keypad, checks,
  /// Coach and proof as Practice; success leads straight into Practice.
  Widget _tryItStep(
    BuildContext context,
    TechniqueLesson lesson,
    _LessonData data,
  ) {
    final cubit = _tryItCubit(data);
    return BlocProvider.value(
      value: cubit,
      child: PracticeFeedbackHaptics(
        child: BlocBuilder<PracticeCubit, PracticeState>(
          builder: (context, state) => MichiReveal(
            key: const ValueKey('lesson-try-it'),
            child: PracticeExerciseView(
              state: state,
              cubit: cubit,
              continueLabel: context.t.learn.practiceStart,
              onContinue: () => unawaited(_openPractice()),
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PracticeSegments(
                    total: lesson.steps.length + 1,
                    current: _step,
                  ),
                  const SizedBox(height: MichiSpacing.lg),
                  Text(
                    TechniqueCopy.stepLabel(context.t, LessonStepKind.tryIt),
                    style: MichiTypography.meta,
                  ),
                  const SizedBox(height: MichiSpacing.xs),
                  Text(
                    context.t.learn.findTechnique(
                      technique: TechniqueCopy.name(
                        context.t,
                        widget.technique,
                      ),
                    ),
                    style: MichiTypography.editorialTitle,
                  ),
                  const SizedBox(height: MichiSpacing.xs),
                  Text(
                    TechniqueCopy.step(
                      context.t,
                      widget.technique,
                      LessonStepKind.tryIt,
                    ),
                    key: const ValueKey('lesson-step-tryIt'),
                    style: MichiTypography.secondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _overview(
    BuildContext context,
    TechniqueLesson lesson,
    _LessonData data,
  ) => [
    SizedBox(
      height: 180,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                for (final cell in data.plan.deduction.focusCells.take(
                  widget.technique == SudokuTechnique.nakedTriple ? 3 : 2,
                )) ...[
                  Transform.rotate(
                    angle: -0.06,
                    child: Container(
                      width: widget.technique == SudokuTechnique.nakedTriple
                          ? 50
                          : 64,
                      height: widget.technique == SudokuTechnique.nakedTriple
                          ? 50
                          : 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MichiColors.ivory,
                        border: Border.all(
                          color: MichiColors.textPrimary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(
                          MichiRadius.control,
                        ),
                      ),
                      child: Text(
                        _overviewDigits(data, cell),
                        style: MichiTypography.heading.copyWith(
                          color: MichiColors.coralText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: MichiSpacing.sm),
                ],
              ],
            ),
          ),
          const MichiMascot(
            state: MichiMascotState.notebook,
            size: 150,
          ),
        ],
      ),
    ),
    Text(
      TechniqueCopy.name(context.t, widget.technique),
      style: MichiTypography.display,
    ),
    const SizedBox(height: MichiSpacing.sm),
    Text(
      TechniqueCopy.description(context.t, widget.technique),
      style: MichiTypography.body,
    ),
    const SizedBox(height: MichiSpacing.lg),
    Row(
      children: [
        Text(
          '${TechniqueCopy.mastery(context.t, data.progress.mastery)} '
          '${data.progress.masteryPercent}%',
          style: MichiTypography.meta,
        ),
        const SizedBox(width: MichiSpacing.md),
        Expanded(
          child: MichiProgressBar(
            value: data.progress.masteryPercent / 100,
          ),
        ),
      ],
    ),
    const SizedBox(height: MichiSpacing.xl),
    Text(context.t.learn.planTitle, style: MichiTypography.heading),
    const SizedBox(height: MichiSpacing.sm),
    for (var index = 0; index <= lesson.steps.length; index++) ...[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: MichiSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: index == 0
                  ? MichiColors.coral
                  : MichiColors.cream,
              child: Text('${index + 1}'),
            ),
            const SizedBox(width: MichiSpacing.md),
            Expanded(
              child: Text(
                index == lesson.steps.length
                    ? context.t.learn.practiceTitle
                    : TechniqueCopy.stepLabel(context.t, lesson.steps[index]),
                style: MichiTypography.body.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              index == lesson.steps.length
                  ? context.t.learn.tasks(count: 5)
                  : context.t.learn.minutes(count: 2),
              style: MichiTypography.meta,
            ),
          ],
        ),
      ),
      const Divider(height: 1, color: MichiColors.hairline),
    ],
  ];

  String _overviewDigits(_LessonData data, CellRef cell) {
    if (widget.technique == SudokuTechnique.hiddenPair) {
      return data.plan.deduction.evidence
          .whereType<UnitCandidateEvidence>()
          .map((item) => item.digit)
          .take(2)
          .join(' ');
    }
    return data.engineState.candidatesFor(cell).digits.take(3).join(' ');
  }

  List<Widget> _lessonStep(
    BuildContext context,
    TechniqueLesson lesson,
    _LessonData data,
    double cellSize,
  ) {
    final kind = lesson.steps[_step];
    // Concept points at where to look; Example shows the complete proof.
    final hint = switch (kind) {
      LessonStepKind.example => data.plan.hints.last,
      _ => data.plan.hints[0],
    };
    return [
      PracticeSegments(total: lesson.steps.length + 1, current: _step),
      const SizedBox(height: MichiSpacing.lg),
      Text(
        TechniqueCopy.stepLabel(context.t, kind),
        style: MichiTypography.meta,
      ),
      const SizedBox(height: MichiSpacing.sm),
      Text(
        TechniqueCopy.name(context.t, widget.technique),
        style: MichiTypography.display,
      ),
      const SizedBox(height: MichiSpacing.lg),
      if (FocusedUnitWidget.unitFor(
            data.plan.deduction,
            state: data.engineState,
          )
          case final unit?)
        SizedBox(
          height: math.min(MediaQuery.sizeOf(context).width - 48, 310),
          child: FocusedUnitWidget(
            unit: unit,
            view: BoardViewState.educational(
              state: data.engineState,
              coachHint: hint,
            ),
            onCellTap: null,
          ),
        )
      else
        Center(
          child: SudokuBoardWidget(
            view: BoardViewState.educational(
              state: data.engineState,
              coachHint: hint,
            ),
            cellSize: cellSize,
            onCellTap: null,
          ),
        ),
      const SizedBox(height: MichiSpacing.xl),
      Text(
        TechniqueCopy.step(context.t, widget.technique, kind),
        key: ValueKey('lesson-step-${kind.name}'),
        style: MichiTypography.body,
      ),
    ];
  }
}
