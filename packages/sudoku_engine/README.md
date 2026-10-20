# sudoku_engine

Pure Dart Sudoku domain package. It has no Flutter, Firebase, UI, or localization
dependency.

## Phase 2 core

- `CellRef` uses zero-based rows and columns (`0..8`). Its flat index is
  `row * 9 + column` (`0..80`); its box is `(row ~/ 3) * 3 + column ~/ 3`.
  A UI may label `CellRef(row: 0, column: 0)` as `r1c1`.
- `SudokuBoard` stores 81 row-major integer values: `0` is empty and `1..9`
  are digits. It copies input, exposes an unmodifiable value list, and
  `withValue` returns a new board. `parse` accepts 81 digits, whitespace, and
  `.` as another empty marker.
- `SudokuUnit` provides the nine cells in each row, column, and box.
  `SudokuConstraints.peersOf` returns 20 unique peers per cell.
- `CandidateMask` stores digit `d` in bit `d - 1`. `0x1ff` represents all
  digits. `CandidateCalculator` derives candidate masks from a board. Filled
  cells return an empty mask, and contradictory empty cells may also have none.
- `SudokuConstraints.validate` reports repeated nonzero digits as structured
  row, column, and box violations. Each violation includes its digit, unit,
  and every affected cell. Ordering is rows, columns, boxes; then unit index
  and digit.

Board construction enforces only the 81-cell shape and digit range. A board
with conflicting digits remains representable, so validation can explain a
bad scan or entry. This validation checks Sudoku constraints only. **Phase 2
does not determine whether a puzzle is solvable or has a unique solution.**
That belongs to the Phase 3 `ExactSolver`.

`SudokuPuzzle` remains a minimal puzzle identity and given board. `SudokuMove`
remains a small semantic placement/elimination model. Gameplay progress and
undo history belong in the application.

Later, `HumanSolver` will find teachable deductions, `CoachEngine` will turn
them into progressive hints, and generator/difficulty components will create
and classify puzzles. None of those algorithms are implemented here.

Run `dart test` from this directory with the workspace's Dart SDK.
