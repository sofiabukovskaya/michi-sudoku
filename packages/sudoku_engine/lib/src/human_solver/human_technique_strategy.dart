import 'deduction.dart';
import 'human_solver_state.dart';
import 'sudoku_technique.dart';

/// A deterministic pattern detector. It reads state but never changes it.
abstract interface class HumanTechniqueStrategy {
  SudokuTechnique get technique;

  /// Returns applicable deductions in stable order, or an empty list.
  List<Deduction> find(HumanSolverState state);
}
