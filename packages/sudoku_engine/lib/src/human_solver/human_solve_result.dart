import 'package:meta/meta.dart';

import '../model/sudoku_board.dart';
import 'deduction.dart';
import 'human_solver_state.dart';

enum HumanSolveStatus { solved, stuck, contradiction }

/// A deterministic technique trace and the state reached by logical solving.
@immutable
final class HumanSolveResult {
  HumanSolveResult({
    required this.status,
    required this.initialBoard,
    required this.finalState,
    required List<Deduction> deductions,
  }) : deductions = List<Deduction>.unmodifiable(deductions);

  final HumanSolveStatus status;
  final SudokuBoard initialBoard;
  final HumanSolverState finalState;
  final List<Deduction> deductions;
}
