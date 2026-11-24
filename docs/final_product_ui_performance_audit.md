# MICHI — Final product UI & performance audit

Scope: release-quality polish pass after hands-on tablet testing. No store or
deployment work was done.

Evidence in [`final_product_ui_evidence/`](final_product_ui_evidence/):

- `*_before_after_design.jpg` for Splash, Home, Progress and Practice. Each
  shows the attached tablet photo, the tablet screenshot after the changes,
  and the approved PDF page (p6, p42, p81, p69).
- `daily_open_before_tablet.mp4` and `daily_open_after_tablet.mp4`.
- `cold_start_splash_after_tablet.mp4`.
- Tablet captures of Game, Welcome and Onboarding after the changes.

Test devices:

- **Android tablet:** Samsung Galaxy Tab A9 (SM-X115), Android 15,
  800×1340 px at 213 dpi, so a **600×1005 dp** window. This is the device from
  the bug report. Measured with **profile** builds.
- **Phone:** iOS Simulator (iPhone, iOS 18.3), debug build, for phone parity.
- **Widget tests** at 360×640, 375×667, 390×844, 430×932, 601×1007 and
  1024×768.

How timings were measured: Android screen recording with touch indicators on.
The tap is the first frame showing the touch dot. Response and settle times
come from per-frame scene-change scores (ffmpeg). This measures what the user
sees, OS and driver included.

---

## Performance

### Root cause of the Daily opening freeze

Before the Game screen could be built, `GameCubit` ran
`ExactSolver.countSolutions` (the uniqueness check) and then `solve` on the UI
isolate. `BacktrackingExactSolver` was correct but very slow per search node:

- every placement copied an immutable 81-cell board and re-checked all values;
- every cell's candidates were recomputed by scanning its 20 peers, with an
  object allocated per mask.

Advanced puzzles need deep backtracking, so the UI thread stayed blocked for
seconds. The recording shows no ripple and no press state during that time;
nothing redraws until the Game route appears.

Benchmark of all Daily-eligible catalog puzzles, uniqueness check plus solve,
AOT-compiled on an Apple-silicon Mac (the tablet is several times slower):

| Difficulty | Before median / p90 / max | After median / p90 / max |
|---|---|---|
| Easy (12) | 8 / 21 / 25 ms | 0 / 0 / 0 ms |
| Medium (8) | 18 / 93 / 93 ms | 0 / 1 / 1 ms |
| Advanced (12) | **341 / 5 141 / 8 380 ms** | **5 / 71 / 118 ms** |

Other suspects were checked and ruled out. `HumanSolver.findNextDeduction`
takes a median of 0.27 ms and at most 0.69 ms on every catalog puzzle. Drift
reads, Daily resolution and sync are asynchronous and short.

### Fix

1. **Solver rewrite (`packages/sudoku_engine/.../exact_solver.dart`).** Search
   state is now row/column/box bitmasks with a popcount table. Each branch
   copies 81 bytes plus 27 ints; there are no per-cell allocations. **The
   search order is unchanged** (lowest-index naked single first, then the
   lowest-index cell with the fewest candidates, digits ascending), so results
   are identical. I compared the old and new implementations on 56 boards (the
   whole catalog, an empty board and multi-solution boards) with limits 1, 2
   and 5, plus `solve`: 0 mismatches. All 160 engine tests pass. Puzzle
   import/Review (`PuzzleAnalyzer`) and scanner checks use the same solver, so
   they get the same speed-up.
2. **Off the UI isolate (`GamePreparation`).** The uniqueness check and solve
   run in `Isolate.run`. The result is cached for the most recent board, and
   Home pre-warms the visible Daily, so opening it rarely waits at all.
   `GamePreparation.inline` exists only for widget tests, so fake-async tests
   never wait on a real isolate.
