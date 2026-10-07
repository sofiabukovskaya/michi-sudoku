import 'package:auto_route/auto_route.dart';
import 'package:michi_mobile/features/auth/presentation/auth_page.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/home/presentation/home_page.dart';
import 'package:michi_mobile/features/learn/presentation/learn_page.dart';
import 'package:michi_mobile/features/onboarding/presentation/onboarding_page.dart';
import 'package:michi_mobile/features/onboarding/presentation/player_level_page.dart';
import 'package:michi_mobile/features/onboarding/presentation/welcome_page.dart';
import 'package:michi_mobile/features/profile/presentation/profile_page.dart';
import 'package:michi_mobile/features/progress/presentation/progress_page.dart';
import 'package:michi_mobile/features/scanner/presentation/scanner_page.dart';
import 'package:michi_mobile/features/splash/presentation/splash_page.dart';

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
    AutoRoute(page: LearnRoute.page),
    AutoRoute(page: ProgressRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: ScannerRoute.page),
  ];
}
