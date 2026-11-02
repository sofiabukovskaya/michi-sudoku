import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import '../content_driver.dart';

Future<void> todaysDailySessionIsActive(WidgetTester tester) async {
  final driver = ContentDriver.current!;
  final state = BlocProvider.of<GameCubit>(
    tester.element(find.byKey(const ValueKey('cell-0'))),
  ).state;
  expect(state.puzzle.id, driver.daily!.puzzle.id);
  expect(state.dailyChallengeKey, driver.daily!.challengeKey);
  expect(state.gameId, isNot(state.puzzle.id));
  expect(find.byKey(const ValueKey('cell-0')), findsOneWidget);
}