3. **Real loading state.** If preparation is still running (an uncached
   Advanced puzzle), Game navigates at once and shows the approved skeleton
   (PDF p52): the empty board shape, "Preparing puzzle…" with a small spinner,
   and an inactive keypad. The Home Daily hero also has an indigo skeleton
   instead of a text line.

### Timings on the tablet (profile builds)

| Flow | Before | After |
|---|---|---|
| Home → **start today's Daily** (Advanced), tap → first visual change | **3.63 s** (screen frozen) | ~15 ms |
| Home → start today's Daily, tap → Game interactive | ≈3.7 s | **≈0.32 s** |
| Home → **continue today's Daily** (restore), tap → first change | **3.04 s** (frozen) | 43 ms |
| Home → continue today's Daily, tap → Game settled | ≈3.1 s | **0.36 s** |
| Another puzzle → Advanced → Start new (not pre-warmed) | — | 48 ms response, skeleton, interactive ≈0.6 s |
| Home → Another puzzle (sheet) | — | 19 ms / 224 ms settled |
| Lesson → Practice | — | 30 ms / 375 ms settled |
| Tab → tab (Learn → Progress, Learn → Play) | — | 17–30 ms / 60–151 ms settled |
| Cold start, process not running | — | system splash ≈1.4 s, then Flutter |
| Cold start after clearing app data (first run) | 2.8 s system splash, then a white→indigo jump | 2.3–3.4 s system splash (unchanged; engine + first-run setup), then a continuous indigo hand-off |

No primary transition I measured feels slower than ~0.6 s, and every one
responds within 50 ms. Not measured on the device: Scanner → Review → Game
(no camera target was set up) and Progress → recommendation. Those paths run
the same, now fast, solver, but they are unverified on hardware.

---

## Tablet

### Responsive system introduced

New in `michi_design_system`:

- **`MichiLayout`** (`tokens/michi_layout.dart`): window classes from the
  available width, never from device names. Compact < 600 dp, medium 600–839,
  expanded ≥ 840. Shared rhythm tokens: card gutter 16, text inset 8 (text sits
  at 24 from the phone edge), group gap 8, element gap 16, section gap 32.
  Readable width 560, focused width 480, task max height 800. Outer margin is
  0 / 32 / 48 by class.
- **`MichiContentFrame`**: one centered readable column. Phones are untouched
  (margin 0, gutters stay inside the content). Larger windows add outer
  whitespace instead of stretching components. Task screens can bound their
  height and choose their vertical placement. I fixed a bug where
  `heightFactor: 1` stopped bounded compositions from centering on tall
  tablets.
- **`MichiListRow`**: one tappable-row geometry. 44 dp leading tile (neutral,
  coral or indigo tone), title and subtitle on one shared vertical center,
  chevron, 72 dp minimum height, 8 dp inner inset, press feedback.
- **`MichiPressFeedback`**: a 0.985 press scale that never intercepts
  gestures. Used by every `MichiButton` and `MichiListRow`.
- Bottom sheets are capped at 560 dp in the app theme. The bottom navigation
  bar sits inside the same readable column.

### Screens changed (tablet decisions)

| Screen | Decision |
|---|---|
| Home | 560 dp column, logo first, no greeting, grouped rows with inset dividers |
| Welcome | Identity at the top; the invitation group placed in the optical middle on medium+ (phone keeps its approved top-down flow) |
| Onboarding | Full-height column with Skip at the top; page-1 disc completed and the art group centered on medium+ (the raster cuts the disc at its edge) |
| Player level | Full-height column, CTA pinned at the bottom |
| Game | Navigation at the top; board cell cap 44 → **52 dp on medium+** (board ≈468 dp); controls spread over the remaining height |
| Lesson | Duplicate app-bar title removed (PDF p68); 800 dp centered task block |
| Practice | Rebuilt (see below); excerpt capped at 280 dp on phones and 320 dp on medium+; two-pane only on expanded (≥ 840) |
| Progress (empty) | Illustration 180 → 220 dp on medium+; one group in the upper third |
| Learn, Week, Profile, Settings, auth, Why, Scanner | Readable column via `MichiContentFrame` |

