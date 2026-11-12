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
	@override late final _Translations$why$en why = _Translations$why$en._(_root);
	@override late final _Translations$recommendation$en recommendation = _Translations$recommendation$en._(_root);
	@override late final _Translations$week$en week = _Translations$week$en._(_root);
	@override late final _Translations$settings$en settings = _Translations$settings$en._(_root);
	@override late final _Translations$sync$en sync = _Translations$sync$en._(_root);
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
	@override String get title => 'Find your way through logic.';
	@override String get subtitle => 'Sudoku with a coach who guides you instead of solving for you.';
	@override String get guest => 'Start without an account';
}

// Path: onboarding
class _Translations$onboarding$en extends Translations$onboarding$uk {
	_Translations$onboarding$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your learning starts here.';
	@override String get chooseLevel => 'Choose your level';
	@override String get skip => 'Skip';
	@override String get next => 'Next';
	@override String get seeTitle => 'Sudoku is easier when you know what to look for.';
	@override String get seeBody => 'MICHI explains the logic behind every move.';
	@override String get hintsTitle => 'Hints that teach.';
	@override String get hintsBody => 'Start with a gentle nudge. Ask for more when you need it.';
	@override String get patternsTitle => 'Learn patterns, not answers.';
	@override String get patternsBody => 'Hidden singles, pairs, X-Wing — at your own pace.';
	@override String get pathTitle => 'Your path through Sudoku.';
	@override String get pathBody => 'MICHI notices where you struggle and suggests what to practice.';
}

// Path: playerLevel
class _Translations$playerLevel$en extends Translations$playerLevel$uk {
	_Translations$playerLevel$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'How well do you know Sudoku?';
	@override String get goToGame => 'Start playing';
	@override String get subtitle => 'Your first lesson and puzzle difficulty follow this choice. You can change it anytime.';
	@override String get beginner => 'Just starting';
	@override String get beginnerDetail => 'Rules and first moves';
	@override String get basics => 'Know the basics';
	@override String get basicsDetail => 'Singles and candidates';
	@override String get regular => 'Play regularly';
	@override String get regularDetail => 'Pairs and pointing pairs';
	@override String get advanced => 'Want a challenge';
	@override String get advancedDetail => 'X-Wing and beyond';
}

