// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:michi_mobile/app/router/app_router.dart' as _i712;
import 'package:michi_mobile/core/di/injection.dart' as _i857;
import 'package:michi_mobile/core/time/game_clock.dart' as _i585;
import 'package:michi_mobile/features/game/data/game_database.dart' as _i520;
import 'package:michi_mobile/features/game/domain/game_repository.dart'
    as _i263;
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart'
    as _i426;
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart'
    as _i56;
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart'
    as _i936;
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart'
    as _i150;
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart'
    as _i769;
import 'package:michi_mobile/features/recommendation/application/learning_profile_provider.dart'
    as _i484;
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart'
    as _i539;
import 'package:michi_mobile/features/recommendation/domain/daily_learning_focus_repository.dart'
    as _i397;
import 'package:sudoku_engine/sudoku_engine.dart' as _i247;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i712.AppRouter>(() => appModule.router);
    gh.lazySingleton<_i247.ExactSolver>(() => appModule.exactSolver);
    gh.lazySingleton<_i247.HumanSolver>(() => appModule.humanSolver);
    gh.lazySingleton<_i247.CoachEngine>(() => appModule.coachEngine);
    gh.lazySingleton<_i585.GameClock>(() => appModule.gameClock);
    gh.lazySingleton<_i520.GameDatabase>(() => appModule.gameDatabase);
    gh.lazySingleton<_i936.LocalPuzzleCatalogLoader>(
      () => appModule.puzzleCatalogLoader,
    );
    gh.lazySingleton<_i56.LocalPracticeCatalog>(
      () => appModule.practiceCatalog,
    );
    gh.lazySingleton<_i150.PuzzleAnalyzer>(
      () => appModule.puzzleAnalyzer(
        gh<_i247.ExactSolver>(),
        gh<_i247.HumanSolver>(),
      ),
    );
    gh.lazySingleton<_i263.GameRepository>(
      () => appModule.gameRepository(gh<_i520.GameDatabase>()),
    );
    gh.lazySingleton<_i426.TechniqueProgressRepository>(
      () => appModule.techniqueProgressRepository(gh<_i520.GameDatabase>()),
    );
    gh.lazySingleton<_i397.DailyLearningFocusRepository>(
      () => appModule.dailyLearningFocusRepository(gh<_i520.GameDatabase>()),
    );
    gh.lazySingleton<_i769.PuzzleRepository>(
      () => appModule.puzzleRepository(
        gh<_i936.LocalPuzzleCatalogLoader>(),
        gh<_i263.GameRepository>(),
      ),
    );
    gh.lazySingleton<_i484.LearningProfileProvider>(
      () => appModule.learningProfileProvider(
        gh<_i426.TechniqueProgressRepository>(),
        gh<_i263.GameRepository>(),
        gh<_i769.PuzzleRepository>(),
      ),
    );
    gh.lazySingleton<_i539.LearningRecommendationService>(
      () => appModule.learningRecommendationService(
        gh<_i484.LearningProfileProvider>(),
        gh<_i397.DailyLearningFocusRepository>(),
        gh<_i585.GameClock>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i857.AppModule {}
