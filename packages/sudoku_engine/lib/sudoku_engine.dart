/// Deterministic Sudoku domain models and contracts. No Flutter dependency.
library;

export 'src/coach/coach_engine.dart';
export 'src/coach/coach_hint.dart';
export 'src/coach/coach_plan.dart';
export 'src/core/candidate_calculator.dart';
export 'src/core/sudoku_constraints.dart';
export 'src/core/sudoku_unit.dart';
export 'src/generator/difficulty_analyzer.dart';
export 'src/generator/sudoku_generator.dart';
export 'src/human_solver/deduction.dart';
export 'src/human_solver/human_solver.dart';
export 'src/human_solver/sudoku_technique.dart';
export 'src/model/candidate_mask.dart';
export 'src/model/cell_ref.dart';
export 'src/model/sudoku_board.dart';
export 'src/model/sudoku_move.dart';
export 'src/model/sudoku_puzzle.dart';
export 'src/solver/exact_solver.dart';