// Path: auth
class _Translations$auth$en extends Translations$auth$uk {
	_Translations$auth$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Account';
	@override String get unavailable => 'Progress is saved on this device.';
	@override String get apple => 'Continue with Apple';
	@override String get google => 'Continue with Google';
	@override String get emailEntry => 'Sign in with email';
	@override String get createTitle => 'Create an account';
	@override String get createSubtitle => 'Your progress stays on this device until sync is available.';
	@override String get signInTitle => 'Welcome back';
	@override String get name => 'Name';
	@override String get email => 'Email';
	@override String get password => 'Password';
	@override String get passwordHint => 'At least 8 characters';
	@override String get createAccount => 'Create account';
	@override String get signIn => 'Sign in';
	@override String get alreadyAccount => 'Already have an account?';
	@override String get noAccount => 'New here?';
	@override String get forgotPassword => 'Forgot password?';
	@override String get resetTitle => 'Reset password';
	@override String get resetSubtitle => 'Enter your account email and we’ll send a reset link.';
	@override String get sendLink => 'Send link';
	@override String get resetSent => 'If an account exists, check your email for a reset link.';
	@override String get verifyTitle => 'Check your email';
	@override String verifySubtitle({required Object email}) => 'We sent a verification link to ${email}.';
	@override String get checkVerification => 'I verified my email';
	@override String get resendVerification => 'Resend link';
	@override String get verified => 'Your email is verified.';
	@override String get notVerified => 'The email is not verified yet.';
	@override String get signOut => 'Sign out';
	@override String get localNotSynced => 'Game progress is still saved on this device.';
	@override String get verifyEmail => 'Verify email';
	@override String get errorInvalidEmail => 'Enter a valid email address.';
	@override String get errorPasswordLength => 'Use at least 8 characters.';
	@override String get errorNameRequired => 'Enter your name.';
	@override String get errorWeakPassword => 'This password is too weak.';
	@override String get errorEmailInUse => 'An account already uses this email.';
	@override String get errorWrongCredentials => 'Check your email and password.';
	@override String get errorDisabled => 'This account is disabled.';
	@override String get errorTooMany => 'Too many attempts. Try again later.';
	@override String get errorNetwork => 'Check your connection and try again.';
	@override String get errorUnavailable => 'Account services are unavailable. You can keep playing as a guest.';
	@override String get errorUnexpected => 'Something went wrong. Please try again.';
	@override String get showPassword => 'Show password';
	@override String get hidePassword => 'Hide password';
	@override String get signOutTitle => 'Sign out of your account?';
	@override String get signOutBody => 'Your local games will stay on this device.';
	@override String get cancel => 'Cancel';
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
	@override String get advanced => 'Advanced';
	@override String get expert => 'Expert';
	@override String get greeting => 'Good morning';
	@override String get newPuzzle => 'Another puzzle';
	@override String get weekTitle => 'This week';
	@override String get weekDetails => 'Details';
	@override String get weekdaysShort => 'Mon|Tue|Wed|Thu|Fri|Sat|Sun';
	@override String get newPuzzleTitle => 'New Sudoku';
	@override String get catalogSource => 'Choose a puzzle';
	@override String get scanSource => 'Scan Sudoku';
	@override String get scanSourceDetail => 'Photo or camera';
	@override String get weekStatusDone => 'Completed';
	@override String get weekStatusToday => 'Today';
	@override String get weekStatusEmpty => 'No activity';
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
	@override String get completionLogic => 'solved cells';
	@override String get completionMistakes => 'mistakes';
	@override String get completionHints => 'hints';
	@override String get dailyStampEarned => 'Daily stamp earned';
	@override String completionPracticeTechnique({required Object technique}) => 'Practice ${technique} next';
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
	@override String get basicsGroup => 'Basics';
	@override String get intermediateGroup => 'Intermediate';
	@override String get advancedGroup => 'Advanced';
	@override String get nowLabel => 'Now';
	@override String groupProgress({required Object completed, required Object total}) => '${completed} of ${total}';
	@override String get extraElimination => 'One selected candidate is not removed by this pattern. Check the highlighted cells.';
	@override String get missingElimination => 'There are more candidates to remove. Follow the highlighted unit.';
	@override String get wrongPlacement => 'That cell or digit does not match the deduction. Recheck the highlighted position.';
	@override String minutes({required Object count}) => '${count} min';
	@override String tasks({required Object count}) => '${count} tasks';
	@override String get wrongCell => 'This cell is outside the pattern. Look at the highlighted cells.';
	@override String get wrongDigit => 'That digit is not the one this pattern places. Check the candidates in the highlighted cell.';
	@override String get wrongCellAndDigit => 'This selection does not match the pattern. Compare the highlighted cells and their candidates.';
	@override String findTechnique({required Object technique}) => 'Find ${technique}';
}

// Path: progress
class _Translations$progress$en extends Translations$progress$uk {
	_Translations$progress$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get doingWell => 'What is going well';
	@override String get learningNow => 'What you are learning now';
	@override String get next => 'Next';
	@override String get noStrong => 'Your strongest techniques will appear after practice.';
	@override String get startLearning => 'Start learning';
	@override String get thisWeek => 'This week';
	@override String completed({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} puzzle completed',
		other: '${n} puzzles completed',
	);
	@override String mastery({required Object percent}) => '${percent}% mastery';
	@override String get openTechnique => 'Open technique';
}

// Path: profile
class _Translations$profile$en extends Translations$profile$uk {
	_Translations$profile$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get guest => 'Guest';
	@override String get localOnly => 'Progress is saved on this device.';
	@override String get puzzles => 'Puzzles';
	@override String get mastered => 'Mastered';
	@override String get activeDays => 'Active days';
	@override String get learnRow => 'Learn';
	@override String get learnDetail => 'Techniques and practice';
	@override String get settingsRow => 'Settings';
	@override String get settingsDetail => 'Language';
	@override String get activity => 'Your activity';
}

