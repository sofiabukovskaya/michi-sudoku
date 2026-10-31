import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_wordmark.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';

@RoutePage()
final class SplashPage extends StatefulWidget {
  const SplashPage({this.repository, super.key});

  /// Optional storage input makes startup restoration deterministic in tests.
  final GameRepository? repository;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

final class _SplashPageState extends State<SplashPage> {
  bool _checking = true;

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
        await context.router.replace(HomeRoute(repository: repository));
      } else {
        setState(() => _checking = false);
      }
    } on Object catch (error, stackTrace) {
      developer.log(
        'Startup game check failed',
        name: 'michi.game',
        error: error,
        stackTrace: stackTrace,
      );
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.indigo,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mascotSize = (constraints.maxWidth * 0.72).clamp(
            160.0,
            constraints.maxHeight < 650 ? 280.0 : 320.0,
          );
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: MichiSpacing.xl),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.08),
                Container(
                  width: mascotSize,
                  height: mascotSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MichiColors.indigoPressed,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/coach_mascot.png',
                    width: mascotSize * 0.84,
                    height: mascotSize * 0.84,
                    excludeFromSemantics: true,
                  ),
                ),
                SizedBox(height: constraints.maxHeight < 650 ? 72 : 96),
                const MichiWordmark(light: true, iconSize: 42),
                const SizedBox(height: MichiSpacing.lg),
                Text(
                  context.t.splash.subtitle,
                  style: MichiTypography.editorialTitle.copyWith(
                    color: MichiColors.ivory,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _checking
                      ? null
                      : () => context.router.replace(const WelcomeRoute()),
                  child: Text(
                    context.t.common.start,
                    style: MichiTypography.body.copyWith(
                      color: MichiColors.ivory,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: MichiSpacing.xl),
              ],
            ),
          );
        },
      ),
    ),
  );
}
