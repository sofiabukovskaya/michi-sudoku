import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';
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
  Widget build(BuildContext context) => RoutePlaceholder(
    title: context.t.appName,
    subtitle: context.t.splash.subtitle,
    actionLabel: context.t.common.start,
    onAction: _checking
        ? null
        : () => context.router.replace(const WelcomeRoute()),
  );
}
