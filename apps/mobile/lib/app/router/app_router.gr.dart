// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppShellPage]
class AppShellRoute extends PageRouteInfo<AppShellRouteArgs> {
  AppShellRoute({
    GameRepository? repository,
    LearningRecommendationService? recommendationService,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AppShellRoute.name,
         args: AppShellRouteArgs(
           repository: repository,
           recommendationService: recommendationService,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'AppShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppShellRouteArgs>(
        orElse: () => const AppShellRouteArgs(),
      );
      return AppShellPage(
        repository: args.repository,
        recommendationService: args.recommendationService,
        key: args.key,
      );
    },
  );
}

class AppShellRouteArgs {
  const AppShellRouteArgs({
    this.repository,
    this.recommendationService,
    this.key,
  });

  final GameRepository? repository;

  final LearningRecommendationService? recommendationService;

  final Key? key;

  @override
  String toString() {
    return 'AppShellRouteArgs{repository: $repository, recommendationService: $recommendationService, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppShellRouteArgs) return false;
    return repository == other.repository &&
        recommendationService == other.recommendationService &&
        key == other.key;
  }

  @override
  int get hashCode =>
      repository.hashCode ^ recommendationService.hashCode ^ key.hashCode;
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({bool fromWelcome = false, Key? key, List<PageRouteInfo>? children})
    : super(
        AuthRoute.name,
        args: AuthRouteArgs(fromWelcome: fromWelcome, key: key),
        initialChildren: children,
      );

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthRouteArgs>(
        orElse: () => const AuthRouteArgs(),
      );
      return AuthPage(fromWelcome: args.fromWelcome, key: args.key);
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({this.fromWelcome = false, this.key});

  final bool fromWelcome;

  final Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{fromWelcome: $fromWelcome, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthRouteArgs) return false;
    return fromWelcome == other.fromWelcome && key == other.key;
  }

  @override
  int get hashCode => fromWelcome.hashCode ^ key.hashCode;
}

/// generated route for
/// [EmailVerificationPage]
class EmailVerificationRoute extends PageRouteInfo<EmailVerificationRouteArgs> {
  EmailVerificationRoute({
    bool fromWelcome = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         EmailVerificationRoute.name,
         args: EmailVerificationRouteArgs(fromWelcome: fromWelcome, key: key),
         initialChildren: children,
       );

  static const String name = 'EmailVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmailVerificationRouteArgs>(
        orElse: () => const EmailVerificationRouteArgs(),
      );
      return EmailVerificationPage(
        fromWelcome: args.fromWelcome,
        key: args.key,
      );
    },
  );
}

class EmailVerificationRouteArgs {
  const EmailVerificationRouteArgs({this.fromWelcome = false, this.key});

  final bool fromWelcome;

  final Key? key;

  @override
  String toString() {
    return 'EmailVerificationRouteArgs{fromWelcome: $fromWelcome, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmailVerificationRouteArgs) return false;
    return fromWelcome == other.fromWelcome && key == other.key;
  }

  @override
  int get hashCode => fromWelcome.hashCode ^ key.hashCode;
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({
    SudokuPuzzle? puzzle,
    PuzzleDefinition? definition,
    String? dailyChallengeKey,
    GameCubit? cubit,
    GameRepository? repository,
    GameClock? clock,
    LearningRecommendationService? recommendationService,
    bool restore = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         GameRoute.name,
         args: GameRouteArgs(
           puzzle: puzzle,
           definition: definition,
           dailyChallengeKey: dailyChallengeKey,
           cubit: cubit,
           repository: repository,
           clock: clock,
           recommendationService: recommendationService,
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
        definition: args.definition,
        dailyChallengeKey: args.dailyChallengeKey,
        cubit: args.cubit,
        repository: args.repository,
        clock: args.clock,
        recommendationService: args.recommendationService,
        restore: args.restore,
        key: args.key,
      );
    },
  );
}

class GameRouteArgs {
  const GameRouteArgs({
    this.puzzle,
    this.definition,
    this.dailyChallengeKey,
    this.cubit,
    this.repository,
    this.clock,
    this.recommendationService,
    this.restore = false,
    this.key,
  });

  final SudokuPuzzle? puzzle;

  final PuzzleDefinition? definition;

  final String? dailyChallengeKey;

  final GameCubit? cubit;

  final GameRepository? repository;

  final GameClock? clock;

  final LearningRecommendationService? recommendationService;

  final bool restore;

  final Key? key;

