// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter_test/flutter_test.dart';

import './step/a_playable_sudoku_game_is_open.dart';
import './step/an_editable_empty_cell_is_selected.dart';
import './step/i_enter_the_correct_digit.dart';
import './step/the_cell_shows_a_playerentered_digit.dart';
import './step/i_enter_an_incorrect_digit.dart';
import './step/the_cell_shows_an_error.dart';
import './step/the_mistake_count_increases.dart';

void main() {
  group('''Entering Sudoku digits''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await aPlayableSudokuGameIsOpen(tester);
    }

    testWidgets('''A correct entry becomes a player digit''', (tester) async {
      await bddSetUp(tester);
      await anEditableEmptyCellIsSelected(tester);
      await iEnterTheCorrectDigit(tester);
      await theCellShowsAPlayerenteredDigit(tester);
    });
    testWidgets('''A wrong entry remains visible as a mistake''', (
      tester,
    ) async {
      await bddSetUp(tester);
      await anEditableEmptyCellIsSelected(tester);
      await iEnterAnIncorrectDigit(tester);
      await theCellShowsAnError(tester);
      await theMistakeCountIncreases(tester);
    });
  });
}
