# Phase 10 visual audit closure

Source: `MICHI — Sudoku Coach.pdf` (106 raster pages), reviewed against the running Flutter app on iPhone SE (375×667), iPhone 16 (regular), and iPhone 16 Pro Max (440×956). The PDF imagery is the approved reference; its original vector layers are unavailable. Design comparison concerns the implemented Phase 1–10 surfaces. The PDF also depicts future product flows.

| Surface | PDF pages | Status | Evidence and precise deviation |
| --- | --- | --- | --- |
| Design system | 1–5, 103–106 | PASS | Paper, ivory, cream, indigo, coral, matcha, ochre and clay tokens; Lora display and Manrope UI; hairlines and flat cards checked against the PDF. |
| Splash | 6, 101 | PASS | Replaced alternate mascot with the approved page-6 artwork; corrected circle scale and vertical position on Compact and Large; removed the visible Start action. A short automatic route delay keeps the approved splash moment. Regular layout uses the same width/height constraints. |
| Welcome | 7 | INTENTIONAL DEVIATION | Apple, Google and email actions require the deferred auth backend. The PDF's embedded raster illustration cannot be separated into reusable transparent layers; the existing app art retains the composition. |
| Onboarding | 28–31 | INTENTIONAL DEVIATION | The four approved layouts and palette are present. Exact pose variants are embedded in flattened PDF pages and are unavailable as reusable assets. |
| Player level | 32 | INTENTIONAL DEVIATION | Selection UI follows the PDF; the choice is local because persistent preference/onboarding account state is outside the implemented flows. |
| Home | 37–44 | INTENTIONAL DEVIATION | Compact, Regular and Large layouts inspected and fit. The fresh-game action starts a puzzle rather than the PDF's first-lesson row because the Home learning recommendation model is deferred. Some illustration poses are unavailable separately from the flattened PDF. |
| Game and board | 45–55, 105 | PASS | Compact, Regular and Large board, selection, related cells, notes, mistakes, controls and keypad inspected. Board scales within the approved geometry and keeps controls reachable. |
| Pause and Coach | 48, 56–65 | PASS | Pause and four progressive hint states inspected on Regular; Compact Direction and Large Direction inspected. Shared responsive sheet and semantic board overlay are used for all levels and technique patterns; widget and Coach tests cover state variants. |
| Completion | 83–84, 104 | INTENTIONAL DEVIATION | Replaced hero with approved page-83 celebration artwork; editorial title, three metrics, earned Daily stamp, next technique row and Continue/Home actions now appear in Compact and Large captures. The PDF's logic score and seven-day streak need scoring/streak domain data that does not exist; the screen shows truthful solved-cell and Daily state. Technique feedback extends in the scroll area. |
| Learn | 66, 72, 79 | INTENTIONAL DEVIATION | Compact and Large path inspected; grouping, active card, progress nodes and future XY-Wing/Swordfish rows reflect the PDF. The PDF's Sudoku Basics/Candidates completion cannot be shown truthfully without those lesson/progress records. The exact cat pose is inseparable from the flattened page; the reusable approved app mascot is used. |
| Technique overview | 67, 72 | INTENTIONAL DEVIATION | Compact and Large layouts inspected. Engine-driven candidate example and reusable mascot replace PDF-specific flattened diagram artwork. All actions remain reachable by scrolling. |
| Lesson | 68, 73–74 | INTENTIONAL DEVIATION | Compact and Large inspected; engine-driven focused box/full-board diagrams retain true current candidates, so their cell values differ from static PDF examples. Fixed action remains reachable. |
| Practice and feedback | 69–70, 75–78 | INTENTIONAL DEVIATION | Compact initial and Large practice inspected; Regular X-Wing result and Naked Triple incorrect feedback inspected. Practice examples come from the validated scenario catalog, so their grids and success/summary compositions are data dependent rather than the PDF's single illustrative puzzle. Existing widget/BDD tests cover correct, almost and summary states. |
| Progress, Profile, Settings | 80–82, 88–100 | INTENTIONAL DEVIATION | Routes inspected. Their Phase-1 placeholders have no progress/profile/settings product models yet; implementing these full PDF screens is outside Phases 1–10. |
| Auth and Scanner | 8–27, 102 | INTENTIONAL DEVIATION | Routes inspected. Backend authentication and camera/OCR are explicitly deferred product phases; their PDF screens are reference material, not implemented flows. |

The implemented surfaces are design-accepted with the documented technical deviations. **1:1 pixel parity is not claimed.** No audit item remains unclassified. The PDF is flattened, so artwork extraction is limited to approved page regions that work as standalone raster assets; no vector source or Figma file is available.

## Visual checks

- Reopened PDF pages 6, 66, 83, 84 and 104 for the unresolved Splash, Learn and Completion decisions; compared current simulator captures with the corresponding pages.
- Regular iPhone: Splash, Welcome, Onboarding, Player Level, Home, Game selection/notes, Pause, all Coach levels; Hidden Pair, Box-Line, Naked Triple and X-Wing learning/practice states.
- Compact iPhone SE: Splash, Welcome, Home, Game, Coach Direction, Learn, Naked Single overview/lesson/practice and Completion. Long content scrolls and actions remain reachable.
- Large iPhone 16 Pro Max: Splash, Home, Game, Coach Direction, Completion, Learn, Technique overview, Lesson, Practice and Progress. No visible overflow in the inspected routes.
- Responsive widget tests also cover 375×667, 390×844 and 430×930 where applicable.

## Reference rules

Paper `#F7F2E8`; ivory `#FFFDF8`; cream `#EFE7DA`; indigo `#4D6275`; coral `#D9826B`; matcha `#56663F`; ochre `#86642A`; clay `#A8554C`. Lora is for editorial titles; Manrope is functional. Cards have no shadow; sheets alone use elevation. The game board follows `9 × clamp(floor((W − 38) / 9), 36, 44) + 14` with a compact height bound.
