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

## Pass 2: product completion

This pass closed the gaps from Pass 1 and then walked the product again as a
new user on the tablet (Galaxy Tab A9, profile builds). Evidence: the
`pass2_*.jpg` files in `final_product_ui_evidence/`.

### Bugs found by using the product

Using the app turned up four issues that no automated check had caught:

- **The Coach looped forever on Advanced puzzles.** Every hint was computed
  from the board alone, and elimination results (pairs, pointing,
  box/line) offered only "Close". After any elimination the next hint
  repeated the same step, so "I'm stuck, help me" could not get past it.
  Fix:
  - the elimination result now has a real action, "Remove them";
  - `GameCubit` remembers proven eliminations for the session (cleared on
    Undo, since an earlier position may not justify them) and removes them
    from pencil notes;
  - hints build on board minus those eliminations.

  A new regression test lets the Coach alone solve all 15 Advanced/Expert
  catalog puzzles. It fails on 13 of them without the fix.
- **A teaching error in Practice.** `practice_hiddenSingle_04` showed a box
  excerpt where the answer digit still had three places, because the proof
  lives in the row. The excerpt is now used only when the box alone proves
  the move; otherwise the full board is shown.
- **Scanner Review moved buttons under the finger.** Fixing a conflict
  removed a banner, the buttons jumped up, and the next tap landed on
  "Scan again", which discards every correction. Review's actions are now
  pinned below the scrolling board, stay in place while checking (disabled
  with progress), and "Scan again" is a quiet text action.
- **"I'm stuck" did nothing visible** while conflicts remained. It now
  re-reveals the conflict banner with a haptic.

### Release items

| Item | Status | Notes |
|---|---|---|
| Practice success proves the technique | **PASS** | The board shows the Coach result hint: the placed digit lands with a gentle pop, proof cells are framed and proof candidates ringed (or eliminations struck). The text gives the concrete reason from this deduction ("Only one place remains for this digit in row 1. 5 can go only in the highlighted cell."). Happy mascot, light haptic. (`pass2_practice_success_proof`) |
| Practice digit input | **PASS** | A shared `MichiDigitPad` in the Game keypad's style. The pending digit shows in the selected cell before checking. Check enables only once an answer exists. Used by Practice, Try it and Scanner corrections. |
| Lesson "Try it" | **PASS** | Runs the real Practice exercise on a different board: select the cell, enter the digit (or mark eliminations), Check, Coach, explained "almost" feedback. Success continues straight to Practice. It is a guided attempt: it uses a non-persisting progress store, so mastery isn't affected. Example now shows the complete proof. (`pass2_lesson_try_it*`) |
| Practice order after a lesson | **PASS** | Practice starts with boards the lesson didn't use; the Example and Try-it boards come last as reinforcement. |
| Continue row | **PASS** (code), not seen on device | A `MiniBoard` thumbnail of the real saved board (givens dark, player digits indigo) inside the shared `MichiListRow` tile. During the walkthrough the only active game was the Daily, which shows on the hero card instead, so the row was never visible on hardware. |
| Streak badge | **PASS** | `DailyStreak` counts consecutive days with a solved Daily from real completed games (today, or a streak ending yesterday). The paw badge shows only when the streak is ≥ 1; at 0 nothing is shown. Unit tested. |
| Returning guest | **PASS** | `OnboardingStore` keeps "onboarding finished" plus the chosen level. On device: fresh install → Welcome; after onboarding and a relaunch → Home. Players with existing history are migrated. Sign-out never resets it. |
| Player level choice | **PASS** | Previously not stored or used. It now sets the filled default in "Another puzzle" (Beginner/Basics → Easy, Regular → Medium, Challenge → Advanced). Verified on device. |
| Coach → Lesson | **PASS** | The Coach result in Game and in Scanner shows "Technique: X · Lesson ›" (PDF p59). In Game it pauses the timer first. |
| Coach sheet on tablet | **PASS** | Capped at a content height and anchored at the bottom instead of a tall empty panel. In exercises it is a rounded floating card. |
| Scanner on hardware | **PASS** with notes | Real photo of a printed puzzle with handwritten "pen" digits: every digit recognized, including handwriting. Duplicate 6s flagged with the instruction; correction with a visible selection frame; "no valid solution" explained; then Coach, back to Review (corrections kept), Continue, a confirmation before replacing the active Daily, and Game. The camera-permission dialog appeared; I did not grant it on your device, and the denial message offers the photo path. Live camera capture was not exercised. The Coach screenshot predates its tablet column fix. |
| Scan Coach tablet composition | **PASS** (code) | Readable column, 52 dp cell cap, 300 dp sheet. Fixed after the hardware screenshot; not re-photographed. |
| Completion | **PASS** | Verified on device. The primary action names the step ("Start practice" / "Start lesson") instead of "Continue". |
| Loading / error states | **PASS** | `MichiLoadingState` (appears only after 250 ms, calm paw mark plus what MICHI is preparing) and `MichiProblemState` (mascot, what happened, Retry or Back) on Learn, Lesson, Practice, Progress, Week and Profile. Game keeps its board skeleton. |
| Empty states | **PASS** | Progress (first puzzle), Week (now has "Start today's Sudoku"), guest Profile (create account), Coach "no step", Scanner failures — each says what it is, why it's empty, and what to do. |
| Copy and voice | **PASS** | MICHI speaks informally, as in the approved design: 50 Czech, 27 Ukrainian and 5 French strings converted from formal address. Czech "hlavolam" unified to "sudoku". English "Low-confidence cells" → "Cells to double-check". New strings added in all six locales. |
| Onboarding path art on tablet | **PASS** | The ends fade softly inside the column instead of being cut. |
| Landscape | **INTENTIONAL DEVIATION** (decision) + not smoke-tested | Phones are portrait-only: iPhone plist plus a runtime lock when the shortest side is under 600 dp, because a 9×9 board and keypad don't fit a landscape phone. Tablets keep all orientations, as iPad multitasking and Android large-screen rules require. The landscape smoke test on the tablet was **not done**: the device was disconnected before that step. |
| Tablet compositions vs PDF | **INTENTIONAL DEVIATION** | The PDF has phone frames only. Tablet layouts are the same language in a 560 dp column with phone-derived size caps; no tablet pixel parity is claimed. |
| Home greeting | **INTENTIONAL DEVIATION** | Removed at your request; the PDF shows "Good morning, Sofia". |
| Splash words rarely visible | **INTENTIONAL DEVIATION** | Navigation never waits for branding; on fast starts users see the disc settle and the fade-through. |
| Imported puzzle digits | **INTENTIONAL DEVIATION** | Handwritten entries on a scanned puzzle become clues; the scanner cannot tell printed digits from the player's own. |

