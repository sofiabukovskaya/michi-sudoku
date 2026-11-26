import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../tokens/michi_colors.dart';
import '../tokens/michi_spacing.dart';
import '../tokens/michi_typography.dart';

/// Where the loader sits; sets paw size and spacing.
enum MichiPawLoaderSize {
  /// Inside a line of text or a button-sized area.
  inline(10, MichiSpacing.xs),

  /// Inside a card whose content is being prepared.
  card(16, MichiSpacing.sm),

  /// Centred on a screen that has nothing else to show yet.
  screen(22, MichiSpacing.md);

  const MichiPawLoaderSize(this.paw, this.gap);

  final double paw;
  final double gap;
}

/// MICHI's loading mark: three paw prints stepping in sequence.
///
/// - Appears only after [delay], so an instant load never flashes it.
/// - Animation is native and cheap: one ticker, opacity and a small scale.
/// - Stops on its own after [maxAnimation] and rests on three visible paws,
///   so a long wait never keeps the frame pipeline busy forever.
/// - Muted tickers (hidden tab, covered route, background) draw nothing.
/// - Reduce Motion shows the resting paws with no animation.
/// - Announced once as [label] (a live region); the paws are decorative.
final class MichiPawLoader extends StatefulWidget {
  const MichiPawLoader({
    required this.label,
    this.size = MichiPawLoaderSize.card,
    this.showLabel = true,
    this.color = MichiColors.coral,
    this.delay = const Duration(milliseconds: 250),
    this.maxAnimation = const Duration(seconds: 12),
    super.key,
  });

  /// What is being prepared, for screen readers and (optionally) on screen.
  final String label;
  final MichiPawLoaderSize size;
  final bool showLabel;
  final Color color;
  final Duration delay;
  final Duration maxAnimation;

  static const cycle = Duration(milliseconds: 1200);

  @override
  State<MichiPawLoader> createState() => _MichiPawLoaderState();
}

final class _MichiPawLoaderState extends State<MichiPawLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: MichiPawLoader.cycle,
  );
  Timer? _show;
  Timer? _stop;
  bool _visible = false;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _visible = true;
    } else {
      _show = Timer(widget.delay, () {
        if (mounted) setState(() => _visible = true);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  void _sync() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _rest();
    } else if (!_started) {
      _started = true;
      _controller.repeat();
      _stop = Timer(widget.maxAnimation, () {
        if (mounted) setState(_rest);
      });
    }
  }

  /// Three visible paws and no ticker, for good.
  void _rest() {
    _started = true;
    _stop?.cancel();
    _controller
      ..stop()
      ..value = 0;
  }

  @override
  void dispose() {
    _show?.cancel();
    _stop?.cancel();
    _controller.dispose();
    super.dispose();
  }

  bool get _resting =>
      !_controller.isAnimating || MediaQuery.disableAnimationsOf(context);

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final paws = RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var index = 0; index < 3; index++) ...[
              if (index > 0) SizedBox(width: size.gap),
              _step(index, size.paw),
            ],
          ],
        ),
      ),
    );
    final content = widget.showLabel
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              paws,
              SizedBox(height: size.gap + MichiSpacing.xs),
              Text(
                widget.label,
                style: MichiTypography.secondary,
                textAlign: TextAlign.center,
              ),
            ],
          )
        : paws;
    return Semantics(
      label: widget.label,
      liveRegion: true,
      child: ExcludeSemantics(
        child: Opacity(opacity: _visible ? 1 : 0, child: content),
      ),
    );
  }

  /// Paw [index] lifts in its own third of the cycle: it fades from 30% to
  /// full and settles from 86% to full size, then fades back.
  Widget _step(int index, double paw) {
    double strength;
    if (_resting) {
      strength = 1;
    } else {
      final phase = (_controller.value - index / 3) % 1;
      // 0..1..0 over the first two thirds of this paw's turn.
      strength = phase < 2 / 3 ? math.sin(phase * 1.5 * math.pi) : 0;
    }
    // Alternate paws are offset like a walking trail.
    return Padding(
      padding: EdgeInsets.only(bottom: index.isOdd ? paw * 0.35 : 0),
      child: Opacity(
        opacity: 0.3 + 0.7 * strength,
        child: Transform.scale(
          scale: 0.86 + 0.14 * strength,
          child: CustomPaint(
            size: Size.square(paw),
            painter: _PawPainter(widget.color),
          ),
        ),
      ),
    );
  }
}

/// A paw print: one main pad and four toes, drawn as vectors so it stays
/// sharp at every size and density.
final class _PawPainter extends CustomPainter {
  const _PawPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final paint = Paint()
      ..color = color
      ..isAntiAlias = true;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(s * 0.5, s * 0.68),
        width: s * 0.52,
        height: s * 0.42,
      ),
      paint,
    );
    for (final (x, y) in const [
      (0.17, 0.42),
      (0.37, 0.2),
      (0.63, 0.2),
      (0.83, 0.42),
    ]) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(s * x, s * y),
          width: s * 0.2,
          height: s * 0.25,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_PawPainter oldDelegate) => oldDelegate.color != color;
}
