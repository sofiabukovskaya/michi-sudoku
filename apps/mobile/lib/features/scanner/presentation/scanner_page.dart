import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

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
import 'package:michi_mobile/features/feedback/domain/feedback_draft.dart';
import 'package:michi_mobile/features/feedback/presentation/feedback_link.dart';
import 'package:michi_mobile/features/game/presentation/widgets/coach_panel.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/board_view_state.dart';
import 'package:michi_mobile/features/game/presentation/widgets/sudoku_board/sudoku_board_widget.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/application/scanner_state.dart';
import 'package:michi_mobile/features/scanner/data/live_grid_watcher.dart';
import 'package:michi_mobile/features/scanner/domain/solution_check.dart';
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
                          ScannerPhase.chooseGrid => _ChooseGrid(
                            choice: state.gridChoice!,
                            cubit: widget.cubit,
                          ),
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
        _Viewfinder(
          controller: ready ? controller : null,
          onAutoCapture: (focus) => unawaited(cubit.capture(focus: focus)),
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
            onPressed: () => unawaited(
              cubit.capture(
                focus: _Viewfinder.focusFor(
                  _Viewfinder.aspectOf(context, controller),
                ),
              ),
            ),
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

/// The live camera at its true aspect ratio (never stretched), as large as
/// the screen allows, with a square scanning frame. The frame is the same
/// region the detector searches first, so what is framed is what is read.
final class _Viewfinder extends StatefulWidget {
  const _Viewfinder({required this.controller, required this.onAutoCapture});

  final CameraController? controller;

  /// Takes the photo once a framed puzzle has held still.
  final ValueChanged<ScanFocus> onAutoCapture;

  /// Frame side as a fraction of the preview's shorter side.
  static const frameFraction = 0.86;

  /// The frame in photo fractions for a preview of the given aspect
  /// (width / height). The preview shows the whole photo, so the mapping is
  /// direct; detection adds its own margin around it.
  static ScanFocus focusFor(double aspect) {
    final width = aspect >= 1 ? frameFraction / aspect : frameFraction;
    final height = aspect >= 1 ? frameFraction : frameFraction * aspect;
    return ScanFocus(
      left: (1 - width) / 2,
      top: (1 - height) / 2,
      right: (1 + width) / 2,
      bottom: (1 + height) / 2,
    );
  }

  /// Preview aspect (width / height) as shown; the plugin reports the
  /// sensor's landscape ratio.
  static double aspectOf(BuildContext context, CameraController? camera) {
    if (camera == null) return 3 / 4;
    final portrait = MediaQuery.orientationOf(context) == Orientation.portrait;
    return portrait ? 1 / camera.value.aspectRatio : camera.value.aspectRatio;
  }

  @override
  State<_Viewfinder> createState() => _ViewfinderState();
}

final class _ViewfinderState extends State<_Viewfinder> {
  late final LiveGridWatcher _watcher = LiveGridWatcher(
    onSteady: () {
      final focus = _focus;
      if (focus == null || !mounted) return;
      unawaited(HapticFeedback.mediumImpact());
      widget.onAutoCapture(focus);
    },
  );
  ScanFocus? _focus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(_Viewfinder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) _sync();
  }

  void _sync() {
    final camera = widget.controller;
    if (camera == null) {
      _focus = null;
      unawaited(_watcher.stop());
      return;
    }
    final focus = _Viewfinder.focusFor(_Viewfinder.aspectOf(context, camera));
    _focus = focus;
    unawaited(_watcher.start(camera, focus));
  }

  @override
  void dispose() {
    _watcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final camera = widget.controller;
      final portrait =
          MediaQuery.orientationOf(context) == Orientation.portrait;
      final aspect = _Viewfinder.aspectOf(context, camera);
      final maxHeight = math.max(
        240,
        MediaQuery.sizeOf(context).height * (portrait ? 0.62 : 0.72),
      );
      var width = constraints.maxWidth;
      var height = width / aspect;
      if (height > maxHeight) {
        height = maxHeight.toDouble();
        width = height * aspect;
      }
      return Center(
        child: SizedBox(
          width: width,
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MichiRadius.control),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (camera != null)
                  // Same aspect as the box, so nothing is stretched or cut.
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: CameraPreview(camera),
                    ),
                  )
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
                IgnorePointer(
                  child: ValueListenableBuilder<LiveGridState>(
                    valueListenable: _watcher.state,
                    builder: (context, live, _) => Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomPaint(
                          painter: _FramePainter(
                            live: camera != null,
                            fraction: _Viewfinder.frameFraction,
                            accent: switch (live) {
                              LiveGridState.searching => null,
                              LiveGridState.found => MichiColors.coral,
                              LiveGridState.steady => MichiColors.success,
                            },
                          ),
                        ),
                        if (camera != null && live != LiveGridState.searching)
                          Align(
                            alignment: const Alignment(0, 0.9),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: MichiColors.ivory,
                                borderRadius: BorderRadius.circular(
                                  MichiRadius.control,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: MichiSpacing.md,
                                  vertical: MichiSpacing.xs,
                                ),
                                child: Text(
                                  context.t.scanner.holdStill,
                                  style: MichiTypography.secondary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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

/// Dims everything outside the frame and marks its corners, so the target
/// area reads at a glance on any page. Painted once; no animation.
final class _FramePainter extends CustomPainter {
  const _FramePainter({
    required this.live,
    required this.fraction,
    this.accent,
  });

  final bool live;
  final double fraction;

  /// Corner colour while live framing sees a puzzle (found, then steady).
  final Color? accent;

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height) * fraction;
    final frame = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: side,
      height: side,
    );
    const radius = Radius.circular(MichiRadius.small);
    if (live) {
      canvas.drawPath(
        Path()
          ..fillType = PathFillType.evenOdd
          ..addRect(Offset.zero & size)
          ..addRRect(RRect.fromRectAndRadius(frame, radius)),
        Paint()..color = const Color(0x66000000),
      );
    }
    final base = live ? MichiColors.ivory : MichiColors.indigo;
    final color = accent ?? base;
    canvas.drawRRect(
      RRect.fromRectAndRadius(frame, radius),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = color.withValues(alpha: 0.6),
    );
    final arm = side * 0.12;
    final corner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = color;
    for (final (point, dx, dy) in [
      (frame.topLeft, 1.0, 1.0),
      (frame.topRight, -1.0, 1.0),
      (frame.bottomRight, -1.0, -1.0),
      (frame.bottomLeft, 1.0, -1.0),
    ]) {
      canvas.drawPath(
        Path()
          ..moveTo(point.dx, point.dy + dy * arm)
          ..lineTo(point.dx, point.dy)
          ..lineTo(point.dx + dx * arm, point.dy),
        corner,
      );
    }
  }

  @override
  bool shouldRepaint(_FramePainter oldDelegate) =>
      oldDelegate.live != live ||
      oldDelegate.fraction != fraction ||
      oldDelegate.accent != accent;
}

/// More than one puzzle in the photo: show them, the player taps one.
final class _ChooseGrid extends StatelessWidget {
  const _ChooseGrid({required this.choice, required this.cubit});

  final ScannerGridChoice choice;
  final ScannerCubit cubit;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.scanner.chooseTitle, style: MichiTypography.editorialTitle),
        const SizedBox(height: MichiSpacing.sm),
        Text(t.scanner.chooseBody, style: MichiTypography.secondary),
        const SizedBox(height: MichiSpacing.lg),
        _ChoicePhoto(choice: choice, onChoose: cubit.chooseGrid),
        const SizedBox(height: MichiSpacing.lg),
        for (var index = 0; index < choice.grids.length; index++) ...[
          MichiButton(
            key: ValueKey('scanner-choose-$index'),
            label: t.scanner.chooseOption(number: index + 1),
            variant: MichiButtonVariant.secondary,
            onPressed: () => unawaited(cubit.chooseGrid(index)),
          ),
          const SizedBox(height: MichiSpacing.sm),
        ],
        MichiButton(
          label: t.scanner.rescan,
          variant: MichiButtonVariant.text,
          onPressed: cubit.rescan,
        ),
      ],
    );
  }
}

