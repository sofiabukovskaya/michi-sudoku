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
	@override String get learn => 'Learn';
	@override String get progress => 'Progress';
	@override String get profile => 'Profile';
	@override String get scanner => 'Scanner';
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
}

// Path: learn
class _Translations$learn$en extends Translations$learn$uk {
	_Translations$learn$en._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Technique lessons are coming later.';
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
			'home.learn' => 'Learn',
			'home.progress' => 'Progress',
			'home.profile' => 'Profile',
			'home.scanner' => 'Scanner',
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
			'learn.unavailable' => 'Technique lessons are coming later.',
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
