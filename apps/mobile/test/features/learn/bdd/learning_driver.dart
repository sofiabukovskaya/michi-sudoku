import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class LearningDriver {
  LearningDriver._(this.database, this.progress, this.router);

  static LearningDriver? current;
  static bool _bootstrapped = false;
  static final catalog = LocalPracticeCatalog(bundle: _PracticeAssetBundle());

  final GameDatabase database;
  final DriftTechniqueProgressRepository progress;
  final AppRouter router;

  static Future<LearningDriver> open(
    WidgetTester tester, {
    SudokuTechnique? practice,
  }) async {
    if (!_bootstrapped) {
      bootstrap();
      _bootstrapped = true;
    }
    LocaleSettings.setLocaleSync(AppLocale.en);
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final database = GameDatabase(NativeDatabase.memory());
    final progress = DriftTechniqueProgressRepository(database);
    await getIt.unregister<TechniqueProgressRepository>();
    getIt.registerSingleton<TechniqueProgressRepository>(progress);
    final router = AppRouter();
    final driver = LearningDriver._(database, progress, router);
    current = driver;
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
      router.dispose();
      await database.close();
    });
    if (practice != null) {
      await tester.runAsync(() => catalog.forTechnique(practice));
    }
    await tester.pumpWidget(MichiApp(router: router));
    router.replaceAll([
      if (practice == null)
        LearnRoute()
      else
        PracticeRoute(technique: practice, catalog: catalog),
    ]).ignore();
    await settleUntil(
      tester,
      find.byKey(
        ValueKey(practice == null ? 'learn-hiddenSingle' : 'practice-check'),
      ),
    );
    return driver;
  }

  static Future<void> settleUntil(WidgetTester tester, Finder finder) async {
    for (var attempt = 0; attempt < 30; attempt++) {
      await tester.pumpAndSettle();
      if (finder.evaluate().isNotEmpty) return;
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
    }
    expect(finder, findsOneWidget);
  }

  Future<DigitPlacement> placement(SudokuTechnique technique) async {
    final scenario = (await catalog.forTechnique(technique)).first;
    return const DeterministicHumanSolver()
        .findNextDeduction(HumanSolverState.initial(scenario.board))!
        .placements
        .single;
  }

  Future<Set<CandidateElimination>> eliminations(
    SudokuTechnique technique,
  ) async {
    final scenario = (await catalog.forTechnique(technique)).first;
    return const DeterministicHumanSolver()
        .findNextDeduction(HumanSolverState.initial(scenario.board))!
        .eliminations
        .toSet();
  }
}

final class _PracticeAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async => ByteData.sublistView(
    File(key).readAsBytesSync(),
  );
}
