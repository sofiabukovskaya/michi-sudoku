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
class TranslationsCs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsCs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.cs,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <cs>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsCs _root = this; // ignore: unused_field

	@override 
	TranslationsCs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsCs(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$cs common = _Translations$common$cs._(_root);
	@override late final _Translations$splash$cs splash = _Translations$splash$cs._(_root);
	@override late final _Translations$welcome$cs welcome = _Translations$welcome$cs._(_root);
	@override late final _Translations$onboarding$cs onboarding = _Translations$onboarding$cs._(_root);
	@override late final _Translations$playerLevel$cs playerLevel = _Translations$playerLevel$cs._(_root);
	@override late final _Translations$auth$cs auth = _Translations$auth$cs._(_root);
	@override late final _Translations$home$cs home = _Translations$home$cs._(_root);
	@override late final _Translations$game$cs game = _Translations$game$cs._(_root);
	@override late final _Translations$learn$cs learn = _Translations$learn$cs._(_root);
	@override late final _Translations$progress$cs progress = _Translations$progress$cs._(_root);
	@override late final _Translations$profile$cs profile = _Translations$profile$cs._(_root);
	@override late final _Translations$scanner$cs scanner = _Translations$scanner$cs._(_root);
}

// Path: common
class _Translations$common$cs extends Translations$common$uk {
	_Translations$common$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Pokračovat';
	@override String get start => 'Začít';
}

// Path: splash
class _Translations$splash$cs extends Translations$splash$uk {
	_Translations$splash$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Nauč se vidět další tah.';
}

// Path: welcome
class _Translations$welcome$cs extends Translations$welcome$uk {
	_Translations$welcome$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tvoje cesta sudoku.';
}

// Path: onboarding
class _Translations$onboarding$cs extends Translations$onboarding$uk {
	_Translations$onboarding$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tady začíná tvoje učení.';
	@override String get chooseLevel => 'Vybrat úroveň';
}

// Path: playerLevel
class _Translations$playerLevel$cs extends Translations$playerLevel$uk {
	_Translations$playerLevel$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Jak dobře znáš sudoku?';
	@override String get goToGame => 'Začít hrát';
}

// Path: auth
class _Translations$auth$cs extends Translations$auth$uk {
	_Translations$auth$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Účet';
	@override String get unavailable => 'Synchronizace postupu přijde později.';
}

// Path: home
class _Translations$home$cs extends Translations$home$uk {
	_Translations$home$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tvoje cesta sudoku';
	@override String get game => 'Hrát';
	@override String get learn => 'Učení';
	@override String get progress => 'Pokrok';
	@override String get profile => 'Profil';
	@override String get scanner => 'Skener';
}

// Path: game
class _Translations$game$cs extends Translations$game$uk {
	_Translations$game$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Hrací pole přijde v další fázi.';
}

// Path: learn
class _Translations$learn$cs extends Translations$learn$uk {
	_Translations$learn$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Lekce technik přijdou později.';
}

// Path: progress
class _Translations$progress$cs extends Translations$progress$uk {
	_Translations$progress$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Přehled zvládnutých technik přijde později.';
}

// Path: profile
class _Translations$profile$cs extends Translations$profile$uk {
	_Translations$profile$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Nastavení profilu přijde později.';
}

// Path: scanner
class _Translations$scanner$cs extends Translations$scanner$uk {
	_Translations$scanner$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Import z fotoaparátu přijde po základní hře.';
}

/// The flat map containing all translations for locale <cs>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsCs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Pokračovat',
			'common.start' => 'Začít',
			'splash.subtitle' => 'Nauč se vidět další tah.',
			'welcome.title' => 'Tvoje cesta sudoku.',
			'onboarding.title' => 'Tady začíná tvoje učení.',
			'onboarding.chooseLevel' => 'Vybrat úroveň',
			'playerLevel.title' => 'Jak dobře znáš sudoku?',
			'playerLevel.goToGame' => 'Začít hrát',
			'auth.title' => 'Účet',
			'auth.unavailable' => 'Synchronizace postupu přijde později.',
			'home.title' => 'Tvoje cesta sudoku',
			'home.game' => 'Hrát',
			'home.learn' => 'Učení',
			'home.progress' => 'Pokrok',
			'home.profile' => 'Profil',
			'home.scanner' => 'Skener',
			'game.unavailable' => 'Hrací pole přijde v další fázi.',
			'learn.unavailable' => 'Lekce technik přijdou později.',
			'progress.unavailable' => 'Přehled zvládnutých technik přijde později.',
			'profile.unavailable' => 'Nastavení profilu přijde později.',
			'scanner.unavailable' => 'Import z fotoaparátu přijde po základní hře.',
			_ => null,
		};
	}
}
