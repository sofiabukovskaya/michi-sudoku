import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// A glanceable thumbnail of a saved puzzle, as in the approved Continue
/// row: givens as dark marks, the player's digits in indigo.
final class MiniBoard extends StatelessWidget {
  const MiniBoard({
    required this.givens,
    required this.current,
    this.size = 36,
    super.key,
  });

  final SudokuBoard givens;
  final SudokuBoard current;
  final double size;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: CustomPaint(
      size: Size.square(size),
      painter: _MiniBoardPainter(givens: givens, current: current),
    ),
  );
}

final class _MiniBoardPainter extends CustomPainter {
  const _MiniBoardPainter({required this.givens, required this.current});

  final SudokuBoard givens;
  final SudokuBoard current;

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 9;
    final box = Paint()
      ..color = MichiColors.boardBoxLine
      ..strokeWidth = 0.8;
    for (final line in [3, 6]) {
      final position = line * cell;
      canvas
        ..drawLine(Offset(position, 0), Offset(position, size.height), box)
        ..drawLine(Offset(0, position), Offset(size.width, position), box);
    }
    final given = Paint()..color = MichiColors.textPrimary;
    final player = Paint()..color = MichiColors.indigo;
    for (var index = 0; index < 81; index++) {
      final ref = CellRef.fromIndex(index);
      if (current.isEmpty(ref)) continue;
      canvas.drawCircle(
        Offset((ref.column + 0.5) * cell, (ref.row + 0.5) * cell),
        cell * 0.28,
        givens.isFilled(ref) ? given : player,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MiniBoardPainter old) =>
      old.givens != givens || old.current != current;
}
