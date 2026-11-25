import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_digit_pad.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/application/scanner_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

@RoutePage()
final class ScannerPage extends StatefulWidget {
  const ScannerPage({required this.cubit, this.beforeImport, super.key});

  final ScannerCubit cubit;
  final Future<bool> Function()? beforeImport;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

final class _ScannerPageState extends State<ScannerPage>
    with WidgetsBindingObserver {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(widget.cubit.initializeCamera());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      unawaited(widget.cubit.suspendCamera());
    } else if (state == AppLifecycleState.resumed) {
      unawaited(widget.cubit.resumeCamera());
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    WidgetsBinding.instance.removeObserver(this);
    unawaited(widget.cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: widget.cubit,
    child: BlocListener<ScannerCubit, ScannerState>(
      listenWhen: (previous, current) =>
          (previous.phase != ScannerPhase.imported &&
              current.phase == ScannerPhase.imported) ||
          (current.review?.issue != null &&
              previous.review?.issue != current.review?.issue),
      listener: (context, state) async {
        if (state.review?.issue != null && _scroll.hasClients) {
          if (MediaQuery.disableAnimationsOf(context)) {
            _scroll.jumpTo(0);
          } else {
            await _scroll.animateTo(
              0,
              duration: MichiMotion.standard,
              curve: MichiMotion.curve,
            );
          }
          return;
        }
        final puzzle = state.imported;
        if (puzzle != null) {
          await context.router.push(GameRoute(definition: puzzle));
          if (context.mounted) await context.router.maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: MichiColors.paper,
        body: SafeArea(
          child: MichiContentFrame(
            child: BlocBuilder<ScannerCubit, ScannerState>(
              builder: (context, state) => Column(
                children: [
                  _Header(onBack: () => context.router.maybePop()),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scroll,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                      child: MichiReveal(
                        key: ValueKey(
                          state.phase == ScannerPhase.validating
                              ? ScannerPhase.review
                              : state.phase,
                        ),
                        child: switch (state.phase) {
                          ScannerPhase.capture => _Capture(
                            state: state,
                            cubit: widget.cubit,
                          ),
                          ScannerPhase.processing => const _Processing(),
                          ScannerPhase.review ||
                          ScannerPhase.validating => _Review(
                            beforeImport: widget.beforeImport,
                            state: state,
                            cubit: widget.cubit,
                          ),
                          ScannerPhase.failure => _Failure(
                            state: state,
                            cubit: widget.cubit,
                          ),
                          ScannerPhase.imported => const SizedBox.shrink(),
                        },
                      ),
                    ),
                  ),
                  if (state.phase == ScannerPhase.review ||
                      state.phase == ScannerPhase.validating)
                    _ReviewActions(
                      beforeImport: widget.beforeImport,
                      state: state,
                      cubit: widget.cubit,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

final class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 24, 0),
    child: Row(
      children: [
        IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        const SizedBox(width: MichiSpacing.sm),
        Text(context.t.scanner.title, style: MichiTypography.heading),
      ],
    ),
  );
}

final class _Capture extends StatelessWidget {
  const _Capture({required this.state, required this.cubit});

  final ScannerState state;
  final ScannerCubit cubit;

  @override
  Widget build(BuildContext context) {
    final access = state.cameraAccess;
    final controller = cubit.imageSource.controller;
    final ready =
        access == CameraAccess.granted &&
        controller != null &&
        controller.value.isInitialized;
    final message = switch (access) {
      CameraAccess.notRequested => context.t.scanner.permissionIntro,
      CameraAccess.denied => context.t.scanner.permissionDenied,
      CameraAccess.settingsRequired => context.t.scanner.permissionSettings,
      CameraAccess.unavailable => context.t.scanner.noCamera,
      CameraAccess.granted => context.t.scanner.frameGuide,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.t.scanner.intro, style: MichiTypography.secondary),
        const SizedBox(height: MichiSpacing.lg),
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MichiRadius.control),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (ready)
                  CameraPreview(controller)
                else
                  const ColoredBox(
                    color: MichiColors.cream,
                    child: Center(
                      child: Icon(
                        Icons.grid_on_outlined,
                        size: 80,
                        color: MichiColors.indigo,
                      ),
                    ),
                  ),
                // This guide only helps framing; it is not a detected grid.
                IgnorePointer(
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.82,
                      heightFactor: 0.82,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ready
                                ? MichiColors.ivory
                                : MichiColors.indigo,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(
                            MichiRadius.small,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: MichiSpacing.md),
        Text(
          message,
          style: MichiTypography.secondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: MichiSpacing.lg),
        if (ready)
          MichiButton(
            key: const ValueKey('scanner-shutter'),
            label: context.t.scanner.shutter,
            onPressed: () => unawaited(cubit.capture()),
          )
        else if (access == CameraAccess.settingsRequired)
          MichiButton(
            label: context.t.scanner.openSettings,
            onPressed: () => unawaited(cubit.openSettings()),
          )
        else if (access != CameraAccess.unavailable)
          MichiButton(
            label: context.t.scanner.openCamera,
            onPressed: () => unawaited(cubit.requestCamera()),
          ),
        const SizedBox(height: MichiSpacing.sm),
        MichiButton(
          key: const ValueKey('scanner-photo'),
          label: context.t.scanner.choosePhoto,
          variant: MichiButtonVariant.secondary,
          onPressed: () => unawaited(cubit.selectPhoto()),
        ),
      ],
    );
  }
}

final class _Processing extends StatelessWidget {
  const _Processing();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 96),
    child: Column(
      children: [
        const CircularProgressIndicator(color: MichiColors.indigo),
        const SizedBox(height: MichiSpacing.xl),
        Text(context.t.scanner.processing, style: MichiTypography.heading),
      ],
    ),
  );
}

final class _Failure extends StatelessWidget {
  const _Failure({required this.state, required this.cubit});

  final ScannerState state;
  final ScannerCubit cubit;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: MichiSpacing.xl),
      MichiBanner(
        message: _failureCopy(context.t, state.failure),
        variant: MichiBannerVariant.error,
      ),
      const SizedBox(height: MichiSpacing.xl),
      MichiButton(
        label: context.t.scanner.rescan,
        onPressed: cubit.rescan,
      ),
      const SizedBox(height: MichiSpacing.sm),
      MichiButton(
        label: context.t.scanner.choosePhoto,
        variant: MichiButtonVariant.secondary,
        onPressed: () => unawaited(cubit.selectPhoto()),
      ),
    ],
  );
}

