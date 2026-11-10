import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/navigation/michi_bottom_nav.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';

/// Keeps the four primary destinations mounted while focused tasks use the
/// root navigator above this shell.
@RoutePage()
final class AppShellPage extends StatelessWidget {
  const AppShellPage({this.repository, this.recommendationService, super.key});

  final GameRepository? repository;
  final LearningRecommendationService? recommendationService;

  @override
  Widget build(BuildContext context) {
    final scope = context.read<LocalProfileScope?>();
    if (scope == null) return _tabs();
    return ValueListenableBuilder<String>(
      valueListenable: scope,
      builder: (context, _, _) => KeyedSubtree(
        key: ValueKey(scope.viewEpoch),
        child: _tabs(),
      ),
    );
  }

  Widget _tabs() => AutoTabsRouter(
    routes: [
      HomeRoute(
        repository: repository,
        recommendationService: recommendationService,
      ),
      LearnRoute(),
      ProgressRoute(),
      ProfileRoute(),
    ],
    builder: (context, child) {
      final tabs = AutoTabsRouter.of(context);
      return Scaffold(
        backgroundColor: MichiColors.paper,
        body: _body(context, child),
        bottomNavigationBar: MichiBottomNav(
          current: MichiTab.values[tabs.activeIndex],
          onSelect: (tab) => tabs.setActiveIndex(tab.index),
        ),
      );
    },
  );

  Widget _body(BuildContext context, Widget child) {
    final sync = context.read<SyncCoordinator?>();
    if (sync == null) return child;
    return AnimatedBuilder(
      animation: sync,
      builder: (context, _) => Column(
        children: [
          if (sync.status == SyncStatus.offline)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MichiSpacing.lg,
                MichiSpacing.sm,
                MichiSpacing.lg,
                0,
              ),
              child: MichiBanner(message: context.t.sync.offline),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
