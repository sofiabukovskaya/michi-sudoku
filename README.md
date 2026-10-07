# MICHI — Sudoku Coach

MICHI is a local-first Flutter app for learning to solve Sudoku logically. The
Coach will teach the reasoning behind a move rather than reveal an answer.
This repository currently contains the **Phase 1 architecture only**.

## Workspace

```text
apps/mobile/                   Flutter app (iOS and Android)
  lib/app/                     Bootstrap, router, theme
  lib/core/                    DI, errors, localization, persistence models
  lib/features/                Feature-first UI and future feature modules
packages/sudoku_engine/        Pure Dart Sudoku domain contracts
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
features with stateful behavior.

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
Theme Tailor code. Generated files stay in the source tree so the app can build
immediately after checkout. For a direct Android build, run
`cd apps/mobile && flutter build apk --debug`.

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
  The flattened design PDF does not provide font files; Manrope
  and Lora are named in typography tokens, with system fallback until assets are
  supplied.
- Existing starter Android and iOS identifiers (`com.example...`) are retained
  until a production application identifier is chosen.

Phase 2 will implement Sudoku constraints, candidates, exact and human solvers,
then Coach deductions and game state. Firebase, scanning, ML and full visual
screens remain outside this phase.
