import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_preparation.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_controls.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_top_bar.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_geometry.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_keypad.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation_engine.dart';
import 'package:michi_mobile/features/recommendation/presentation/recommendation_copy.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class GamePage extends StatefulWidget {
  const GamePage({
    this.puzzle,
    this.definition,
    this.dailyChallengeKey,
    this.cubit,
    this.repository,
    this.clock,
    this.recommendationService,
    this.restore = false,
    super.key,
  });

  /// Legacy test fixture input. Production routes pass [definition].
  final SudokuPuzzle? puzzle;
  final PuzzleDefinition? definition;
  final String? dailyChallengeKey;

  /// Supplied by widget tests; normal navigation uses the composition root.
  final GameCubit? cubit;
  final GameRepository? repository;
  final GameClock? clock;
  final LearningRecommendationService? recommendationService;
  final bool restore;

  @override
  State<GamePage> createState() => _GamePageState();
}

final class _GamePageState extends State<GamePage> with WidgetsBindingObserver {
  GameCubit? _cubit;
  Timer? _ticker;
  bool _loading = true;
  bool _numberFirst = false;
  int? _armedDigit;
  bool _loadFailed = false;
  PuzzleDifficulty? _difficulty;
  bool _isDaily = false;
  PuzzleDefinition? _definition;
  Future<LearningRecommendation>? _postGameRecommendation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _definition = widget.definition;
    _difficulty = widget.definition?.difficulty;
    _isDaily =
        widget.dailyChallengeKey != null ||
        widget.cubit?.state.dailyChallengeKey != null;
    if (widget.cubit case final cubit?) {
      _attach(cubit);
    } else {
      unawaited(_initialize());
    }
  }

  Future<void> _initialize() async {
    try {
      final repository = widget.repository ?? getIt<GameRepository>();
      final stored = widget.restore ? await repository.loadActiveGame() : null;
      if (widget.restore && stored == null) {
        if (mounted) {
          setState(() {
            _loading = false;
            _loadFailed = true;
          });
        }
        return;
      }
      final exactSolver = getIt<ExactSolver>();
      final humanSolver = getIt<HumanSolver>();
      final coachEngine = getIt<CoachEngine>();
      final clock = widget.clock ?? getIt<GameClock>();
      final GameCubit cubit;
      if (stored == null) {
        final puzzle = widget.definition?.puzzle ?? widget.puzzle;
        if (puzzle == null) {
          throw StateError('A new game requires a selected puzzle.');
        }
        _difficulty = widget.definition?.difficulty;
        _isDaily = widget.dailyChallengeKey != null;
        final prepared = await getIt<GamePreparation>().prepare(puzzle.givens);
        if (!mounted) return;
        cubit = GameCubit(
          prepared: prepared,
          puzzle: puzzle,
          dailyChallengeKey: widget.dailyChallengeKey,
          exactSolver: exactSolver,
          humanSolver: humanSolver,
          coachEngine: coachEngine,
          repository: repository,
          clock: clock,
        );
      } else {
        _isDaily = stored.dailyChallengeKey != null;
        try {
          _definition = await getIt<PuzzleRepository>().getPuzzle(
            stored.puzzleId,
          );
          _difficulty = _definition?.difficulty;
        } on Object {
          // Legacy or removed catalog content remains restorable.
        }
        if (_definition == null && stored.puzzleId.startsWith('imported_')) {
          try {
            _definition = await getIt<ImportedPuzzleRepository>().load(
              stored.puzzleId,
            );
          } on Object {
            // The active board restores if import metadata cannot be loaded.
          }
        }
        try {
          final prepared = await getIt<GamePreparation>().prepare(
            stored.initialBoard,
          );
          if (!mounted) return;
          cubit = GameCubit.restore(
            prepared: prepared,
            stored: stored,
            exactSolver: exactSolver,
            humanSolver: humanSolver,
            coachEngine: coachEngine,
            repository: repository,
            clock: clock,
          );
        } on FormatException catch (error, stackTrace) {
          developer.log(
            'Discarding an invalid restored game',
            name: 'michi.game',
            error: error,
            stackTrace: stackTrace,
          );
          await repository.deleteActiveGame(stored.gameId);
          rethrow;
          // The solver reports invalid puzzle content with StateError.
          // ignore: avoid_catching_errors
        } on StateError catch (error, stackTrace) {
          developer.log(
            'Discarding an unsolvable restored game',
            name: 'michi.game',
            error: error,
            stackTrace: stackTrace,
          );
          await repository.deleteActiveGame(stored.gameId);
          rethrow;
        }
      }
      if (!mounted) {
        await cubit.close();
        return;
      }
      setState(() => _attach(cubit));
    } on Object catch (error, stackTrace) {
      developer.log(
        'Unable to open game',
        name: 'michi.game',
        error: error,
        stackTrace: stackTrace,
      );
      if (mounted) {
        setState(() {
          _loading = false;
          _loadFailed = true;
        });
      }
    }
  }

  void _attach(GameCubit cubit) {
    _cubit = cubit;
    _loading = false;
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      _startTicker(cubit);
    }
  }

  void _startTicker(GameCubit cubit) {
    _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted &&
          !cubit.state.isPaused &&
          cubit.state.status != GameStatus.completed) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    if (lifecycle == AppLifecycleState.resumed) {
      final cubit = _cubit;
      if (cubit != null) _startTicker(cubit);
    } else if (lifecycle == AppLifecycleState.inactive ||
        lifecycle == AppLifecycleState.paused ||
        lifecycle == AppLifecycleState.detached) {
      final cubit = _cubit;
      _ticker?.cancel();
      _ticker = null;
      if (cubit != null) unawaited(cubit.onAppBackground());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    if (widget.cubit == null && _cubit != null) {
      unawaited(_cubit!.close());
    }
    super.dispose();
  }

  void _place(GameCubit cubit, int digit) {
    final before = cubit.state;
    cubit.enterDigit(digit);
    final after = cubit.state;
    if (identical(before, after)) return;
    unawaited(
      after.status == GameStatus.completed
          ? HapticFeedback.heavyImpact()
          : after.mistakes > before.mistakes
          ? HapticFeedback.mediumImpact()
          : after.notesMode
          ? HapticFeedback.selectionClick()
          : HapticFeedback.lightImpact(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = _cubit;
    if (cubit == null) {
      return Scaffold(
        backgroundColor: MichiPalette.of(context).paper,
        body: _loading
            ? const _GameSkeleton()
            : Center(
                child: _loadFailed
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(context.t.game.restoreUnavailable),
                          const SizedBox(height: MichiSpacing.lg),
                          MichiButton(
                            label: context.t.game.backHome,
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
      );
    }
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<GameCubit, GameState>(
        listenWhen: (previous, current) =>
            previous.storageFailure != current.storageFailure,
        listener: (context, state) {
          if (state.storageFailure == null) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.t.game.saveFailed),
              action: SnackBarAction(
                label: context.t.game.retrySave,
                onPressed: cubit.retryPersistence,
              ),
            ),
          );
        },
        child: Scaffold(
          backgroundColor: MichiPalette.of(context).paper,
          body: SafeArea(
            // Navigation stays at the top; board and controls use the
            // window's height and the input area spreads toward the thumbs.
            child: MichiContentFrame(
              expandedMaxHeight: 960,
              expandedAlignment: Alignment.topCenter,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxHeight < 710;
                  // Phones keep the approved 44 cell; larger windows get a
                  // bounded step up rather than a board stretched to fit.
                  final maxCell =
                      MichiLayout.classify(
                            MediaQuery.sizeOf(context).width,
                          ) ==
                          MichiWindowClass.compact
                      ? 44
                      : 52;
                  final widthCell = ((constraints.maxWidth - 38) / 9)
                      .floor()
                      .clamp(36, maxCell)
                      .toDouble();
                  final heightCell = ((constraints.maxHeight - 260) / 9)
                      .floor()
                      .clamp(36, maxCell)
                      .toDouble();
                  final cellSize = math.min(widthCell, heightCell);
                  return BlocBuilder<GameCubit, GameState>(
                    builder: (context, state) {
                      if (state.status == GameStatus.completed) {
                        _postGameRecommendation ??= _recommendAfterGame(state);
                        return FutureBuilder<LearningRecommendation>(
                          future: _postGameRecommendation,
                          builder: (context, snapshot) => MichiReveal(
                            child: _CompletedSurface(
                              state: state,
                              elapsed: cubit.elapsed,
                              puzzleTitle: _gameTitle(context),
                              isDaily: _isDaily,
                              recommendation: snapshot.data,
                              onContinue: snapshot.data == null
                                  ? null
                                  : () => openRecommendation(
                                      context,
                                      snapshot.data!,
                                    ).ignore(),
                              onHome: () async {
                                await cubit.flushPersistence();
                                if (context.mounted &&
                                    cubit.state.storageFailure == null) {
                                  await Navigator.of(context).maybePop();
                                }
                              },
                            ),
                          ),
                        );
                      }
                      final input = _GameInputArea(
                        state: state,
                        compact: compact,
                        onUndo: cubit.undo,
                        onErase: cubit.erase,
                        onToggleNotes: cubit.toggleNotesMode,
                        onHint: cubit.requestHint,
                        armedDigit: _numberFirst ? _armedDigit ?? 0 : null,
                        onInputOptions: () async {
                          final action = await showModalBottomSheet<String>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (sheet) => MichiBottomSheet(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SwitchListTile(
                                      title: Text(sheet.t.game.numberFirst),
                                      value: _numberFirst,
                                      onChanged: (_) =>
                                          Navigator.pop(sheet, 'mode'),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.edit_note),
                                      title: Text(sheet.t.game.fillNotes),
                                      enabled: state.wrongCells.isEmpty,
                                      onTap: () =>
                                          Navigator.pop(sheet, 'notes'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          if (!mounted) return;
                          if (action == 'mode') {
                            setState(() {
                              _numberFirst = !_numberFirst;
                              _armedDigit = null;
                            });
                          } else if (action == 'notes') {
                            cubit.fillPencilNotes();
                          }
                        },
                        onDigit: (digit) {
                          if (_numberFirst) {
                            unawaited(HapticFeedback.selectionClick());
                            setState(() => _armedDigit = digit);
                          } else {
                            _place(cubit, digit);
                          }
                        },
                        onWhy: _whyAction(context, cubit, state),
                      );
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: MichiSpacing.sm,
                            ),
                            child: GameTopBar(
                              title: _gameTitle(context),
                              elapsed: cubit.elapsed,
                              paused: state.isPaused,
                              onBack: () async {
                                cubit.pause();
                                await cubit.flushPersistence();
                                if (context.mounted &&
                                    cubit.state.storageFailure == null) {
                                  await Navigator.of(context).maybePop();
                                }
                              },
                              onPause: state.isPaused
                                  ? cubit.resume
                                  : cubit.pause,
                            ),
                          ),
                          SizedBox(
                            height: compact ? MichiSpacing.sm : MichiSpacing.lg,
                          ),
                          if (state.isPaused)
                            _PausedSurface(
                              dimension: BoardGeometry(cellSize).size,
                              elapsed: cubit.elapsed,
                              onResume: cubit.resume,
                            )
                          else
                            SudokuBoardWidget(
                              view: BoardViewState.fromGame(
                                state,
                                armedDigit: _numberFirst && state.coach == null
                                    ? _armedDigit
                                    : null,
                              ),
                              cellSize: cellSize,
                              onCellTap: (cell) {
                                cubit.selectCell(cell);
                                if (_numberFirst &&
                                    _armedDigit != null &&
                                    state.coach == null &&
                                    !state.isGiven(cell) &&
                                    (state.board.isEmpty(cell) ||
                                        state.isWrong(cell))) {
                                  _place(cubit, _armedDigit!);
                                } else {
                                  unawaited(HapticFeedback.selectionClick());
                                }
                              },
                            ),
                          const SizedBox(height: MichiSpacing.sm),
                          Expanded(
                            child: state.isPaused
                                ? ExcludeSemantics(
                                    child: IgnorePointer(
                                      child: Opacity(
                                        opacity: 0.38,
                                        child: input,
                                      ),
                                    ),
                                  )
                                : state.coach != null
                                ? CoachPanel(
                                    model: CoachPresenter.present(
                                      context.t,
                                      state.coach!,
                                    ),
                                    onNext: cubit.requestNextHint,
                                    onDismiss: cubit.dismissHint,
                                    onApply: () {
                                      cubit.applyCoachResult();
                                      unawaited(
                                        cubit.state.status ==
                                                GameStatus.completed
                                            ? HapticFeedback.heavyImpact()
                                            : HapticFeedback.lightImpact(),
                                      );
                                    },
                                  )
                                : state.hintUnavailable != null
                                ? HintUnavailablePanel(
                                    reason: state.hintUnavailable!,
                                    onDismiss: cubit.dismissHint,
                                    onShowMistake: cubit.selectWrongCell,
                                  )
                                : input,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _gameTitle(BuildContext context) {
    if (_definition?.source == PuzzleSource.imported) {
      return context.t.scanner.importedTitle;
    }
    final kind = _isDaily
        ? context.t.game.dailyTitle
        : context.t.game.standardTitle;
    final difficulty = switch (_difficulty) {
      PuzzleDifficulty.easy => context.t.home.easy,
      PuzzleDifficulty.medium => context.t.home.medium,
      PuzzleDifficulty.advanced => context.t.home.advanced,
      PuzzleDifficulty.expert => context.t.home.expert,
      null => null,
    };
    return difficulty == null ? kind : '$kind · $difficulty';
  }

  Future<LearningRecommendation> _recommendAfterGame(GameState state) {
    final game = GameLearningEvidence(
      gameId: state.gameId,
      techniqueHelp: state.techniqueHelp,
      requiredTechniques: _definition?.requiredTechniques ?? const {},
    );
    final service =
        widget.recommendationService ??
        (widget.repository == null &&
                getIt.isRegistered<LearningRecommendationService>()
            ? getIt<LearningRecommendationService>()
            : null);
    if (service != null) return service.afterGame(game);
    return Future.value(
      const LearningRecommendationEngine().recommend(
        LearningProfileSnapshot(
          date: LocalDate.fromDateTime(
            (widget.clock ?? SystemGameClock()).now(),
          ),
          techniqueProgress: const {},
          recentNormalGames: const [],
        ),
        justFinished: game,
      ),
    );
  }

  VoidCallback? _whyAction(
    BuildContext context,
    GameCubit cubit,
    GameState state,
  ) {
    final cell = state.selectedCell;
    if (cell == null || state.board.isEmpty(cell)) return null;
    final selection = cubit.whyForCell(cell);
    if (selection.availability != WhyAvailability.available &&
        selection.availability != WhyAvailability.given) {
      return null;
    }
    return () => context.router.push(
      WhyRoute(game: state, selection: selection, cell: cell),
    );
  }
}

final class _GameInputArea extends StatelessWidget {
  const _GameInputArea({
    required this.state,
    required this.compact,
    required this.onUndo,
    required this.onErase,
    required this.onToggleNotes,
    required this.armedDigit,
    required this.onInputOptions,
    required this.onHint,
    required this.onDigit,
    required this.onWhy,
  });

  final GameState state;
  final bool compact;
  final VoidCallback onUndo;
  final VoidCallback onErase;
  final VoidCallback onToggleNotes;
  final int? armedDigit;
  final VoidCallback onInputOptions;
  final VoidCallback onHint;
  final ValueChanged<int> onDigit;
  final VoidCallback? onWhy;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: MichiSpacing.sm),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GameControls(
          state: state,
          onUndo: onUndo,
          onErase: onErase,
          onToggleNotes: onToggleNotes,
          onHint: onHint,
        ),
        SudokuKeypad(
          armedDigit: armedDigit,
          state: state,
          compact: compact,
          onDigit: onDigit,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                state.notesMode
                    ? context.t.game.notesModeOn
                    : context.t.game.mistakes(count: state.mistakes),
                style: MichiTypography.meta.copyWith(
                  color: state.wrongCells.isEmpty
                      ? MichiColors.textSecondary
                      : MichiColors.error,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            IconButton(
              tooltip: context.t.game.inputOptions,
              onPressed: onInputOptions,
              icon: Icon(
                armedDigit == null ? Icons.tune : Icons.pin_outlined,
                color: MichiColors.indigo,
              ),
            ),
            if (onWhy != null) ...[
              const SizedBox(width: MichiSpacing.sm),
              TextButton(
                key: const ValueKey('why-action'),
                onPressed: onWhy,
                child: Text(context.t.why.title),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}

final class _PausedSurface extends StatelessWidget {
  const _PausedSurface({
    required this.dimension,
    required this.elapsed,
    required this.onResume,
  });

  final double dimension;
  final Duration elapsed;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: dimension,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: MichiColors.cream,
        borderRadius: BorderRadius.circular(MichiRadius.control),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.t.game.pausedTitle, style: MichiTypography.heading),
            const SizedBox(height: MichiSpacing.sm),
            Text(
              context.t.game.pausedAt(time: _formatElapsed(elapsed)),
              style: MichiTypography.secondary,
            ),
            const SizedBox(height: MichiSpacing.xl),
            MichiButton(label: context.t.game.resume, onPressed: onResume),
          ],
        ),
      ),
    ),
  );
}

final class _CompletedSurface extends StatelessWidget {
  const _CompletedSurface({
    required this.state,
    required this.elapsed,
    required this.puzzleTitle,
    required this.isDaily,
    required this.recommendation,
    required this.onContinue,
    required this.onHome,
  });

  final GameState state;
  final Duration elapsed;
  final String puzzleTitle;
  final bool isDaily;
  final LearningRecommendation? recommendation;
  final VoidCallback? onContinue;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: MichiColors.indigo,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(MichiRadius.hero),
              ),
            ),
            child: SizedBox(
              height: math.max(320, constraints.maxHeight * 0.49),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      tooltip: context.t.game.backHome,
                      onPressed: onHome,
                      icon: const Icon(Icons.close, color: MichiColors.ivory),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          MichiMascot.assetFor(MichiMascotState.celebrating),
                          width: math.min(constraints.maxWidth - 48, 400),
                          fit: BoxFit.contain,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                    Text(
                      context.t.game.completeTitle,
                      style: MichiTypography.display.copyWith(
                        color: MichiColors.ivory,
                      ),
                    ),
                    const SizedBox(height: MichiSpacing.sm),
                    Row(
                      children: [
                        Text(
                          _formatElapsed(elapsed),
                          style: MichiTypography.heading.copyWith(
                            color: MichiColors.ivory,
                          ),
                        ),
                        const SizedBox(width: MichiSpacing.md),
                        Expanded(
                          child: Text(
                            puzzleTitle,
                            style: MichiTypography.secondary.copyWith(
                              color: MichiColors.ivory,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _CompletionMetric(
                      value: state.correctEditableCells,
                      label: context.t.game.completionLogic,
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: MichiColors.hairline,
                    ),
                    _CompletionMetric(
                      value: state.mistakes,
                      label: context.t.game.completionMistakes,
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: MichiColors.hairline,
                    ),
                    _CompletionMetric(
                      value: state.hintsRequested,
                      label: context.t.game.completionHints,
                    ),
                  ],
                ),
                const Divider(height: MichiSpacing.xxl),
                Text(context.t.game.completeBody, style: MichiTypography.body),
                if (isDaily) ...[
                  const SizedBox(height: MichiSpacing.lg),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: MichiColors.indigo,
                        child: Icon(
                          Icons.pets,
                          size: 15,
                          color: MichiColors.ivory,
                        ),
                      ),
                      const SizedBox(width: MichiSpacing.sm),
                      Text(
                        context.t.game.dailyStampEarned,
                        style: MichiTypography.body.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
                if (recommendation case final recommended?) ...[
                  const Divider(height: MichiSpacing.xxl),
                  InkWell(
                    key: const ValueKey('post-game-next-step'),
                    onTap: onContinue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: MichiSpacing.sm,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  RecommendationCopy.action(
                                    context.t,
                                    recommended,
                                  ),
                                  style: MichiTypography.body.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  RecommendationCopy.detail(
                                    context.t,
                                    recommended,
                                  ),
                                  style: MichiTypography.secondary,
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: MichiSpacing.xl),
                MichiButton(
                  label: onContinue == null
                      ? context.t.game.backHome
                      : context.t.common.continueLabel,
                  onPressed: onContinue ?? onHome,
                ),
                if (onContinue != null)
                  TextButton(
                    onPressed: onHome,
                    child: Text(context.t.game.backHome),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

final class _CompletionMetric extends StatelessWidget {
  const _CompletionMetric({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$value', style: MichiTypography.functionalTitle),
        Text(label, style: MichiTypography.secondary),
      ],
    ),
  );
}

String _formatElapsed(Duration elapsed) =>
    '${elapsed.inMinutes.toString().padLeft(2, '0')}:'
    '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';

/// Approved Game loading state: the board's shape, a quiet progress line and
/// an inactive keypad, so opening a puzzle never looks like a frozen screen.
final class _GameSkeleton extends StatelessWidget {
  const _GameSkeleton();

  @override
  Widget build(BuildContext context) => SafeArea(
    child: MichiContentFrame(
      expandedMaxHeight: 960,
      expandedAlignment: Alignment.topCenter,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact =
              MichiLayout.classify(MediaQuery.sizeOf(context).width) ==
              MichiWindowClass.compact;
          final cell = ((constraints.maxWidth - 38) / 9)
              .floor()
              .clamp(28, compact ? 44 : 52)
              .toDouble();
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
              const SizedBox(height: MichiSpacing.sm),
              ExcludeSemantics(
                child: CustomPaint(
                  size: Size.square(cell * 9),
                  painter: const _EmptyBoardPainter(),
                ),
              ),
              const SizedBox(height: MichiSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox.square(
                    dimension: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: MichiColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: MichiSpacing.sm),
                  Text(
                    context.t.game.loading,
                    style: MichiTypography.secondary,
                  ),
                ],
              ),
              const Spacer(),
              ExcludeSemantics(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var digit = 1; digit <= 9; digit++)
                      Text(
                        '$digit',
                        style: MichiTypography.heading.copyWith(
                          fontSize: 26,
                          color: MichiColors.disabledBackground,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: MichiSpacing.xxl),
            ],
          );
        },
      ),
    ),
  );
}

final class _EmptyBoardPainter extends CustomPainter {
  const _EmptyBoardPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 9;
    canvas.drawRect(Offset.zero & size, Paint()..color = MichiColors.ivory);
    final thin = Paint()
      ..color = MichiColors.boardCellLine
      ..strokeWidth = 1;
    final thick = Paint()
      ..color = MichiColors.boardBoxLine
      ..strokeWidth = 2;
    for (var line = 0; line <= 9; line++) {
      final position = line * cell;
      final paint = line % 3 == 0 ? thick : thin;
      canvas
        ..drawLine(Offset(position, 0), Offset(position, size.height), paint)
        ..drawLine(Offset(0, position), Offset(size.width, position), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _EmptyBoardPainter oldDelegate) => false;
}