### Remaining tablet deviations

- The approved PDF only shows phone screens. The tablet compositions are my
  extrapolation of the same language (column, margins, size caps), not
  approved designs.
- On the 600 dp tablet in landscape (1005×600 dp), Game drops to the compact
  cell size. That works, but I did not walk through landscape screens.
- The onboarding "path" illustration (page 3) intentionally runs off its
  edges; inside a tablet column it reads as cropped. Low priority.

---

## Visual polish

- **Spacing system.** Home, Practice, Progress and Splash use `MichiLayout`
  and `MichiSpacing` tokens instead of local 12/16/20/24 constants. Text sits
  at 24 and cards at 16 from the phone edge, as specified.
- **Home.** Removed the time-based greeting ("Good morning" / "Dobré ráno",
  every locale). Composition: logo → Daily hero → grouped rows → 32 dp →
  This Week. The misaligned "Another puzzle" row (bare icon without a tile,
  different chevron color and inset) and the Focus and Continue rows now share
  `MichiListRow`, so icon, title and subtitle baselines and the chevron line
  up.
- **Practice.** Follows PDF p69–73. Close button and centered "Practice ·
  technique" title. Segmented progress with an "Exercise 1 of 5" counter.
  Editorial "Find: …" title and prompt. A bounded, centered excerpt board.
  A stable answer area (digits plus Ask MICHI / Check). Feedback and Coach
  rise as a sheet over the board's lower edge, so the board never jumps or
  shrinks after an answer. This fixes a real overflow on 360×640 phones. The
  board also no longer overflows when space is very tight.
- **Progress empty state.** Title, illustration, explanation and CTA form one
  revealed group placed in the upper third. It is not a small island at the
  top and not centered so low that the CTA drifts away from the title.
- **Splash.** See Motion.
- **Optical centering.** Splash disc and words are composed as one group
  whose visual weight sits just above the middle. The onboarding art group is
  centered on mascot plus disc, not on the raster's bounding box. The Welcome
  invitation is balanced against the wordmark.

---

## Motion

Platform rule followed: native launch screens stay static and fast.

- **Native launch.** Android's launch was plain white, and the Android 12+
  system splash used the default background, so there was a white/black flash
  before the indigo Flutter splash. It is now indigo with the mascot disc
  (`values-v31` `windowSplashScreen*`, `launch_background`), matching iOS.
  `MainActivity` removes the system splash instantly instead of cross-fading
  it, because the first Flutter frame is identical. It then sends
  `launchScreenRemoved` on `michi/launch`.
- **In-app splash.** The first Flutter frame matches the native launch: the
  disc at the exact screen center at the platform's measured size (iOS 188 pt,
  Android system splash 128 dp, verified in the recording). The entrance
  starts only when the OS launch screen is actually gone. Android signals
  this; iOS uses the first rasterized frame; a 1.5 s fallback covers anything
  else. I first tried "first frame rasterized" on Android, and the recording
  showed the entrance had already played behind the system splash. From
  there the disc settles upward with a small head-tilt, the coral logic path
  of the mark draws in, and the tagline slides in (720 ms).
  **Navigation never waits for it.** As soon as startup is ready, the
  destination arrives with a 480 ms fade-through (splash dissolves to paper,
  then content rises 2%). On this tablet, startup is ready almost
  immediately, so users see the disc settle and the fade-through. The
  wordmark and tagline only appear when startup takes longer. That is
  deliberate, but it means the full splash composition is rarely seen
  (`splash_before_after_design.jpg` shows a real mid-hand-off frame).
- **Press states.** Every primary button and row gets a 150 ms press scale.
  The Daily hero CTA, rows and tabs give feedback in under 50 ms.
