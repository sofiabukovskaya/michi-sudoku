import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';

Future<void> aCatalogMediumGameIsActive(WidgetTester tester) async {
  final state = BlocProvider.of<GameCubit>(
    tester.element(find.byKey(const ValueKey('cell-0'))),
  ).state;
  expect(state.gameId, isNot(state.puzzle.id));
  expect(state.puzzle.id, isNot('phase-6-standard'));
  expect(state.puzzle.id, startsWith('classic_medium_'));
  expect(find.byKey(const ValueKey('cell-0')), findsOneWidget);
}
