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
  ///
  /// A box excerpt is used only when that box alone proves the move. A Hidden
  /// Single found in a row or column may still have several places for its
  /// digit inside the box; showing only the box would hide the reason.
  static SudokuUnit? unitFor(Deduction deduction, {HumanSolverState? state}) {
    if (deduction.technique == SudokuTechnique.nakedSingle) {
      return SudokuUnit.box(deduction.focusCells.first.box);
    }
    if (deduction.technique == SudokuTechnique.hiddenSingle) {
      final box = SudokuUnit.box(deduction.focusCells.first.box);
      final placement = deduction.placements.singleOrNull;
      if (state == null || placement == null) return box;
      final places = box.cells.where(
        (cell) =>
            state.board.isEmpty(cell) &&
            state.candidatesFor(cell).contains(placement.digit),
      );
      return places.length == 1 ? box : null;
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
        // Never larger than the space given; never a stretched debug grid.
        final side = math
            .min(
              116,
              (math.min(constraints.maxWidth, constraints.maxHeight) / 3)
                  .floor(),
            )
            .toDouble();
        return Center(
          child: Container(
            foregroundDecoration: BoxDecoration(
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
    final placed = hint?.revealedPlacements
        .where((placement) => placement.cell == cell)
        .firstOrNull;
    final focused =
        placed == null && (hint?.focusCells.contains(cell) ?? false);
    final selected = placed == null && view.selectedCell == cell;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
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
        child: AnimatedContainer(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : MichiMotion.quick,
          curve: MichiMotion.curve,
          width: side,
          height: side,
          decoration: BoxDecoration(
            color: placed != null
                ? MichiColors.successTint
                : selected
                ? MichiColors.boardSelected
                : focused
                ? MichiColors.coralTint
                : MichiColors.ivory,
            border: Border.all(
              color: placed != null
                  ? MichiColors.success
                  : selected
                  ? MichiColors.indigo
                  : focused
                  ? MichiColors.coral
                  : MichiColors.boardCellLine,
              width: placed != null || selected || focused ? 2 : 1,
            ),
          ),
          child: placed != null
              // The proven digit lands in its cell: cause and effect.
              ? Center(
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey(placed),
                    tween: Tween(begin: reduceMotion ? 1 : 0.4, end: 1),
                    duration: MichiMotion.emphasis,
                    curve: Curves.easeOutBack,
                    builder: (_, scale, child) =>
                        Transform.scale(scale: scale, child: child),
                    child: Text(
                      '${placed.digit}',
                      key: ValueKey('proof-digit-${cell.index}'),
                      style: MichiTypography.heading.copyWith(
                        fontSize: (side * 0.44).clamp(24, 44),
                        color: MichiColors.success,
                      ),
                    ),
                  ),
                )
              : digit != 0
              ? Center(
                  child: Text(
                    '$digit',
                    style: MichiTypography.heading.copyWith(
                      fontSize: (side * 0.44).clamp(24, 44),
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
                        final proof =
                            !eliminated &&
                            (view.coachHint?.candidateHighlights.contains(
                                  CandidateRef(cell, digit),
                                ) ??
                                false);
                        final text = Text(
                          '$digit',
                          style: MichiTypography.meta.copyWith(
                            fontSize: side < 50 ? 7 : 14,
                            fontWeight: proof ? FontWeight.w800 : null,
                            color: eliminated
                                ? MichiColors.error
                                : proof
                                ? MichiColors.indigo
                                : MichiColors.boardCandidate,
                            decoration: eliminated
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        );
                        if (!proof) return text;
                        // Proof candidates get the same quiet ring the
                        // full-board Coach overlay draws.
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MichiColors.ivory,
                            border: Border.all(
                              color: MichiColors.indigo,
                              width: 1.2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: text,
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