String _failureCopy(Translations t, ScanFailureKind? kind) => switch (kind) {
  ScanFailureKind.noGridFound => t.scanner.noGridFound,
  ScanFailureKind.invalidGeometry => t.scanner.invalidGeometry,
  ScanFailureKind.segmentationFailure => t.scanner.segmentationFailure,
  ScanFailureKind.recognitionFailure => t.scanner.recognitionFailure,
  ScanFailureKind.imageDecodeFailure || null => t.scanner.imageDecodeFailure,
};

final class _Review extends StatelessWidget {
  const _Review({required this.state, required this.cubit, this.beforeImport});
  final Future<bool> Function()? beforeImport;

  final ScannerState state;
  final ScannerCubit cubit;

  @override
  Widget build(BuildContext context) {
    final review = state.review!;
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.scanner.reviewTitle, style: MichiTypography.editorialTitle),
        const SizedBox(height: MichiSpacing.sm),
        Text(t.scanner.reviewBody, style: MichiTypography.secondary),
        const SizedBox(height: MichiSpacing.md),
        if (review.lowConfidenceCount > 0)
          MichiBanner(
            message: t.scanner.lowConfidenceCount(
              count: review.lowConfidenceCount,
            ),
          ),
        if (review.lowConfidenceCount > 0)
          const SizedBox(height: MichiSpacing.md),
        if (review.conflicts.isNotEmpty)
          // Re-reveals when "I'm stuck" or Continue is blocked by conflicts,
          // so the tap visibly answers with what to fix first.
          MichiReveal(
            key: ValueKey(('conflicts', review.issue)),
            child: MichiBanner(
              message: t.scanner.duplicateClues,
              variant: MichiBannerVariant.error,
            ),
          ),
        if (review.conflicts.isNotEmpty)
          const SizedBox(height: MichiSpacing.md),
        if (review.issue != null &&
            review.issue != ScannerReviewIssue.duplicateClues)
          MichiBanner(
            message: switch (review.issue!) {
              ScannerReviewIssue.duplicateClues => t.scanner.duplicateClues,
              ScannerReviewIssue.noSolution => t.scanner.noSolution,
              ScannerReviewIssue.multipleSolutions =>
                t.scanner.multipleSolutions,
              ScannerReviewIssue.validation => t.scanner.validationFailure,
              ScannerReviewIssue.storage => t.scanner.storageFailure,
              ScannerReviewIssue.completed => t.scanner.completed,
              ScannerReviewIssue.unsupportedStep => t.scanner.noStep,
            },
            variant:
                review.issue == ScannerReviewIssue.unsupportedStep ||
                    review.issue == ScannerReviewIssue.completed
                ? MichiBannerVariant.information
                : MichiBannerVariant.error,
          ),
        const SizedBox(height: MichiSpacing.md),
        Center(
          child: _ReviewBoard(review: review, onSelect: cubit.selectCell),
        ),
        const SizedBox(height: MichiSpacing.lg),
        // Always present, so actions below never jump under the finger;
        // dimmed until a cell is chosen.
        _DigitInput(
          current: review.selectedIndex == null
              ? 0
              : review.board.values[review.selectedIndex!],
          onDigit: review.selectedIndex == null ? null : cubit.editSelected,
        ),
        const SizedBox(height: MichiSpacing.lg),
      ],
    );
  }
}

