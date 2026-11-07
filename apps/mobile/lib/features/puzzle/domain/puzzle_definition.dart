import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Product difficulty is based on the hardest supported logical technique.
enum PuzzleDifficulty { easy, medium, advanced, expert }

enum PuzzleSource { catalog, imported }

final class PuzzleDefinition {
  PuzzleDefinition({
    required this.id,
    required this.initialBoard,
    required this.difficulty,
    required Iterable<SudokuTechnique> requiredTechniques,
    required this.contentVersion,
    required this.dailyEligible,
    this.source = PuzzleSource.catalog,
    this.humanSolverFullySupported = true,
  }) : requiredTechniques = Set<SudokuTechnique>.unmodifiable(
         requiredTechniques,
       ) {
    if (id.isEmpty || contentVersion < 1) {
      throw ArgumentError('Puzzle identity and version are required.');
    }
  }

  factory PuzzleDefinition.imported({
    required SudokuBoard board,
    required bool humanSolverFullySupported,
    required Iterable<SudokuTechnique> requiredTechniques,
    PuzzleDifficulty? difficulty,
  }) => PuzzleDefinition(
    id: 'imported_${sha256.convert(utf8.encode(board.values.join()))}',
    initialBoard: board,
    difficulty: difficulty,
    requiredTechniques: requiredTechniques,
    contentVersion: 1,
    dailyEligible: false,
    source: PuzzleSource.imported,
    humanSolverFullySupported: humanSolverFullySupported,
  );

  final String id;
  final SudokuBoard initialBoard;
  final PuzzleDifficulty? difficulty;
  final Set<SudokuTechnique> requiredTechniques;
  final int contentVersion;
  final bool dailyEligible;
  final PuzzleSource source;
  final bool humanSolverFullySupported;

  SudokuPuzzle get puzzle => SudokuPuzzle(id: id, givens: initialBoard);
}
