// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

import 'package:flutter_test/flutter_test.dart';

import './step/the_learn_screen_is_open.dart';
import './step/i_select_hidden_single.dart';
import './step/the_hidden_single_lesson_is_shown.dart';
import './step/i_advance_through_the_lesson.dart';
import './step/i_can_start_hidden_single_practice.dart';
import './step/i_solve_hidden_single_independently.dart';
import './step/learn_reflects_the_saved_progress.dart';
import './step/naked_single_practice_is_open.dart';
import './step/i_enter_the_correct_naked_single_placement.dart';
import './step/independent_practice_progress_is_saved.dart';
import './step/naked_pair_practice_is_open.dart';
import './step/i_ask_michi_and_advance_through_coach.dart';
import './step/the_result_shows_candidate_eliminations.dart';
import './step/hint_assisted_practice_is_not_independent.dart';
import './step/i_select_xwing.dart';
import './step/the_xwing_technique_screen_is_shown.dart';
import './step/i_open_the_xwing_lesson.dart';
import './step/the_xwing_lesson_shows_the_pattern_and_practice_action.dart';
import './step/xwing_practice_is_open.dart';
import './step/i_select_exactly_the_xwing_eliminations.dart';
import './step/xwing_practice_is_correct_and_progress_is_saved.dart';
import './step/i_advance_xwing_coach_to_result.dart';
import './step/result_reveals_exactly_the_xwing_eliminations.dart';

void main() {
  group('''Learn and practice Sudoku techniques''', () {
    testWidgets('''Learn Hidden Single''', (tester) async {
      await theLearnScreenIsOpen(tester);
      await iSelectHiddenSingle(tester);
      await theHiddenSingleLessonIsShown(tester);
      await iAdvanceThroughTheLesson(tester);
      await iCanStartHiddenSinglePractice(tester);
      await iSolveHiddenSingleIndependently(tester);
      await learnReflectsTheSavedProgress(tester);
    });
    testWidgets('''Solve Naked Single independently''', (tester) async {
      await nakedSinglePracticeIsOpen(tester);
      await iEnterTheCorrectNakedSinglePlacement(tester);
      await independentPracticeProgressIsSaved(tester);
    });
    testWidgets('''Use Coach during Naked Pair practice''', (tester) async {
      await nakedPairPracticeIsOpen(tester);
      await iAskMichiAndAdvanceThroughCoach(tester);
      await theResultShowsCandidateEliminations(tester);
      await hintAssistedPracticeIsNotIndependent(tester);
    });
    testWidgets('''Learn X-Wing''', (tester) async {
      await theLearnScreenIsOpen(tester);
      await iSelectXwing(tester);
      await theXwingTechniqueScreenIsShown(tester);
      await iOpenTheXwingLesson(tester);
      await theXwingLessonShowsThePatternAndPracticeAction(tester);
    });
    testWidgets('''Solve X-Wing eliminations independently''', (tester) async {
      await xwingPracticeIsOpen(tester);
      await iSelectExactlyTheXwingEliminations(tester);
      await xwingPracticeIsCorrectAndProgressIsSaved(tester);
    });
    testWidgets('''Ask Coach for X-Wing''', (tester) async {
      await xwingPracticeIsOpen(tester);
      await iAdvanceXwingCoachToResult(tester);
      await resultRevealsExactlyTheXwingEliminations(tester);
    });
  });
}
