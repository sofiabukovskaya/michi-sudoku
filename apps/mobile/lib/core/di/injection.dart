import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @lazySingleton
  AppRouter get router => AppRouter();

  @lazySingleton
  ExactSolver get exactSolver => const BacktrackingExactSolver();

  @lazySingleton
  HumanSolver get humanSolver => const DeterministicHumanSolver();

  @lazySingleton
  CoachEngine get coachEngine => const StructuredCoachEngine();

  @lazySingleton
  GameClock get gameClock => SystemGameClock();

  @lazySingleton
  GameDatabase get gameDatabase => GameDatabase.open();

  @lazySingleton
  GameRepository gameRepository(GameDatabase database) =>
      DriftGameRepository(database);
}
