import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_wordmark.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';

@RoutePage()
final class SplashPage extends StatefulWidget {
  const SplashPage({this.repository, super.key});

  /// Optional storage input makes startup restoration deterministic in tests.
  final GameRepository? repository;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

final class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  /// Plays while startup work runs; navigation never waits for it. The
  /// destination fades in over the still-animating splash instead.
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 720),
  );

  bool _started = false;

  @override
  void initState() {
    super.initState();
    unawaited(_checkForSavedGame());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _entrance.value = 1;
    } else if (!_started) {
      _started = true;
      // Begin when the OS launch screen is actually gone, so the entrance
      // is seen from its first beat. Android 12+ keeps its splash up after
      // Flutter's first frame and reports the removal; iOS swaps on the
      // first rasterized frame. A fallback keeps the splash from waiting.
      if (defaultTargetPlatform == TargetPlatform.android) {
        _launchChannel.setMethodCallHandler((call) async {
          if (call.method == 'launchScreenRemoved') _beginEntrance();
        });
        _fallback = Timer(const Duration(milliseconds: 1500), _beginEntrance);
      } else {
        unawaited(
          WidgetsBinding.instance.waitUntilFirstFrameRasterized.then(
            (_) => _beginEntrance(),
          ),
        );
      }
    }
  }

  static const _launchChannel = MethodChannel('michi/launch');
  Timer? _fallback;

  void _beginEntrance() {
    _fallback?.cancel();
    if (mounted && _entrance.value == 0 && !_entrance.isAnimating) {
      _entrance.forward();
    }
  }

  @override
  void dispose() {
    _fallback?.cancel();
    if (defaultTargetPlatform == TargetPlatform.android) {
      _launchChannel.setMethodCallHandler(null);
    }
    _entrance.dispose();
    super.dispose();
  }

  Future<void> _checkForSavedGame() async {
    final repository = widget.repository ?? getIt<GameRepository>();
    try {
      final active = await repository.loadActiveSummary();
      if (!mounted) return;
      if (active != null) {
        await context.router.replace(
          AppShellRoute(
            children: [
              HomeRoute(
                repository: repository,
                recommendationService: widget.repository == null
                    ? getIt<LearningRecommendationService>()
                    : null,
              ),
            ],
          ),
        );
      } else {
        _scheduleWelcome();
      }
    } on Object catch (error, stackTrace) {
      developer.log(
        'Startup game check failed',
        name: 'michi.game',
        error: error,
        stackTrace: stackTrace,
      );
      if (mounted) _scheduleWelcome();
    }
  }

  void _scheduleWelcome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.router.current.name == SplashRoute.name) {
        unawaited(context.router.replace(const WelcomeRoute()));
      }
    });
    WidgetsBinding.instance.ensureVisualUpdate();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.indigo,
    body: LayoutBuilder(
      builder: (context, constraints) => AnimatedBuilder(
        animation: _entrance,
        builder: (context, _) => _SplashComposition(
          size: constraints.biggest,
          progress: _entrance.value,
          tagline: context.t.splash.subtitle,
        ),
      ),
    ),
  );
}

/// Mascot disc, mark and tagline composed as one optically centered group.
///
/// The first frame matches the native launch screen: the disc at the exact
/// screen center at launch-image scale. It then settles up into the group
/// while the logic path draws and the words arrive.
final class _SplashComposition extends StatelessWidget {
  const _SplashComposition({
    required this.size,
    required this.progress,
    required this.tagline,
  });

  /// Native launch disc size, measured on device: the iOS LaunchScreen image
  /// is 188pt; the Android 12+ system splash masks it to about 128dp.
  static double get _launchDisc =>
      defaultTargetPlatform == TargetPlatform.android ? 128 : 188;

  final Size size;
  final double progress;
  final String tagline;

  static double _interval(double value, double begin, double end) =>
      MichiMotion.curve.transform(
        ((value - begin) / (end - begin)).clamp(0.0, 1.0),
      );

  @override
  Widget build(BuildContext context) {
    final windowClass = MichiLayout.classify(size.width);
    final disc = switch (windowClass) {
      MichiWindowClass.compact => (size.width * 0.62).clamp(188.0, 248.0),
      MichiWindowClass.medium => 264.0,
      MichiWindowClass.expanded => 288.0,
    };
    final settle = _interval(progress, 0, 0.62);
    final mark = _interval(progress, 0.28, 0.82);
    final words = _interval(progress, 0.45, 1);

    // The disc finishes slightly above center; the words below it bring the
    // whole group's visual weight to just above the middle of the window.
    final startCenter = size.height / 2;
    final endCenter = size.height * 0.42;
    final discCenter = startCenter + (endCenter - startCenter) * settle;
    final scale = (_launchDisc / disc) + (1 - _launchDisc / disc) * settle;
    final textTop = endCenter + disc / 2 + MichiSpacing.xl;

    return Stack(
      children: [
        Positioned(
          left: (size.width - disc) / 2,
          top: discCenter - disc / 2,
          width: disc,
          height: disc,
          child: Transform.scale(
            scale: scale,
            child: Transform.rotate(
              // A small curious head-tilt as the mascot settles.
              angle: 0.05 * math.sin(settle * math.pi),
              child: MichiMascot(state: MichiMascotState.walking, size: disc),
            ),
          ),
        ),
        Positioned(
          left: MichiSpacing.xl,
          right: MichiSpacing.xl,
          top: textTop + (1 - mark) * MichiSpacing.sm,
          child: Opacity(
            opacity: mark,
            child: Column(
              children: [
                MichiWordmark(
                  light: true,
                  iconSize: windowClass == MichiWindowClass.compact ? 40 : 46,
                  pathProgress: mark,
                ),
                const SizedBox(height: MichiSpacing.lg),
                Opacity(
                  opacity: words,
                  child: Transform.translate(
                    offset: Offset(0, (1 - words) * MichiSpacing.md),
                    child: Text(
                      tagline,
                      style: MichiTypography.editorialTitle.copyWith(
                        color: MichiColors.ivory,
                        fontSize: windowClass == MichiWindowClass.compact
                            ? 20
                            : 22,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
