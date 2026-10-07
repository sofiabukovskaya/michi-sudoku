# michi_design_system

Flutter-only visual tokens and reusable controls. It contains no app navigation,
Sudoku logic or feature state. The current controls are representative Phase 1
primitives; more variants will be added alongside actual screens.

Theme Tailor generates `MichiPalette` as a `ThemeExtension`; components resolve
colors from the active theme. Light mode uses the approved MICHI palette. Dark
mode values remain deferred until they are designed.

The source PDF is flattened. Font family names are configured, but Manrope and
Lora font files must be provided before typography can match the design exactly.
