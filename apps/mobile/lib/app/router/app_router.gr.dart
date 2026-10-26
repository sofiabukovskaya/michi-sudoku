// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthPage();
    },
  );
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    SudokuPuzzle? puzzle,
    GameCubit? cubit,
    GameRepository? repository,
    GameClock? clock,
    bool restore = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         GameRoute.name,
         args: GameRouteArgs(
           puzzle: puzzle,
           cubit: cubit,
           repository: repository,
           clock: clock,
           restore: restore,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'GameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GameRouteArgs>(
        orElse: () => const GameRouteArgs(),
      );
      return GamePage(
        puzzle: args.puzzle,
        cubit: args.cubit,
        repository: args.repository,
        clock: args.clock,
        restore: args.restore,
        key: args.key,
      );
    },
  );
}

class GameRouteArgs {
  const GameRouteArgs({
    this.puzzle,
    this.cubit,
    this.repository,
    this.clock,
    this.restore = false,
    this.key,
  });

  final SudokuPuzzle? puzzle;

  final GameCubit? cubit;

  final GameRepository? repository;

  final GameClock? clock;

  final bool restore;

  final Key? key;

  @override
  String toString() {
    return 'GameRouteArgs{puzzle: $puzzle, cubit: $cubit, repository: $repository, clock: $clock, restore: $restore, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameRouteArgs) return false;
    return puzzle == other.puzzle &&
        cubit == other.cubit &&
        repository == other.repository &&
        clock == other.clock &&
        restore == other.restore &&
        key == other.key;
  }

  @override
  int get hashCode =>
      puzzle.hashCode ^
      cubit.hashCode ^
      repository.hashCode ^
      clock.hashCode ^
      restore.hashCode ^
      key.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    GameRepository? repository,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(repository: repository, key: key),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomePage(repository: args.repository, key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.repository, this.key});

  final GameRepository? repository;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{repository: $repository, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return repository == other.repository && key == other.key;
  }

  @override
  int get hashCode => repository.hashCode ^ key.hashCode;
}

/// generated route for
/// [LearnPage]
class LearnRoute extends PageRouteInfo<void> {
  const LearnRoute({List<PageRouteInfo>? children})
    : super(LearnRoute.name, initialChildren: children);

  static const String name = 'LearnRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LearnPage();
    },
  );
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingPage();
    },
  );
}

/// generated route for
/// [PlayerLevelPage]
class PlayerLevelRoute extends PageRouteInfo<void> {
  const PlayerLevelRoute({List<PageRouteInfo>? children})
    : super(PlayerLevelRoute.name, initialChildren: children);

  static const String name = 'PlayerLevelRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlayerLevelPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [ProgressPage]
class ProgressRoute extends PageRouteInfo<void> {
  const ProgressRoute({List<PageRouteInfo>? children})
    : super(ProgressRoute.name, initialChildren: children);

  static const String name = 'ProgressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProgressPage();
    },
  );
}

/// generated route for
/// [ScannerPage]
class ScannerRoute extends PageRouteInfo<void> {
  const ScannerRoute({List<PageRouteInfo>? children})
    : super(ScannerRoute.name, initialChildren: children);

  static const String name = 'ScannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScannerPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    GameRepository? repository,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SplashRoute.name,
         args: SplashRouteArgs(repository: repository, key: key),
         initialChildren: children,
       );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return SplashPage(repository: args.repository, key: args.key);
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({this.repository, this.key});

  final GameRepository? repository;

  final Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{repository: $repository, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SplashRouteArgs) return false;
    return repository == other.repository && key == other.key;
  }

  @override
  int get hashCode => repository.hashCode ^ key.hashCode;
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
