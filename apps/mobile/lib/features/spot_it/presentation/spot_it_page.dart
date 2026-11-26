import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_page_state.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/practice/application/practice_cubit.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:michi_mobile/features/practice/presentation/widgets/practice_exercise_view.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/spot_it/data/spot_it_store.dart';
import 'package:michi_mobile/features/spot_it/domain/spot_it_finder.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Today's 30-second "Spot it": one moment from a real puzzle where exactly
/// one cell can be filled for sure. Solving it keeps the Daily streak on a
/// busy day; it never completes the Daily itself.
@RoutePage()
final class SpotItPage extends StatefulWidget {
  const SpotItPage({super.key});

  @override
  State<SpotItPage> createState() => _SpotItPageState();
}

final class _SpotItPageState extends State<SpotItPage> {
  PracticeCubit? _cubit;
  bool _failed = false;
  final SpotItStore _store = SpotItStore();
  final GameClock _clock = getIt<GameClock>();

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final catalog = await LocalPuzzleCatalogLoader().load();
      final pool = [
        ...catalog.puzzlesByDifficulty(PuzzleDifficulty.medium),
        ...catalog.puzzlesByDifficulty(PuzzleDifficulty.advanced),
      ]..sort((a, b) => a.id.compareTo(b.id));
      final now = _clock.now().toLocal();
      final day = '${now.year}-${now.month}-${now.day}';
      // The same moment all day, a different one tomorrow.
      final start =
          LocalPuzzleRepository.stableHash('spot-it|$day') % pool.length;
      const solver = DeterministicHumanSolver();
      final scenario =
          [
                for (var i = 0; i < 40; i++) pool[(start + i) % pool.length],
              ]
              .map((puzzle) {
                return SpotItFinder.find(
                  id: 'spot_${puzzle.id}',
                  puzzle: puzzle.initialBoard,
                  solver: solver,
                );
              })
              .firstWhere((found) => found != null, orElse: () => null);
      if (scenario == null) throw StateError('No Spot it moment found.');
      final progressRepository = getIt<TechniqueProgressRepository>();
      final progress = await progressRepository.load(scenario.technique);
      final cubit = PracticeCubit(
        scenarios: [scenario],
        humanSolver: getIt<HumanSolver>(),
        coachEngine: getIt<CoachEngine>(),
        progressRepository: progressRepository,
        initialProgress: progress,
      );
      if (!mounted) {
        await cubit.close();
        return;
      }
      setState(() => _cubit = cubit);
    } on Object {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    if (_cubit case final cubit?) unawaited(cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final cubit = _cubit;
    final appBar = AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close_rounded),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        onPressed: () => context.router.maybePop(),
      ),
      centerTitle: true,
      title: Text(
        t.spotIt.title,
        style: MichiTypography.body.copyWith(fontWeight: FontWeight.w700),
      ),
    );
    if (cubit == null) {
      return Scaffold(
        backgroundColor: MichiColors.paper,
        appBar: appBar,
        body: _failed
            ? MichiProblemState(
                message: t.learn.unavailable,
                actionLabel: MaterialLocalizations.of(
                  context,
                ).backButtonTooltip,
                onAction: () => Navigator.of(context).maybePop(),
              )
            : MichiLoadingState(label: t.learn.loading),
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
              unawaited(_store.markDone(_clock.now()));
            case PracticeStatus.incorrect:
              unawaited(HapticFeedback.mediumImpact());
            case PracticeStatus.answering || PracticeStatus.completed:
              break;
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: MichiColors.paper,
          appBar: appBar,
          body: SafeArea(
            top: false,
            child: PracticeExerciseView(
              state: state,
              cubit: cubit,
              continueLabel: t.spotIt.done,
              onContinue: () => context.router.maybePop(),
              header: const _SpotItHeader(),
            ),
          ),
        ),
      ),
    );
  }
}

/// The question and a gentle 30-second mark: after it, a pointer to the
/// hint. Nothing fails or locks when time runs out.
final class _SpotItHeader extends StatefulWidget {
  const _SpotItHeader();

  static const _window = Duration(seconds: 30);

  @override
  State<_SpotItHeader> createState() => _SpotItHeaderState();
}

final class _SpotItHeaderState extends State<_SpotItHeader> {
  bool _past = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_SpotItHeader._window, () {
      if (mounted) setState(() => _past = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!reduceMotion)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: _SpotItHeader._window,
            builder: (context, value, _) => MichiProgressBar(value: value),
          ),
        const SizedBox(height: MichiSpacing.lg),
        Text(t.spotIt.question, style: MichiTypography.editorialTitle),
        const SizedBox(height: MichiSpacing.xs),
        Text(
          _past ? t.spotIt.stuck : t.spotIt.prompt,
          style: MichiTypography.secondary,
        ),
      ],
    );
  }
}