final class _ChoicePhoto extends StatefulWidget {
  const _ChoicePhoto({required this.choice, required this.onChoose});

  final ScannerGridChoice choice;
  final Future<void> Function(int index) onChoose;

  @override
  State<_ChoicePhoto> createState() => _ChoicePhotoState();
}

final class _ChoicePhotoState extends State<_ChoicePhoto> {
  late final Uint8List _bytes = Uint8List.fromList(widget.choice.image.bytes);
  Size? _pixels;

  @override
  void initState() {
    super.initState();
    unawaited(_measure());
  }

  Future<void> _measure() async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(_bytes);
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    if (mounted) {
      setState(
        () => _pixels = Size(
          descriptor.width.toDouble(),
          descriptor.height.toDouble(),
        ),
      );
    }
    descriptor.dispose();
    buffer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixels = _pixels;
    if (pixels == null) return const SizedBox(height: 240);
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = MediaQuery.sizeOf(context).height * 0.5;
        var width = constraints.maxWidth;
        var height = width * pixels.height / pixels.width;
        if (height > maxHeight) {
          height = maxHeight;
          width = height * pixels.width / pixels.height;
        }
        final scale = width / pixels.width;
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MichiRadius.control),
            child: SizedBox(
              width: width,
              height: height,
              child: GestureDetector(
                onTapUp: (details) {
                  final point = details.localPosition / scale;
                  for (var i = 0; i < widget.choice.grids.length; i++) {
                    if (_outline(widget.choice.grids[i], 1).contains(point)) {
                      unawaited(widget.onChoose(i));
                      return;
                    }
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ExcludeSemantics(
                      child: Image.memory(
                        _bytes,
                        fit: BoxFit.fill,
                        gaplessPlayback: true,
                      ),
                    ),
                    ExcludeSemantics(
                      child: CustomPaint(
                        painter: _ChoicePainter(
                          grids: widget.choice.grids,
                          scale: scale,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Path _outline(GridGeometry grid, double scale) {
  final path = Path()
    ..moveTo(grid.corners.first.x * scale, grid.corners.first.y * scale);
  for (final corner in grid.corners.skip(1)) {
    path.lineTo(corner.x * scale, corner.y * scale);
  }
  return path..close();
}

final class _ChoicePainter extends CustomPainter {
  const _ChoicePainter({required this.grids, required this.scale});

  final List<GridGeometry> grids;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < grids.length; index++) {
      final outline = _outline(grids[index], scale);
      canvas
        ..drawPath(
          outline,
          Paint()..color = MichiColors.coral.withValues(alpha: 0.14),
        )
        ..drawPath(
          outline,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = MichiColors.coral,
        );
      final bounds = outline.getBounds();
      final badge = Offset(bounds.center.dx, bounds.center.dy);
      canvas.drawCircle(badge, 18, Paint()..color = MichiColors.coral);
      final label = TextPainter(
        text: TextSpan(
          text: '${index + 1}',
          style: MichiTypography.heading.copyWith(color: MichiColors.ivory),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, badge - Offset(label.width / 2, label.height / 2));
      label.dispose();
    }
  }

  @override
  bool shouldRepaint(_ChoicePainter oldDelegate) =>
      oldDelegate.grids != grids || oldDelegate.scale != scale;
}

final class _Processing extends StatelessWidget {
  const _Processing();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 96),
    child: Column(
      children: [
        MichiPawLoader(
          label: context.t.scanner.processing,
          size: MichiPawLoaderSize.screen,
          delay: Duration.zero,
        ),
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
  ScanFailureKind.multipleGrids => t.scanner.multipleGrids,
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
        if (review.check case final check?) ...[
          // Re-reveals on every check, so a repeated tap visibly answers.
          MichiReveal(
            key: ValueKey(('check', check)),
            child: MichiBanner(
              key: const ValueKey('scanner-check-result'),
              message: switch (check.verdict) {
                SolutionVerdict.solved => t.scanner.checkSolved,
                SolutionVerdict.onTrack => t.scanner.checkOnTrack,
                SolutionVerdict.conflicts => t.scanner.checkConflicts,
                SolutionVerdict.offTrack =>
                  check.suspects.isEmpty
                      ? t.scanner.checkOffTrackWide
                      : t.scanner.checkOffTrack,
              },
              variant:
                  check.verdict == SolutionVerdict.solved ||
                      check.verdict == SolutionVerdict.onTrack
                  ? MichiBannerVariant.information
                  : MichiBannerVariant.error,
            ),
          ),
          const SizedBox(height: MichiSpacing.md),
        ],
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
        const SizedBox(height: MichiSpacing.sm),
        _ReviewLegend(review: review),
        const FeedbackLink(category: FeedbackCategory.scanner),
        const SizedBox(height: MichiSpacing.md),
        // Fixed height whether or not a cell is chosen: nothing below moves.
        _CellPhoto(
          review: review,
          onDigit: cubit.editSelected,
          onNext: cubit.selectNextToCheck,
        ),
        const SizedBox(height: MichiSpacing.lg),
      ],
    );
  }
}

/// What the two marks mean, shown only when a mark is on the board.
final class _ReviewLegend extends StatelessWidget {
  const _ReviewLegend({required this.review});

  final ScannerReviewData review;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final unsure = review.lowConfidenceCount > 0;
    final conflict = review.conflicts.isNotEmpty;
    final check = review.check;
    final suspect =
        check != null &&
        check.verdict == SolutionVerdict.offTrack &&
        check.suspects.isNotEmpty;
    Widget item(String mark, Color color, Color tint, String text) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(mark, style: MichiTypography.meta.copyWith(color: color)),
        ),
        const SizedBox(width: MichiSpacing.xs),
        Flexible(child: Text(text, style: MichiTypography.meta)),
      ],
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: MichiSpacing.lg,
        runSpacing: MichiSpacing.xs,
        children: [
          if (unsure)
            item(
              '?',
              MichiColors.coralText,
              MichiColors.coralTint,
              t.scanner.legendUnsure,
            ),
          if (conflict)
            item(
              '!',
              MichiColors.error,
              MichiColors.errorTint,
              t.scanner.legendConflict,
            ),
          if (suspect)
            item(
              '○',
              MichiColors.coralText,
              MichiColors.coralTint,
              t.scanner.legendSuspect,
            ),
        ],
      ),
    );
  }
}

