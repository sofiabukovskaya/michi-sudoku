# MICHI — Sudoku Coach

MICHI is a local-first Flutter app for learning to solve Sudoku logically. The
Coach teaches the reasoning behind a move through progressive hints.
Phases 1–16 include the workspace foundation, Sudoku engine, playable Game and
Coach, local restoration, bundled puzzles, Learn and Practice, recommendations,
and a still-image scanner with a local printed-digit model and editable review.
Design audits record the visual
decisions for [Phase 10](docs/phase10_design_audit.md) and
[scanner Phase 13](docs/phase13_scanner_design_audit.md).

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
  lib/features/scanner/        Camera/photo capture, Review and import
  assets/practice/             Versioned production practice scenarios
  lib/features/                Other feature modules and placeholders
packages/sudoku_engine/        Pure Dart rules, solvers, Coach planning
packages/sudoku_scanner/       Flutter still-image recognition pipeline
packages/michi_design_system/  Flutter tokens and reusable controls
tools/sudoku_scanner_ml/        Python training, evaluation and export
```

Dependency direction:

```text
mobile ─┬─> sudoku_engine (pure Dart)
        ├─> sudoku_scanner (no game logic)
        └─> michi_design_system (no business logic)
```

The packages do not depend on each other. The mobile app converts a
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
version 7). `active_games` has one slot per local profile for the unfinished
game; `completed_games` is keyed by profile and game ID. Completion inserts its history row and
removes the matching active row in one transaction. Repeating a completion is
safe. `GameRepository` keeps SQL out of `GameCubit` and exposes active-game,
summary, completion and recent-history operations.
The v1→v2 migration adds nullable Daily challenge keys to active and completed
games without deleting existing data. The v2→v3 migration adds a technique
help ledger and technique progress table; migration tests preserve active and
completed games and Daily identity across both upgrades. A challenge key is separate from both
the stable puzzle ID and the unique game session ID.
Later migrations add reasoning, daily learning focus, and imported puzzle
metadata. Imported puzzle IDs derive from the confirmed 81-cell board hash;
`gameId` remains a separate session identity.
Phase 16 scopes user records to guest or Firebase UID profiles and migrates
legacy records into guest. The transactional outbox and per-device practice
contributions synchronize completed games, learning progress, and Daily
completion. See [Phase 16 local-first sync](docs/phase16_local_first_sync.md)
for merge rules, emulator verification, and live setup still required.

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
complete deduction trace, required techniques, clue count and
Easy/Medium/Advanced/Expert classification. The bundled pack is a test gate:
all 35 puzzles must have a unique solution, be solved by the supported HumanSolver,
and match their stored metadata. The current pack contains 12 Easy, 8 Medium,
12 Advanced and 3 Expert puzzles. Expert puzzles are excluded from Daily.
Advanced source puzzles were curated from [Peter Norvig's top95 corpus](https://www.norvig.com/top95.txt)
and checked against the exact solver and human trace. Distribution rights for
that source should be confirmed before a public release.

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

`TechniqueLesson` defines three semantic lesson steps and a Practice action for
Naked Single, Hidden Single, Naked Pair, Pointing Pair, Hidden Pair, Box-Line
Reduction, Naked Triple and X-Wing. Slang owns all six-language copy;
the pure-Dart engine remains responsible for deduction truth. Lesson examples
reuse the structured Sudoku board renderer in a read-only educational mode.

`TechniquePracticeScenario` stores a stable ID, target `SudokuTechnique`, board,
optional candidate snapshot and content version. The local `practice_v1.json`
pack contains five scenarios per technique, 40 total. A production-catalog test
parses every board, checks constraints
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

Tested with Flutter 3.47.8, Dart 3.13.7 and the native Android/iOS toolchains.
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
`cd apps/mobile && flutter build apk --debug` with Java 21.

## Accounts and local-first sync

Firebase Core and Authentication SDKs are integrated with the existing Android
and iOS app IDs. Optional email registration, sign-in, password reset, and email
verification are integrated with the MICHI account screens. Guest gameplay
remains local and available without Firebase. Authenticated completed games,
Daily completion, and technique progress synchronize through a Drift outbox;
active games stay on their owning device. Firestore rules restrict each UID to
its own progress, and an Auth deletion Function removes cloud data. Account
controls stay hidden until each Firebase provider and its platform setup is
verified; the Auth emulator can exercise email flows now. See the
[Phase 15 setup guide](docs/phase15_firebase_setup.md) for provider steps and
[Phase 16 sync](docs/phase16_local_first_sync.md) for the merge policy and
live deployment prerequisites.

The home screen selects a bundled puzzle by difficulty, starts or continues
today's Daily, or continues the saved game. Game, content, and Coach behavior
is covered by Cubit, catalog validation, migration, repository, widget, and
BDD tests under `apps/mobile/test/features/`.

## Printed Sudoku recognition

The scanner runs a bundled 32×32 grayscale, ten-class TFLite model on-device.
Python tooling trains and exports the model; the app does not use Python,
remote inference or image uploads. The classifier implements the existing
`DigitClassifier` contract, while editable Review and Sudoku validation remain
in the import flow. The model's official Wicht V2 real-photo holdout cell
accuracy is **92.10%** with **6.40 corrections per board on average**; this is
measured with annotated grid outlines, so grid detection quality is separate.
See the [evaluation](docs/phase14_scanner_ml_evaluation.md),
[model card](docs/phase14_digit_model_card.md), and
[reproduction guide](tools/sudoku_scanner_ml/README.md) for data provenance,
splits, metrics and limitations. CI checks Python tests, model loading,
Flutter analysis and workspace tests without retraining.

## Decisions and scope

- Dart pub workspaces and Melos share one lockfile and offer workspace commands.
- AutoRoute owns navigation. GetIt is used in bootstrap; widgets receive
  dependencies via constructors or future Cubits.
- Slang generates typed copy for English, Ukrainian, Czech, Spanish, French
  and German from `apps/mobile/lib/core/localization/i18n/`. Device language
  is selected at startup; Ukrainian is the fallback. Settings persists a
  device-local language preference.
- The engine uses immutable data and semantic deductions without localized text.
- The scanner recognizes still photos locally and returns digits with
  confidence. Capture, Review, validation, and import live in the mobile app.
- Theme Tailor generates the design system's palette extension. Approved
  colors, spacing, radius, motion and initial controls live in that package.
  Manrope and Lora font assets are bundled under the Open Font License.
- Existing starter Android and iOS identifiers (`com.example...`) are retained
  until a production application identifier is chosen.

The engine supports constraints, candidates, exact solving, structured human
deductions for eight techniques, and four-level semantic Coach plans.
See [the engine README](packages/sudoku_engine/README.md) for the APIs and
responsibility boundaries. Cross-device active games, leaderboards,
subscriptions, XY-Wing, Swordfish, and unrelated visual screens remain future
work.

Phase 17 remote content, Daily publishing, cache, and reminder operations are documented in [docs/phase17_remote_content.md](docs/phase17_remote_content.md).
