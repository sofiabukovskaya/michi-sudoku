import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_controls.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_top_bar.dart';
import 'package:michi_mobile/features/game/presentation/widgets/post_game_technique_feedback.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_geometry.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_keypad.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
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
  final bool restore;

  @override
  State<GamePage> createState() => _GamePageState();
}

final class _GamePageState extends State<GamePage> with WidgetsBindingObserver {
  GameCubit? _cubit;
  Timer? _ticker;
  bool _loading = true;
  bool _loadFailed = false;
  PuzzleDifficulty? _difficulty;
  bool _isDaily = false;
  PuzzleDefinition? _definition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _definition = widget.definition;
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
        cubit = GameCubit(
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
        try {
          cubit = GameCubit.restore(
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
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted &&
          !cubit.state.isPaused &&
          cubit.state.status != GameStatus.completed) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycle) {
    if (lifecycle == AppLifecycleState.inactive ||
        lifecycle == AppLifecycleState.paused ||
        lifecycle == AppLifecycleState.detached) {
      final cubit = _cubit;
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

  @override
  Widget build(BuildContext context) {
    final cubit = _cubit;
    if (cubit == null) {
      return Scaffold(
        backgroundColor: MichiPalette.of(context).paper,
        body: Center(
          child: _loading
              ? Text(context.t.game.loading, style: MichiTypography.secondary)
              : _loadFailed
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxHeight < 710;
                final widthCell = ((constraints.maxWidth - 38) / 9)
                    .floor()
                    .clamp(36, 44)
                    .toDouble();
                final heightCell = ((constraints.maxHeight - 260) / 9)
                    .floor()
                    .clamp(36, 44)
                    .toDouble();
                final cellSize = math.min(widthCell, heightCell);
                return BlocBuilder<GameCubit, GameState>(
                  builder: (context, state) {
                    if (state.status == GameStatus.completed) {
                      return _CompletedSurface(
                        state: state,
                        elapsed: cubit.elapsed,
                        puzzleTitle: _gameTitle(context),
                        requiredTechniques: _isDaily
                            ? const {}
                            : _definition?.requiredTechniques ?? const {},
                        onHome: () async {
                          await cubit.flushPersistence();
                          if (context.mounted &&
                              cubit.state.storageFailure == null) {
                            await Navigator.of(context).maybePop();
                          }
                        },
                      );
                    }
                    final input = _GameInputArea(
                      state: state,
                      compact: compact,
                      onUndo: cubit.undo,
                      onErase: cubit.erase,
                      onToggleNotes: cubit.toggleNotesMode,
                      onHint: cubit.requestHint,
                      onDigit: cubit.enterDigit,
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
                            view: BoardViewState.fromGame(state),
                            cellSize: cellSize,
                            onCellTap: cubit.selectCell,
                          ),
                        const SizedBox(height: MichiSpacing.sm),
                        Expanded(
                          child: state.isPaused
                              ? ExcludeSemantics(
                                  child: IgnorePointer(
                                    child: Opacity(opacity: 0.38, child: input),
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
                                  onApply: cubit.applyCoachResult,
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
    );
  }

  String _gameTitle(BuildContext context) {
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
}

final class _GameInputArea extends StatelessWidget {
  const _GameInputArea({
    required this.state,
    required this.compact,
    required this.onUndo,
    required this.onErase,
    required this.onToggleNotes,
    required this.onHint,
    required this.onDigit,
  });

  final GameState state;
  final bool compact;
  final VoidCallback onUndo;
  final VoidCallback onErase;
  final VoidCallback onToggleNotes;
  final VoidCallback onHint;
  final ValueChanged<int> onDigit;

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
        SudokuKeypad(state: state, compact: compact, onDigit: onDigit),
        Text(
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
    required this.requiredTechniques,
    required this.onHome,
  });

  final GameState state;
  final Duration elapsed;
  final String puzzleTitle;
  final Set<SudokuTechnique> requiredTechniques;
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
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomPaint(
                          size: Size.square(130),
                          painter: _CompletedGridPainter(),
                        ),
                        const SizedBox(width: MichiSpacing.lg),
                        Image.asset(
                          'assets/images/coach_mascot.png',
                          height: 148,
                          excludeFromSemantics: true,
                        ),
                      ],
                    ),
                    const Spacer(),
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
                    _CompletionMetric(
                      value: state.mistakes,
                      label: context.t.game.completionMistakes,
                    ),
                    _CompletionMetric(
                      value: state.hintsRequested,
                      label: context.t.game.completionHints,
                    ),
                  ],
                ),
                const Divider(height: MichiSpacing.xxl),
                Text(context.t.game.completeBody, style: MichiTypography.body),
                const SizedBox(height: MichiSpacing.xl),
                PostGameTechniqueFeedback(
                  requiredTechniques: requiredTechniques,
                  techniqueHelp: state.techniqueHelp,
                ),
                const SizedBox(height: MichiSpacing.xl),
                MichiButton(label: context.t.game.backHome, onPressed: onHome),
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

final class _CompletedGridPainter extends CustomPainter {
  const _CompletedGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..rotate(-0.08);
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(8),
    );
    canvas.drawRRect(rect, Paint()..color = MichiColors.ivory);
    final line = Paint()
      ..color = MichiColors.boardBoxLine
      ..strokeWidth = 1;
    for (var part = 1; part < 3; part++) {
      final position = size.width * part / 3;
      canvas
        ..drawLine(Offset(position, 0), Offset(position, size.height), line)
        ..drawLine(Offset(0, position), Offset(size.width, position), line);
    }
    for (var row = 0; row < 9; row++) {
      for (var column = 0; column < 9; column++) {
        canvas.drawCircle(
          Offset(
            (column + 0.5) * size.width / 9,
            (row + 0.5) * size.height / 9,
          ),
          1.8,
          Paint()..color = MichiColors.indigo,
        );
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CompletedGridPainter oldDelegate) => false;
}

String _formatElapsed(Duration elapsed) =>
    '${elapsed.inMinutes.toString().padLeft(2, '0')}:'
    '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
