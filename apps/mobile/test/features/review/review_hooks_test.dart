import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/presentation/game_page.dart';
import 'package:michi_mobile/features/review/data/review_service.dart';
import 'package:michi_mobile/features/review/domain/review_policy.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

class _Review extends Mock implements ReviewService {}

void main() {
  late _Review review;
  late List<ReviewMoment> moments;
  setUpAll(() {
    registerFallbackValue(<ReviewMoment>{});
    registerFallbackValue(() => true);
  });

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final saved = SharedPreferencesAsyncPlatform.instance;
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    addTearDown(() => SharedPreferencesAsyncPlatform.instance = saved);
    review = _Review();
    moments = [];
    getIt.registerSingleton<ReviewService>(review);
    when(
      () => review.consider(
        moments: any(named: 'moments'),
        isVisible: any(named: 'isVisible'),
      ),
    ).thenAnswer((call) async {
      final visible = call.namedArguments[#isVisible]! as bool Function();
      if (visible()) {
        moments.addAll(call.namedArguments[#moments]! as Set<ReviewMoment>);
      }
    });
  });
  tearDown(getIt.reset);

  for (final best in [false, true]) {
    testWidgets(
      best
          ? 'visible personal best offers review'
          : 'clean finish offers review after settling',
      (tester) async {
        const solver = BacktrackingExactSolver();
        final solution = solver.solve(DemoPuzzle.standard.givens)!;
        final cell = CellRef.fromIndex(0);
        final cubit = GameCubit(
          puzzle: SudokuPuzzle(
            id: 'one-away',
            givens: solution.withValue(cell, 0),
          ),
          exactSolver: solver,
          humanSolver: const DeterministicHumanSolver(),
          coachEngine: const StructuredCoachEngine(),
        );
        addTearDown(cubit.close);
        if (best) {
          await SharedPreferencesAsync().setString(
            'michi.insight.last',
            jsonEncode({
              'game': cubit.state.gameId,
              'insight': {
                'kind': 'personalBest',
                'technique': 'nakedPair',
                'count': 1,
              },
            }),
          );
          cubit
            ..selectCell(cell)
            ..enterDigit(solution.valueAt(cell) == 1 ? 2 : 1);
        }

        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await tester.pumpWidget(
          TranslationProvider(
            child: MaterialApp(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(disableAnimations: true),
                child: child!,
              ),
              home: GamePage(cubit: cubit),
            ),
          ),
        );
        await tester.pump();
        expect(moments, isEmpty);
        cubit
          ..selectCell(cell)
          ..enterDigit(solution.valueAt(cell));
        await tester.pump();
        for (var frame = 0; frame < 4; frame++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(find.text('Solved.'), findsOneWidget);
        expect(moments, isEmpty);
        if (best) {
          final insight = find.textContaining('New personal best');
          expect(insight, findsOneWidget);
          await tester.ensureVisible(insight);
        }
        for (var frame = 0; frame < 25; frame++) {
          await tester.pump(const Duration(milliseconds: 100));
          if (moments.isNotEmpty) break;
        }
        expect(moments, [
          if (best) ReviewMoment.personalBest else ReviewMoment.cleanPuzzle,
        ]);
      },
    );
  }
}
