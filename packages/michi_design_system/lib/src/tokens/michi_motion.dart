import 'package:flutter/animation.dart';

/// MICHI motion tokens. Durations are ceilings for feedback, never delays:
/// input is always accepted immediately and no product action waits for an
/// animation. Under Reduce Motion every transition collapses to its end state.
abstract final class MichiMotion {
  /// Microinteractions: press, tap acknowledgement, digit selection.
  static const quick = Duration(milliseconds: 150);

  /// Selection and state changes: highlights, toggles, tab state.
  static const standard = Duration(milliseconds: 200);

  /// Content and sheet transitions: feedback sheets, step changes.
  static const enter = Duration(milliseconds: 260);

  /// A single emphasised change: a placed digit settling, a mascot pop.
  static const emphasis = Duration(milliseconds: 300);

  /// Coach and Why? evidence revealed in logical order.
  static const reveal = Duration(milliseconds: 420);

  /// Brief fallback when the platform asks for reduced motion but a change
  /// still needs a hint of continuity (opacity only).
  static const reduced = Duration(milliseconds: 100);

  /// The house curve: quick start, gentle settle.
  static const curve = Cubic(0.2, 0, 0, 1);

  /// Leaving elements accelerate away.
  static const exit = Cubic(0.4, 0, 1, 1);
}
