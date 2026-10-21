# MICHI — Sudoku Coach

MICHI is a local-first Flutter app for learning to solve Sudoku logically. The
Coach teaches the reasoning behind a move through progressive hints.
Phases 1–6 are implemented: the workspace foundation, Sudoku domain rules,
exact mathematical solver, initial human reasoning, progressive Coach planning,
and a playable Game and Coach vertical slice.

## Workspace

```text
apps/mobile/                   Flutter app (iOS and Android)
  lib/app/                     Bootstrap, router, theme
  lib/core/                    DI, errors, localization, persistence models
  lib/features/game/           Play state, board rendering and controls
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
selection, undo, mistakes and Coach progression. The board is painted from
immutable view state, with a semantic target for each cell. Coach copy is
mapped from structured engine hints into Slang translations.

## Setup

Tested with Flutter 3.41.6, Dart 3.11.4 and the native Android/iOS toolchains.

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

The home screen opens a bundled demo puzzle for the Phase 6 game. Game and Coach
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
responsibility boundaries. Phase 6 adds localized hint presentation and local
game state. Persistence, Firebase, scanning, ML, and unrelated visual screens
remain future work.
