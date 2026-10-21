import 'package:flutter/painting.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// One source of truth for board painting, semantics hit areas, and taps.
final class BoardGeometry {
  const BoardGeometry(this.cellSize);

  final double cellSize;

  // Nine cells, six thin lines, two box lines and two outer hairlines.
  double get size => 9 * cellSize + 14;

  double startOf(int position) {
    var offset = 1.0;
    for (var index = 0; index < position; index++) {
      offset += cellSize + ((index + 1) % 3 == 0 ? 3 : 1);
    }
    return offset;
  }

  Rect rectFor(CellRef cell) => Rect.fromLTWH(
    startOf(cell.column),
    startOf(cell.row),
    cellSize,
    cellSize,
  );

  CellRef? cellAt(Offset point) {
    if (point.dx < 0 || point.dy < 0 || point.dx > size || point.dy > size) {
      return null;
    }
    for (var row = 0; row < 9; row++) {
      for (var column = 0; column < 9; column++) {
        final cell = CellRef(row: row, column: column);
        if (rectFor(cell).contains(point)) return cell;
      }
    }
    return null;
  }
}
