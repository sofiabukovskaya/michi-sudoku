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
    PuzzleDefinition? definition,
    String? dailyChallengeKey,
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
           definition: definition,
           dailyChallengeKey: dailyChallengeKey,
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
        definition: args.definition,
        dailyChallengeKey: args.dailyChallengeKey,
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
    this.definition,
    this.dailyChallengeKey,
    this.cubit,
    this.repository,
    this.clock,
    this.restore = false,
    this.key,
  });

  final SudokuPuzzle? puzzle;

  final PuzzleDefinition? definition;

  final String? dailyChallengeKey;

  final GameCubit? cubit;

  final GameRepository? repository;

  final GameClock? clock;

  final bool restore;

  final Key? key;

  @override
  String toString() {
    return 'GameRouteArgs{puzzle: $puzzle, definition: $definition, dailyChallengeKey: $dailyChallengeKey, cubit: $cubit, repository: $repository, clock: $clock, restore: $restore, key: $key}';
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
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(
           repository: repository,
           puzzleRepository: puzzleRepository,
           clock: clock,
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
    this.key,
  });

  final GameRepository? repository;

  final PuzzleRepository? puzzleRepository;

  final GameClock? clock;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{repository: $repository, puzzleRepository: $puzzleRepository, clock: $clock, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return repository == other.repository &&
        puzzleRepository == other.puzzleRepository &&
        clock == other.clock &&
        key == other.key;
  }

  @override
  int get hashCode =>
      repository.hashCode ^
      puzzleRepository.hashCode ^
      clock.hashCode ^
      key.hashCode;
}

/// generated route for
/// [LearnPage]
class LearnRoute extends PageRouteInfo<LearnRouteArgs> {
  LearnRoute({
    TechniqueProgressRepository? progressRepository,
    LocalPracticeCatalog? catalog,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         LearnRoute.name,
         args: LearnRouteArgs(
           progressRepository: progressRepository,
           catalog: catalog,
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
        key: args.key,
      );
    },
  );
}

class LearnRouteArgs {
  const LearnRouteArgs({this.progressRepository, this.catalog, this.key});

  final TechniqueProgressRepository? progressRepository;

  final LocalPracticeCatalog? catalog;

  final Key? key;

  @override
  String toString() {
    return 'LearnRouteArgs{progressRepository: $progressRepository, catalog: $catalog, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LearnRouteArgs) return false;
    return progressRepository == other.progressRepository &&
        catalog == other.catalog &&
        key == other.key;
  }

  @override
  int get hashCode =>
      progressRepository.hashCode ^ catalog.hashCode ^ key.hashCode;
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
