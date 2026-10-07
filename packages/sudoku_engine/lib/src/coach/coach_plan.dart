import '../human_solver/sudoku_technique.dart';
import 'coach_hint.dart';

final class CoachPlan {
  CoachPlan({required this.technique, required List<CoachHint> hints})
    : hints = List.unmodifiable(hints);

  final SudokuTechnique technique;
  final List<CoachHint> hints;
}
