///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$en common = _Translations$common$en._(_root);
	@override late final _Translations$splash$en splash = _Translations$splash$en._(_root);
	@override late final _Translations$welcome$en welcome = _Translations$welcome$en._(_root);
	@override late final _Translations$onboarding$en onboarding = _Translations$onboarding$en._(_root);
	@override late final _Translations$playerLevel$en playerLevel = _Translations$playerLevel$en._(_root);
	@override late final _Translations$auth$en auth = _Translations$auth$en._(_root);
	@override late final _Translations$home$en home = _Translations$home$en._(_root);
	@override late final _Translations$game$en game = _Translations$game$en._(_root);
	@override late final _Translations$learn$en learn = _Translations$learn$en._(_root);
	@override late final _Translations$progress$en progress = _Translations$progress$en._(_root);
	@override late final _Translations$profile$en profile = _Translations$profile$en._(_root);
	@override late final _Translations$scanner$en scanner = _Translations$scanner$en._(_root);
	@override late final _Translations$coach$en coach = _Translations$coach$en._(_root);
}

// Path: common
class _Translations$common$en extends Translations$common$uk {
	_Translations$common$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Continue';
	@override String get start => 'Start';
}

// Path: splash
class _Translations$splash$en extends Translations$splash$uk {
	_Translations$splash$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Learn to see the next move.';
}

// Path: welcome
class _Translations$welcome$en extends Translations$welcome$uk {
	_Translations$welcome$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your path through Sudoku.';
}

// Path: onboarding
class _Translations$onboarding$en extends Translations$onboarding$uk {
	_Translations$onboarding$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your learning starts here.';
	@override String get chooseLevel => 'Choose your level';
}

// Path: playerLevel
class _Translations$playerLevel$en extends Translations$playerLevel$uk {
	_Translations$playerLevel$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'How well do you know Sudoku?';
	@override String get goToGame => 'Start playing';
}

// Path: auth
class _Translations$auth$en extends Translations$auth$uk {
	_Translations$auth$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account';
	@override String get unavailable => 'Progress sync is coming later.';
}

// Path: home
class _Translations$home$en extends Translations$home$uk {
	_Translations$home$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your path through Sudoku';
	@override String get game => 'Play';
	@override String get continueGame => 'Continue game';
	@override String continueDetails({required Object date, required Object progress, required Object time}) => 'Started ${date} · ${progress}% · ${time}';
	@override String get replaceTitle => 'Start a new puzzle?';
	@override String get replaceBody => 'Your unfinished game will be replaced.';
	@override String get keepPlaying => 'Keep playing';
	@override String get startNew => 'Start new puzzle';
	@override String get storageUnavailable => 'Saved game unavailable. Try again later.';
	@override String get loading => 'Checking saved game…';
	@override String get learn => 'Learn';
	@override String get progress => 'Progress';
	@override String get profile => 'Profile';
	@override String get scanner => 'Scanner';
	@override String get chooseDifficulty => 'Choose a difficulty';
	@override String get easy => 'Easy';
	@override String get medium => 'Medium';
	@override String get dailyTitle => 'Sudoku of the Day';
	@override String get dailyStart => 'Start today’s Sudoku';
	@override String get dailyContinue => 'Continue today’s Sudoku';
	@override String get dailyCompleted => 'Completed today';
	@override String get contentUnavailable => 'Puzzle content is unavailable. Please try again.';
}

