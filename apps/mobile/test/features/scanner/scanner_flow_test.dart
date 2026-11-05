// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter_test/flutter_test.dart';

import './step/a_photographed_grid_has_been_located_and_its_cells_recognized.dart';
import './step/a_lowconfidence_cell_is_selected_and_corrected.dart';
import './step/review_shows_the_corrected_clue_and_removes_its_review_marker.dart';
import './step/recognition_produced_duplicate_impossible_or_incomplete_clues.dart';
import './step/the_player_confirms_the_board.dart';
import './step/the_board_remains_editable_in_review_with_a_specific_issue.dart';
import './step/a_corrected_board_has_exactly_one_mathematical_solution.dart';
import './step/the_player_confirms_it.dart';
import './step/the_imported_clues_become_immutable_givens_in_game.dart';
import './step/the_game_and_coach_session_can_be_restored_locally.dart';

void main() {
  group('''Import a photographed Sudoku''', () {
    testWidgets('''Review and correct a recognized clue''', (tester) async {
      await aPhotographedGridHasBeenLocatedAndItsCellsRecognized(tester);
      await aLowconfidenceCellIsSelectedAndCorrected(tester);
      await reviewShowsTheCorrectedClueAndRemovesItsReviewMarker(tester);
    });
    testWidgets('''Reject an invalid recognized board''', (tester) async {
      await recognitionProducedDuplicateImpossibleOrIncompleteClues(tester);
      await thePlayerConfirmsTheBoard(tester);
      await theBoardRemainsEditableInReviewWithASpecificIssue(tester);
    });
    testWidgets('''Continue an imported puzzle in Game''', (tester) async {
      await aCorrectedBoardHasExactlyOneMathematicalSolution(tester);
      await thePlayerConfirmsIt(tester);
      await theImportedCluesBecomeImmutableGivensInGame(tester);
      await theGameAndCoachSessionCanBeRestoredLocally(tester);
    });
  });
}
