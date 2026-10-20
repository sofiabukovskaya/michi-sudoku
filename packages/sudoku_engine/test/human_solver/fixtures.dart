import 'package:sudoku_engine/sudoku_engine.dart';

/// Starts from structurally legal candidates and replaces selected masks.
HumanSolverState stateWithMasks(
  Map<CellRef, CandidateMask> overrides, {
  SudokuBoard? board,
}) {
  final initial = HumanSolverState.initial(board ?? SudokuBoard.empty());
  return HumanSolverState.fromCandidates(
    board: initial.board,
    candidates: {...initial.candidates, ...overrides},
  );
}

CandidateMask mask(Iterable<int> digits) => CandidateMask.fromDigits(digits);

CellRef cell(int row, int column) => CellRef(row: row, column: column);