### Interaction audit (summary)

- Every primary button and row has a press scale.
- Haptics fire on tabs, board cells, digit pads, answers (light, medium,
  heavy), Coach application and blocked scanner actions.
- Motion explains cause and effect:
  - the placed digit pops;
  - feedback sheets slide over a stable board;
  - Coach steps reveal;
  - banners re-reveal when they answer a tap.
- No important interaction I tried was dead. "I'm stuck" during a conflict
  was the only one, and it is fixed.

## Pass 3: functional correctness, motion and iPhone validation

Test environment:

- **iPhone:** iPhone 15 Pro Max (iPhone16,2), iOS 18.7.8, ProMotion 120 Hz
  (measured), Profile build signed with the existing development team, so
  the install keeps your local data.
- **Android:** the Galaxy Tab A9 was unavailable.

Status key:

- **[iPhone]** verified on the physical iPhone
- **[Tests]** verified by automated tests
- **[Code]** implemented but unverified at runtime
- **[Deferred]** device unavailable
- **[Pending owner]** needs your interaction on the device

See also: [`motion_design_system.md`](motion_design_system.md).

### Functional issues found and fixed

1. **Timer counted time the app was closed** (the 729-minute report).
   - Cause: `GameTimer.restore` added the wall-clock time since the run
     started, capped at 12 hours, whenever the process ended while the timer
     ran (force-stop, reinstall, OS kill). 9 minutes of play plus 12 hours
     closed restored as 12 h 9 min.
   - Fix: a restored run counts only up to its last save (`updatedAt`).
     Leaving Game by any route, including the iOS back swipe, now pauses and
     saves before closing. Backgrounding and locking already paused through
     the lifecycle observer. Opening a lesson from Coach pauses.
   - **[Tests]** `game_timer_test.dart` covers the 729-minute scenario and
     clock changes; `coach_elimination_lifecycle_test.dart` covers terminate
     → restore with 12 h closed → 5 min restored, and paused time never
     counting.
   - The existing test "interrupted session catches up with bounded wall
     time" encoded the old behaviour and was replaced, because the
     requirement changed.
2. **Coach elimination state (Pass 2 fix reworked).**
   - Pass 2 removed accepted eliminations from the player's pencil notes and
     kept them only in memory. That broke the requirement to keep notes
     separate, failed an existing test, and lost proofs on restore.
   - Now each accepted removal is a `ProvenElimination` storing the position
     it was proven on. It holds while every digit of that position is still
     on the board: entering digits keeps it; erasing or undoing one of those
     digits drops it permanently.
   - Removals are kept in `GameState` and persisted in a new
     `active_games.proven_eliminations_json` column (schema v9, default
     `'[]'`; a damaged value reads as empty and never blocks a saved game).
   - The solver uses the board minus valid proofs; pencil notes are never
     read or written.
   - Why? and manual-move reasoning use the pre-move board plus only the
     proofs that already held there.
   - **[Tests]**
     - `coach_elimination_lifecycle_test.dart`: no repeat after accepting;
       notes untouched; enter keeps; undo to the proof position keeps; erase
       of a basis digit drops; notes don't feed proofs; pause → terminate →
       restore keeps proofs, and the next hint moves on.
     - `game_migration_test.dart`: a schema-8 saved game loads after the
       upgrade. An idempotent migration fixes a duplicate-column failure
       found while testing.
     - `coach_completes_puzzles_test.dart`: Coach alone completes all 15
       Advanced/Expert catalog puzzles.
