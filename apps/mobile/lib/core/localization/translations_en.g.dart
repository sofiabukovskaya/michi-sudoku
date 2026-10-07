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
	@override String get unavailable => 'The Sudoku board is coming in the next phase.';
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
			'game.unavailable' => 'The Sudoku board is coming in the next phase.',
			'learn.unavailable' => 'Technique lessons are coming later.',
			'progress.unavailable' => 'Technique mastery is coming later.',
			'profile.unavailable' => 'Profile settings are coming later.',
			'scanner.unavailable' => 'Camera import will follow the core game.',
			_ => null,
		};
	}
}