  @override
  String toString() {
    return 'GameRouteArgs{puzzle: $puzzle, definition: $definition, dailyChallengeKey: $dailyChallengeKey, cubit: $cubit, repository: $repository, clock: $clock, recommendationService: $recommendationService, restore: $restore, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameRouteArgs) return false;
    return puzzle == other.puzzle &&
        definition == other.definition &&
        dailyChallengeKey == other.dailyChallengeKey &&
        cubit == other.cubit &&
        repository == other.repository &&
        clock == other.clock &&
        recommendationService == other.recommendationService &&
        restore == other.restore &&
        key == other.key;
  }

  @override
  int get hashCode =>
      puzzle.hashCode ^
      definition.hashCode ^
      dailyChallengeKey.hashCode ^
      cubit.hashCode ^
      repository.hashCode ^
      clock.hashCode ^
      recommendationService.hashCode ^
      restore.hashCode ^
      key.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    GameRepository? repository,
    PuzzleRepository? puzzleRepository,
    GameClock? clock,
    LearningRecommendationService? recommendationService,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(
           repository: repository,
           puzzleRepository: puzzleRepository,
           clock: clock,
           recommendationService: recommendationService,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomePage(
        repository: args.repository,
        puzzleRepository: args.puzzleRepository,
        clock: args.clock,
        recommendationService: args.recommendationService,
        key: args.key,
      );
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.repository,
    this.puzzleRepository,
    this.clock,
    this.recommendationService,
    this.key,
  });

  final GameRepository? repository;

  final PuzzleRepository? puzzleRepository;

  final GameClock? clock;

  final LearningRecommendationService? recommendationService;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{repository: $repository, puzzleRepository: $puzzleRepository, clock: $clock, recommendationService: $recommendationService, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return repository == other.repository &&
        puzzleRepository == other.puzzleRepository &&
        clock == other.clock &&
        recommendationService == other.recommendationService &&
        key == other.key;
  }

  @override
  int get hashCode =>
      repository.hashCode ^
      puzzleRepository.hashCode ^
      clock.hashCode ^
      recommendationService.hashCode ^
      key.hashCode;
}

/// generated route for
/// [LearnPage]
class LearnRoute extends PageRouteInfo<LearnRouteArgs> {
  LearnRoute({
    TechniqueProgressRepository? progressRepository,
    LocalPracticeCatalog? catalog,
    LearningRecommendationService? recommendationService,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         LearnRoute.name,
         args: LearnRouteArgs(
           progressRepository: progressRepository,
           catalog: catalog,
           recommendationService: recommendationService,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'LearnRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LearnRouteArgs>(
        orElse: () => const LearnRouteArgs(),
      );
      return LearnPage(
        progressRepository: args.progressRepository,
        catalog: args.catalog,
        recommendationService: args.recommendationService,
        key: args.key,
      );
    },
  );
}

class LearnRouteArgs {
  const LearnRouteArgs({
    this.progressRepository,
    this.catalog,
    this.recommendationService,
    this.key,
  });

  final TechniqueProgressRepository? progressRepository;

  final LocalPracticeCatalog? catalog;

  final LearningRecommendationService? recommendationService;

  final Key? key;

  @override
  String toString() {
    return 'LearnRouteArgs{progressRepository: $progressRepository, catalog: $catalog, recommendationService: $recommendationService, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LearnRouteArgs) return false;
    return progressRepository == other.progressRepository &&
        catalog == other.catalog &&
        recommendationService == other.recommendationService &&
        key == other.key;
  }

  @override
  int get hashCode =>
      progressRepository.hashCode ^
      catalog.hashCode ^
      recommendationService.hashCode ^
      key.hashCode;
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
/// [PasswordResetPage]
class PasswordResetRoute extends PageRouteInfo<PasswordResetRouteArgs> {
  PasswordResetRoute({
    String initialEmail = '',
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PasswordResetRoute.name,
         args: PasswordResetRouteArgs(initialEmail: initialEmail, key: key),
         initialChildren: children,
       );

  static const String name = 'PasswordResetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordResetRouteArgs>(
        orElse: () => const PasswordResetRouteArgs(),
      );
      return PasswordResetPage(initialEmail: args.initialEmail, key: args.key);
    },
  );
}

class PasswordResetRouteArgs {
  const PasswordResetRouteArgs({this.initialEmail = '', this.key});

  final String initialEmail;

  final Key? key;

  @override
  String toString() {
    return 'PasswordResetRouteArgs{initialEmail: $initialEmail, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PasswordResetRouteArgs) return false;
    return initialEmail == other.initialEmail && key == other.key;
  }

