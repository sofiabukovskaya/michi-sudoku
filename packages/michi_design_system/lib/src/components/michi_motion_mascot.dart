import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

/// The supplied MICHI vector animations (Motion Library V2.1).
enum MichiMotionAsset {
  /// Blink, breathing and tail. Home only, one cycle at a time.
  idle('assets/mascot/michi_idle.json', MichiMotionRest.start),

  /// Head tilt and paw to chin. Coach, when a hint opens.
  thinking('assets/mascot/michi_thinking.json', MichiMotionRest.end),

  /// Soft hop and smile. A confirmed correct learning answer.
  happy('assets/mascot/michi_happy.json', MichiMotionRest.end),

  /// Raised paws and sparks. Puzzle completion and technique mastery.
  celebrating('assets/mascot/michi_celebrating.json', MichiMotionRest.end),

  /// Ink impact and paw mark. A Daily completion that was recorded.
  dailyStamp('assets/mascot/michi_daily_stamp.json', MichiMotionRest.end);

  const MichiMotionAsset(this.path, this.rest);

  final String path;

  /// The frame shown when not playing, and under Reduce Motion: idle rests
  /// on its first pose; reactions rest on their final, meaningful pose.
  final MichiMotionRest rest;

  static const package = 'michi_design_system';
}

enum MichiMotionRest { start, end }

/// How often a composition plays while it is visible.
enum MichiMotionPlayback {
  /// Once per [MichiMotionMascot.trigger] value, then holds its rest pose.
  once,

  /// One cycle when shown, then occasionally while visible: quiet life,
  /// not perpetual motion. No frames are drawn between cycles.
  occasional,
}

/// Plays one supplied MICHI composition, driven only by UI events.
///
/// - Replays only when [trigger] changes, never on an unrelated rebuild.
/// - Under Reduce Motion, or while its ticker is muted (hidden tab, covered
///   route, backgrounded app), it shows the rest pose and draws no frames.
/// - Product actions never wait for it; completion commits nothing.
/// - Decorative: excluded from semantics; meaning lives in the text beside it.
final class MichiMotionMascot extends StatefulWidget {
  const MichiMotionMascot({
    required this.asset,
    required this.size,
    this.playback = MichiMotionPlayback.once,
    this.trigger,
    this.occasionalInterval = const Duration(seconds: 24),
    this.startDelay = Duration.zero,
    this.fallback,
    super.key,
  });

  final MichiMotionAsset asset;
  final double size;
  final MichiMotionPlayback playback;

  /// A semantic event identity. A new value replays a one-shot animation.
  final Object? trigger;
  final Duration occasionalInterval;

  /// Lets a reaction follow another one (the Daily stamp after the
  /// celebration). Nothing waits on it; Reduce Motion skips straight to rest.
  final Duration startDelay;

  /// Shown if the composition cannot be loaded.
  final Widget? fallback;

  @override
  State<MichiMotionMascot> createState() => _MichiMotionMascotState();
}

final class _MichiMotionMascotState extends State<MichiMotionMascot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
  );
  LottieComposition? _composition;
  Timer? _next;
  bool _played = false;

  bool get _reduceMotion => MediaQuery.disableAnimationsOf(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_composition != null && _reduceMotion) _rest();
  }

  @override
  void didUpdateWidget(MichiMotionMascot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset != widget.asset) {
      _composition = null;
      _played = false;
      _next?.cancel();
      _controller.stop();
    } else if (oldWidget.trigger != widget.trigger) {
      _play();
    }
  }

  @override
  void dispose() {
    _next?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onLoaded(LottieComposition composition) {
    _composition = composition;
    _controller.duration = composition.duration;
    if (_played) return;
    _played = true;
    if (widget.startDelay == Duration.zero || _reduceMotion) {
      _play();
    } else {
      // Hidden until its moment, so the end pose does not appear early.
      _controller.value = 0;
      _next = Timer(widget.startDelay, _play);
    }
  }

  void _rest() {
    _next?.cancel();
    _controller
      ..stop()
      ..value = widget.asset.rest == MichiMotionRest.start ? 0 : 1;
  }

  void _play() {
    if (_composition == null || !mounted) return;
    if (_reduceMotion) {
      _rest();
      return;
    }
    _next?.cancel();
    unawaited(
      _controller.forward(from: 0).whenComplete(() {
        if (!mounted) return;
        if (widget.asset.rest == MichiMotionRest.start) _controller.value = 0;
        if (widget.playback == MichiMotionPlayback.occasional) {
          _next = Timer(widget.occasionalInterval, _playIfVisible);
        }
      }),
    );
  }

  /// A muted ticker (hidden tab, covered route, backgrounded app) skips the
  /// cycle; the next one is scheduled instead of queueing animation work.
  void _playIfVisible() {
    if (!mounted) return;
    if (TickerMode.valuesOf(context).enabled) {
      _play();
    } else {
      _next = Timer(widget.occasionalInterval, _playIfVisible);
    }
  }

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: RepaintBoundary(
      child: SizedBox.square(
        dimension: widget.size,
        child: Lottie.asset(
          widget.asset.path,
          package: MichiMotionAsset.package,
          controller: _controller,
          onLoaded: _onLoaded,
          fit: BoxFit.contain,
          frameRate: FrameRate.composition,
          errorBuilder: (context, error, stackTrace) =>
              widget.fallback ?? const SizedBox.shrink(),
        ),
      ),
    ),
  );
}