// Path: scanner
class _Translations$scanner$en extends Translations$scanner$uk {
	_Translations$scanner$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Scan Sudoku';
	@override String get intro => 'Frame the whole grid, then take a photo or choose one.';
	@override String get openCamera => 'Use camera';
	@override String get choosePhoto => 'Choose photo';
	@override String get shutter => 'Take photo';
	@override String get frameGuide => 'Keep all four corners inside the frame.';
	@override String get processing => 'Reading your Sudoku…';
	@override String get reviewTitle => 'Check the digits';
	@override String get reviewBody => 'Tap any cell to fix it before playing.';
	@override String get needsReview => 'Needs review';
	@override String get conflict => 'Conflicting clue';
	@override String get selected => 'selected';
	@override String get recognized => 'recognized';
	@override String get empty => 'empty';
	@override String get clear => 'Clear';
	@override String get confirm => 'Import Sudoku';
	@override String get rescan => 'Scan again';
	@override String get permissionIntro => 'Allow camera access to take a photo.';
	@override String get permissionDenied => 'Camera access was denied. You can still choose a photo.';
	@override String get permissionSettings => 'Enable camera access in Settings, or choose a photo.';
	@override String get noCamera => 'No camera is available. Choose a photo instead.';
	@override String get openSettings => 'Open Settings';
	@override String get imageDecodeFailure => 'We could not read this image. Try another photo.';
	@override String get noGridFound => 'No Sudoku grid was found. Include the whole grid and try again.';
	@override String get invalidGeometry => 'The grid could not be straightened. Try a clearer photo.';
	@override String get segmentationFailure => 'The grid could not be divided into cells. Try again.';
	@override String get recognitionFailure => 'Some digits could not be read. Please try again.';
	@override String get duplicateClues => 'Fix the highlighted conflicting clues.';
	@override String get noSolution => 'These clues have no valid solution. Check the digits.';
	@override String get multipleSolutions => 'Some clues may be missing; this board has multiple solutions.';
	@override String get storageFailure => 'The imported puzzle could not be saved. Try again.';
	@override String get validationFailure => 'Could not check this puzzle. Try confirming again.';
	@override String get unsupportedCoach => 'MICHI may not yet explain every step in this Sudoku.';
	@override String get importedTitle => 'Imported Sudoku';
	@override String lowConfidenceCount({required Object count}) => 'Low-confidence cells: ${count}';
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
	@override String get hiddenPair => 'Hidden pair';
	@override String get boxLineReduction => 'Box-line reduction';
	@override String get nakedTriple => 'Naked triple';
	@override String get xWing => 'X-Wing';
	@override String get identifyHiddenPair => 'Two digits can appear only in the same two cells. Remove their other candidates.';
	@override String get understandBoxLine => 'This digit is confined to one box along the line. Remove it elsewhere in that box.';
	@override String get understandTriple => 'Three cells share exactly three digits. Remove those digits from other cells in the unit.';
	@override String get understandXWing => 'Two lines have this digit in the same two crossing positions. Remove it elsewhere on the crossing lines.';
}

// Path: why
class _Translations$why$en extends Translations$why$uk {
	_Translations$why$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explanation';
	@override String whyHere({required Object digit}) => 'Why does ${digit} go here?';
	@override String get givenTitle => 'This is a given digit of the puzzle';
	@override String get givenBody => 'It was on the board from the start, so there is no solving step to explain. Explanations are available for digits you place yourself.';
	@override String get unavailableTitle => 'No direct explanation yet';
	@override String get unavailableBody => 'MICHI cannot prove this move with a supported technique in its pre-move state.';
	@override String get lesson => 'Lesson';
	@override String get gotIt => 'Got it';
	@override String unitRestrictions({required Object unit, required Object digits}) => 'The filled digits in ${unit} are ${digits}.';
	@override String onlyCandidate({required Object digit}) => 'The row, column and box rule out the other digits. Only ${digit} fits here.';
	@override String unitSearch({required Object digit, required Object unit}) => 'Look for a place for ${digit} in ${unit}.';
	@override String solePosition({required Object digit, required Object unit}) => 'The crossed-out ${digit} marks show where it cannot go in ${unit}. This is the only place left.';
	@override String placement({required Object digit}) => 'Therefore ${digit} goes here.';
	@override String unitRow({required Object index}) => 'row ${index}';
	@override String unitColumn({required Object index}) => 'column ${index}';
	@override String unitBox({required Object index}) => 'box ${index}';
}

// Path: recommendation
class _Translations$recommendation$en extends Translations$recommendation$uk {
	_Translations$recommendation$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String focusTitle({required Object technique}) => 'Focus of the day: ${technique}';
	@override String learnAction({required Object technique}) => 'Learn ${technique}';
	@override String practiceAction({required Object technique}) => 'Practice ${technique}';
	@override String reviewAction({required Object technique}) => 'Review ${technique}';
	@override String duration({required Object minutes}) => '${minutes} min';
	@override String get startWithBasics => 'Start with the first logical move.';
	@override String get repeatedCoachHelp => 'You recently needed MICHI’s help.';
	@override String get weakIndependentPractice => 'Independent practice needs reinforcement.';
	@override String get continuePractice => 'Keep practicing this technique.';
	@override String get nextTechnique => 'The next step in your path.';
	@override String get masteredNeedsReview => 'A familiar technique needs a review.';
	@override String get allMasteredReview => 'Review a skill you have mastered.';
}