/// Review's actions stay pinned below the scrolling board, so fixing a
/// digit (which can remove a banner) never moves a button under the finger.
final class _ReviewActions extends StatelessWidget {
  const _ReviewActions({
    required this.beforeImport,
    required this.state,
    required this.cubit,
  });

  final Future<bool> Function()? beforeImport;
  final ScannerState state;
  final ScannerCubit cubit;

  @override
  Widget build(BuildContext context) {
    final review = state.review!;
    final t = context.t;
    final checking = state.phase == ScannerPhase.validating;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MichiLayout.cardGutter,
        MichiSpacing.sm,
        MichiLayout.cardGutter,
        MichiSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Same buttons in the same places while MICHI checks the board;
          // they disable instead of disappearing.
          MichiButton(
            key: const ValueKey('scanner-confirm'),
            label: checking ? t.scanner.checking : t.scanner.confirm,
            isLoading: checking,
            onPressed: checking
                ? null
                : () async {
                    if (await beforeImport?.call() == false ||
                        !context.mounted) {
                      return;
                    }
                    await cubit.confirm();
                  },
          ),
          const SizedBox(height: MichiSpacing.sm),
          MichiButton(
            key: const ValueKey('scanner-stuck'),
            label: t.scanner.stuck,
            variant: MichiButtonVariant.secondary,
            onPressed: checking
                ? null
                : () async {
                    final plan = await cubit.nextHint();
                    if (plan == null) {
                      unawaited(HapticFeedback.mediumImpact());
                      return;
                    }
                    if (!context.mounted) return;
                    await Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (_) =>
                            _ScanCoach(board: review.board, plan: plan),
                      ),
                    );
                  },
          ),
          const SizedBox(height: MichiSpacing.xs),
          // Discards corrections, so it is the quietest action.
          MichiButton(
            key: const ValueKey('scanner-rescan'),
            label: t.scanner.rescan,
            variant: MichiButtonVariant.text,
            onPressed: checking ? null : cubit.rescan,
          ),
        ],
      ),
    );
  }
}

final class _ScanCoach extends StatefulWidget {
  const _ScanCoach({required this.board, required this.plan});
  final SudokuBoard board;
  final CoachPlan plan;
  @override
  State<_ScanCoach> createState() => _ScanCoachState();
}

