import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/navigation/michi_bottom_nav.dart';
import 'package:michi_mobile/app/router/app_router.dart';
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
  Widget build(BuildContext context) => AutoTabsRouter(
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
        body: child,
        bottomNavigationBar: MichiBottomNav(
          current: MichiTab.values[tabs.activeIndex],
          onSelect: (tab) => tabs.setActiveIndex(tab.index),
        ),
      );
    },
  );
}
