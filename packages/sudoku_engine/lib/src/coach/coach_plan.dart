import 'package:meta/meta.dart';

import '../human_solver/deduction.dart';
import '../human_solver/sudoku_technique.dart';
import 'coach_hint.dart';

/// Stateless four-step disclosure plan for exactly one deduction.
@immutable
final class CoachPlan {
  CoachPlan({required this.deduction, required List<CoachHint> hints})
    : hints = List<CoachHint>.unmodifiable(hints) {
    if (this.hints.length != CoachHintLevel.values.length) {
      throw ArgumentError('A Coach plan must contain exactly four hints.');
    }
    for (var index = 0; index < this.hints.length; index++) {
      if (this.hints[index].level != CoachHintLevel.values[index]) {
        throw ArgumentError('Coach hints must be ordered by level.');
      }
    }
    final result = this.hints.last;
    if (!_sameList(result.revealedEliminations, deduction.eliminations) ||
        !_sameList(result.revealedPlacements, deduction.placements)) {
      throw ArgumentError('The result hint must match the deduction action.');
    }
  }

  final Deduction deduction;
  final List<CoachHint> hints;

  SudokuTechnique get technique => deduction.technique;
  int get length => hints.length;
  CoachHint get first => hints.first;
  CoachHint get last => hints.last;

  CoachHint hintForLevel(CoachHintLevel level) => hints[level.index];

  @override
  bool operator ==(Object other) =>
      other is CoachPlan &&
      deduction == other.deduction &&
      _sameList(hints, other.hints);

  @override
  int get hashCode => Object.hash(deduction, Object.hashAll(hints));
}

bool _sameList<T>(List<T> left, List<T> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}