final class _ScanCoachState extends State<_ScanCoach> {
  int step = 0;
  late final position = HumanSolverState.initial(widget.board);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: MichiContentFrame(
        expandedMaxHeight: 960,
        expandedAlignment: Alignment.topCenter,
        child: LayoutBuilder(
          builder: (context, bounds) {
            final compact =
                MichiLayout.classify(MediaQuery.sizeOf(context).width) ==
                MichiWindowClass.compact;
            final cell = math
                .min((bounds.maxWidth - 32) / 9, bounds.maxHeight * .53 / 9)
                .clamp(24.0, compact ? 44.0 : 52.0);
            final panel = compact
                ? bounds.maxHeight * .35
                : math.min<double>(bounds.maxHeight * .35, 300);
            void close() => Navigator.of(context).pop();
            final technique = widget.plan.technique;
            return Column(
              children: [
                _Header(onBack: close),
                Expanded(
                  child: Center(
                    child: SudokuBoardWidget(
                      view: BoardViewState.educational(
                        state: position,
                        coachHint: widget.plan.hints[step],
                      ),
                      cellSize: cell,
                      onCellTap: null,
                    ),
                  ),
                ),
                SizedBox(
                  height: panel,
                  child: CoachPanel(
                    model: CoachPresenter.presentPlan(
                      context.t,
                      widget.plan,
                      step,
                    ),
                    readOnlyResult: step == widget.plan.hints.length - 1,
                    // Scanner → stuck → Coach → the lesson behind the step.
                    onOpenLesson: TechniqueLessons.supported.contains(technique)
                        ? () => unawaited(
                            context.router.push(
                              TechniqueLessonRoute(technique: technique),
                            ),
                          )
                        : null,
                    onDismiss: close,
                    onApply: close,
                    onNext: () => setState(() => step++),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

final class _ReviewBoard extends StatelessWidget {
  const _ReviewBoard({required this.review, required this.onSelect});

  final ScannerReviewData review;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final side = math.min<double>(constraints.maxWidth, 430);
      // The frame is painted over the cells so all four edges stay visible.
      return Container(
        width: side,
        height: side,
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: MichiColors.boardBoxLine, width: 2),
          borderRadius: BorderRadius.circular(MichiRadius.control),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(MichiRadius.control),
          child: ColoredBox(
            color: MichiColors.ivory,
            child: Column(
              children: [
                for (var row = 0; row < 9; row++)
                  Expanded(
                    child: Row(
                      children: [
                        for (var column = 0; column < 9; column++)
                          Expanded(
                            child: _ReviewCell(
                              review: review,
                              cell: CellRef(row: row, column: column),
                              onTap: () => onSelect(row * 9 + column),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

final class _ReviewCell extends StatelessWidget {
  const _ReviewCell({
    required this.review,
    required this.cell,
    required this.onTap,
  });

  final ScannerReviewData review;
  final CellRef cell;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final digit = review.board.valueAt(cell);
    final low = review.needsReview(cell);
    final conflict = review.conflicts.contains(cell);
    final selected = review.selectedIndex == cell.index;
    final t = context.t;
    final value = digit == 0
        ? t.scanner.empty
        : '${t.scanner.recognized} $digit';
    final flags = [
      if (low) t.scanner.needsReview,
      if (conflict) t.scanner.conflict,
      if (selected) t.scanner.selected,
    ];
    return Semantics(
      button: true,
      selected: selected,
      label:
          '${t.game.row} ${cell.row + 1}, ${t.game.column} ${cell.column + 1}, '
          '$value${flags.isEmpty ? '' : ', ${flags.join(', ')}'}',
      child: InkWell(
        key: ValueKey('scan-cell-${cell.index}'),
        onTap: onTap,
        child: AnimatedContainer(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : MichiMotion.quick,
          // Selection reads on top of conflict and review tints.
          foregroundDecoration: selected
              ? BoxDecoration(
                  border: Border.all(color: MichiColors.indigo, width: 2.5),
                )
              : null,
          decoration: BoxDecoration(
            color: conflict
                ? MichiColors.errorTint
                : selected
                ? MichiColors.boardSelected
                : low
                ? MichiColors.coralTint
                : MichiColors.ivory,
            border: Border(
              right: BorderSide(
                color: columnBorder(cell.column),
                width: cell.column % 3 == 2 ? 2 : 0.7,
              ),
              bottom: BorderSide(
                color: rowBorder(cell.row),
                width: cell.row % 3 == 2 ? 2 : 0.7,
              ),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  digit == 0 ? '' : '$digit',
                  style: MichiTypography.heading.copyWith(
                    color: conflict
                        ? MichiColors.error
                        : MichiColors.textPrimary,
                  ),
                ),
              ),
              if (low || conflict)
                Positioned(
                  right: 2,
                  top: 0,
                  child: Text(
                    conflict ? '!' : '?',
                    style: MichiTypography.meta.copyWith(
                      color: conflict
                          ? MichiColors.error
                          : MichiColors.coralText,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color columnBorder(int column) =>
      column % 3 == 2 ? MichiColors.boardBoxLine : MichiColors.boardCellLine;
  Color rowBorder(int row) =>
      row % 3 == 2 ? MichiColors.boardBoxLine : MichiColors.boardCellLine;
}

final class _DigitInput extends StatelessWidget {
  const _DigitInput({required this.current, required this.onDigit});

  final int current;
  final ValueChanged<int>? onDigit;

  @override
  Widget build(BuildContext context) {
    final edit = onDigit;
    return AnimatedOpacity(
      opacity: edit == null ? 0.4 : 1,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : MichiMotion.quick,
      child: IgnorePointer(
        ignoring: edit == null,
        child: Column(
          children: [
            MichiDigitPad(
              digits: const [1, 2, 3, 4, 5, 6, 7, 8, 9],
              selected: {if (current != 0) current},
              keyFor: (digit) => 'scan-digit-$digit',
              onDigit: (digit) => edit?.call(digit),
            ),
            TextButton.icon(
              key: const ValueKey('scan-clear'),
              onPressed: edit == null ? null : () => edit(0),
              icon: const Icon(Icons.backspace_outlined),
              label: Text(context.t.scanner.clear),
            ),
          ],
        ),
      ),
    );
  }
}
