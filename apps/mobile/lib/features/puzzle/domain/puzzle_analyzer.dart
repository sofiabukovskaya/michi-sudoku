import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class PuzzleAnalysis {
  PuzzleAnalysis({
    required this.isValid,
    required this.hasSolution,
    required this.hasUniqueSolution,
    required this.humanResult,
    required Iterable<SudokuTechnique> requiredTechniques,
    required this.hardestTechnique,
    required this.difficulty,
    required this.clueCount,
  }) : requiredTechniques = Set<SudokuTechnique>.unmodifiable(
         requiredTechniques,
       );

  final bool isValid;
  final bool hasSolution;
  final bool hasUniqueSolution;
  final HumanSolveResult? humanResult;
  final Set<SudokuTechnique> requiredTechniques;
  final SudokuTechnique? hardestTechnique;
  final PuzzleDifficulty? difficulty;
  final int clueCount;

  bool get isProductionReady =>
      isValid &&
      hasUniqueSolution &&
      humanResult?.status == HumanSolveStatus.solved &&
      difficulty != null;
}

/// Expensive content validation for tests and editorial tooling, not Home.
final class PuzzleAnalyzer {
  const PuzzleAnalyzer(this.exactSolver, this.humanSolver);

  final ExactSolver exactSolver;
  final HumanSolver humanSolver;

  static const List<SudokuTechnique> techniqueOrder =
      SudokuTechniqueOrder.supported;

  PuzzleAnalysis analyze(SudokuBoard board) {
    final valid = SudokuConstraints.validate(board).isValid;
    final count = valid ? exactSolver.countSolutions(board) : 0;
    final human = count == 1 ? humanSolver.solveLogically(board) : null;
    final techniques =
        human?.deductions.map((item) => item.technique).toSet() ??
        <SudokuTechnique>{};
    final hardest = techniqueOrder.reversed
        .where(techniques.contains)
        .firstOrNull;
    final difficulty = switch (hardest) {
      null => null,
      SudokuTechnique.nakedSingle ||
      SudokuTechnique.hiddenSingle => PuzzleDifficulty.easy,
      SudokuTechnique.nakedPair ||
      SudokuTechnique.pointingPair => PuzzleDifficulty.medium,
      SudokuTechnique.hiddenPair ||
      SudokuTechnique.boxLineReduction ||
      SudokuTechnique.nakedTriple => PuzzleDifficulty.advanced,
      SudokuTechnique.xWing => PuzzleDifficulty.expert,
      _ => null,
    };
    return PuzzleAnalysis(
      isValid: valid,
      hasSolution: count > 0,
      hasUniqueSolution: count == 1,
      humanResult: human,
      requiredTechniques: techniques,
      hardestTechnique: hardest,
      difficulty: difficulty,
      clueCount: board.filledCellCount,
    );
  }
}
