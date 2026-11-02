// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter_test/flutter_test.dart';

import './step/a_playable_sudoku_game_is_open.dart';
import './step/i_request_the_first_coach_hint.dart';
import './step/coach_level_direction_is_visible.dart';
import './step/no_final_coach_action_is_revealed.dart';
import './step/coach_is_showing_level.dart';
import './step/i_request_another_coach_hint.dart';
import './step/coach_level_focus_is_visible.dart';
import './step/coach_level_reasoning_is_visible.dart';
import './step/coach_level_result_is_visible.dart';
import './step/the_actual_coach_action_is_visualized.dart';

void main() {
  group('''Progressive Sudoku coaching''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await aPlayableSudokuGameIsOpen(tester);
    }

    testWidgets('''The first hint gives direction without the answer''', (
      tester,
    ) async {
      await bddSetUp(tester);
      await iRequestTheFirstCoachHint(tester);
      await coachLevelDirectionIsVisible(tester);
      await noFinalCoachActionIsRevealed(tester);
    });
    testWidgets('''Another hint narrows the focus''', (tester) async {
      await bddSetUp(tester);
      await coachIsShowingLevel(tester, 0);
      await iRequestAnotherCoachHint(tester);
      await coachLevelFocusIsVisible(tester);
      await noFinalCoachActionIsRevealed(tester);
    });
    testWidgets('''The reasoning hint keeps the placement hidden''', (
      tester,
    ) async {
      await bddSetUp(tester);
      await coachIsShowingLevel(tester, 1);
      await iRequestAnotherCoachHint(tester);
      await coachLevelReasoningIsVisible(tester);
      await noFinalCoachActionIsRevealed(tester);
    });
    testWidgets('''The final hint shows the actual engine deduction''', (
      tester,
    ) async {
      await bddSetUp(tester);
      await coachIsShowingLevel(tester, 2);
      await iRequestAnotherCoachHint(tester);
      await coachLevelResultIsVisible(tester);
      await theActualCoachActionIsVisualized(tester);
    });
  });
}
