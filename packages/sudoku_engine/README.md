# sudoku_engine

Pure Dart domain package. It has no Flutter, Firebase, UI or localization
dependency.

- **ExactSolver** will find mathematical solutions and count up to two solutions
  to verify uniqueness.
- **HumanSolver** will find deterministic, teachable deductions in technique
  order. It will return structured evidence, eliminations and placements.
- **CoachEngine** will turn a verified deduction into progressive hint data.
  The mobile app will localize and display that data.
- **SudokuGenerator** and **DifficultyAnalyzer** are contracts for later puzzle
  content work.

Phase 1 includes immutable board and candidate types, technique identifiers,
deduction and Coach models, plus implementation-free solver contracts. Technique
implementations will be added with the algorithms in Phase 2 rather than as
nonfunctional placeholders.

Run `dart test` from this directory.
