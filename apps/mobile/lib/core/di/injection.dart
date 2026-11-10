import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/profile/local_profile_manager.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/core/sync/cloud_sync_repository.dart';
import 'package:michi_mobile/core/sync/firestore_cloud_sync_repository.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/core/sync/sync_engine.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/data/firebase_auth_repository.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_profile_provider.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/data/drift_daily_learning_focus_repository.dart';
import 'package:michi_mobile/features/recommendation/domain/daily_learning_focus_repository.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/data/drift_imported_puzzle_repository.dart';
import 'package:michi_mobile/features/scanner/data/platform_scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @lazySingleton
  FirebaseRuntime get firebaseRuntime => FirebaseRuntime();

  @lazySingleton
  AuthRepository authRepository(FirebaseRuntime runtime) =>
      FirebaseAuthRepository(runtime);

  @lazySingleton
  AuthCubit authCubit(AuthRepository repository) => AuthCubit(repository);

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
  LocalProfileScope get localProfileScope => LocalProfileScope();

  @lazySingleton
  LocalProfileManager localProfileManager(
    GameDatabase database,
    LocalProfileScope scope,
  ) => LocalProfileManager(database, scope);

  @lazySingleton
  CloudSyncRepository cloudSyncRepository(FirebaseRuntime runtime) =>
      FirestoreCloudSyncRepository(runtime);

  @lazySingleton
  SyncEngine syncEngine(GameDatabase database, CloudSyncRepository remote) =>
      SyncEngine(database, remote);

  @lazySingleton
  SyncCoordinator syncCoordinator(
    AuthCubit auth,
    LocalProfileScope scope,
    LocalProfileManager profiles,
    SyncEngine engine,
    GameDatabase database,
    AppRouter router,
  ) => SyncCoordinator(
    auth: auth,
    scope: scope,
    profiles: profiles,
    engine: engine,
    database: database,
    router: router,
  );

  @lazySingleton
  GameRepository gameRepository(
    GameDatabase database,
    LocalProfileScope scope,
  ) => DriftGameRepository(database, scope);

  @lazySingleton
  LocalPuzzleCatalogLoader get puzzleCatalogLoader =>
      LocalPuzzleCatalogLoader();

  @lazySingleton
  PuzzleAnalyzer puzzleAnalyzer(ExactSolver exact, HumanSolver human) =>
      PuzzleAnalyzer(exact, human);

  @lazySingleton
  PuzzleRepository puzzleRepository(
    LocalPuzzleCatalogLoader loader,
    GameRepository games,
  ) => LocalPuzzleRepository(loader, games);

  @lazySingleton
  TechniqueProgressRepository techniqueProgressRepository(
    GameDatabase database,
    LocalProfileScope scope,
  ) => DriftTechniqueProgressRepository(database, scope);

  @lazySingleton
  LocalPracticeCatalog get practiceCatalog => LocalPracticeCatalog();

  @lazySingleton
  DailyLearningFocusRepository dailyLearningFocusRepository(
    GameDatabase database,
    LocalProfileScope scope,
  ) => DriftDailyLearningFocusRepository(database, scope);

  @lazySingleton
  LearningProfileProvider learningProfileProvider(
    TechniqueProgressRepository progress,
    GameRepository games,
    PuzzleRepository puzzles,
  ) => LearningProfileProvider(progress, games, puzzles);

  @lazySingleton
  LearningRecommendationService learningRecommendationService(
    LearningProfileProvider profile,
    DailyLearningFocusRepository focus,
    GameClock clock,
  ) => LearningRecommendationService(
    profileProvider: profile,
    focusRepository: focus,
    clock: clock,
  );

  @lazySingleton
  GridDetector get gridDetector => const LocalGridDetector();

  @lazySingleton
  PerspectiveCorrector get perspectiveCorrector =>
      const HomographyPerspectiveCorrector();

  @lazySingleton
  CellSegmenter get cellSegmenter => const InsetCellSegmenter();

  @lazySingleton
  DigitClassifier get digitClassifier => TFLiteDigitClassifier();

  @lazySingleton
  SudokuScannerService scannerService(
    GridDetector detector,
    PerspectiveCorrector corrector,
    CellSegmenter segmenter,
    DigitClassifier classifier,
  ) => LocalSudokuScannerService(
    detector: detector,
    corrector: corrector,
    segmenter: segmenter,
    classifier: classifier,
  );

  @lazySingleton
  ImportedPuzzleRepository importedPuzzleRepository(
    GameDatabase database,
    LocalProfileScope scope,
  ) => DriftImportedPuzzleRepository(database, scope);

  ScannerImageSource get scannerImageSource => PlatformScannerImageSource();

  ScannerCubit scannerCubit(
    ScannerImageSource source,
    SudokuScannerService service,
    PuzzleAnalyzer analyzer,
    ImportedPuzzleRepository imported,
  ) => ScannerCubit(
    imageSource: source,
    scanner: service,
    analyzer: analyzer,
    importedPuzzles: imported,
  );
}
