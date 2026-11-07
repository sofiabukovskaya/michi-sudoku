import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'board_view_state.dart';

/// A focused excerpt for lessons and practice whose move fits one box.
final class FocusedUnitWidget extends StatelessWidget {
  const FocusedUnitWidget({
    required this.unit,
    required this.view,
    required this.onCellTap,
    super.key,
  });

  final SudokuUnit unit;
  final BoardViewState view;
  final ValueChanged<CellRef>? onCellTap;

  /// Row, column and multi-unit deductions need the full board for orientation.
  static SudokuUnit? unitFor(Deduction deduction) {
    if (deduction.technique == SudokuTechnique.nakedSingle ||
        deduction.technique == SudokuTechnique.hiddenSingle) {
      return SudokuUnit.box(deduction.focusCells.first.box);
    }
    if (deduction.technique != SudokuTechnique.nakedPair &&
        deduction.technique != SudokuTechnique.hiddenPair &&
        deduction.technique != SudokuTechnique.nakedTriple) {
      return null;
    }
    final evidence = deduction.evidence;
    final unit =
        evidence.whereType<UnitEvidence>().firstOrNull?.unit ??
        evidence.whereType<UnitCandidateEvidence>().firstOrNull?.unit;
    return unit?.type == SudokuUnitType.box ? unit : null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = (math.min(constraints.maxWidth, constraints.maxHeight) / 3)
            .clamp(48, 102)
            .toDouble();
        return Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: MichiColors.boardBoxLine, width: 2),
              borderRadius: BorderRadius.circular(MichiRadius.control),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MichiRadius.control - 2),
              child: SizedBox(
                width: side * 3,
                height: side * 3,
                child: Column(
                  children: [
                    for (var line = 0; line < 3; line++)
                      Row(
                        children: [
                          for (var column = 0; column < 3; column++)
                            _FocusedCell(
                              cell: unit.cells[line * 3 + column],
                              side: side,
                              view: view,
                              onCellTap: onCellTap,
                            ),
                        ],
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

final class _FocusedCell extends StatelessWidget {
  const _FocusedCell({
    required this.cell,
    required this.side,
    required this.view,
    required this.onCellTap,
  });

  final CellRef cell;
  final double side;
  final BoardViewState view;
  final ValueChanged<CellRef>? onCellTap;

  @override
  Widget build(BuildContext context) {
    final digit = view.board.valueAt(cell);
    final candidates = view.notes[cell] ?? CandidateMask.empty;
    final hint = view.coachHint;
    final focused = hint?.focusCells.contains(cell) ?? false;
    final selected = view.selectedCell == cell;
    final action = onCellTap;
    return Semantics(
      label:
          '${context.t.game.row} ${cell.row + 1}, '
          '${context.t.game.column} ${cell.column + 1}',
      button: action != null,
      selected: selected,
      onTap: action == null ? null : () => action(cell),
      child: GestureDetector(
        key: ValueKey('cell-${cell.index}'),
        excludeFromSemantics: true,
        onTap: action == null ? null : () => action(cell),
        child: Container(
          width: side,
          height: side,
          decoration: BoxDecoration(
            color: selected
                ? MichiColors.boardSelected
                : focused
                ? MichiColors.coralTint
                : MichiColors.ivory,
            border: Border.all(
              color: selected
                  ? MichiColors.indigo
                  : focused
                  ? MichiColors.coral
                  : MichiColors.boardCellLine,
              width: selected || focused ? 2 : 1,
            ),
          ),
          child: digit != 0
              ? Center(
                  child: Text(
                    '$digit',
                    style: MichiTypography.heading.copyWith(
                      fontSize: 44,
                      color: view.isGiven(cell)
                          ? MichiColors.textPrimary
                          : MichiColors.indigo,
                    ),
                  ),
                )
              : _CandidateGrid(
                  cell: cell,
                  mask: candidates,
                  side: side,
                  view: view,
                ),
        ),
      ),
    );
  }
}

final class _CandidateGrid extends StatelessWidget {
  const _CandidateGrid({
    required this.cell,
    required this.mask,
    required this.side,
    required this.view,
  });

  final CellRef cell;
  final CandidateMask mask;
  final double side;
  final BoardViewState view;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var row = 0; row < 3; row++)
        Expanded(
          child: Row(
            children: [
              for (var column = 0; column < 3; column++)
                Expanded(
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        final digit = row * 3 + column + 1;
                        if (!mask.contains(digit)) {
                          return const SizedBox.shrink();
                        }
                        final eliminated =
                            view.selectedEliminations.contains(
                              CandidateElimination(cell, digit),
                            ) ||
                            (view.coachHint?.revealedEliminations.contains(
                                  CandidateElimination(cell, digit),
                                ) ??
                                false);
                        return Text(
                          '$digit',
                          style: MichiTypography.meta.copyWith(
                            fontSize: side < 50 ? 7 : 14,
                            color: eliminated
                                ? MichiColors.error
                                : MichiColors.boardCandidate,
                            decoration: eliminated
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}