  @override
  int get hashCode => initialEmail.hashCode ^ key.hashCode;
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
/// [PracticePage]
class PracticeRoute extends PageRouteInfo<PracticeRouteArgs> {
  PracticeRoute({
    required SudokuTechnique technique,
    LocalPracticeCatalog? catalog,
    TechniqueProgressRepository? progressRepository,
    HumanSolver? humanSolver,
    CoachEngine? coachEngine,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PracticeRoute.name,
         args: PracticeRouteArgs(
           technique: technique,
           catalog: catalog,
           progressRepository: progressRepository,
           humanSolver: humanSolver,
           coachEngine: coachEngine,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'PracticeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PracticeRouteArgs>();
      return PracticePage(
        technique: args.technique,
        catalog: args.catalog,
        progressRepository: args.progressRepository,
        humanSolver: args.humanSolver,
        coachEngine: args.coachEngine,
        key: args.key,
      );
    },
  );
}

class PracticeRouteArgs {
  const PracticeRouteArgs({
    required this.technique,
    this.catalog,
    this.progressRepository,
    this.humanSolver,
    this.coachEngine,
    this.key,
  });

  final SudokuTechnique technique;

  final LocalPracticeCatalog? catalog;

  final TechniqueProgressRepository? progressRepository;

  final HumanSolver? humanSolver;

  final CoachEngine? coachEngine;

  final Key? key;

  @override
  String toString() {
    return 'PracticeRouteArgs{technique: $technique, catalog: $catalog, progressRepository: $progressRepository, humanSolver: $humanSolver, coachEngine: $coachEngine, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PracticeRouteArgs) return false;
    return technique == other.technique &&
        catalog == other.catalog &&
        progressRepository == other.progressRepository &&
        humanSolver == other.humanSolver &&
        coachEngine == other.coachEngine &&
        key == other.key;
  }

  @override
  int get hashCode =>
      technique.hashCode ^
      catalog.hashCode ^
      progressRepository.hashCode ^
      humanSolver.hashCode ^
      coachEngine.hashCode ^
      key.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    GameRepository? games,
    TechniqueProgressRepository? progress,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(games: games, progress: progress, key: key),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return ProfilePage(
        games: args.games,
        progress: args.progress,
        key: args.key,
      );
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.games, this.progress, this.key});

  final GameRepository? games;

  final TechniqueProgressRepository? progress;

  final Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{games: $games, progress: $progress, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileRouteArgs) return false;
    return games == other.games &&
        progress == other.progress &&
        key == other.key;
  }

  @override
  int get hashCode => games.hashCode ^ progress.hashCode ^ key.hashCode;
}

/// generated route for
/// [ProgressPage]
class ProgressRoute extends PageRouteInfo<ProgressRouteArgs> {
  ProgressRoute({
    TechniqueProgressRepository? progressRepository,
    GameRepository? gameRepository,
    LearningRecommendationService? recommendationService,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ProgressRoute.name,
         args: ProgressRouteArgs(
           progressRepository: progressRepository,
           gameRepository: gameRepository,
           recommendationService: recommendationService,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ProgressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProgressRouteArgs>(
        orElse: () => const ProgressRouteArgs(),
      );
      return ProgressPage(
        progressRepository: args.progressRepository,
        gameRepository: args.gameRepository,
        recommendationService: args.recommendationService,
        key: args.key,
      );
    },
  );
}

class ProgressRouteArgs {
  const ProgressRouteArgs({
    this.progressRepository,
    this.gameRepository,
    this.recommendationService,
    this.key,
  });

  final TechniqueProgressRepository? progressRepository;

  final GameRepository? gameRepository;

  final LearningRecommendationService? recommendationService;

  final Key? key;

  @override
  String toString() {
    return 'ProgressRouteArgs{progressRepository: $progressRepository, gameRepository: $gameRepository, recommendationService: $recommendationService, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProgressRouteArgs) return false;
    return progressRepository == other.progressRepository &&
        gameRepository == other.gameRepository &&
        recommendationService == other.recommendationService &&
        key == other.key;
  }

  @override
  int get hashCode =>
      progressRepository.hashCode ^
      gameRepository.hashCode ^
      recommendationService.hashCode ^
      key.hashCode;
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    bool fromWelcome = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         RegisterRoute.name,
         args: RegisterRouteArgs(fromWelcome: fromWelcome, key: key),
         initialChildren: children,
       );

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return RegisterPage(fromWelcome: args.fromWelcome, key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.fromWelcome = false, this.key});

  final bool fromWelcome;

  final Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{fromWelcome: $fromWelcome, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterRouteArgs) return false;
    return fromWelcome == other.fromWelcome && key == other.key;
  }

  @override
  int get hashCode => fromWelcome.hashCode ^ key.hashCode;
}

/// generated route for
/// [ScannerPage]
class ScannerRoute extends PageRouteInfo<ScannerRouteArgs> {
  ScannerRoute({
    required ScannerCubit cubit,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ScannerRoute.name,
         args: ScannerRouteArgs(cubit: cubit, key: key),
         initialChildren: children,
       );

  static const String name = 'ScannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScannerRouteArgs>();
      return ScannerPage(cubit: args.cubit, key: args.key);
    },
  );
}

