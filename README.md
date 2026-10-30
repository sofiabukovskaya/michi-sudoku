# MICHI — Sudoku Coach

MICHI is a local-first Flutter app for learning to solve Sudoku logically. The
Coach teaches the reasoning behind a move through progressive hints.
Phases 1–9 are implemented: the workspace foundation, Sudoku domain rules,
exact mathematical solver, initial human reasoning, progressive Coach planning,
playable Game and Coach, local game restoration, bundled puzzle content, and
the first Learn and Practice loop.

## Workspace

```text
apps/mobile/                   Flutter app (iOS and Android)
  lib/app/                     Bootstrap, router, theme
  lib/core/                    DI, errors, localization, clock
  lib/features/game/           Play state, board rendering and controls
    data/                       Drift database, repository and codecs
    domain/                     App-facing game persistence contract
  lib/features/coach/          Semantic hint presentation
  lib/features/puzzle/         Catalog, analysis, Daily and selection
  assets/puzzles/              Versioned production Sudoku pack
  lib/features/learn/          Lessons and local learning progress
  lib/features/practice/       Focused technique exercises and Coach
  assets/practice/             Versioned production practice scenarios
  lib/features/                Other feature modules and placeholders
packages/sudoku_engine/        Pure Dart rules, solvers, Coach planning
packages/sudoku_scanner/       Flutter image recognition contracts
packages/michi_design_system/  Flutter tokens and reusable controls
```

Dependency direction:

```text
mobile ─┬─> sudoku_engine (pure Dart)
        ├─> sudoku_scanner (no game logic)
        └─> michi_design_system (no business logic)
```

The packages do not depend on each other. The mobile app will convert a
confirmed scan into an engine board. Sudoku logic never depends on Flutter,
Firebase, camera types, or localized UI copy.

Features add `data/`, `domain/`, and `presentation/` only when each layer has a
real responsibility. Placeholder pages are stateless; no placeholder Cubits or
repositories have been created. `flutter_bloc` and `bloc_test` are ready for
features with stateful behavior. `GameCubit` owns board entries, manual notes,
selection, undo, mistakes, timer and Coach progression. The board is painted from
immutable view state, with a semantic target for each cell. Coach copy is
mapped from structured engine hints into Slang translations.

## Local game storage

The mobile app uses Drift with a SQLite database named `michi_games` (schema
version 3). `active_games` has a single slot for the unfinished game;
`completed_games` is keyed by game ID. Completion inserts its history row and
removes the matching active row in one transaction. Repeating a completion is
safe. `GameRepository` keeps SQL out of `GameCubit` and exposes active-game,
summary, completion and recent-history operations.
The v1→v2 migration adds nullable Daily challenge keys to active and completed
games without deleting existing data. The v2→v3 migration adds a technique
help ledger and technique progress table; migration tests preserve active and
completed games and Daily identity across both upgrades. A challenge key is separate from both
the stable puzzle ID and the unique game session ID.

Boards are stored as 81-character `0`–`9` strings. Player pencil notes are
JSON from zero-based cell index to `CandidateMask` bits. The last 100 meaningful
board/note snapshots are stored as undo history. Mistakes remain cumulative
when an action is undone. Selection and open Coach panels are transient;
restored games reopen paused. Startup skips onboarding when a saved game exists.
A corrupt active record is logged and removed,
while completed history is retained. Unsupported future schema versions fail
explicitly until a migration is added.

Each meaningful action queues a serialized save. The timer stores accumulated
duration and a running wall-clock timestamp; a monotonic clock measures the
current foreground run. Pausing or backgrounding records the accumulated time
without writing every second. If a process stops without a pause callback,
restoration adds a bounded wall-clock gap and reopens paused. Home progress is
correctly filled editable cells divided by all editable cells, so wrong digits
never increase progress. Starting another game asks for confirmation.

## Puzzle content and Daily Sudoku

`PuzzleDefinition` is immutable content: a stable ID, givens, technique-based
difficulty, required `SudokuTechnique` values, pack version and Daily
eligibility. It contains no player progress. `PuzzleCatalog` loads
`apps/mobile/assets/puzzles/classic_v1.json` once and checks its schema.
`PuzzleAnalyzer` uses the ExactSolver for uniqueness and the HumanSolver for a
complete deduction trace, required techniques, clue count and Easy/Medium
classification. The actual bundled pack is a test gate: all 20 internally
authored puzzles must have a unique solution, be solved by the current
HumanSolver, and match their stored metadata. Easy uses singles; Medium needs
Naked Pair or Pointing Pair. Harder labels wait for supported techniques.

