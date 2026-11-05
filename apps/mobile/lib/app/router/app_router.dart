import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/auth/presentation/auth_page.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/game/presentation/why_page.dart';
import 'package:michi_mobile/features/home/presentation/home_page.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/learn_page.dart';
import 'package:michi_mobile/features/learn/presentation/technique_lesson_page.dart';
import 'package:michi_mobile/features/onboarding/presentation/onboarding_page.dart';
import 'package:michi_mobile/features/onboarding/presentation/player_level_page.dart';
import 'package:michi_mobile/features/onboarding/presentation/welcome_page.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/practice/presentation/practice_page.dart';
import 'package:michi_mobile/features/profile/presentation/profile_page.dart';
import 'package:michi_mobile/features/progress/presentation/progress_page.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/presentation/scanner_page.dart';
import 'package:michi_mobile/features/splash/presentation/splash_page.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: PlayerLevelRoute.page),
    AutoRoute(page: AuthRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: GameRoute.page),
    AutoRoute(page: WhyRoute.page),
    AutoRoute(page: LearnRoute.page),
    AutoRoute(page: TechniqueLessonRoute.page),
    AutoRoute(page: PracticeRoute.page),
    AutoRoute(page: ProgressRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: ScannerRoute.page),
  ];
}