class ScannerRouteArgs {
  const ScannerRouteArgs({required this.cubit, this.key});

  final ScannerCubit cubit;

  final Key? key;

  @override
  String toString() {
    return 'ScannerRouteArgs{cubit: $cubit, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScannerRouteArgs) return false;
    return cubit == other.cubit && key == other.key;
  }

  @override
  int get hashCode => cubit.hashCode ^ key.hashCode;
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
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
/// [TechniqueLessonPage]
class TechniqueLessonRoute extends PageRouteInfo<TechniqueLessonRouteArgs> {
  TechniqueLessonRoute({
    required SudokuTechnique technique,
    LocalPracticeCatalog? catalog,
    TechniqueProgressRepository? progressRepository,
    HumanSolver? humanSolver,
    CoachEngine? coachEngine,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         TechniqueLessonRoute.name,
         args: TechniqueLessonRouteArgs(
           technique: technique,
           catalog: catalog,
           progressRepository: progressRepository,
           humanSolver: humanSolver,
           coachEngine: coachEngine,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'TechniqueLessonRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TechniqueLessonRouteArgs>();
      return TechniqueLessonPage(
        technique: args.technique,
        catalog: args.catalog,
        progressRepository: args.progressRepository,
        humanSolver: args.humanSolver,
        coachEngine: args.coachEngine,
        key: args.key,
      );
    },
  );
}

class TechniqueLessonRouteArgs {
  const TechniqueLessonRouteArgs({
    required this.technique,
    this.catalog,
    this.progressRepository,
    this.humanSolver,
    this.coachEngine,
    this.key,
  });

  final SudokuTechnique technique;

  final LocalPracticeCatalog? catalog;

  final TechniqueProgressRepository? progressRepository;

  final HumanSolver? humanSolver;

  final CoachEngine? coachEngine;

  final Key? key;

  @override
  String toString() {
    return 'TechniqueLessonRouteArgs{technique: $technique, catalog: $catalog, progressRepository: $progressRepository, humanSolver: $humanSolver, coachEngine: $coachEngine, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TechniqueLessonRouteArgs) return false;
    return technique == other.technique &&
        catalog == other.catalog &&
        progressRepository == other.progressRepository &&
        humanSolver == other.humanSolver &&
        coachEngine == other.coachEngine &&
        key == other.key;
  }

  @override
  int get hashCode =>
      technique.hashCode ^
      catalog.hashCode ^
      progressRepository.hashCode ^
      humanSolver.hashCode ^
      coachEngine.hashCode ^
      key.hashCode;
}

/// generated route for
/// [WeekPage]
class WeekRoute extends PageRouteInfo<WeekRouteArgs> {
  WeekRoute({
    GameRepository? games,
    GameClock? clock,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         WeekRoute.name,
         args: WeekRouteArgs(games: games, clock: clock, key: key),
         initialChildren: children,
       );

  static const String name = 'WeekRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WeekRouteArgs>(
        orElse: () => const WeekRouteArgs(),
      );
      return WeekPage(games: args.games, clock: args.clock, key: args.key);
    },
  );
}

class WeekRouteArgs {
  const WeekRouteArgs({this.games, this.clock, this.key});

  final GameRepository? games;

  final GameClock? clock;

  final Key? key;

  @override
  String toString() {
    return 'WeekRouteArgs{games: $games, clock: $clock, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WeekRouteArgs) return false;
    return games == other.games && clock == other.clock && key == other.key;
  }

  @override
  int get hashCode => games.hashCode ^ clock.hashCode ^ key.hashCode;
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

/// generated route for
/// [WhyPage]
class WhyRoute extends PageRouteInfo<WhyRouteArgs> {
  WhyRoute({
    required GameState game,
    required WhySelection selection,
    required CellRef cell,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         WhyRoute.name,
         args: WhyRouteArgs(
           game: game,
           selection: selection,
           cell: cell,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'WhyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WhyRouteArgs>();
      return WhyPage(
        game: args.game,
        selection: args.selection,
        cell: args.cell,
        key: args.key,
      );
    },
  );
}

class WhyRouteArgs {
  const WhyRouteArgs({
    required this.game,
    required this.selection,
    required this.cell,
    this.key,
  });

  final GameState game;

  final WhySelection selection;

  final CellRef cell;

  final Key? key;

  @override
  String toString() {
    return 'WhyRouteArgs{game: $game, selection: $selection, cell: $cell, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WhyRouteArgs) return false;
    return game == other.game &&
        selection == other.selection &&
        cell == other.cell &&
        key == other.key;
  }

  @override
  int get hashCode =>
      game.hashCode ^ selection.hashCode ^ cell.hashCode ^ key.hashCode;
}
