# michi_design_system

Flutter-only visual tokens and reusable controls. It contains no app navigation,
Sudoku logic or feature state. The current controls are representative Phase 1
primitives; more variants will be added alongside actual screens.

Theme Tailor generates `MichiPalette` as a `ThemeExtension`; components resolve
colors from the active theme. Light mode uses the approved MICHI palette. Dark
mode values remain deferred until they are designed.

Manrope and Lora variable font assets are bundled in `assets/fonts/` with their
Open Font License files. The Phase 6 Game uses the approved board and Coach
palette tokens, and the bottom sheet uses the approved radius and shadow.
