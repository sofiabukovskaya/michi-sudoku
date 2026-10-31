import 'package:sudoku_engine/sudoku_engine.dart';

/// Immutable content; the current Deduction is derived at session start.
final class TechniquePracticeScenario {
  const TechniquePracticeScenario({
    required this.id,
    required this.technique,
    required this.board,
    required this.contentVersion,
    this.candidateOverrides = const {},
  });

  final String id;
  final SudokuTechnique technique;
  final SudokuBoard board;
  final int contentVersion;

  /// Candidate removals from earlier logical steps in this puzzle.
  /// Keys are zero-based cell indexes; values use CandidateMask bits.
  final Map<int, int> candidateOverrides;

  HumanSolverState get initialState {
    final legal = const CandidateCalculator().calculateAll(board);
    return HumanSolverState.fromCandidates(
      board: board,
      candidates: {
        for (final entry in legal.entries)
          entry.key: candidateOverrides.containsKey(entry.key.index)
              ? CandidateMask(candidateOverrides[entry.key.index]!)
              : entry.value,
      },
    );
  }
}