// Path: week
class _Translations$week$en extends Translations$week$uk {
	_Translations$week$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'This week';
	@override String get empty => 'No puzzles completed yet this week. Your activity will appear here as you play.';
	@override String get puzzles => 'Puzzles';
	@override String get minutes => 'Minutes';
	@override String get daily => 'Daily';
	@override String activeDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} active day',
		other: '${n} active days',
	);
	@override String completedDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} puzzle completed',
		other: '${n} puzzles completed',
	);
	@override String get today => 'Today';
	@override String get noActivity => 'No activity';
	@override String get summary => 'Your local Sudoku activity';
}

// Path: settings
class _Translations$settings$en extends Translations$settings$uk {
	_Translations$settings$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get general => 'General';
	@override String get title => 'Settings';
	@override String get language => 'Language';
	@override String get languageDetail => 'Choose the language for MICHI.';
	@override String get reminders => 'Reminders';
	@override String get dailyReminder => 'Daily at 08:00';
	@override String get reminderSignIn => 'Sign in to enable reminders.';
	@override String get reminderPermission => 'Allow notifications in system settings to enable reminders.';
	@override String get reminderUnavailable => 'Notifications are unavailable on this device.';
}

// Path: sync
class _Translations$sync$en extends Translations$sync$uk {
	_Translations$sync$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get account => 'Account';
	@override String get email => 'Email';
	@override String get synchronization => 'Synchronization';
	@override String get syncing => 'Syncing…';
	@override String get synced => 'Synced recently';
	@override String lastSynced({required Object time}) => 'Last synced — ${time}';
	@override String get pending => 'Saved locally · waiting to sync';
	@override String get offline => 'Offline. Progress will be saved and synced later.';
	@override String get error => 'Sync error';
	@override String get retry => 'Retry';
	@override String get guest => 'Progress is saved only on this device.';
	@override String get deleteAccount => 'Delete account';
	@override String get deleteTitle => 'Delete your account?';
	@override String get deleteBody => 'Your account and synchronized progress will be permanently deleted.';
	@override String get deleteConfirm => 'Delete account';
	@override String get deleteFailed => 'Could not delete your account. Sign in again and retry.';
	@override String get signOut => 'Sign out';
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
	@override late final _Translations$learn$lessons$hiddenPair$en hiddenPair = _Translations$learn$lessons$hiddenPair$en._(_root);
	@override late final _Translations$learn$lessons$boxLineReduction$en boxLineReduction = _Translations$learn$lessons$boxLineReduction$en._(_root);
	@override late final _Translations$learn$lessons$nakedTriple$en nakedTriple = _Translations$learn$lessons$nakedTriple$en._(_root);
	@override late final _Translations$learn$lessons$xWing$en xWing = _Translations$learn$lessons$xWing$en._(_root);
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

// Path: learn.lessons.hiddenPair
class _Translations$learn$lessons$hiddenPair$en extends Translations$learn$lessons$hiddenPair$uk {
	_Translations$learn$lessons$hiddenPair$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'Two digits are hidden in the same two cells.';
	@override String get concept => 'A hidden pair is found by following digits, not matching cell masks.';
	@override String get lookFor => 'Find two digits that occur in exactly the same two cells of a unit.';
	@override String get reasoning => 'Both digits belong to those cells; every other candidate there can go.';
	@override String get example => 'The highlighted two cells contain the only positions for both digits.';
	@override String get tryIt => 'Remove extra candidates from those two cells.';
}

// Path: learn.lessons.boxLineReduction
class _Translations$learn$lessons$boxLineReduction$en extends Translations$learn$lessons$boxLineReduction$uk {
	_Translations$learn$lessons$boxLineReduction$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'A row or column confines a digit to one box.';
	@override String get concept => 'A line can lock a digit inside a box.';
	@override String get lookFor => 'Find two or three positions for a digit in one line, all inside one box.';
	@override String get reasoning => 'The digit must appear in that box on the line, so remove it elsewhere in the box.';
	@override String get example => 'Follow the highlighted line into the box and find candidates outside it.';
	@override String get tryIt => 'Remove the digit from the other cells of that box.';
}

// Path: learn.lessons.nakedTriple
class _Translations$learn$lessons$nakedTriple$en extends Translations$learn$lessons$nakedTriple$uk {
	_Translations$learn$lessons$nakedTriple$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'Three cells share only three candidate digits.';
	@override String get concept => 'A triple reserves three digits for three cells in one unit.';
	@override String get lookFor => 'Find three cells whose candidate union contains exactly three digits.';
	@override String get reasoning => 'The three digits must fill those cells, even when their masks differ.';
	@override String get example => 'The highlighted cells use different pairs but share exactly three digits.';
	@override String get tryIt => 'Remove those digits from the other cells in the unit.';
}

// Path: learn.lessons.xWing
class _Translations$learn$lessons$xWing$en extends Translations$learn$lessons$xWing$uk {
	_Translations$learn$lessons$xWing$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get description => 'Two lines align the same digit in two crossing positions.';
	@override String get concept => 'An X-Wing links two rows or two columns by one candidate digit.';
	@override String get lookFor => 'Find two lines where a digit appears exactly twice in matching positions.';
	@override String get reasoning => 'The four intersections reserve this digit, so remove it elsewhere on the crossing lines.';
	@override String get example => 'Trace the four highlighted positions and the two crossing lines.';
	@override String get tryIt => 'Remove the digit outside the four pattern cells.';
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
			'welcome.title' => 'Find your way through logic.',
			'welcome.subtitle' => 'Sudoku with a coach who guides you instead of solving for you.',
			'welcome.guest' => 'Start without an account',
			'onboarding.title' => 'Your learning starts here.',
			'onboarding.chooseLevel' => 'Choose your level',
			'onboarding.skip' => 'Skip',
			'onboarding.next' => 'Next',
			'onboarding.seeTitle' => 'Sudoku is easier when you know what to look for.',
			'onboarding.seeBody' => 'MICHI explains the logic behind every move.',
			'onboarding.hintsTitle' => 'Hints that teach.',
			'onboarding.hintsBody' => 'Start with a gentle nudge. Ask for more when you need it.',
			'onboarding.patternsTitle' => 'Learn patterns, not answers.',
			'onboarding.patternsBody' => 'Hidden singles, pairs, X-Wing — at your own pace.',
			'onboarding.pathTitle' => 'Your path through Sudoku.',
			'onboarding.pathBody' => 'MICHI notices where you struggle and suggests what to practice.',
			'playerLevel.title' => 'How well do you know Sudoku?',
			'playerLevel.goToGame' => 'Start playing',
			'playerLevel.subtitle' => 'Your first lesson and puzzle difficulty follow this choice. You can change it anytime.',
			'playerLevel.beginner' => 'Just starting',
			'playerLevel.beginnerDetail' => 'Rules and first moves',
			'playerLevel.basics' => 'Know the basics',
			'playerLevel.basicsDetail' => 'Singles and candidates',
			'playerLevel.regular' => 'Play regularly',
			'playerLevel.regularDetail' => 'Pairs and pointing pairs',
			'playerLevel.advanced' => 'Want a challenge',
			'playerLevel.advancedDetail' => 'X-Wing and beyond',
			'auth.title' => 'Account',
			'auth.unavailable' => 'Progress is saved on this device.',
			'auth.apple' => 'Continue with Apple',
			'auth.google' => 'Continue with Google',
			'auth.emailEntry' => 'Sign in with email',
			'auth.createTitle' => 'Create an account',
			'auth.createSubtitle' => 'Your progress stays on this device until sync is available.',
			'auth.signInTitle' => 'Welcome back',
			'auth.name' => 'Name',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.passwordHint' => 'At least 8 characters',
			'auth.createAccount' => 'Create account',
			'auth.signIn' => 'Sign in',
			'auth.alreadyAccount' => 'Already have an account?',
			'auth.noAccount' => 'New here?',
			'auth.forgotPassword' => 'Forgot password?',
			'auth.resetTitle' => 'Reset password',
			'auth.resetSubtitle' => 'Enter your account email and we’ll send a reset link.',
			'auth.sendLink' => 'Send link',
			'auth.resetSent' => 'If an account exists, check your email for a reset link.',
			'auth.verifyTitle' => 'Check your email',
			'auth.verifySubtitle' => ({required Object email}) => 'We sent a verification link to ${email}.',
			'auth.checkVerification' => 'I verified my email',
			'auth.resendVerification' => 'Resend link',
			'auth.verified' => 'Your email is verified.',
			'auth.notVerified' => 'The email is not verified yet.',
			'auth.signOut' => 'Sign out',
			'auth.localNotSynced' => 'Game progress is still saved on this device.',
			'auth.verifyEmail' => 'Verify email',
			'auth.errorInvalidEmail' => 'Enter a valid email address.',
			'auth.errorPasswordLength' => 'Use at least 8 characters.',
			'auth.errorNameRequired' => 'Enter your name.',
			'auth.errorWeakPassword' => 'This password is too weak.',
			'auth.errorEmailInUse' => 'An account already uses this email.',
			'auth.errorWrongCredentials' => 'Check your email and password.',
			'auth.errorDisabled' => 'This account is disabled.',
			'auth.errorTooMany' => 'Too many attempts. Try again later.',
			'auth.errorNetwork' => 'Check your connection and try again.',
			'auth.errorUnavailable' => 'Account services are unavailable. You can keep playing as a guest.',
			'auth.errorUnexpected' => 'Something went wrong. Please try again.',
			'auth.showPassword' => 'Show password',
			'auth.hidePassword' => 'Hide password',
			'auth.signOutTitle' => 'Sign out of your account?',
			'auth.signOutBody' => 'Your local games will stay on this device.',
			'auth.cancel' => 'Cancel',
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
			'home.advanced' => 'Advanced',
			'home.expert' => 'Expert',
			'home.greeting' => 'Good morning',
			'home.newPuzzle' => 'Another puzzle',
			'home.weekTitle' => 'This week',
			'home.weekDetails' => 'Details',
			'home.weekdaysShort' => 'Mon|Tue|Wed|Thu|Fri|Sat|Sun',
			'home.newPuzzleTitle' => 'New Sudoku',
			'home.catalogSource' => 'Choose a puzzle',
			'home.scanSource' => 'Scan Sudoku',
			'home.scanSourceDetail' => 'Photo or camera',
			'home.weekStatusDone' => 'Completed',
			'home.weekStatusToday' => 'Today',
			'home.weekStatusEmpty' => 'No activity',
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
			'game.completionLogic' => 'solved cells',
			'game.completionMistakes' => 'mistakes',
			'game.completionHints' => 'hints',
			'game.dailyStampEarned' => 'Daily stamp earned',
			'game.completionPracticeTechnique' => ({required Object technique}) => 'Practice ${technique} next',
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
			'learn.lessons.hiddenPair.description' => 'Two digits are hidden in the same two cells.',
			'learn.lessons.hiddenPair.concept' => 'A hidden pair is found by following digits, not matching cell masks.',
			'learn.lessons.hiddenPair.lookFor' => 'Find two digits that occur in exactly the same two cells of a unit.',
			'learn.lessons.hiddenPair.reasoning' => 'Both digits belong to those cells; every other candidate there can go.',
			'learn.lessons.hiddenPair.example' => 'The highlighted two cells contain the only positions for both digits.',
			'learn.lessons.hiddenPair.tryIt' => 'Remove extra candidates from those two cells.',
			'learn.lessons.boxLineReduction.description' => 'A row or column confines a digit to one box.',
			'learn.lessons.boxLineReduction.concept' => 'A line can lock a digit inside a box.',
			'learn.lessons.boxLineReduction.lookFor' => 'Find two or three positions for a digit in one line, all inside one box.',
			'learn.lessons.boxLineReduction.reasoning' => 'The digit must appear in that box on the line, so remove it elsewhere in the box.',
			'learn.lessons.boxLineReduction.example' => 'Follow the highlighted line into the box and find candidates outside it.',
			'learn.lessons.boxLineReduction.tryIt' => 'Remove the digit from the other cells of that box.',
			'learn.lessons.nakedTriple.description' => 'Three cells share only three candidate digits.',
			'learn.lessons.nakedTriple.concept' => 'A triple reserves three digits for three cells in one unit.',
			'learn.lessons.nakedTriple.lookFor' => 'Find three cells whose candidate union contains exactly three digits.',
			'learn.lessons.nakedTriple.reasoning' => 'The three digits must fill those cells, even when their masks differ.',
			'learn.lessons.nakedTriple.example' => 'The highlighted cells use different pairs but share exactly three digits.',
			'learn.lessons.nakedTriple.tryIt' => 'Remove those digits from the other cells in the unit.',
			'learn.lessons.xWing.description' => 'Two lines align the same digit in two crossing positions.',
			'learn.lessons.xWing.concept' => 'An X-Wing links two rows or two columns by one candidate digit.',
			'learn.lessons.xWing.lookFor' => 'Find two lines where a digit appears exactly twice in matching positions.',
			'learn.lessons.xWing.reasoning' => 'The four intersections reserve this digit, so remove it elsewhere on the crossing lines.',
			'learn.lessons.xWing.example' => 'Trace the four highlighted positions and the two crossing lines.',
			'learn.lessons.xWing.tryIt' => 'Remove the digit outside the four pattern cells.',
			'learn.basicsGroup' => 'Basics',
			'learn.intermediateGroup' => 'Intermediate',
			'learn.advancedGroup' => 'Advanced',
			'learn.nowLabel' => 'Now',
			'learn.groupProgress' => ({required Object completed, required Object total}) => '${completed} of ${total}',
			'learn.extraElimination' => 'One selected candidate is not removed by this pattern. Check the highlighted cells.',
			'learn.missingElimination' => 'There are more candidates to remove. Follow the highlighted unit.',
			'learn.wrongPlacement' => 'That cell or digit does not match the deduction. Recheck the highlighted position.',
			'learn.minutes' => ({required Object count}) => '${count} min',
			'learn.tasks' => ({required Object count}) => '${count} tasks',
			'learn.wrongCell' => 'This cell is outside the pattern. Look at the highlighted cells.',
			'learn.wrongDigit' => 'That digit is not the one this pattern places. Check the candidates in the highlighted cell.',
			'learn.wrongCellAndDigit' => 'This selection does not match the pattern. Compare the highlighted cells and their candidates.',
			'learn.findTechnique' => ({required Object technique}) => 'Find ${technique}',
			'progress.doingWell' => 'What is going well',
			'progress.learningNow' => 'What you are learning now',
			'progress.next' => 'Next',
			'progress.noStrong' => 'Your strongest techniques will appear after practice.',
			'progress.startLearning' => 'Start learning',
			'progress.thisWeek' => 'This week',
			'progress.completed' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} puzzle completed', other: '${n} puzzles completed', ),
			'progress.mastery' => ({required Object percent}) => '${percent}% mastery',
			'progress.openTechnique' => 'Open technique',
			'profile.guest' => 'Guest',
			'profile.localOnly' => 'Progress is saved on this device.',
			'profile.puzzles' => 'Puzzles',
			'profile.mastered' => 'Mastered',
			'profile.activeDays' => 'Active days',
			'profile.learnRow' => 'Learn',
			'profile.learnDetail' => 'Techniques and practice',
			'profile.settingsRow' => 'Settings',
			'profile.settingsDetail' => 'Language',
			'profile.activity' => 'Your activity',
			'scanner.title' => 'Scan Sudoku',
			'scanner.intro' => 'Frame the whole grid, then take a photo or choose one.',
			'scanner.openCamera' => 'Use camera',
			'scanner.choosePhoto' => 'Choose photo',
			'scanner.shutter' => 'Take photo',
			'scanner.frameGuide' => 'Keep all four corners inside the frame.',
			'scanner.processing' => 'Reading your Sudoku…',
			'scanner.reviewTitle' => 'Check the digits',
			'scanner.reviewBody' => 'Tap any cell to fix it before playing.',
			'scanner.needsReview' => 'Needs review',
			'scanner.conflict' => 'Conflicting clue',
			'scanner.selected' => 'selected',
			'scanner.recognized' => 'recognized',
			'scanner.empty' => 'empty',
			'scanner.clear' => 'Clear',
			'scanner.confirm' => 'Import Sudoku',
			'scanner.rescan' => 'Scan again',
			'scanner.permissionIntro' => 'Allow camera access to take a photo.',
			'scanner.permissionDenied' => 'Camera access was denied. You can still choose a photo.',
			'scanner.permissionSettings' => 'Enable camera access in Settings, or choose a photo.',
			'scanner.noCamera' => 'No camera is available. Choose a photo instead.',
			'scanner.openSettings' => 'Open Settings',
			'scanner.imageDecodeFailure' => 'We could not read this image. Try another photo.',
			'scanner.noGridFound' => 'No Sudoku grid was found. Include the whole grid and try again.',
			'scanner.invalidGeometry' => 'The grid could not be straightened. Try a clearer photo.',
			'scanner.segmentationFailure' => 'The grid could not be divided into cells. Try again.',
			'scanner.recognitionFailure' => 'Some digits could not be read. Please try again.',
			'scanner.duplicateClues' => 'Fix the highlighted conflicting clues.',
			'scanner.noSolution' => 'These clues have no valid solution. Check the digits.',
			'scanner.multipleSolutions' => 'Some clues may be missing; this board has multiple solutions.',
			'scanner.storageFailure' => 'The imported puzzle could not be saved. Try again.',
			'scanner.validationFailure' => 'Could not check this puzzle. Try confirming again.',
			'scanner.unsupportedCoach' => 'MICHI may not yet explain every step in this Sudoku.',
			'scanner.importedTitle' => 'Imported Sudoku',
			'scanner.lowConfidenceCount' => ({required Object count}) => 'Low-confidence cells: ${count}',
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
			'coach.hiddenPair' => 'Hidden pair',
			'coach.boxLineReduction' => 'Box-line reduction',
			'coach.nakedTriple' => 'Naked triple',
			'coach.xWing' => 'X-Wing',
			'coach.identifyHiddenPair' => 'Two digits can appear only in the same two cells. Remove their other candidates.',
			'coach.understandBoxLine' => 'This digit is confined to one box along the line. Remove it elsewhere in that box.',
			'coach.understandTriple' => 'Three cells share exactly three digits. Remove those digits from other cells in the unit.',
			'coach.understandXWing' => 'Two lines have this digit in the same two crossing positions. Remove it elsewhere on the crossing lines.',
			'why.title' => 'Explanation',
			'why.whyHere' => ({required Object digit}) => 'Why does ${digit} go here?',
			'why.givenTitle' => 'This is a given digit of the puzzle',
			'why.givenBody' => 'It was on the board from the start, so there is no solving step to explain. Explanations are available for digits you place yourself.',
			'why.unavailableTitle' => 'No direct explanation yet',
			'why.unavailableBody' => 'MICHI cannot prove this move with a supported technique in its pre-move state.',
			'why.lesson' => 'Lesson',
			'why.gotIt' => 'Got it',
			'why.unitRestrictions' => ({required Object unit, required Object digits}) => 'The filled digits in ${unit} are ${digits}.',
			'why.onlyCandidate' => ({required Object digit}) => 'The row, column and box rule out the other digits. Only ${digit} fits here.',
			'why.unitSearch' => ({required Object digit, required Object unit}) => 'Look for a place for ${digit} in ${unit}.',
			'why.solePosition' => ({required Object digit, required Object unit}) => 'The crossed-out ${digit} marks show where it cannot go in ${unit}. This is the only place left.',
			'why.placement' => ({required Object digit}) => 'Therefore ${digit} goes here.',
			'why.unitRow' => ({required Object index}) => 'row ${index}',
			'why.unitColumn' => ({required Object index}) => 'column ${index}',
			'why.unitBox' => ({required Object index}) => 'box ${index}',
			'recommendation.focusTitle' => ({required Object technique}) => 'Focus of the day: ${technique}',
			'recommendation.learnAction' => ({required Object technique}) => 'Learn ${technique}',
			'recommendation.practiceAction' => ({required Object technique}) => 'Practice ${technique}',
			'recommendation.reviewAction' => ({required Object technique}) => 'Review ${technique}',
			'recommendation.duration' => ({required Object minutes}) => '${minutes} min',
			'recommendation.startWithBasics' => 'Start with the first logical move.',
			'recommendation.repeatedCoachHelp' => 'You recently needed MICHI’s help.',
			'recommendation.weakIndependentPractice' => 'Independent practice needs reinforcement.',
			'recommendation.continuePractice' => 'Keep practicing this technique.',
			'recommendation.nextTechnique' => 'The next step in your path.',
			'recommendation.masteredNeedsReview' => 'A familiar technique needs a review.',
			'recommendation.allMasteredReview' => 'Review a skill you have mastered.',
			'week.title' => 'This week',
			'week.empty' => 'No puzzles completed yet this week. Your activity will appear here as you play.',
			'week.puzzles' => 'Puzzles',
			'week.minutes' => 'Minutes',
			'week.daily' => 'Daily',
			'week.activeDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} active day', other: '${n} active days', ),
			'week.completedDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} puzzle completed', other: '${n} puzzles completed', ),
			'week.today' => 'Today',
			'week.noActivity' => 'No activity',
			'week.summary' => 'Your local Sudoku activity',
			'settings.general' => 'General',
			'settings.title' => 'Settings',
			'settings.language' => 'Language',
			'settings.languageDetail' => 'Choose the language for MICHI.',
			'settings.reminders' => 'Reminders',
			'settings.dailyReminder' => 'Daily at 08:00',
			'settings.reminderSignIn' => 'Sign in to enable reminders.',
			'settings.reminderPermission' => 'Allow notifications in system settings to enable reminders.',
			'settings.reminderUnavailable' => 'Notifications are unavailable on this device.',
			'sync.account' => 'Account',
			'sync.email' => 'Email',
			'sync.synchronization' => 'Synchronization',
			'sync.syncing' => 'Syncing…',
			'sync.synced' => 'Synced recently',
			'sync.lastSynced' => ({required Object time}) => 'Last synced — ${time}',
			'sync.pending' => 'Saved locally · waiting to sync',
			'sync.offline' => 'Offline. Progress will be saved and synced later.',
			'sync.error' => 'Sync error',
			'sync.retry' => 'Retry',
			'sync.guest' => 'Progress is saved only on this device.',
			'sync.deleteAccount' => 'Delete account',
			'sync.deleteTitle' => 'Delete your account?',
			'sync.deleteBody' => 'Your account and synchronized progress will be permanently deleted.',
			'sync.deleteConfirm' => 'Delete account',
			'sync.deleteFailed' => 'Could not delete your account. Sign in again and retry.',
			'sync.signOut' => 'Sign out',
			_ => null,
		};
	}
}
