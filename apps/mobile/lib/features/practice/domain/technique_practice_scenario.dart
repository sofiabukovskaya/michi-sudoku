import 'package:sudoku_engine/sudoku_engine.dart';

/// Immutable content; the current Deduction is derived at session start.
final class TechniquePracticeScenario {
  const TechniquePracticeScenario({
    required this.id,
    required this.technique,
    required this.board,
    required this.contentVersion,
  });

  final String id;
  final SudokuTechnique technique;
  final SudokuBoard board;
  final int contentVersion;
}
