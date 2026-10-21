import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_controls.dart';
import 'package:michi_mobile/features/game/presentation/widgets/game_top_bar.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_keypad.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class GamePage extends StatefulWidget {
  const GamePage({this.puzzle, this.cubit, super.key});

  /// Optional input keeps the route ready for future puzzle sources.
  final SudokuPuzzle? puzzle;

  /// Supplied by widget tests; normal navigation uses the composition root.
  final GameCubit? cubit;

  @override
  State<GamePage> createState() => _GamePageState();
}

final class _GamePageState extends State<GamePage> {
  late final GameCubit _cubit;
  late final Timer _timer;
  Duration _elapsed = Duration.zero;
  bool _paused = false;

  @override
  void initState() {
    super.initState();
    _cubit =
        widget.cubit ??
        GameCubit(
          puzzle: widget.puzzle ?? DemoPuzzle.standard,
          exactSolver: getIt<ExactSolver>(),
          humanSolver: getIt<HumanSolver>(),
          coachEngine: getIt<CoachEngine>(),
        );
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _paused || _cubit.state.status == GameStatus.completed) {
        return;
      }
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    if (widget.cubit == null) unawaited(_cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _cubit,
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
            // Reserve space for controls and keypad on short viewports.
            final heightCell = ((constraints.maxHeight - 220) / 9)
                .floor()
                .clamp(36, 44)
                .toDouble();
            final cellSize = math.min(widthCell, heightCell);
            return BlocBuilder<GameCubit, GameState>(
              builder: (context, state) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MichiSpacing.sm,
                    ),
                    child: GameTopBar(
                      elapsed: _elapsed,
                      paused: _paused,
                      onBack: () => Navigator.of(context).maybePop(),
                      onPause: () => setState(() => _paused = !_paused),
                    ),
                  ),
                  if (_paused)
                    Expanded(
                      child: _PausedSurface(
                        onResume: () => setState(() => _paused = false),
                      ),
                    )
                  else ...[
                    SizedBox(
                      height: compact ? MichiSpacing.sm : MichiSpacing.lg,
                    ),
                    SudokuBoardWidget(
                      view: BoardViewState.fromGame(state),
                      cellSize: cellSize,
                      onCellTap: _cubit.selectCell,
                    ),
                    const SizedBox(height: MichiSpacing.sm),
                    Expanded(
                      child: state.status == GameStatus.completed
                          ? const _CompletedSurface()
                          : state.coach != null
                          ? CoachPanel(
                              model: CoachPresenter.present(
                                context.t,
                                state.coach!,
                              ),
                              onNext: _cubit.requestNextHint,
                              onDismiss: _cubit.dismissHint,
                              onApply: _cubit.applyCoachResult,
                            )
                          : state.hintUnavailable != null
                          ? HintUnavailablePanel(
                              reason: state.hintUnavailable!,
                              onDismiss: _cubit.dismissHint,
                              onShowMistake: _cubit.selectWrongCell,
                            )
                          : _GameInputArea(
                              state: state,
                              compact: compact,
                              onUndo: _cubit.undo,
                              onErase: _cubit.erase,
                              onToggleNotes: _cubit.toggleNotesMode,
                              onHint: _cubit.requestHint,
                              onDigit: _cubit.enterDigit,
                            ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
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
  const _PausedSurface({required this.onResume});

  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.t.game.pausedTitle, style: MichiTypography.heading),
        const SizedBox(height: MichiSpacing.xl),
        MichiButton(label: context.t.game.resume, onPressed: onResume),
      ],
    ),
  );
}

final class _CompletedSurface extends StatelessWidget {
  const _CompletedSurface();

  @override
  Widget build(BuildContext context) => MichiBottomSheet(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.t.game.completeTitle, style: MichiTypography.heading),
        const SizedBox(height: MichiSpacing.sm),
        Text(context.t.game.completeBody, style: MichiTypography.secondary),
        const SizedBox(height: MichiSpacing.xl),
        MichiButton(
          label: context.t.game.backHome,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ],
    ),
  );
}
