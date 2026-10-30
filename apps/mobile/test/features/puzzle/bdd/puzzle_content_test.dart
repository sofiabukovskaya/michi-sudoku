// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter_test/flutter_test.dart';

import './step/home_has_no_active_game.dart';
import './step/i_choose_medium_and_start_a_puzzle.dart';
import './step/a_catalog_medium_game_is_active.dart';
import './step/home_has_todays_unfinished_daily.dart';
import './step/i_start_sudoku_of_the_day.dart';
import './step/todays_daily_session_is_active.dart';
import './step/todays_daily_is_one_move_from_completion.dart';
import './step/i_finish_todays_daily.dart';
import './step/home_marks_todays_daily_completed.dart';

void main() {
  group('''Local puzzle content and Daily Sudoku''', () {
    testWidgets('''Start a Medium puzzle from the catalog''', (tester) async {
      await homeHasNoActiveGame(tester);
      await iChooseMediumAndStartAPuzzle(tester);
      await aCatalogMediumGameIsActive(tester);
    });
    testWidgets('''Start today's Daily Sudoku''', (tester) async {
      await homeHasTodaysUnfinishedDaily(tester);
      await iStartSudokuOfTheDay(tester);
      await todaysDailySessionIsActive(tester);
    });
    testWidgets('''Complete today's Daily Sudoku''', (tester) async {
      await todaysDailyIsOneMoveFromCompletion(tester);
      await iFinishTodaysDaily(tester);
      await homeMarksTodaysDailyCompleted(tester);
    });
  });
}