- **Tabs.** Selected icon pill and a 1.08 icon scale, with a selection-click
  haptic on change.
- **Practice.** Segment fill animates. Title and board reveal per exercise.
  Answer, feedback and Coach cross-fade and slide (260 ms). The feedback
  mascot pops in on a correct answer (ease-out-back) and settles calmly on
  "almost". Haptics: light on correct, medium on incorrect, heavy on
  completion.
- **Already present and kept:** board placement and notes cross-fade, keypad
  states, game haptics (placement, notes, mistake, completion), lesson step
  reveal, the Why/Coach overlay painter, completion reveal.
- **Reduce Motion.** Every new animation checks
  `MediaQuery.disableAnimationsOf`. The splash renders its final frame, route
  fades become instant, and the press scale, segment and mascot pops turn off.

---

## Design: remaining differences from the approved PDF

- Home greeting removed on purpose, as requested (the PDF shows "Good
  morning, Sofia").
- The streak badge ("7 days") and the mini-board thumbnail in the Continue row
  (PDF p37) are still not built. Continue uses a play-icon tile.
- The Practice success state does not draw the placed digit or highlight the
  proof cells as PDF p69 does ("Pair found" with marked cells). Feedback is
  text plus mascot.
- The lesson "Try it" step says "pick the cell and enter the digit" but shows
  no keypad. This looks like a pre-existing gap in the lesson flow, not
  something introduced here.
- Guest users without an active game land on Welcome on every launch, because
  there is no "onboarding finished" flag. Returning guests probably expect
  Home. This is a product decision to make.
- The PDF has no tablet frames (see Tablet → remaining deviations).

## Anything that still looks unfinished

- The Practice digit chips are plain 44 dp squares. They work, but they look
  less crafted than the game keypad.
- The splash animation is rarely seen on fast startups. That is correct
  behavior, but the brand moment is mostly the hand-off.
- Scanner → Review on tablet was not walked through on the device this pass.

---

## Verification

| Check | Result |
|---|---|
| `dart format` (melos format set) | Clean |
| `build_runner` generation (routes, DI, translations, Drift, BDD) | Clean |
| `flutter analyze` (all packages) | No issues |
| Workspace tests (`melos run test`) | engine 160 ✓ · mobile 228 ✓ · scanner 18 ✓ · design system 2 ✓ (mobile re-run after the final splash change: 229 ✓, including a new inline-preparation test) |
| Android `flutter build apk --profile` | ✓ (installed and walked through on the tablet) |
| iOS `flutter build ios --simulator` | ✓ (launched on an iOS 18.3 simulator, Home checked) |
| Tablet walkthrough | Splash, Welcome, Onboarding, Level, Home, Daily (new and continue), Game, Learn, Technique, Lesson, Practice (+feedback), Progress (empty and with data), Profile, Another-puzzle sheet, replace sheet, loading skeleton |

Test changes made in this pass, each for a stated reason:

- Practice size cap is per size class (phone 280, tablet 320).
- The Learn BDD step taps Practice's Close instead of Back.
- Widget tests use `GamePreparation.inline` instead of real-time waits.
- The lifecycle test registers its in-memory repository for Splash.
- The content driver waits frame-by-frame while the loading spinner runs.

---

## Verdict

**NOT YET VISUALLY READY FOR BETA**

The release blocker is fixed. Daily opens in ~0.3 s instead of freezing for
3–4 s, with immediate feedback and the solver unchanged in its results. The
tablet now reads as the same MICHI composed for a larger canvas, and the
problem screens (Splash, Home, Progress, Practice) are clearly better than in
the attached evidence. Before a beta, these still need to be closed:

- a design decision on the tablet compositions, since they are extrapolated
  from phone-only designs;
- the Practice success state with marked proof cells (p69);
- the Continue-row thumbnail and streak badge;
- the lesson "Try it" input gap;
- a hardware walkthrough of Scanner → Review and landscape tablet.
