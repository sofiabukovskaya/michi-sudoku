import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/application/scanner_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

@RoutePage()
final class ScannerPage extends StatefulWidget {
  const ScannerPage({required this.cubit, super.key});

  final ScannerCubit cubit;

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

final class _ScannerPageState extends State<ScannerPage>
    with WidgetsBindingObserver {
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
    WidgetsBinding.instance.removeObserver(this);
    unawaited(widget.cubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: widget.cubit,
    child: BlocListener<ScannerCubit, ScannerState>(
      listenWhen: (previous, current) =>
          previous.phase != ScannerPhase.imported &&
          current.phase == ScannerPhase.imported,
      listener: (context, state) async {
        final puzzle = state.imported;
        if (puzzle != null) {
          await context.router.push(GameRoute(definition: puzzle));
          if (context.mounted) await context.router.maybePop();
        }
      },
      child: Scaffold(
        backgroundColor: MichiColors.paper,
        body: SafeArea(
          child: BlocBuilder<ScannerCubit, ScannerState>(
            builder: (context, state) => Column(
              children: [
                _Header(onBack: () => context.router.maybePop()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: switch (state.phase) {
                      ScannerPhase.capture => _Capture(
                        state: state,
                        cubit: widget.cubit,
                      ),
                      ScannerPhase.processing => const _Processing(),
                      ScannerPhase.review || ScannerPhase.validating => _Review(
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
              ],
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
  const _Review({required this.state, required this.cubit});

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
          MichiBanner(
            message: t.scanner.duplicateClues,
            variant: MichiBannerVariant.error,
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
            },
            variant: MichiBannerVariant.error,
          ),
        const SizedBox(height: MichiSpacing.md),
        Center(
          child: _ReviewBoard(review: review, onSelect: cubit.selectCell),
        ),
        const SizedBox(height: MichiSpacing.lg),
        if (review.selectedIndex != null) ...[
          _DigitInput(onDigit: cubit.editSelected),
          const SizedBox(height: MichiSpacing.lg),
        ],
        if (state.phase == ScannerPhase.validating)
          const Center(
            child: CircularProgressIndicator(color: MichiColors.indigo),
          )
        else
          MichiButton(
            key: const ValueKey('scanner-confirm'),
            label: t.scanner.confirm,
            onPressed: () => unawaited(cubit.confirm()),
          ),
        const SizedBox(height: MichiSpacing.sm),
        MichiButton(
          label: t.scanner.rescan,
          variant: MichiButtonVariant.secondary,
          onPressed: cubit.rescan,
        ),
      ],
    );
  }
}

final class _ReviewBoard extends StatelessWidget {
  const _ReviewBoard({required this.review, required this.onSelect});

  final ScannerReviewData review;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final side = math.min<double>(constraints.maxWidth, 430);
      return SizedBox.square(
        dimension: side,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: MichiColors.ivory,
            border: Border.all(color: MichiColors.boardBoxLine, width: 2),
          ),
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
        child: DecoratedBox(
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
  const _DigitInput({required this.onDigit});

  final ValueChanged<int> onDigit;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          for (var digit = 1; digit <= 9; digit++)
            SizedBox(
              width: 48,
              height: 48,
              child: OutlinedButton(
                key: ValueKey('scan-digit-$digit'),
                onPressed: () => onDigit(digit),
                child: Text('$digit'),
              ),
            ),
        ],
      ),
      TextButton.icon(
        key: const ValueKey('scan-clear'),
        onPressed: () => onDigit(0),
        icon: const Icon(Icons.backspace_outlined),
        label: Text(context.t.scanner.clear),
      ),
    ],
  );
}
