import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'board_geometry.dart';
import 'board_view_state.dart';
import 'coach_overlay_painter.dart';
import 'sudoku_board_painter.dart';

final class SudokuBoardWidget extends StatelessWidget {
  const SudokuBoardWidget({
    required this.view,
    required this.cellSize,
    required this.onCellTap,
    super.key,
  });

  final BoardViewState view;
  final double cellSize;
  final ValueChanged<CellRef>? onCellTap;

  @override
  Widget build(BuildContext context) {
    final geometry = BoardGeometry(cellSize);
    final translations = context.t;
    return SizedBox.square(
      dimension: geometry.size,
      child: Stack(
        children: [
          Positioned.fill(
            child: _BoardPaint(view: view, geometry: geometry),
          ),
          for (var index = 0; index < 81; index++)
            _cellSemantics(
              geometry,
              CellRef.fromIndex(index),
              translations,
            ),
        ],
      ),
    );
  }

  Widget _cellSemantics(
    BoardGeometry geometry,
    CellRef cell,
    Translations translations,
  ) {
    final digit = view.board.valueAt(cell);
    final notes = view.notes[cell];
    final position =
        '${translations.game.row} ${cell.row + 1}, '
        '${translations.game.column} ${cell.column + 1}';
    final parts = <String>[
      position,
      if (digit == 0) translations.game.empty else '$digit',
      if (digit != 0 && view.isGiven(cell)) translations.game.given,
      if (digit != 0 && !view.isGiven(cell)) translations.game.entered,
      if (notes != null && !notes.isEmpty)
        '${translations.game.candidates} ${notes.digits.join(', ')}',
      if (view.isWrong(cell)) translations.game.error,
      if (view.selectedCell == cell) translations.game.selected,
    ];
    return Positioned.fromRect(
      rect: geometry.rectFor(cell),
      child: Semantics(
        label: parts.join(', '),
        button: onCellTap != null,
        selected: view.selectedCell == cell,
        onTap: onCellTap == null ? null : () => onCellTap!(cell),
        child: GestureDetector(
          key: ValueKey('cell-${cell.index}'),
          behavior: HitTestBehavior.opaque,
          excludeFromSemantics: true,
          onTap: onCellTap == null ? null : () => onCellTap!(cell),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

// Animate just the painted layers. Hit targets and spoken labels always reflect
// the current board, even when a player taps several squares in succession.
class _BoardPaint extends StatefulWidget {
  const _BoardPaint({required this.view, required this.geometry});
  final BoardViewState view;
  final BoardGeometry geometry;
  @override
  State<_BoardPaint> createState() => _BoardPaintState();
}

class _BoardPaintState extends State<_BoardPaint> {
  BoardViewState? previous;
  @override
  void didUpdateWidget(_BoardPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view != widget.view) previous = oldWidget.view;
  }

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    key: ValueKey(widget.view),
    tween: Tween(begin: previous == null ? 1 : 0, end: 1),
    duration: MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : MichiMotion.quick,
    builder: (_, progress, _) => CustomPaint(
      painter: SudokuBoardPainter(
        view: widget.view,
        geometry: widget.geometry,
        previous: previous,
        progress: progress,
      ),
      foregroundPainter: CoachOverlayPainter(
        hint: widget.view.coachHint,
        geometry: widget.geometry,
      ),
    ),
  );
}
