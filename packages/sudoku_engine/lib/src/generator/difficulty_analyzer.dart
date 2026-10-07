import '../human_solver/sudoku_technique.dart';
import '../model/sudoku_puzzle.dart';

enum SudokuDifficulty { beginner, intermediate, advanced, expert }

final class DifficultyAssessment {
  DifficultyAssessment(this.level, List<SudokuTechnique> requiredTechniques)
    : requiredTechniques = List.unmodifiable(requiredTechniques);

  final SudokuDifficulty level;
  final List<SudokuTechnique> requiredTechniques;
}

abstract interface class DifficultyAnalyzer {
  DifficultyAssessment analyze(SudokuPuzzle puzzle);
}
