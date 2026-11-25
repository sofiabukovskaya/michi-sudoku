# MICHI — Motion design system

Motion in MICHI does at least one of these jobs: acknowledge an action, direct
attention, explain logic, show progress, reward an achievement, or express
MICHI's personality. Anything that does none of them is removed.

## Principles

1. **Input never waits.** Durations cap how long feedback takes; they are
   never delays. Taps are accepted immediately, and no product action
   (saving, mastery, navigation) waits for an animation.
2. **Business events drive animation.** A confirmed answer, a recorded
   completion or an opened Coach session starts a reaction. An animation
   finishing never commits anything.
3. **Explain, don't decorate.** Coach and Why? motion only orders attention
   over evidence the deduction already contains. It never adds evidence,
   reveals a later hint level or shows the answer early.
4. **Quiet by default.** Static screens draw no frames. Idle life is one
   short cycle at a time, never a loop.
5. **Reduce Motion is a full experience.** Every animation has a meaningful
   end state, shown immediately when the system asks for reduced motion.

## Tokens (`MichiMotion`, `michi_design_system`)

| Token | Duration | Use |
|---|---:|---|
| `quick` | 150 ms | Microinteractions: press, digit selection, board changes |
| `standard` | 200 ms | Selection and state changes: highlights, tabs |
| `enter` | 260 ms | Content and sheet transitions: feedback sheets, steps |
| `emphasis` | 300 ms | One emphasised change: a placed proof digit settling |
| `reveal` | 420 ms | A new Coach step's evidence, staged in logical order |
| `reduced` | 100 ms | Opacity-only continuity where a cut would be jarring |
| `curve` | `Cubic(0.2, 0, 0, 1)` | House curve: quick start, gentle settle |
| `exit` | `Cubic(0.4, 0, 1, 1)` | Leaving elements |

Mascot reactions use their composition's own duration (below). Why? markers
use a 900 ms staged reveal.

## Lottie assets (Motion Library V2.1)

Only the five JSON compositions ship, in
`packages/michi_design_system/assets/mascot/`. The GIF previews, SVG/PNG
artwork and the Python builder from the pack are **not** bundled. Runtime:
`lottie: ^3.8.2`, added for these assets only.

| Asset | Length | Rest pose | Where | Playback |
|---|---:|---|---|---|
| `michi_idle.json` | 5.0 s | first frame | Home Daily card (unfinished Daily) | One cycle when shown, then one cycle every 24 s while visible |
| `michi_thinking.json` | 2.4 s | final (paw to chin) | Coach panel (Game, Practice, Why?, Scanner Coach) | Once per Coach session; holds across steps |
| `michi_happy.json` | 1.4 s | final | Correct Practice / Try-it answer; session summary without mastery | Once per confirmed answer |
| `michi_celebrating.json` | 1.8 s | final | Puzzle completion; session summary when the technique is mastered | Once on arrival |
| `michi_daily_stamp.json` | 0.9 s | final | Completion of a Daily that was saved (no storage failure) | Once, starting 1.2 s after the celebration |

Static illustrations are kept where they say more than the generic poses:
Welcome (board and MICHI composition), onboarding, Learn and lessons (reading
MICHI), Profile, empty states, and the "almost" answer (calm pointing MICHI).
A completed Daily on Home keeps the static happy pose, so returning to Home
never replays a reward.

### Compatibility findings (Flutter `lottie` 3.8.2)

- All five parse in the Flutter runtime with **no warnings**. Duration
  (5.0 / 2.4 / 1.4 / 1.8 / 0.9 s), 60 fps, 640×640, start frame 0 and the
  absence of embedded images are asserted by `test/motion_assets_test.dart`.
- Features used: null and shape layers, groups, paths, fills, strokes,
  transforms and opacity. No masks, mattes, effects, expressions or images,
  which is the safest subset for the Flutter renderer.
- Each composition was rendered with Flutter's own `LottieDrawable` at eight
  points across the full timeline on MICHI's paper colour
  (`final_product_ui_evidence/pass3_lottie_runtime_*.png`):
  - Thinking: both front paws, paw-to-chin gesture, blink, head movement and
    the curled tail, matching the V2.1 preview.
  - Idle: blink, breathing, tail.
  - Happy: hop and smile.
  - Celebrating: raised paws, sparks from mid-timeline.
  - Daily stamp: empty at frame 0, oversized impact, coral ring, settled
    stamp.
  - No clipping, missing limbs, distortion or opaque backgrounds.
- **No modifications** were made to the supplied JSON files.
- Playback uses `FrameRate.composition` (60 fps). On a 120 Hz iPhone the
  mascot updates at its authored 60 fps; it is not sped up and repaints only
  when a frame changes.
- The reconstructed vector MICHI is close to, but not identical with, the
  approved raster artwork used on other screens. Seeing both styles in one
  session needs owner sign-off on the iPhone.

## Component: `MichiMotionMascot`

`packages/michi_design_system/lib/src/components/michi_motion_mascot.dart`

- **Typed assets:** `MichiMotionAsset` holds each path and its rest pose
  (`start` for idle, `end` for reactions).
