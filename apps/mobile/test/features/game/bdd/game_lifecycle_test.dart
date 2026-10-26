// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter_test/flutter_test.dart';

import './step/an_unfinished_local_game_with_entries_and_notes.dart';
import './step/the_game_is_reopened_from_local_storage.dart';
import './step/the_board_notes_mistakes_timer_and_undo_are_restored.dart';
import './step/a_running_sudoku_is_shown.dart';
import './step/i_pause_the_sudoku.dart';
import './step/the_board_is_hidden_and_input_is_disabled_and_time_stops.dart';
import './step/i_resume_the_sudoku.dart';
import './step/the_board_returns_and_time_continues.dart';
import './step/a_locally_saved_sudoku_one_move_from_completion.dart';
import './step/i_enter_the_final_correct_number.dart';
import './step/the_game_is_completed_once_and_the_active_game_is_removed.dart';
import './step/home_no_longer_offers_continue.dart';

void main() {
  group('''Local Sudoku game lifecycle''', () {
    testWidgets('''Continue an unfinished game after reopening''', (
      tester,
    ) async {
      await anUnfinishedLocalGameWithEntriesAndNotes(tester);
      await theGameIsReopenedFromLocalStorage(tester);
      await theBoardNotesMistakesTimerAndUndoAreRestored(tester);
    });
    testWidgets('''Pause and resume a running game''', (tester) async {
      await aRunningSudokuIsShown(tester);
      await iPauseTheSudoku(tester);
      await theBoardIsHiddenAndInputIsDisabledAndTimeStops(tester);
      await iResumeTheSudoku(tester);
      await theBoardReturnsAndTimeContinues(tester);
    });
    testWidgets('''Finish a locally saved game''', (tester) async {
      await aLocallySavedSudokuOneMoveFromCompletion(tester);
      await iEnterTheFinalCorrectNumber(tester);
      await theGameIsCompletedOnceAndTheActiveGameIsRemoved(tester);
      await homeNoLongerOffersContinue(tester);
    });
  });
}