// Path: game
class _Translations$game$en extends Translations$game$uk {
	_Translations$game$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Daily Sudoku · Medium';
	@override String get undo => 'Undo';
	@override String get erase => 'Erase';
	@override String get notes => 'Notes';
	@override String get hint => 'Hint';
	@override String mistakes({required Object count}) => 'Mistakes: ${count} of 3';
	@override String get notesModeOn => 'Notes mode: tap a number to toggle a candidate';
	@override String get row => 'Row';
	@override String get column => 'column';
	@override String get empty => 'empty';
	@override String get given => 'given';
	@override String get entered => 'entered';
	@override String get selected => 'selected';
	@override String get error => 'incorrect';
	@override String get candidates => 'candidates';
	@override String get completeTitle => 'Solved.';
	@override String get completeBody => 'You completed this Sudoku.';
	@override String get backHome => 'Back to home';
	@override String get pause => 'Pause';
	@override String get pausedTitle => 'Paused';
	@override String get resume => 'Resume';
	@override String pausedAt({required Object time}) => 'Timer stopped at ${time}';
	@override String get loading => 'Preparing your Sudoku…';
	@override String get restoreUnavailable => 'This game could not be restored.';
	@override String get saveFailed => 'Your game could not be saved.';
	@override String get retrySave => 'Retry';
	@override String completionStats({required Object mistakes, required Object hints}) => '${mistakes} mistakes · ${hints} hints';
	@override String get standardTitle => 'Sudoku';
	@override String get dailyTitle => 'Daily Sudoku';
}

// Path: learn
class _Translations$learn$en extends Translations$learn$uk {
	_Translations$learn$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Learn';
	@override String get intro => 'A clear next step, one technique at a time.';
	@override String get newLabel => 'New';
	@override String get learningLabel => 'Learning';
	@override String get practicingLabel => 'Practicing';
	@override String get masteredLabel => 'Mastered';
	@override String get planTitle => 'Lesson plan';
	@override String get lessonStart => 'Start lesson';
	@override String get next => 'Next';
	@override String get practiceStart => 'Start practice';
	@override String get concept => 'Concept';
	@override String get lookFor => 'Look for';
	@override String get reasoning => 'Why it works';
	@override String get example => 'Example';
	@override String get tryIt => 'Try it';
	@override String exercise({required Object current, required Object total}) => 'Exercise ${current} of ${total}';
	@override String get placementPrompt => 'Select a cell and a digit.';
	@override String get eliminationPrompt => 'Select a cell, then mark every candidate to remove.';
	@override String get checkAnswer => 'Check answer';
	@override String get correctTitle => 'Well spotted';
	@override String get incorrectTitle => 'Not quite';
	@override String get tryAgain => 'Try again';
	@override String get askMichi => 'Ask MICHI';
	@override String get nextScenario => 'Next exercise';
	@override String get sessionSummary => 'Practice complete';
	@override String summaryStats({required Object correct, required Object attempts}) => '${correct} correct · ${attempts} attempts';
	@override String hintsUsed({required Object count}) => '${count} with MICHI';
	@override String get done => 'Done';
	@override String get loading => 'Preparing your lesson…';
	@override String get unavailable => 'Learning content is unavailable. Please try again.';
	@override String get noScenarios => 'No practice exercises are available yet.';
	@override String get saveFailed => 'Progress could not be saved. Try again.';
	@override String get selectedForElimination => 'Selected for removal';
	@override String get requiredTechniques => 'Techniques in this puzzle';
	@override String get helpedTechniques => 'MICHI helped with';
	@override String get noHints => 'No hints used';
	@override String get practiceTitle => 'Practice';
	@override String get continueLesson => 'Continue lesson';
	@override late final _Translations$learn$lessons$en lessons = _Translations$learn$lessons$en._(_root);
}

// Path: progress
class _Translations$progress$en extends Translations$progress$uk {
	_Translations$progress$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Technique mastery is coming later.';
}

// Path: profile
class _Translations$profile$en extends Translations$profile$uk {
	_Translations$profile$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Profile settings are coming later.';
}

// Path: scanner
class _Translations$scanner$en extends Translations$scanner$uk {
	_Translations$scanner$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Camera import will follow the core game.';
}

