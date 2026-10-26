# MICHI — Sudoku Coach

MICHI is a local-first Flutter app for learning to solve Sudoku logically. The
Coach teaches the reasoning behind a move through progressive hints.
Phases 1–7 are implemented: the workspace foundation, Sudoku domain rules,
exact mathematical solver, initial human reasoning, progressive Coach planning,
and a playable Game and Coach flow with local game restoration.

## Workspace

```text
apps/mobile/                   Flutter app (iOS and Android)
  lib/app/                     Bootstrap, router, theme
  lib/core/                    DI, errors, localization, clock
  lib/features/game/           Play state, board rendering and controls
    data/                       Drift database, repository and codecs
    domain/                     App-facing game persistence contract
  lib/features/coach/          Semantic hint presentation
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
version 1). `active_games` has a single slot for the unfinished game;
`completed_games` is keyed by game ID. Completion inserts its history row and
removes the matching active row in one transaction. Repeating a completion is
safe. `GameRepository` keeps SQL out of `GameCubit` and exposes active-game,
summary, completion and recent-history operations.

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

The home screen opens a bundled demo puzzle or continues the saved game. Game and Coach
behavior is covered by Cubit tests, widget tests, and BDD scenarios under
`apps/mobile/test/features/game/`. Run only those tests with
`cd apps/mobile && flutter test test/features/game`.

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
responsibility boundaries. Firebase, scanning, ML, a production puzzle catalog,
Daily Sudoku and unrelated visual screens remain future work.
