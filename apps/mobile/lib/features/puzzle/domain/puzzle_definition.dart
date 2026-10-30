import 'package:sudoku_engine/sudoku_engine.dart';

/// Product difficulty is based on the hardest supported logical technique.
enum PuzzleDifficulty { easy, medium }

final class PuzzleDefinition {
  PuzzleDefinition({
    required this.id,
    required this.initialBoard,
    required this.difficulty,
    required Iterable<SudokuTechnique> requiredTechniques,
    required this.contentVersion,
    required this.dailyEligible,
  }) : requiredTechniques = Set<SudokuTechnique>.unmodifiable(
         requiredTechniques,
       ) {
    if (id.isEmpty || contentVersion < 1) {
      throw ArgumentError('Puzzle identity and version are required.');
    }
  }

  final String id;
  final SudokuBoard initialBoard;
  final PuzzleDifficulty difficulty;
  final Set<SudokuTechnique> requiredTechniques;
  final int contentVersion;
  final bool dailyEligible;

  SudokuPuzzle get puzzle => SudokuPuzzle(id: id, givens: initialBoard);
}
