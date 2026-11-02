import 'package:sudoku_engine/sudoku_engine.dart';

enum MoveReasoningSource { manual, coach }

/// Small deterministic record of the state before a proved player placement.
final class MoveReasoningContext {
  const MoveReasoningContext({
    required this.preMoveBoard,
    required this.cell,
    required this.digit,
    required this.technique,
    required this.source,
  });

  final SudokuBoard preMoveBoard;
  final CellRef cell;
  final int digit;
  final SudokuTechnique technique;
  final MoveReasoningSource source;

  DigitPlacement get placement => DigitPlacement(cell, digit);
}
