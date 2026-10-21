import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'board_geometry.dart';
import 'board_view_state.dart';

/// Draws values and ordinary game states; Coach visuals use another painter.
final class SudokuBoardPainter extends CustomPainter {
  const SudokuBoardPainter({required this.view, required this.geometry});

  final BoardViewState view;
  final BoardGeometry geometry;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & Size.square(geometry.size);
    canvas
      ..save()
      ..clipRRect(RRect.fromRectAndRadius(bounds, const Radius.circular(12)))
      ..drawRect(bounds, Paint()..color = MichiColors.ivory);
    _paintCellBackgrounds(canvas);
    _paintGrid(canvas);
    _paintValues(canvas);
    _paintStateOutlines(canvas);
    canvas.restore();
  }

  void _paintCellBackgrounds(Canvas canvas) {
    final selected = view.selectedCell;
    final selectedValue = selected == null ? 0 : view.board.valueAt(selected);
    for (var index = 0; index < 81; index++) {
      final cell = CellRef.fromIndex(index);
      Color? color;
      if (view.isWrong(cell)) {
        color = MichiColors.errorTint;
      } else if (cell == selected) {
        color = MichiColors.boardSelected;
      } else if (selected != null &&
          selectedValue != 0 &&
          view.board.valueAt(cell) == selectedValue) {
        color = MichiColors.boardSameDigit;
      } else if (selected != null &&
          (cell.row == selected.row ||
              cell.column == selected.column ||
              cell.box == selected.box)) {
        color = MichiColors.boardRelated;
      }
      if (color != null) {
        canvas.drawRect(geometry.rectFor(cell), Paint()..color = color);
      }
    }
  }

  void _paintGrid(Canvas canvas) {
    final boardSize = geometry.size;
    final outerPaint = Paint()..color = MichiColors.boardBoxLine;
    canvas
      ..drawRect(Rect.fromLTWH(0, 0, boardSize, 1), outerPaint)
      ..drawRect(Rect.fromLTWH(0, boardSize - 1, boardSize, 1), outerPaint)
      ..drawRect(Rect.fromLTWH(0, 0, 1, boardSize), outerPaint)
      ..drawRect(Rect.fromLTWH(boardSize - 1, 0, 1, boardSize), outerPaint);
    for (var boundary = 1; boundary < 9; boundary++) {
      final thick = boundary % 3 == 0;
      final lineWidth = thick ? 3.0 : 1.0;
      final linePaint = Paint()
        ..color = thick ? MichiColors.boardBoxLine : MichiColors.boardCellLine;
      final position = geometry.startOf(boundary) - lineWidth;
      canvas
        ..drawRect(Rect.fromLTWH(position, 0, lineWidth, boardSize), linePaint)
        ..drawRect(Rect.fromLTWH(0, position, boardSize, lineWidth), linePaint);
    }
  }

  void _paintValues(Canvas canvas) {
    for (var index = 0; index < 81; index++) {
      final cell = CellRef.fromIndex(index);
      final digit = view.board.valueAt(cell);
      final rect = geometry.rectFor(cell);
      if (digit != 0) {
        final wrong = view.isWrong(cell);
        _paintText(
          canvas,
          '$digit',
          rect,
          TextStyle(
            fontFamily: MichiTypography.functionalFamily,
            fontSize: geometry.cellSize * 0.58,
            fontWeight: wrong
                ? FontWeight.w800
                : view.isGiven(cell)
                ? FontWeight.w700
                : FontWeight.w600,
            color: wrong
                ? MichiColors.error
                : view.isGiven(cell)
                ? MichiColors.textPrimary
                : MichiColors.indigo,
          ),
        );
      } else {
        final notes = view.notes[cell];
        if (notes == null) continue;
        for (final note in notes.digits) {
          final noteRect = Rect.fromLTWH(
            rect.left + ((note - 1) % 3) * rect.width / 3,
            rect.top + ((note - 1) ~/ 3) * rect.height / 3,
            rect.width / 3,
            rect.height / 3,
          );
          _paintText(
            canvas,
            '$note',
            noteRect,
            const TextStyle(
              fontFamily: MichiTypography.functionalFamily,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: MichiColors.boardCandidate,
            ),
          );
        }
      }
    }
  }

  void _paintStateOutlines(Canvas canvas) {
    for (var index = 0; index < 81; index++) {
      final cell = CellRef.fromIndex(index);
      final rect = geometry.rectFor(cell).deflate(1);
      if (view.isWrong(cell)) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          Paint()
            ..color = MichiColors.error
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5,
        );
        final corner = Path()
          ..moveTo(rect.right - 9, rect.top)
          ..lineTo(rect.right, rect.top)
          ..lineTo(rect.right, rect.top + 9)
          ..close();
        canvas.drawPath(corner, Paint()..color = MichiColors.error);
      } else if (cell == view.selectedCell) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          Paint()
            ..color = MichiColors.indigo
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      }
    }
  }

  static void _paintText(
    Canvas canvas,
    String text,
    Rect rect,
    TextStyle style,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: rect.width);
    painter.paint(
      canvas,
      Offset(
        rect.center.dx - painter.width / 2,
        rect.center.dy - painter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant SudokuBoardPainter oldDelegate) =>
      oldDelegate.view != view ||
      oldDelegate.geometry.cellSize != geometry.cellSize;
}
