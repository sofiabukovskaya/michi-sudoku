import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

final class _SplashPageState extends State<SplashPage> {
  Timer? _welcomeTimer;

  @override
  void initState() {
    super.initState();
    unawaited(_checkForSavedGame());
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
    _welcomeTimer?.cancel();
    _welcomeTimer = Timer(const Duration(milliseconds: 900), () {
      if (mounted && context.router.current.name == SplashRoute.name) {
        unawaited(context.router.replace(const WelcomeRoute()));
      }
    });
  }

  @override
  void dispose() {
    _welcomeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.indigo,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 650;
          final mascotSize = (constraints.maxWidth * (compact ? 0.67 : 0.80))
              .clamp(
                160.0,
                compact ? 280.0 : 360.0,
              );
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: MichiSpacing.xl),
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * (compact ? 0.18 : 0.16),
                ),
                MichiMascot(
                  state: MichiMascotState.walking,
                  size: mascotSize,
                ),
                SizedBox(height: compact ? 32 : 64),
                const MichiWordmark(light: true, iconSize: 42),
                const SizedBox(height: MichiSpacing.lg),
                Text(
                  context.t.splash.subtitle,
                  style: MichiTypography.editorialTitle.copyWith(
                    color: MichiColors.ivory,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    ),
  );
}