- **Playback:** `once` (default) or `occasional` (idle, with an interval).
- **`trigger`:** a semantic event identity. A new value replays; an unrelated
  rebuild with the same value never does.
- **`startDelay`:** lets one reaction follow another (stamp after
  celebration). The composition stays at its empty first frame until then.
- **`fallback`:** the approved static MICHI, shown if a composition cannot
  load.
- Each instance owns one `AnimationController` (single ticker, disposed
  with the widget). There is no global animation service, and no coupling
  to Sudoku engine state or persistence.
- `RepaintBoundary` around the animation, so a playing mascot repaints only
  itself. It is wrapped in `ExcludeSemantics`: it is decorative, and the
  meaning is in the text beside it, so VoiceOver announces nothing extra.
- Compositions are loaded lazily on first use and cached by `lottie`'s
  composition cache. Nothing is preloaded at startup.

### Lifecycle rules

| Situation | Behaviour |
|---|---|
| Reduce Motion on | Rest pose immediately, no ticker running |
| Hidden tab | `ActiveTabTickers` wraps each tab page in `TickerMode` (auto_route's tab `IndexedStack` does not mute hidden tabs). Muted tickers draw nothing; idle skips its cycle and reschedules |
| Route covered by another route | Muted by Flutter's overlay `TickerMode` |
| App backgrounded or device locked | Flutter stops producing frames; the Game also pauses and saves |
| Rebuild with the same trigger | No replay |
| Achievement revisited | Completion is shown once per finished game; Home shows a static pose for a completed Daily |

## Coach and Why?

- **Coach step reveal (`CoachOverlayPainter.reveal`).** A new hint is staged
  in logical order over `MichiMotion.reveal` (420 ms):
  1. unit and focus cells fade in (0–45%);
  2. highlighted candidates (25–70%);
  3. eliminations are struck through from corner to corner (45–100%);
  4. a placement lands last (55–100%).

  Only a change of hint restarts the reveal. A digit, note or selection
  change keeps the overlay settled, so rapid input never re-animates
  evidence. The overlay animates only what the current hint contains, and
  the user can move to the next hint at any moment.
- **Why? markers.** In a 900 ms staged reveal: the searched unit, then each
  numbered marker as its step is reached, then the ruled-out positions, then
  the target cell. Every element is final from the start; motion only orders
  attention.

## Learn and Practice

- **Correct answer:** the proof board shows the placed digit with an
  ease-out pop (`emphasis`), framed proof cells and ringed proof candidates.
  The success sheet slides in (`enter`) with Happy. The board and controls
  never move.
- **Almost:** the sheet slides in with a static calm MICHI and the specific
  reason; no punitive motion.
- Lesson step and segment transitions use `standard` and `emphasis`.

## Game

The existing behaviour is kept, because it is already immediate and
non-blocking: board layers cross-fade over `quick` (placement, notes,
highlights), the keypad selection animates over `quick`, and haptics fire on
placement, notes, mistakes and completion. The board geometry never changes
during animation.

## Accessibility

- Every animation checks `MediaQuery.disableAnimationsOf`.
- Rest poses carry the full meaning: final stamp, celebrating pose, proof
  digit already placed, all Why? markers shown.
- Decorative mascots are excluded from semantics.
- Logical evidence is never conveyed by motion alone. Text and the static
  overlay state carry it.

## Tests

| Test | Covers |
|---|---|
| `michi_design_system/test/motion_assets_test.dart` | All five compositions parse in the Flutter runtime, timings, size, no images or warnings |
| `michi_design_system/test/michi_motion_mascot_test.dart` | One-shot plays once and then schedules no frames; unrelated rebuilds don't replay, a new trigger does; Reduce Motion rest poses (end for reactions, start for idle); a muted ticker draws nothing; occasional idle is idle between cycles; a delayed stamp stays invisible until its moment |

## Performance

### Measurement method

Opt-in `--dart-define=MICHI_FRAME_STATS=true`
(`lib/core/diagnostics/frame_stats.dart`). Every 5 s with rendered frames it
logs UI (build) and raster p50/p95/p99, frames over the 8.3 ms (120 Hz) and
16.7 ms (60 Hz) budgets, resident memory and display refresh rate. Windows
without frames are not logged, which exposes unintended background
animation. It is compiled out unless the define is set.

### Results so far

Physical iPhone 15 Pro Max, iOS 18.7.8, Profile build, Impeller.

| Measurement | Value |
|---|---|
| Display refresh | 120 Hz (ProMotion) |
| Baseline (pre-animation) Home at launch | UI p99 4.1 ms, raster p99 8.0 ms, 0 frames over 16.7 ms, 0 over 8.3 ms, RSS 146 MB |
| Baseline Home at rest | No frames drawn |

The full before/after scenario comparison was **not performed**. The owner
chose to skip the baseline run, and the animation build's measurements on
the iPhone are pending the owner's own launch and walkthrough. See the
audit report for what remains open.

## Remaining limitations

- The supplied vector MICHI differs slightly from the approved raster
  artwork. Mixing the two needs owner visual acceptance on device.
- iPhone frame-timing results with the animations, and memory after
  repeated navigation, are not yet measured.
- Physical Android tablet behaviour: **deferred, device unavailable**.