`PuzzleRepository` keeps Home and Game independent of JSON. The bundled
`LocalPuzzleRepository` selects by difficulty, excludes the active puzzle and
the last 20 completed IDs, and replays the least recently completed eligible
puzzle when exhausted. A future remote repository can implement the same
boundary. No network is needed for New Game or Daily.

Daily uses the user's **local calendar date**. The stable key
`YYYY-MM-DD|catalog-vN` is hashed with 32-bit FNV-1a over UTF-8, then mapped
onto daily-eligible IDs in sorted order. The same date and pack version map to
the same puzzle on every device. Home refreshes when resumed and after a game;
completion is queried by challenge key, even if the puzzle ID appears again.
Changing the catalog mapping requires a version bump. This local-date policy
may change when a published backend Daily challenge is introduced.

## Learn and technique practice

`TechniqueLesson` defines static, semantic five-step content for Naked Single,
Hidden Single, Naked Pair, and Pointing Pair. Slang owns all six-language copy;
the pure-Dart engine remains responsible for deduction truth. Lesson examples
reuse the structured Sudoku board renderer in a read-only educational mode.

`TechniquePracticeScenario` stores a stable ID, target `SudokuTechnique`, board,
and content version. The local `practice_v1.json` pack contains five scenarios
per technique. A production-catalog test parses every board, checks constraints
and solution uniqueness, verifies that the first `HumanSolver` deduction is the
target technique with a meaningful placement or elimination, and builds all
four `StructuredCoachEngine` hint levels. `PracticeCubit` runs a five-exercise
session independently of `GameCubit`. Placement answers match engine placements;
candidate selections must exactly match engine eliminations. Incorrect checks
offer retry or progressive Coach help. Practice candidates come from the
engine, not the player's Game notes.

`TechniqueProgressRepository` persists per-technique aggregates through Drift.
Attempts include wrong checks; correct attempts count completed exercises.
`firstTryCorrect` counts correct answers with no hint and no earlier wrong check.
The independent streak resets on a wrong or hint-assisted check. The deepest
hint level used for a successful exercise is tracked separately for Direction,
Focus, Reasoning, and Result. Mastery v1 is deterministic: **New** before any
check, **Learning** after a check, **Practicing** from three correct exercises,
and **Mastered** after at least five correct exercises, four independent first
tries, and three consecutive independent successes. A normal game never awards
mastery. Its completion screen shows catalog `requiredTechniques` and the
persisted highest Coach level reached for each helped technique, without
reanalyzing the puzzle. These aggregates can later support recommendations;
no recommendation algorithm is included yet.

## Setup

Tested with Flutter 3.41.6, Dart 3.11.4 and the native Android/iOS toolchains.
Use the Dart SDK bundled with that Flutter installation if another `dart`
launcher on your `PATH` reports an older SDK.

```sh
flutter pub get
dart run melos bootstrap
dart run melos run generate
dart run melos run format
dart run melos run analyze
dart run melos run test
cd apps/mobile && flutter run
```

`dart run melos run generate` runs `build_runner` in the mobile and design
system packages. It produces AutoRoute, injectable, Freezed, JSON, Slang and
Theme Tailor code, plus BDD widget tests. Generated files stay in the source tree so the app can build
immediately after checkout. For a direct Android build, run
`cd apps/mobile && flutter build apk --debug`.

The home screen selects a bundled puzzle by difficulty, starts or continues
today's Daily, or continues the saved game. Game, content, and Coach behavior
is covered by Cubit, catalog validation, migration, repository, widget, and
BDD tests under `apps/mobile/test/features/`.

## Decisions and scope

- Dart pub workspaces and Melos share one lockfile and offer workspace commands.
- AutoRoute owns navigation. GetIt is used in bootstrap; widgets receive
  dependencies via constructors or future Cubits.
- Slang generates typed copy for English, Ukrainian, Czech, Spanish, French
  and German from `apps/mobile/lib/core/localization/i18n/`. Device language
  is selected at startup; Ukrainian is the fallback. LocaleSettings can be
  wired to Settings when that screen is implemented.
- The engine uses immutable data and semantic deductions without localized text.
- The scanner exposes encoded image data and confidence, without camera or OCR
  implementations.
- Theme Tailor generates the design system's palette extension. Approved
  colors, spacing, radius, motion and initial controls live in that package.
  Manrope and Lora font assets are bundled under the Open Font License.
- Existing starter Android and iOS identifiers (`com.example...`) are retained
  until a production application identifier is chosen.

The engine supports constraints, candidates, exact solving, structured human
deductions for four techniques, and four-level semantic Coach plans.
See [the engine README](packages/sudoku_engine/README.md) for the APIs and
responsibility boundaries. Firebase, scanning, ML, streaks, leaderboards,
subscriptions, advanced techniques, and unrelated visual screens remain
future work.
