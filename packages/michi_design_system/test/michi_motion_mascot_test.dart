import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:michi_design_system/michi_design_system.dart';

Widget _host(Widget child, {bool reduceMotion = false}) => MediaQuery(
  data: MediaQueryData(disableAnimations: reduceMotion),
  child: Directionality(textDirection: TextDirection.ltr, child: child),
);

AnimationController _controller(WidgetTester tester) =>
    tester.widget<LottieBuilder>(find.byType(LottieBuilder)).controller!
        as AnimationController;

/// Composition loading reads the asset bundle on a real event loop.
Future<void> _load(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump();
    final controller = _controller(tester);
    if (controller.duration != null) return;
  }
  fail('Composition did not load.');
}

void main() {
  testWidgets('a one-shot plays once, then draws no more frames', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const MichiMotionMascot(asset: MichiMotionAsset.happy, size: 80),
      ),
    );
    await _load(tester);
    final controller = _controller(tester);
    expect(controller.isAnimating, isTrue);
    expect(controller.duration, const Duration(milliseconds: 1400));
    await tester.pump(const Duration(milliseconds: 1500));
    expect(controller.isAnimating, isFalse);
    expect(controller.value, 1, reason: 'rests on the final pose');
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('unrelated rebuilds never replay; a new trigger does', (
    tester,
  ) async {
    Widget mascot(Object trigger) => _host(
      MichiMotionMascot(
        asset: MichiMotionAsset.happy,
        size: 80,
        trigger: trigger,
      ),
    );
    await tester.pumpWidget(mascot(1));
    await _load(tester);
    await tester.pump(const Duration(milliseconds: 1500));
    final controller = _controller(tester);
    expect(controller.isAnimating, isFalse);

    await tester.pumpWidget(mascot(1));
    expect(controller.isAnimating, isFalse);

    await tester.pumpWidget(mascot(2));
    expect(controller.isAnimating, isTrue);
    await tester.pump(const Duration(milliseconds: 1500));
  });

  testWidgets('Reduce Motion shows the rest pose without animating', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const MichiMotionMascot(asset: MichiMotionAsset.celebrating, size: 80),
        reduceMotion: true,
      ),
    );
    await _load(tester);
    final controller = _controller(tester);
    expect(controller.isAnimating, isFalse);
    expect(controller.value, 1);
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('idle rests on its first pose under Reduce Motion', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const MichiMotionMascot(
          asset: MichiMotionAsset.idle,
          size: 80,
          playback: MichiMotionPlayback.occasional,
        ),
        reduceMotion: true,
      ),
    );
    await _load(tester);
    expect(_controller(tester).value, 0);
    expect(_controller(tester).isAnimating, isFalse);
  });

  testWidgets('a muted ticker (hidden tab) draws no animation frames', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        const TickerMode(
          enabled: false,
          child: MichiMotionMascot(
            asset: MichiMotionAsset.idle,
            size: 80,
            playback: MichiMotionPlayback.occasional,
          ),
        ),
      ),
    );
    await _load(tester);
    expect(tester.binding.hasScheduledFrame, isFalse);
    await tester.pump(const Duration(seconds: 6));
    expect(_controller(tester).value, 0);
  });

  testWidgets('occasional idle is still between cycles', (tester) async {
    await tester.pumpWidget(
      _host(
        const MichiMotionMascot(
          asset: MichiMotionAsset.idle,
          size: 80,
          playback: MichiMotionPlayback.occasional,
          occasionalInterval: Duration(seconds: 10),
        ),
      ),
    );
    await _load(tester);
    final controller = _controller(tester);
    expect(controller.isAnimating, isTrue);
    await tester.pump(const Duration(milliseconds: 5100));
    expect(controller.isAnimating, isFalse);
    expect(tester.binding.hasScheduledFrame, isFalse);
    await tester.pump(const Duration(seconds: 10));
    expect(controller.isAnimating, isTrue, reason: 'next quiet cycle');
    await tester.pump(const Duration(milliseconds: 5100));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a delayed stamp is invisible until its moment', (tester) async {
    await tester.pumpWidget(
      _host(
        const MichiMotionMascot(
          asset: MichiMotionAsset.dailyStamp,
          size: 80,
          startDelay: Duration(milliseconds: 1200),
        ),
      ),
    );
    await _load(tester);
    final controller = _controller(tester);
    expect(controller.value, 0);
    expect(controller.isAnimating, isFalse);
    await tester.pump(const Duration(milliseconds: 1250));
    expect(controller.isAnimating, isTrue);
    await tester.pump(const Duration(seconds: 1));
    expect(controller.value, 1);
  });
}
