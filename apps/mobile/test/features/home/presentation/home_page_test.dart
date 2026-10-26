import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';

void main() {
  setUpAll(bootstrap);

  testWidgets('Home shows Continue only for an unfinished local game', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftGameRepository(database);
    final router = AppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(MichiApp(router: router));
    router.push(HomeRoute(repository: repository)).ignore();
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('continue-game')), findsNothing);

    final now = DateTime.utc(2026, 10);
    final game = StoredGame(
      gameId: 'saved',
      puzzleId: DemoPuzzle.standard.id,
      initialBoard: DemoPuzzle.standard.givens,
      currentBoard: DemoPuzzle.standard.givens,
      notes: const {},
      undoHistory: const [],
      mistakes: 0,
      elapsedBeforeRun: const Duration(minutes: 18, seconds: 4),
      runningSince: null,
      startedAt: now,
      updatedAt: now,
      isPaused: true,
      hintsRequested: 0,
      highestHintLevelUsed: 0,
      correctEditableCells: 0,
      editableCells: DemoPuzzle.standard.givens.emptyCellCount,
    );
    await repository.saveActiveGame(game);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(MichiApp(router: router));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('continue-game')), findsOneWidget);
    expect(find.textContaining('18:04'), findsOneWidget);

    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();
    expect(find.textContaining('replace'), findsWidgets);
    await tester.tap(find.text('Keep playing'));
    await tester.pumpAndSettle();
    expect((await repository.loadActiveGame())!.gameId, 'saved');
  });
}