/// The chosen cell as it looked in the photo, beside what was read, so an
/// unsure cell can be checked without going back to the page.
final class _CellPhoto extends StatelessWidget {
  const _CellPhoto({
    required this.review,
    required this.onDigit,
    required this.onNext,
  });

  final ScannerReviewData review;
  final ValueChanged<int> onDigit;

  /// Jumps to the next cell worth checking.
  final VoidCallback onNext;

  static const _side = 56.0;

  /// One byte buffer per cell image, so a rebuild reuses the decoded image.
  static final _bytes = Expando<Uint8List>();

  @override
  Widget build(BuildContext context) {
    final index = review.selectedIndex;
    final image = index == null ? null : review.result.cells[index].image;
    // An unsure cell offers MICHI's second reading; only a tap applies it.
    final alternative = index == null
        ? null
        : review.result.cells[index].prediction.alternative;
    final suggest =
        index != null &&
        alternative != null &&
        review.needsReview(CellRef.fromIndex(index)) &&
        review.board.values[index] != alternative;
    final remaining = review.toCheck.length;
    final next = remaining == 0
        ? null
        : context.t.scanner.nextToCheck(count: remaining);
    return SizedBox(
      height: _side,
      child: image == null
          ? (next == null
                ? null
                : Center(
                    child: TextButton.icon(
                      key: const ValueKey('scan-next-check'),
                      onPressed: onNext,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: Text(next),
                    ),
                  ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    context.t.scanner.fromPhoto,
                    style: MichiTypography.secondary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: MichiSpacing.md),
                ExcludeSemantics(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(MichiRadius.small),
                    child: Image.memory(
                      _bytes[image] ??= Uint8List.fromList(image.bytes),
                      key: ValueKey('scan-photo-$index'),
                      width: _side,
                      height: _side,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                  ),
                ),
                if (suggest) ...[
                  const SizedBox(width: MichiSpacing.md),
                  Flexible(
                    child: TextButton(
                      key: ValueKey('scan-suggest-$alternative'),
                      onPressed: () => onDigit(alternative),
                      child: Text(
                        context.t.scanner.maybe(digit: alternative),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
                if (next != null)
                  IconButton(
                    key: const ValueKey('scan-next-check'),
                    tooltip: next,
                    onPressed: onNext,
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
              ],
            ),
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
          // Pinned with the actions, so the keypad is always fully visible
          // and never moves; dimmed until a cell is chosen.
          _DigitInput(
            current: review.selectedIndex == null
                ? 0
                : review.board.values[review.selectedIndex!],
            onDigit: review.selectedIndex == null || checking
                ? null
                : cubit.editSelected,
          ),
          const SizedBox(height: MichiSpacing.xs),
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
          Row(
            children: [
              Expanded(
                child: MichiButton(
                  key: const ValueKey('scanner-check'),
                  label: t.scanner.checkSolution,
                  variant: MichiButtonVariant.secondary,
                  onPressed: checking
                      ? null
                      : () => unawaited(cubit.checkSolution()),
                ),
              ),
              const SizedBox(width: MichiSpacing.sm),
              Expanded(
                child: _StuckButton(
                  review: review,
                  cubit: cubit,
                  checking: checking,
                ),
              ),
            ],
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

/// "I'm stuck": one Coach hint for the reviewed board.
final class _StuckButton extends StatelessWidget {
  const _StuckButton({
    required this.review,
    required this.cubit,
    required this.checking,
  });

  final ScannerReviewData review;
  final ScannerCubit cubit;
  final bool checking;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return MichiButton(
      key: const ValueKey('scanner-stuck'),
      label: t.scanner.stuckShort,
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
                  builder: (_) => _ScanCoach(board: review.board, plan: plan),
                ),
              );
            },
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
    final check = review.check;
    final suspect =
        check != null &&
        check.verdict == SolutionVerdict.offTrack &&
        check.suspects.contains(cell);
    final conflict = review.conflicts.contains(cell);
    final selected = review.selectedIndex == cell.index;
    final t = context.t;
    final value = digit == 0
        ? t.scanner.empty
        : '${t.scanner.recognized} $digit';
    final flags = [
      if (suspect) t.scanner.legendSuspect,
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
              : suspect
              // A possible mistake: ringed, never changed or explained away.
              ? BoxDecoration(
                  border: Border.all(color: MichiColors.coral, width: 2.5),
                  borderRadius: BorderRadius.circular(MichiRadius.small),
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
        // One compact row (digits, then clear), so the pinned area stays
        // short on small phones.
        child: Row(
          children: [
            Expanded(
              child: MichiDigitPad(
                digits: const [1, 2, 3, 4, 5, 6, 7, 8, 9],
                selected: {if (current != 0) current},
                keyFor: (digit) => 'scan-digit-$digit',
                onDigit: (digit) => edit?.call(digit),
              ),
            ),
            IconButton(
              key: const ValueKey('scan-clear'),
              tooltip: context.t.scanner.clear,
              onPressed: edit == null ? null : () => edit(0),
              icon: const Icon(Icons.backspace_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
