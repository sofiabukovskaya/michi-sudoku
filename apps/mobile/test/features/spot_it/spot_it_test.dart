import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/progress/domain/daily_streak.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/spot_it/data/spot_it_store.dart';
import 'package:michi_mobile/features/spot_it/domain/spot_it_finder.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import '../../helpers/solve_exercise.dart';
import '../../helpers/warm_puzzle_catalog.dart';

void main() {
  const solver = DeterministicHumanSolver();

  test('a found moment has exactly one logical placement, and it is right', () {
    final catalog = LocalPuzzleCatalogLoader.parse(
      File('assets/puzzles/classic_v1.json').readAsStringSync(),
    );
    var checked = 0;
    for (final puzzle in catalog.puzzlesByDifficulty(PuzzleDifficulty.medium)) {
      final scenario = SpotItFinder.find(
        id: puzzle.id,
        puzzle: puzzle.initialBoard,
        solver: solver,
      );
      if (scenario == null) continue;
      final deduction = solver.findNextDeduction(scenario.initialState)!;
      expect(deduction.technique, SudokuTechnique.hiddenSingle);
      final placement = deduction.placements.single;
      final solution = const BacktrackingExactSolver().solve(
        puzzle.initialBoard,
      )!;
      expect(solution.valueAt(placement.cell), placement.digit);
      expect(scenario.board.emptyCellCount, greaterThanOrEqualTo(30));
      // Only singles so far: what the player sees is the whole truth.
      expect(scenario.candidateOverrides, isEmpty);
      if (++checked == 20) break;
    }
    expect(checked, 20);
  });

  test('a solved Spot it keeps the streak like a Daily', () {
    final now = DateTime(2026, 11, 26, 12);
    final yesterday = DateTime(2026, 11, 25);
    final daily = CompletedGame(
      gameId: 'g',
      puzzleId: 'p',
      dailyChallengeKey: '2026-11-24|catalog-v3',
      initialBoard: SudokuBoard.fromValues(List<int>.filled(81, 0)),
      completedBoard: SudokuBoard.fromValues(List<int>.filled(81, 0)),
      startedAt: DateTime(2026, 11, 24, 9),
      completedAt: DateTime(2026, 11, 24, 9, 20),
      elapsed: const Duration(minutes: 20),
      mistakes: 0,
      hintsRequested: 0,
      highestHintLevelUsed: 0,
    );
    expect(DailyStreak.count(now, [daily]), 0);
    expect(DailyStreak.count(now, [daily], extraDays: [yesterday]), 2);
  });

  test('the store marks a day once', () async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    final store = SpotItStore();
    final now = DateTime(2026, 11, 26, 18);
    expect(await store.isDone(now), isFalse);
    await store.markDone(now);
    await store.markDone(now);
    expect(await store.isDone(now), isTrue);
    expect(await store.days(), hasLength(1));
  });

  group('screen', () {
    setUpAll(() async {
      bootstrap();
      await warmPuzzleCatalog();
    });

    testWidgets("solving today's Spot it marks the day done", (tester) async {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      LocaleSettings.setLocaleSync(AppLocale.en);
      final database = GameDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      await getIt.unregister<TechniqueProgressRepository>();
      getIt.registerSingleton<TechniqueProgressRepository>(
        DriftTechniqueProgressRepository(database),
      );
      final router = AppRouter();
      addTearDown(router.dispose);
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(390, 844);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(MichiApp(router: router));
      router.replaceAll([const SpotItRoute()]).ignore();
      for (var i = 0; i < 50; i++) {
        await tester.pump(const Duration(milliseconds: 100));
        if (find
            .byKey(const ValueKey('practice-check'))
            .evaluate()
            .isNotEmpty) {
          break;
        }
      }
      expect(find.text('Which cell can be filled for sure?'), findsOneWidget);
      await solveVisibleExercise(tester);
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      expect(await tester.runAsync(SpotItStore().days), hasLength(1));
    });
  });
}
