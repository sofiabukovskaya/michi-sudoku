import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'board_geometry.dart';

/// Visualizes only facts supplied by CoachHint, without deriving a move.
final class CoachOverlayPainter extends CustomPainter {
  const CoachOverlayPainter({required this.hint, required this.geometry});

  final CoachHint? hint;
  final BoardGeometry geometry;

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
    for (final unit in current.focusUnits) {
      _paintUnit(canvas, unit);
    }
    for (final cell in current.focusCells) {
      _paintFocusCell(canvas, cell);
    }
    for (final candidate in current.candidateHighlights) {
      _paintCandidate(canvas, candidate, MichiColors.indigo);
    }
    for (final elimination in current.revealedEliminations) {
      _paintElimination(canvas, elimination);
    }
    for (final placement in current.revealedPlacements) {
      _paintPlacement(canvas, placement);
    }
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

  void _paintElimination(Canvas canvas, CandidateElimination elimination) {
    final rect = _candidateRect(elimination.cell, elimination.digit);
    _paintSmallDigit(
      canvas,
      elimination.digit,
      rect,
      MichiColors.boardEliminated,
    );
    canvas.drawLine(
      rect.topLeft + const Offset(2, 2),
      rect.bottomRight - const Offset(2, 2),
      Paint()
        ..color = MichiColors.coralText
        ..strokeWidth = 1.5,
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
      oldDelegate.geometry.cellSize != geometry.cellSize;
}
