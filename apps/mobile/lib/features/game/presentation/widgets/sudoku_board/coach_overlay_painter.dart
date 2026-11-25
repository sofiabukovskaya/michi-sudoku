import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'board_geometry.dart';

/// Visualizes only facts supplied by CoachHint, without deriving a move.
///
/// [reveal] (0 → 1) stages a new hint in logical order: the unit and focus
/// cells first, then highlighted candidates, then eliminations struck through
/// and, last, a placement. It only animates what this hint already contains;
/// it never shows a later level early.
final class CoachOverlayPainter extends CustomPainter {
  const CoachOverlayPainter({
    required this.hint,
    required this.geometry,
    this.reveal = 1,
  });

  final CoachHint? hint;
  final BoardGeometry geometry;
  final double reveal;

  static double _stage(double value, double begin, double end) =>
      ((value - begin) / (end - begin)).clamp(0.0, 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    final current = hint;
    if (current == null) return;
    canvas
      ..save()
      ..clipRRect(
        RRect.fromRectAndRadius(
          Offset.zero & Size.square(geometry.size),
          const Radius.circular(12),
        ),
      );
    final evidence = _stage(reveal, 0, 0.45);
    final candidates = _stage(reveal, 0.25, 0.7);
    final strike = _stage(reveal, 0.45, 1);
    final placement = _stage(reveal, 0.55, 1);
    _withOpacity(canvas, evidence, () {
      for (final unit in current.focusUnits) {
        _paintUnit(canvas, unit);
      }
      for (final cell in current.focusCells) {
        _paintFocusCell(canvas, cell);
      }
    });
    _withOpacity(canvas, candidates, () {
      for (final candidate in current.candidateHighlights) {
        _paintCandidate(canvas, candidate, MichiColors.indigo);
      }
    });
    if (strike > 0) {
      for (final elimination in current.revealedEliminations) {
        _paintElimination(canvas, elimination, strike);
      }
    }
    _withOpacity(canvas, placement, () {
      for (final item in current.revealedPlacements) {
        _paintPlacement(canvas, item);
      }
    });
    canvas.restore();
  }

  /// Only a staged layer pays for a save layer; settled layers draw directly.
  static void _withOpacity(
    Canvas canvas,
    double opacity,
    void Function() draw,
  ) {
    if (opacity <= 0) return;
    if (opacity >= 1) {
      draw();
      return;
    }
    canvas.saveLayer(
      null,
      Paint()..color = Color.fromRGBO(0, 0, 0, opacity),
    );
    draw();
    canvas.restore();
  }

  void _paintUnit(Canvas canvas, SudokuUnit unit) {
    final rows = unit.cells.map((cell) => cell.row);
    final columns = unit.cells.map((cell) => cell.column);
    final topLeft = geometry.rectFor(
      CellRef(
        row: rows.reduce(math.min),
        column: columns.reduce(math.min),
      ),
    );
    final bottomRight = geometry.rectFor(
      CellRef(
        row: rows.reduce(math.max),
        column: columns.reduce(math.max),
      ),
    );
    final rect = Rect.fromLTRB(
      topLeft.left,
      topLeft.top,
      bottomRight.right,
      bottomRight.bottom,
    ).deflate(1);
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        Paint()..color = MichiColors.coralTint.withValues(alpha: 0.34),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        Paint()
          ..color = MichiColors.coral
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
  }

  void _paintFocusCell(Canvas canvas, CellRef cell) {
    final rect = geometry.rectFor(cell).deflate(2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      Paint()
        ..color = MichiColors.coral
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  Rect _candidateRect(CellRef cell, int digit) {
    final rect = geometry.rectFor(cell);
    return Rect.fromLTWH(
      rect.left + ((digit - 1) % 3) * rect.width / 3,
      rect.top + ((digit - 1) ~/ 3) * rect.height / 3,
      rect.width / 3,
      rect.height / 3,
    );
  }

  void _paintCandidate(Canvas canvas, CandidateRef candidate, Color color) {
    final rect = _candidateRect(candidate.cell, candidate.digit);
    canvas.drawCircle(
      rect.center,
      rect.width * 0.42,
      Paint()..color = MichiColors.ivory,
    );
    _paintSmallDigit(canvas, candidate.digit, rect, color);
  }

  /// The strike is drawn across the candidate as it is ruled out.
  void _paintElimination(
    Canvas canvas,
    CandidateElimination elimination,
    double strike,
  ) {
    final rect = _candidateRect(elimination.cell, elimination.digit);
    _paintSmallDigit(
      canvas,
      elimination.digit,
      rect,
      MichiColors.boardEliminated,
    );
    final from = rect.topLeft + const Offset(2, 2);
    final to = rect.bottomRight - const Offset(2, 2);
    canvas.drawLine(
      from,
      Offset.lerp(from, to, strike)!,
      Paint()
        ..color = MichiColors.coralText
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );
  }

  void _paintPlacement(Canvas canvas, DigitPlacement placement) {
    final rect = geometry.rectFor(placement.cell).deflate(2);
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        Paint()..color = MichiColors.successTint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        Paint()
          ..color = MichiColors.success
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    final painter = TextPainter(
      text: TextSpan(
        text: '${placement.digit}',
        style: TextStyle(
          fontFamily: MichiTypography.functionalFamily,
          fontSize: geometry.cellSize * 0.58,
          fontWeight: FontWeight.w700,
          color: MichiColors.success,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      Offset(
        rect.center.dx - painter.width / 2,
        rect.center.dy - painter.height / 2,
      ),
    );
  }

  static void _paintSmallDigit(
    Canvas canvas,
    int digit,
    Rect rect,
    Color color,
  ) {
    final painter = TextPainter(
      text: TextSpan(
        text: '$digit',
        style: TextStyle(
          fontFamily: MichiTypography.functionalFamily,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      Offset(
        rect.center.dx - painter.width / 2,
        rect.center.dy - painter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CoachOverlayPainter oldDelegate) =>
      oldDelegate.hint != hint ||
      oldDelegate.reveal != reveal ||
      oldDelegate.geometry.cellSize != geometry.cellSize;
}
