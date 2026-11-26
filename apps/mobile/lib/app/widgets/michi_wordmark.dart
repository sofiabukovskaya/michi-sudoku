import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';

/// Compact brand mark used on the entry screens and Home.
final class MichiWordmark extends StatelessWidget {
  const MichiWordmark({
    this.light = false,
    this.iconSize = 32,
    this.pathProgress = 1,
    super.key,
  });

  final bool light;
  final double iconSize;

  /// How much of the coral logic path is drawn, from 0 to 1. The splash
  /// animates it; every other surface shows the finished mark.
  final double pathProgress;

  @override
  Widget build(BuildContext context) {
    final foreground = light ? MichiColors.ivory : MichiColors.textPrimary;
    return Semantics(
      label: 'michi',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            size: Size.square(iconSize),
            painter: _MarkPainter(light: light, progress: pathProgress),
          ),
          const SizedBox(width: MichiSpacing.sm),
          Text(
            'michi',
            style: MichiTypography.heading.copyWith(
              color: foreground,
              fontSize: iconSize * 0.9,
              height: 1,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }
}

final class _MarkPainter extends CustomPainter {
  const _MarkPainter({required this.light, required this.progress});

  final bool light;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 32;
    final outline = Paint()
      ..color = light ? MichiColors.ivory : MichiColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * scale;
    final grid = Paint()
      ..color = light ? const Color(0xFFBFCAD0) : MichiColors.boardBoxLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = scale;
    final coral = Paint()
      ..color = MichiColors.coral
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.8 * scale;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1 * scale, 1 * scale, 30 * scale, 30 * scale),
      Radius.circular(6 * scale),
    );
    canvas.drawRRect(rect, outline);
    for (final position in [11.0, 21.0]) {
      canvas
        ..drawLine(
          Offset(position * scale, scale),
          Offset(position * scale, 31 * scale),
          grid,
        )
        ..drawLine(
          Offset(scale, position * scale),
          Offset(31 * scale, position * scale),
          grid,
        );
    }
    final path = Path()
      ..moveTo(3 * scale, 27 * scale)
      ..cubicTo(
        9 * scale,
        25 * scale,
        11 * scale,
        28 * scale,
        14 * scale,
        21 * scale,
      )
      ..cubicTo(
        18 * scale,
        13 * scale,
        21 * scale,
        17 * scale,
        29 * scale,
        6 * scale,
      );
    if (progress >= 1) {
      canvas.drawPath(path, coral);
    } else if (progress > 0) {
      for (final metric in path.computeMetrics()) {
        canvas.drawPath(
          metric.extractPath(0, metric.length * progress),
          coral,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MarkPainter oldDelegate) =>
      light != oldDelegate.light || progress != oldDelegate.progress;
}