// Path: coach
class _Translations$coach$en extends Translations$coach$uk {
	_Translations$coach$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String step({required Object step}) => 'Hint ${step} of 4';
	@override String get kTry => 'I\'ll try';
	@override String get show => 'Show me';
	@override String get see => 'I see';
	@override String get more => 'Another hint';
	@override String get close => 'Close';
	@override String get showMistake => 'Show mistake';
	@override String place({required Object digit}) => 'Place ${digit}';
	@override String unitRow({required Object index}) => 'row ${index}';
	@override String unitColumn({required Object index}) => 'column ${index}';
	@override String unitBox({required Object index}) => 'box ${index}';
	@override String get inspectCell => 'Look at the highlighted cell.';
	@override String inspectUnit({required Object unit}) => 'Look at the highlighted ${unit}.';
	@override String get inspectCandidates => 'Which digits can go in this cell?';
	@override String inspectPositions({required Object unit}) => 'Where can this digit go in the highlighted ${unit}?';
	@override String get inspectPair => 'Find the two cells with the same two candidates.';
	@override String get singleRemains => 'Only one candidate remains in this cell.';
	@override String onlyPosition({required Object unit}) => 'Only one place remains for this digit in the ${unit}.';
	@override String pairRestriction({required Object unit}) => 'These two digits occupy the highlighted pair. Remove them elsewhere in the ${unit}.';
	@override String get alignment => 'The candidate positions align in one line, so remove this digit outside the box.';
	@override String resultPlacement({required Object digit}) => '${digit} can go only in the highlighted cell.';
	@override String get resultEliminations => 'Remove the crossed-out candidates from the highlighted cells.';
	@override String get resultActions => 'Use the highlighted logical action.';
	@override String technique({required Object name}) => 'Technique: ${name}';
	@override String get nakedSingle => 'Naked single';
	@override String get hiddenSingle => 'Hidden single';
	@override String get nakedPair => 'Naked pair';
	@override String get pointingPair => 'Pointing pair';
	@override String get unavailable => 'Hint unavailable';
	@override String get wrongTitle => 'Fix the mistake first.';
	@override String get wrongBody => 'A logical next step cannot be found while a wrong digit remains on the board.';
	@override String get stuckTitle => 'No supported step yet.';
	@override String get stuckBody => 'MICHI cannot explain the next step with the techniques currently available.';
}

// Path: learn.lessons
class _Translations$learn$lessons$en extends Translations$learn$lessons$uk {
	_Translations$learn$lessons$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learn$lessons$nakedSingle$en nakedSingle = _Translations$learn$lessons$nakedSingle$en._(_root);
	@override late final _Translations$learn$lessons$hiddenSingle$en hiddenSingle = _Translations$learn$lessons$hiddenSingle$en._(_root);
	@override late final _Translations$learn$lessons$nakedPair$en nakedPair = _Translations$learn$lessons$nakedPair$en._(_root);
	@override late final _Translations$learn$lessons$pointingPair$en pointingPair = _Translations$learn$lessons$pointingPair$en._(_root);
}

// Path: learn.lessons.nakedSingle
class _Translations$learn$lessons$nakedSingle$en extends Translations$learn$lessons$nakedSingle$uk {
	_Translations$learn$lessons$nakedSingle$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'One empty cell has just one possible digit.';
	@override String get concept => 'Candidates are the digits that can still fit in an empty cell.';
	@override String get lookFor => 'Find a cell where the row, column and box rule out every digit but one.';
	@override String get reasoning => 'Only one candidate remains, so that digit must go in this cell.';
	@override String get example => 'The highlighted cell has one legal candidate. Notice what its peers exclude.';
	@override String get tryIt => 'Choose that cell and place its remaining digit.';
}

// Path: learn.lessons.hiddenSingle
class _Translations$learn$lessons$hiddenSingle$en extends Translations$learn$lessons$hiddenSingle$uk {
	_Translations$learn$lessons$hiddenSingle$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'A digit has only one possible position in a row, column or box.';
	@override String get concept => 'Look at one digit across a unit, rather than all digits in one cell.';
	@override String get lookFor => 'Find the only empty position where that digit is still allowed.';
	@override String get reasoning => 'Other cells may have several candidates, but this digit has just one home in the unit.';
	@override String get example => 'The highlighted unit leaves one position for the target digit.';
	@override String get tryIt => 'Choose the unique position and place that digit.';
}

