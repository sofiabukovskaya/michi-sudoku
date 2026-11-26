import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _Progress implements TechniqueProgressRepository {
  _Progress(this.all);

  final Map<SudokuTechnique, TechniqueProgress> all;

  @override
  Future<TechniqueProgress> load(SudokuTechnique technique) async =>
      all[technique] ?? TechniqueProgress(technique: technique);

  @override
  Future<Map<SudokuTechnique, TechniqueProgress>> loadAll() async => all;

  @override
  Future<TechniqueProgress> recordCheck({
    required SudokuTechnique technique,
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  }) async => load(technique);
}

void main() {
  setUpAll(bootstrap);

  testWidgets('a new mastery stamps once; afterwards the stamp is still', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    await getIt.unregister<TechniqueProgressRepository>();
    getIt.registerSingleton<TechniqueProgressRepository>(
      _Progress({
        SudokuTechnique.hiddenSingle: const TechniqueProgress(
          technique: SudokuTechnique.hiddenSingle,
          attempts: 6,
          correctAttempts: 6,
          firstTryCorrect: 5,
          independentStreak: 4,
          masteredEver: true,
        ),
        SudokuTechnique.nakedPair: const TechniqueProgress(
          technique: SudokuTechnique.nakedPair,
          attempts: 3,
          correctAttempts: 3,
        ),
      }),
    );
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));

    Future<void> open() async {
      router.replaceAll([const NotebookRoute()]).ignore();
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 100));
        if (find
            .byKey(const ValueKey('notebook-count'))
            .evaluate()
            .isNotEmpty) {
          break;
        }
      }
    }

    await open();
    expect(find.text('1 of 8 stamped'), findsOneWidget);
    expect(find.byType(MichiMotionMascot), findsOneWidget);
    expect(find.textContaining('%'), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(MichiApp(router: router));
    await open();
    expect(find.byType(MichiMotionMascot), findsNothing);
    expect(find.byKey(const ValueKey('notebook-stamp')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
