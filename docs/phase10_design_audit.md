# Phase 10 design audit

Source: `MICHI — Sudoku Coach.pdf` (106 pages), the approved visual source of truth. Every page was reviewed. PDF screens use Ukrainian examples; app copy remains localized with Slang in English, Ukrainian, Czech, Spanish, French, and German.
The user confirmed that the PDF imagery should remain the reference for this audit. The PDF contains a raster image for each page, so original vector layers are not available from it.

| Implemented surface | PDF pages | Corrections made | Remaining difference / status |
| --- | --- | --- | --- |
| Design system | 1–5, 103–106 | Aligned paper, ivory, cream, indigo, coral, matcha, ochre and clay tokens; Lora display and Manrope functional type; thin progress line; no card shadows. | Core tokens aligned. Exact per-component pixel parity needs signoff. |
| Splash | 6, 101 | Indigo field, centered mascot circle, wordmark, editorial tagline; scaled mascot for short windows. | iPhone SE inspected: the artwork sits higher than on PDF page 6. Visible Start action retained for navigation; PDF has none. Mascot is the existing raster app asset, not the exact PDF pose. |
| Welcome | 7 | Wordmark, board and mascot composition, editorial heading, guest action. | PDF Apple, Google and email actions absent because those backends remain deferred. Illustration approximate. |
| Onboarding | 28–31 | Four pages, approved palette, progress paws, board/path/mascot compositions. | Illustration details and poses approximate. |
| Player level | 32 | Four selectable cards and matching action hierarchy. | Choice is local to the page, not persisted. |
| Home | 37–44 | Daily hero, greeting, active game card, week strip and four-tab navigation; Daily hero now grows to fit wrapped localized copy. | iPhone SE layout inspected and fits. Fresh Home keeps “Another puzzle” rather than PDF first-lesson row; art and some copy differ. |
| Game and board states | 45–55, 105 | State-driven board geometry, given/entered digits, selection, peers, notes, mistakes, controls and keypad; board resized for short viewports. | Regular iPhone game, selection and notes inspected. iPhone SE board and controls fit. Large-screen manual review outstanding. |
| Pause and Coach | 48, 56–65 | Four structured levels, small mascot, unavailable hint handling; regular iPhone pause and all four hint levels inspected. | iPhone SE Coach Level 1 fits. Other compact Coach levels, unavailable state and other technique patterns need simulator signoff. |
| Completion | 83–84, 104 | Indigo hero, board art, mascot, three metrics, feedback and Home action. | Solved-cell count substitutes for PDF “logic” score; stamp and recommended lesson absent; hero art differs. |
| Learn | 66, 72, 79 | Grouped path, active coral card, locked later rows and bottom navigation. | iPhone SE path inspected and fits as a scrolling view. PDF page 66 has Sudoku Basics and Candidates entries plus future advanced techniques; the app has the eight Phase 10 supported techniques. Path art and exact card geometry differ. |
| Technique overview | 67, 72 | Editorial title, candidate example, mascot, thin mastery line and four-row plan; pair and triple examples use deduction data. | iPhone SE Naked Single overview inspected; its lesson plan scrolls behind the fixed action area. Example and mascot use programmatic/existing assets rather than exact PDF art. |
| Lesson | 68, 73–74 | Segmented progress, focused 3×3 box diagram for box deductions, full board for row/column patterns, real engine state. | iPhone SE Naked Single lesson inspected: the board and fixed action fit; explanatory copy continues in the scroll view. Exact diagram layout differs from the PDF examples. |
| Practice and feedback | 69–70, 75–78 | Focused box diagram where applicable; full board for row/column patterns; matcha correct and ochre almost feedback; progress and summary. | iPhone SE Naked Single Practice inspected and fits. PDF page 69 shows a pair success state, while the inspected app state was initial single practice. Art and some feedback composition differ; success and summary need further simulator comparison. |
| Progress, Profile, Settings | 80–82, 88–100 | Routes inspected. | These remain placeholders or limited Phase 1 navigation and are not visually matched. |
| Auth and Scanner | 8–27, 102 | Routes inspected. | Product flows deferred; placeholders outside implemented product scope. |

## Manual comparisons completed

- Reviewed all 106 PDF pages and reopened approved references after changes.
- Compared running iPhone 16 against PDF Splash, Welcome, Onboarding, Player Level, Home, Game, selected cells, notes, Pause and all four Coach hint levels.
- Inspected Hidden Pair, Box-Line Reduction, Naked Triple and X-Wing overview, lesson and Practice on the iPhone 16; inspected X-Wing Coach through Result and Naked Triple incorrect feedback. A thin row excerpt found during inspection was replaced with full-board context for row/column deductions.
- Captured and inspected an iPhone 16 Game/Coach Direction screenshot after corrections. Launched MICHI on iPhone 16 Pro Max (440×956) and compared its Splash screenshot against PDF page 6; its mascot pose, raster sharpness and Start action still differ. Other large-screen routes were not inspected.
- Launched MICHI on an iPhone SE (375×667) and inspected Splash, Welcome, Home, Game, Coach Level 1, Learn, Naked Single overview, lesson and initial Practice. The compact Home, Game, Coach, Learn and Practice layouts fit without visible clipping. Lesson copy continues by scrolling beneath the fixed action. The Splash artwork sits higher than in the PDF composition. Onboarding and Player Level were traversed, but were not compared visually page by page.
- Widget tests cover 375×667, 390×844 and 430×930 where those surfaces are tested. They do not replace manual review of every state on Compact and Large devices.

## Outstanding acceptance work

The PDF comparison has **not** reached 1:1 parity. Compact routes beyond the screens listed above, large-screen routes beyond Splash, unavailable Coach, completion, Practice success/summary and exact illustrations still require review. The table records known product differences. Do not claim Phase 10 visual parity is complete until these are resolved or expressly accepted.

## Rules used during review

Paper `#F7F2E8`; ivory `#FFFDF8`; cream `#EFE7DA`; indigo `#4D6275`; coral `#D9826B`; matcha `#56663F`; ochre `#86642A`; clay `#A8554C`. Lora is for editorial titles; Manrope is functional. Cards have no shadow; sheets alone use elevation. Body text begins 24pt from the edge and card containers 16pt. Controls target 44pt where board geometry permits. The game board follows `9 × clamp(floor((W − 38) / 9), 36, 44) + 14` with a height bound for compact screens.
