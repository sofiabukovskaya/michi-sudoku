# Phase 13 scanner verification

Automated verification (Flutter 3.47.8):

- `dart format .`: 308 files checked, no changes.
- `dart run melos run generate`: passed for generated routing, DI, localization,
  Drift, and BDD code.
- `dart run melos run analyze`: all four workspace packages passed.
- `dart run melos run test`: 356 tests passed (2 design system, 182 mobile,
  12 scanner, 160 engine), including three scanner BDD scenarios.
- Android debug APK and iOS simulator debug app built successfully.
- `git diff --check`: passed.

Manual iPhone 16e simulator check (iOS 18.3):

1. Opened Home → Another puzzle → Scan Sudoku → Choose photo.
2. Selected the generated perspective Sudoku image from Photos. The grid was
   located, recognition completed, and Review showed all 81 editable cells.
3. Corrected seven interim recognizer mistakes. Duplicate conflicts cleared;
   confirmation accepted the uniquely solvable board.
4. Game showed the confirmed clues as immutable givens. Coach produced a hint,
   a player digit was entered, and Explanation opened for an imported given.
5. Force quit and relaunched the app. Home offered Continue, and the imported
   title, givens, player digit, and paused state restored.
6. Selected a blank image. The scanner showed its no-grid message with rescan
   and photo retry actions.

The clean generated photo is deterministic test art, not evidence of real-world
recognition accuracy. The temporary template classifier still requires careful
Review, especially for printed font variations, handwriting, glare, and blur.
Camera capture and permission behavior require a physical device; the simulator
does not provide a camera feed. Review layout is covered by widget tests at
320×568, 390×844, and 430×932 logical pixels.