3. **Practice order made 13 tests fail.** Practice rotates past the boards
   the lesson used. The order is now a named rule (`practiceSessionOrder`)
   shared by the page and the tests, so tests answer the exercise actually
   shown. **[Tests]**
4. **The 4 earlier recommendation failures** were caused by the loading
   spinner keeping `pumpAndSettle` from settling. The spinner was replaced
   with a calm static mark in Pass 2. **[Tests]**
5. **Hidden tabs kept animating.** auto_route's tab `IndexedStack` does not
   mute tickers on inactive tabs. `ActiveTabTickers` now wraps each tab page
   in `TickerMode`. **[Code]**, with the muted-ticker behaviour covered by
   the mascot tests.

### Animation integration

| Item | Status |
|---|---|
| All five V2.1 compositions parse in Flutter `lottie` 3.8.2, no warnings, exact timings | **[Tests]** |
| Rendered by Flutter's renderer across the full timeline; no clipping or missing limbs; Thinking has both paws and the curled tail; transparent on paper | **[Tests]** (renders in `pass3_lottie_runtime_*.png`) |
| `MichiMotionMascot`: once, occasional, trigger-only replay, start delay, Reduce Motion rest poses, muted-ticker behaviour | **[Tests]** (7 widget tests) |
| Placements: Home idle, Coach thinking, Practice / Try-it happy, completion celebrating, recorded-Daily stamp, mastery celebrating | **[Code]**, **[Pending owner]** on iPhone |
| Supplied JSON unmodified; only JSON shipped | **[Code]** |
| Look of the vector MICHI next to the approved raster artwork | **[Pending owner]** visual acceptance |

### Motion and interaction

- **Coach:** each new step reveals in logical order (evidence, candidates,
  strikes drawn across, placement last), 420 ms. Only a new hint
  re-animates. **[Code]** (game tests pass)
- **Why?:** markers appear in step order, then the ruled-out positions, then
  the target. **[Code]**
- **Motion tokens:** consolidated and documented in `MichiMotion`, adding
  `reveal` and `exit`. **[Code]**

### Performance (physical iPhone)

| Item | Status |
|---|---|
| Opt-in frame statistics (`MICHI_FRAME_STATS`), compiled out by default | **[Code]** |
| Display refresh 120 Hz; pre-animation Home at launch: UI p99 4.1 ms, raster p99 8.0 ms, 0 frames over budget, 146 MB | **[iPhone]** |
| Pre-animation Home at rest draws no frames | **[iPhone]** |
| Scenario baseline (Daily, rapid entry, Coach, tabs, Practice, Scanner, lock) | Skipped by owner |
| Animation build: frame timings, memory after repeated navigation, idle activity | **[Pending owner]**, the owner is launching the build |

### iOS-specific

| Item | Status |
|---|---|
| Install over the existing app without data loss (same bundle and team) | **[iPhone]** |
| Portrait-only iPhone (plist plus runtime lock under 600 dp) | **[Code]** |
| Camera capture of a printed puzzle; Photo Library; limited access; denied permissions | **[Pending owner]**, needs your explicit permission and hands |
| Lifecycle: background, lock, terminate, restore on device | **[Tests]** for logic, **[Pending owner]** on device |
| Reduce Motion and VoiceOver on device | **[Tests]** for behaviour and semantics exclusion, **[Pending owner]** on device |

### Android and tablet

| Item | Status |
|---|---|
| Physical Galaxy Tab A9 (portrait, landscape, performance) | **[Deferred]** DEFERRED — DEVICE UNAVAILABLE |
| Responsive layout tests (360×640 … 1024×768) | **[Tests]** |
| Android profile/release build with these changes | Not run this pass |

### Automated results

- Mobile app: **256 passed, 0 failed** (full run, before the animation
  wiring).
- After the animation and motion changes:
  - game folder 113 ✓;
  - practice and learn 41 ✓;
  - design system 14 ✓ (motion assets 5, mascot behaviour 7, existing 2).
- `flutter analyze`: clean for the app and design system.
- **Not yet re-run after the final changes:** the complete workspace suite
  (`melos run test`), the Android build and the iOS Release build.

## Verdict

**NOT READY — REMAINING BLOCKERS**

The functional defects are fixed and covered by tests. The animations are
validated in the Flutter runtime and integrated. What blocks owner acceptance
is verification that hasn't happened yet:

1. **iPhone walkthrough of the animation build:** all five animations in
   context, Reduce Motion, VoiceOver, lock / background / terminate /
   restore, and the real camera capture (needs your permission).
2. **iPhone frame-timing and memory measurements** of the animation build.
   No baseline exists for comparison, because it was skipped.
3. **Full regression run and builds after the final changes:**
   `melos run test`, Android profile APK, iOS Release build.

Physical Android tablet verification remains **DEFERRED — DEVICE
UNAVAILABLE** and is not counted as a blocker for iPhone owner acceptance.
