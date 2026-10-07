import '../model/sudoku_puzzle.dart';
import 'difficulty_analyzer.dart';

/// Generation is deferred; this contract is intentionally implementation-free.
abstract interface class SudokuGenerator {
  SudokuPuzzle generate(SudokuDifficulty difficulty);
}
