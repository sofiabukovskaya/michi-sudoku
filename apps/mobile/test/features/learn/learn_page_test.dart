import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/learn/data/drift_technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  setUpAll(bootstrap);

  for (final size in [
    const Size(375, 667),
    const Size(390, 844),
    const Size(430, 930),
  ]) {
    testWidgets('Learn shows four techniques at ${size.width}×${size.height}', (
      tester,
    ) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = size;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      LocaleSettings.setLocaleSync(AppLocale.en);
      final database = GameDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      await getIt.unregister<TechniqueProgressRepository>();
      getIt.registerSingleton<TechniqueProgressRepository>(
        DriftTechniqueProgressRepository(database),
      );
      final router = AppRouter();
      addTearDown(router.dispose);
      await tester.pumpWidget(MichiApp(router: router));
      router.replaceAll([LearnRoute()]).ignore();
      await tester.pumpAndSettle();
      for (final technique in [
        SudokuTechnique.nakedSingle,
        SudokuTechnique.hiddenSingle,
        SudokuTechnique.nakedPair,
        SudokuTechnique.pointingPair,
      ]) {
        expect(find.byKey(ValueKey('learn-${technique.name}')), findsOneWidget);
      }
      expect(find.text('Now'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Hidden Single lesson advances to practice with localized copy', (
    tester,
  ) async {
    tester.view
      ..devicePixelRatio = 1
      ..physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    LocaleSettings.setLocaleSync(AppLocale.uk);
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await getIt.unregister<TechniqueProgressRepository>();
    getIt.registerSingleton<TechniqueProgressRepository>(
      DriftTechniqueProgressRepository(database),
    );
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    router.replaceAll([LearnRoute()]).ignore();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('learn-hiddenSingle')));
    for (var attempt = 0; attempt < 30; attempt++) {
      await tester.pumpAndSettle();
      if (find.byKey(const ValueKey('lesson-primary')).evaluate().isNotEmpty) {
        break;
      }
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
    }
    expect(find.byKey(const ValueKey('lesson-primary')), findsOneWidget);
    expect(find.text('Прихований одинак'), findsWidgets);
    expect(find.text('План уроку'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('lesson-primary')));
    await tester.pumpAndSettle();
    for (final step in [
      'concept',
      'example',
      'tryIt',
    ]) {
      expect(find.byKey(ValueKey('lesson-step-$step')), findsOneWidget);
      if (step != 'tryIt') {
        await tester.tap(find.byKey(const ValueKey('lesson-primary')));
        await tester.pumpAndSettle();
      }
    }
    expect(find.text('Почати практику'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
