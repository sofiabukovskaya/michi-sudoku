import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:michi_design_system/michi_design_system.dart';

/// Progress empty state: MICHI with a pencil beside a small blank board.
///
/// A vector redraw of the approved 390×230 illustration, so it stays sharp
/// at any size and pixel density (the raster was blurry on 3× screens).
final class FirstPuzzleArt extends StatelessWidget {
  const FirstPuzzleArt({required this.height, super.key});

  final double height;

  static const double _aspect = 390 / 230;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Center(
      child: CustomPaint(
        size: Size(height * _aspect, height),
        painter: const _FirstPuzzlePainter(),
      ),
    ),
  );
}

final class _FirstPuzzlePainter extends CustomPainter {
  const _FirstPuzzlePainter();

  static const _ink = Color(0xFF282826);
  static const _fur = Color(0xFFF2EADD);
  static const _paperWhite = Color(0xFFFDFCF6);
  static const _whisker = Color(0xFF8A8F96);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(size.width / 390, size.height / 230);
    _board(canvas);
    _cat(canvas);
    canvas.restore();
  }

  Paint _stroke(double width, [Color color = _ink]) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = color
    ..isAntiAlias = true;

  Paint _fill(Color color) => Paint()
    ..color = color
    ..isAntiAlias = true;

  void _board(Canvas canvas) {
    canvas
      ..save()
      ..translate(98, 129)
      ..rotate(-3.4 * math.pi / 180);
    const half = 79.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTRB(-half, -half, half, half),
        const Radius.circular(10),
      ),
      _fill(_paperWhite),
    );
    final edge = _stroke(2.6);
    const open = 9.0;
    // The outer edges stop short of the rounded corners, as in the sketch.
    canvas
      ..drawLine(
        const Offset(-half + open, -half),
        const Offset(half - open, -half),
        edge,
      )
      ..drawLine(
        const Offset(-half + open, half),
        const Offset(half - open, half),
        edge,
      )
      ..drawLine(
        const Offset(-half, -half + open * 2),
        const Offset(-half, half - open),
        edge,
      )
      ..drawLine(
        const Offset(half, -half + open * 1.5),
        const Offset(half, half - open),
        edge,
      );
    final line = _stroke(3);
    final dot = _fill(_ink);
    for (final t in [-half / 3, half / 3]) {
      canvas
        ..drawLine(Offset(t, -half), Offset(t, half), line)
        ..drawLine(Offset(-half, t), Offset(half, t), line);
    }
    for (final x in [-half / 3, half / 3]) {
      for (final y in [-half / 3, half / 3]) {
        canvas.drawCircle(Offset(x, y), 3.4, dot);
      }
    }
    canvas.restore();
  }

  void _cat(Canvas canvas) {
    final outline = _stroke(3.2);
    final fur = _fill(_fur);

    // Tail, behind the body.
    final tail = Path()
      ..moveTo(284, 196)
      ..cubicTo(318, 193, 330, 178, 340, 160)
      ..cubicTo(345, 151, 348, 145, 355, 151)
      ..cubicTo(364, 150, 366, 140, 358, 137)
      ..cubicTo(349, 134, 342, 140, 338, 150)
      ..cubicTo(332, 166, 318, 181, 290, 183);
    canvas
      ..drawPath(tail, fur)
      ..drawPath(tail, outline);

    // Body.
    final body = Path()
      ..moveTo(212, 112)
      ..cubicTo(198, 128, 193, 148, 194, 170)
      ..cubicTo(194, 186, 197, 196, 210, 200)
      ..lineTo(275, 200)
      ..cubicTo(287, 197, 293, 186, 293, 170)
      ..cubicTo(293, 146, 288, 128, 279, 114)
      ..close();
    canvas
      ..drawPath(body, fur)
      ..drawPath(body, outline);
    // Front paws.
    for (final (left, right) in [(220.0, 241.0), (247.0, 269.0)]) {
      final paw = Path()
        ..moveTo(left, 200)
        ..arcToPoint(
          Offset(right, 200),
          radius: Radius.elliptical((right - left) / 2, 15),
        );
      canvas
        ..drawPath(paw, fur)
        ..drawPath(paw, _stroke(2.8));
    }

    // Pencil, tucked behind the right ear.
    canvas
      ..save()
      ..translate(290, 55)
      ..rotate(math.atan2(-37, 26));
    const length = 47.0;
    const width = 8.0;
    final shaft = Path()
      ..moveTo(0, -width / 2)
      ..lineTo(length * 0.62, -width / 2)
      ..lineTo(length * 0.62, width / 2)
      ..lineTo(0, width / 2)
      ..close();
    final tip = Path()
      ..moveTo(length * 0.62, -width / 2)
      ..lineTo(length, 0)
      ..lineTo(length * 0.62, width / 2)
      ..close();
    canvas
      ..drawPath(shaft, _fill(MichiColors.coral))
      ..drawPath(tip, _fill(_paperWhite))
      ..drawPath(shaft, _stroke(2.2))
      ..drawPath(tip, _stroke(2.2))
      ..drawLine(
        const Offset(length * 0.92, -1),
        const Offset(length, 0),
        _stroke(2.6),
      )
      ..restore();

    // Ears: the dark one on the left, the light one with a pink inner line.
    final darkEar = Path()
      ..moveTo(208, 52)
      ..quadraticBezierTo(214, 22, 228, 19)
      ..quadraticBezierTo(237, 22, 240, 43)
      ..close();
    canvas.drawPath(darkEar, _fill(_ink));
    final lightEar = Path()
      ..moveTo(268, 48)
      ..lineTo(290, 33)
      ..quadraticBezierTo(291, 52, 288, 68)
      ..close();
    canvas
      ..drawPath(lightEar, fur)
      ..drawPath(lightEar, outline)
      ..drawLine(
        const Offset(274, 51),
        const Offset(287, 43.5),
        _stroke(2.6, MichiColors.coral.withValues(alpha: 0.65)),
      );

    // Head.
    final head = Rect.fromCenter(
      center: const Offset(244.5, 83),
      width: 91,
      height: 82,
    );
    canvas
      ..drawOval(head, fur)
      ..drawOval(head, outline);

    // Face.
    final ink = _fill(_ink);
    canvas
      ..drawCircle(const Offset(232, 80.5), 4.4, ink)
      ..drawCircle(const Offset(263, 87), 4.4, ink)
      ..drawPath(
        Path()
          ..moveTo(239.5, 90.5)
          ..lineTo(246.5, 91)
          ..lineTo(242.5, 95.5)
          ..close(),
        _fill(MichiColors.coral),
      )
      ..drawCircle(const Offset(240.8, 100.5), 3, ink);
    final whisker = _stroke(1.2, _whisker);
    canvas
      ..drawLine(const Offset(188.5, 81), const Offset(200, 84), whisker)
      ..drawLine(const Offset(188.5, 94), const Offset(200, 92.5), whisker)
      ..drawLine(const Offset(282.5, 102.5), const Offset(296, 104), whisker)
      ..drawLine(const Offset(282.5, 111), const Offset(291, 115.5), whisker);
  }

  @override
  bool shouldRepaint(_FirstPuzzlePainter oldDelegate) => false;
}
