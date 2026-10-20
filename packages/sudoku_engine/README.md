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
2. **HumanSolver — implemented in Phase 4.** `DeterministicHumanSolver`
   identifies named, teachable deductions from the current board and logical
   candidate state. It never consults exact search when choosing a move.
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

## Human reasoning

`HumanSolverState.initial(board)` derives legal candidate masks for empty
cells. The immutable state stores those masks separately from `SudokuBoard`:
board values alone cannot retain a Naked Pair or Pointing Pair elimination.
Applying a `Deduction` creates a new state, removes the specified candidates,
places any digits, and intersects the remaining masks with the new board's
legal candidates. A previously eliminated candidate never reappears after an
unrelated placement. Invalid deduction actions throw `StateError`; an invalid
board or impossible candidate state is reported as a contradiction.

Each deduction contains a technique ID, focus cells, structured evidence,
candidate eliminations, and/or digit placements. Evidence is semantic data
(`CandidateSetEvidence`, `UnitCandidateEvidence`, `UnitEvidence`), with no
localized text. The app can later turn it into Coach hints and explanations.

Phase 4 supports **Naked Single**, **Hidden Single**, **Naked Pair**, and
**Pointing Pair**, in that priority order. Within a technique, scanning is
deterministic: cells by index; units as rows, columns, then boxes; digits in
ascending order. Hidden Single keeps the first row/column/box evidence path
when the same placement is found more than once.

```dart
const humanSolver = DeterministicHumanSolver();
final state = HumanSolverState.initial(board);
final next = humanSolver.findNextDeduction(state); // Deduction?; null if none
final result = humanSolver.solveLogically(board); // status, finalState, trace
```

`HumanSolveResult` preserves the ordered deduction trace and ends with
`solved`, `stuck`, or `contradiction`. **Stuck is a valid result:** a perfectly
solvable Sudoku may require a technique outside the current catalogue. Human
reasoning does not determine mathematical solvability or uniqueness; use
`ExactSolver` for those questions. Exact search is used only as a test oracle
for the HumanSolver regression fixtures.

`SudokuPuzzle` remains a minimal puzzle identity and given board. `SudokuMove`
remains a small semantic placement/elimination model. Gameplay progress and
undo history belong in the application.

Coach hint planning, more advanced human techniques, generator, and difficulty
analysis remain future work.

Run `dart test` from this directory with the workspace's Dart SDK.
