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
bad scan or entry. Constraint validation reports rule conflicts; it does not
determine whether a puzzle has a solution.

## Solver layers

1. **ExactSolver — implemented in Phase 3.** `BacktrackingExactSolver`
   determines mathematical solvability, returns a complete solution, counts
   solutions up to a caller-provided limit, and checks uniqueness by counting
   at most two. Rule-invalid or contradictory boards have zero solutions.
2. **HumanSolver — future Phase 4.** Will identify named, teachable deductions
   in technique order.
3. **CoachEngine — future phase.** Will convert structured deductions into
   progressive hint data for the app to localize and display.

Exact search validates the starting board, repeatedly places cells with a
single legal candidate, then branches on the empty cell with the fewest
candidates (MRV). Ties use the lowest cell index and digits are tried from
1 to 9. It uses immutable board copies and the core candidate/constraint
APIs. Its search path does **not** claim to be how a human should solve the
puzzle.

```dart
const solver = BacktrackingExactSolver();
final solution = solver.solve(board); // SudokuBoard?; null if unsolvable
final exists = solver.hasSolution(board);
final count = solver.countSolutions(board, limit: 2); // Stops at 2
final unique = solver.hasUniqueSolution(board);
```

`SudokuPuzzle` remains a minimal puzzle identity and given board. `SudokuMove`
remains a small semantic placement/elimination model. Gameplay progress and
undo history belong in the application.

Generator and difficulty components remain future work. No human technique,
hint, or puzzle generation algorithm is implemented in Phase 3.

Run `dart test` from this directory with the workspace's Dart SDK.
