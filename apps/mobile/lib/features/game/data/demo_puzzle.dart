import 'package:sudoku_engine/sudoku_engine.dart';

/// Offline Phase 6 puzzle. Content validation happens when GameCubit starts.
abstract final class DemoPuzzle {
  static final SudokuPuzzle standard = SudokuPuzzle(
    id: 'phase-6-standard',
    givens: SudokuBoard.parse('''
      530070000
      600195000
      098000060
      800060003
      400803001
      700020006
      060000280
      000419005
      000080079
    '''),
  );
}