// Path: learn.lessons.nakedPair
class _Translations$learn$lessons$nakedPair$en extends Translations$learn$lessons$nakedPair$uk {
	_Translations$learn$lessons$nakedPair$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'Two cells in one unit have the same pair of candidates.';
	@override String get concept => 'A pair reserves its two digits for those two cells.';
	@override String get lookFor => 'Find two cells in the same row, column or box with exactly the same two candidates.';
	@override String get reasoning => 'Those digits cannot appear elsewhere in that unit, so eliminate them there.';
	@override String get example => 'The highlighted pair removes candidates from other cells in its unit.';
	@override String get tryIt => 'Mark every candidate the pair eliminates. No digit is placed yet.';
}

// Path: learn.lessons.pointingPair
class _Translations$learn$lessons$pointingPair$en extends Translations$learn$lessons$pointingPair$uk {
	_Translations$learn$lessons$pointingPair$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'Two candidate positions in a box align on one row or column.';
	@override String get concept => 'A box can confine a digit to one line.';
	@override String get lookFor => 'Find exactly two positions for a digit inside a box on the same row or column.';
	@override String get reasoning => 'The digit must stay in that box, so remove it elsewhere on the shared line.';
	@override String get example => 'Follow the highlighted line outside the box to see the eliminations.';
	@override String get tryIt => 'Mark every candidate removed outside the box.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Continue',
			'common.start' => 'Start',
			'splash.subtitle' => 'Learn to see the next move.',
			'welcome.title' => 'Your path through Sudoku.',
			'onboarding.title' => 'Your learning starts here.',
			'onboarding.chooseLevel' => 'Choose your level',
			'playerLevel.title' => 'How well do you know Sudoku?',
			'playerLevel.goToGame' => 'Start playing',
			'auth.title' => 'Account',
			'auth.unavailable' => 'Progress sync is coming later.',
			'home.title' => 'Your path through Sudoku',
			'home.game' => 'Play',
			'home.continueGame' => 'Continue game',
			'home.continueDetails' => ({required Object date, required Object progress, required Object time}) => 'Started ${date} · ${progress}% · ${time}',
			'home.replaceTitle' => 'Start a new puzzle?',
			'home.replaceBody' => 'Your unfinished game will be replaced.',
			'home.keepPlaying' => 'Keep playing',
			'home.startNew' => 'Start new puzzle',
			'home.storageUnavailable' => 'Saved game unavailable. Try again later.',
			'home.loading' => 'Checking saved game…',
			'home.learn' => 'Learn',
			'home.progress' => 'Progress',
			'home.profile' => 'Profile',
			'home.scanner' => 'Scanner',
			'home.chooseDifficulty' => 'Choose a difficulty',
			'home.easy' => 'Easy',
			'home.medium' => 'Medium',
			'home.dailyTitle' => 'Sudoku of the Day',
			'home.dailyStart' => 'Start today’s Sudoku',
			'home.dailyContinue' => 'Continue today’s Sudoku',
			'home.dailyCompleted' => 'Completed today',
			'home.contentUnavailable' => 'Puzzle content is unavailable. Please try again.',
			'game.title' => 'Daily Sudoku · Medium',
			'game.undo' => 'Undo',
			'game.erase' => 'Erase',
			'game.notes' => 'Notes',
			'game.hint' => 'Hint',
			'game.mistakes' => ({required Object count}) => 'Mistakes: ${count} of 3',
			'game.notesModeOn' => 'Notes mode: tap a number to toggle a candidate',
			'game.row' => 'Row',
			'game.column' => 'column',
			'game.empty' => 'empty',
			'game.given' => 'given',
			'game.entered' => 'entered',
			'game.selected' => 'selected',
			'game.error' => 'incorrect',
			'game.candidates' => 'candidates',
			'game.completeTitle' => 'Solved.',
			'game.completeBody' => 'You completed this Sudoku.',
			'game.backHome' => 'Back to home',
			'game.pause' => 'Pause',
			'game.pausedTitle' => 'Paused',
			'game.resume' => 'Resume',
			'game.pausedAt' => ({required Object time}) => 'Timer stopped at ${time}',
			'game.loading' => 'Preparing your Sudoku…',
			'game.restoreUnavailable' => 'This game could not be restored.',
			'game.saveFailed' => 'Your game could not be saved.',
			'game.retrySave' => 'Retry',
			'game.completionStats' => ({required Object mistakes, required Object hints}) => '${mistakes} mistakes · ${hints} hints',
			'game.standardTitle' => 'Sudoku',
			'game.dailyTitle' => 'Daily Sudoku',
			'learn.title' => 'Learn',
			'learn.intro' => 'A clear next step, one technique at a time.',
			'learn.newLabel' => 'New',
			'learn.learningLabel' => 'Learning',
			'learn.practicingLabel' => 'Practicing',
			'learn.masteredLabel' => 'Mastered',
			'learn.planTitle' => 'Lesson plan',
			'learn.lessonStart' => 'Start lesson',
			'learn.next' => 'Next',
			'learn.practiceStart' => 'Start practice',
			'learn.concept' => 'Concept',
			'learn.lookFor' => 'Look for',
			'learn.reasoning' => 'Why it works',
			'learn.example' => 'Example',
			'learn.tryIt' => 'Try it',
			'learn.exercise' => ({required Object current, required Object total}) => 'Exercise ${current} of ${total}',
			'learn.placementPrompt' => 'Select a cell and a digit.',
			'learn.eliminationPrompt' => 'Select a cell, then mark every candidate to remove.',
			'learn.checkAnswer' => 'Check answer',
			'learn.correctTitle' => 'Well spotted',
			'learn.incorrectTitle' => 'Not quite',
			'learn.tryAgain' => 'Try again',
			'learn.askMichi' => 'Ask MICHI',
			'learn.nextScenario' => 'Next exercise',
			'learn.sessionSummary' => 'Practice complete',
			'learn.summaryStats' => ({required Object correct, required Object attempts}) => '${correct} correct · ${attempts} attempts',
			'learn.hintsUsed' => ({required Object count}) => '${count} with MICHI',
			'learn.done' => 'Done',
			'learn.loading' => 'Preparing your lesson…',
			'learn.unavailable' => 'Learning content is unavailable. Please try again.',
			'learn.noScenarios' => 'No practice exercises are available yet.',
			'learn.saveFailed' => 'Progress could not be saved. Try again.',
			'learn.selectedForElimination' => 'Selected for removal',
			'learn.requiredTechniques' => 'Techniques in this puzzle',
			'learn.helpedTechniques' => 'MICHI helped with',
			'learn.noHints' => 'No hints used',
			'learn.practiceTitle' => 'Practice',
			'learn.continueLesson' => 'Continue lesson',
			'learn.lessons.nakedSingle.description' => 'One empty cell has just one possible digit.',
			'learn.lessons.nakedSingle.concept' => 'Candidates are the digits that can still fit in an empty cell.',
			'learn.lessons.nakedSingle.lookFor' => 'Find a cell where the row, column and box rule out every digit but one.',
			'learn.lessons.nakedSingle.reasoning' => 'Only one candidate remains, so that digit must go in this cell.',
			'learn.lessons.nakedSingle.example' => 'The highlighted cell has one legal candidate. Notice what its peers exclude.',
			'learn.lessons.nakedSingle.tryIt' => 'Choose that cell and place its remaining digit.',
			'learn.lessons.hiddenSingle.description' => 'A digit has only one possible position in a row, column or box.',
			'learn.lessons.hiddenSingle.concept' => 'Look at one digit across a unit, rather than all digits in one cell.',
			'learn.lessons.hiddenSingle.lookFor' => 'Find the only empty position where that digit is still allowed.',
			'learn.lessons.hiddenSingle.reasoning' => 'Other cells may have several candidates, but this digit has just one home in the unit.',
			'learn.lessons.hiddenSingle.example' => 'The highlighted unit leaves one position for the target digit.',
			'learn.lessons.hiddenSingle.tryIt' => 'Choose the unique position and place that digit.',
			'learn.lessons.nakedPair.description' => 'Two cells in one unit have the same pair of candidates.',
			'learn.lessons.nakedPair.concept' => 'A pair reserves its two digits for those two cells.',
			'learn.lessons.nakedPair.lookFor' => 'Find two cells in the same row, column or box with exactly the same two candidates.',
			'learn.lessons.nakedPair.reasoning' => 'Those digits cannot appear elsewhere in that unit, so eliminate them there.',
			'learn.lessons.nakedPair.example' => 'The highlighted pair removes candidates from other cells in its unit.',
			'learn.lessons.nakedPair.tryIt' => 'Mark every candidate the pair eliminates. No digit is placed yet.',
			'learn.lessons.pointingPair.description' => 'Two candidate positions in a box align on one row or column.',
			'learn.lessons.pointingPair.concept' => 'A box can confine a digit to one line.',
			'learn.lessons.pointingPair.lookFor' => 'Find exactly two positions for a digit inside a box on the same row or column.',
			'learn.lessons.pointingPair.reasoning' => 'The digit must stay in that box, so remove it elsewhere on the shared line.',
			'learn.lessons.pointingPair.example' => 'Follow the highlighted line outside the box to see the eliminations.',
			'learn.lessons.pointingPair.tryIt' => 'Mark every candidate removed outside the box.',
			'progress.unavailable' => 'Technique mastery is coming later.',
			'profile.unavailable' => 'Profile settings are coming later.',
			'scanner.unavailable' => 'Camera import will follow the core game.',
			'coach.step' => ({required Object step}) => 'Hint ${step} of 4',
			'coach.kTry' => 'I\'ll try',
			'coach.show' => 'Show me',
			'coach.see' => 'I see',
			'coach.more' => 'Another hint',
			'coach.close' => 'Close',
			'coach.showMistake' => 'Show mistake',
			'coach.place' => ({required Object digit}) => 'Place ${digit}',
			'coach.unitRow' => ({required Object index}) => 'row ${index}',
			'coach.unitColumn' => ({required Object index}) => 'column ${index}',
			'coach.unitBox' => ({required Object index}) => 'box ${index}',
			'coach.inspectCell' => 'Look at the highlighted cell.',
			'coach.inspectUnit' => ({required Object unit}) => 'Look at the highlighted ${unit}.',
			'coach.inspectCandidates' => 'Which digits can go in this cell?',
			'coach.inspectPositions' => ({required Object unit}) => 'Where can this digit go in the highlighted ${unit}?',
			'coach.inspectPair' => 'Find the two cells with the same two candidates.',
			'coach.singleRemains' => 'Only one candidate remains in this cell.',
			'coach.onlyPosition' => ({required Object unit}) => 'Only one place remains for this digit in the ${unit}.',
			'coach.pairRestriction' => ({required Object unit}) => 'These two digits occupy the highlighted pair. Remove them elsewhere in the ${unit}.',
			'coach.alignment' => 'The candidate positions align in one line, so remove this digit outside the box.',
			'coach.resultPlacement' => ({required Object digit}) => '${digit} can go only in the highlighted cell.',
			'coach.resultEliminations' => 'Remove the crossed-out candidates from the highlighted cells.',
			'coach.resultActions' => 'Use the highlighted logical action.',
			'coach.technique' => ({required Object name}) => 'Technique: ${name}',
			'coach.nakedSingle' => 'Naked single',
			'coach.hiddenSingle' => 'Hidden single',
			'coach.nakedPair' => 'Naked pair',
			'coach.pointingPair' => 'Pointing pair',
			'coach.unavailable' => 'Hint unavailable',
			'coach.wrongTitle' => 'Fix the mistake first.',
			'coach.wrongBody' => 'A logical next step cannot be found while a wrong digit remains on the board.',
			'coach.stuckTitle' => 'No supported step yet.',
			'coach.stuckBody' => 'MICHI cannot explain the next step with the techniques currently available.',
			_ => null,
		};
	}
}
