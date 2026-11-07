# Phase 13 scanner design audit

The approved `MICHI — Sudoku Coach.pdf` remains the reference for MICHI's paper,
ivory, indigo, coral, typography, radii, and button treatment. It does not
provide a complete scanner capture or Review artboard. The Phase 13 screens use
the existing design-system tokens and controls with the following explicit
scanner-specific decisions:

- Capture uses a square camera preview and a simple inset frame guide. The
  frame is guidance only; it does not claim to be the detected grid.
- Photo import remains available when the camera is unavailable or denied.
- Processing has a single progress state. Failure states explain what happened
  and provide rescan and photo retry actions.
- Review displays an editable 9×9 board, digit keypad, clear action, and
  localized conflict and solvability messages. Coral review markers use `?`;
  duplicate conflicts use `!`. Cell semantics also announce the state, so
  information is not conveyed by color alone.
- The board width is bounded by the available screen width and 430 logical
  pixels. Controls scroll below it on compact screens. Widget tests cover
  320×568, 390×844, and 430×932 viewports.

This work uses actual `SudokuScanResult` data. The design PDF is a visual
reference, not a source of Sudoku clues or solving rules.
