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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$splash$de splash = _Translations$splash$de._(_root);
	@override late final _Translations$welcome$de welcome = _Translations$welcome$de._(_root);
	@override late final _Translations$onboarding$de onboarding = _Translations$onboarding$de._(_root);
	@override late final _Translations$playerLevel$de playerLevel = _Translations$playerLevel$de._(_root);
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$home$de home = _Translations$home$de._(_root);
	@override late final _Translations$game$de game = _Translations$game$de._(_root);
	@override late final _Translations$learn$de learn = _Translations$learn$de._(_root);
	@override late final _Translations$progress$de progress = _Translations$progress$de._(_root);
	@override late final _Translations$profile$de profile = _Translations$profile$de._(_root);
	@override late final _Translations$scanner$de scanner = _Translations$scanner$de._(_root);
}

// Path: common
class _Translations$common$de extends Translations$common$uk {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Weiter';
	@override String get start => 'Starten';
}

// Path: splash
class _Translations$splash$de extends Translations$splash$uk {
	_Translations$splash$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Lerne, den nächsten Zug zu erkennen.';
}

// Path: welcome
class _Translations$welcome$de extends Translations$welcome$uk {
	_Translations$welcome$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dein Weg durch Sudoku.';
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$uk {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hier beginnt dein Lernweg.';
	@override String get chooseLevel => 'Niveau wählen';
}

// Path: playerLevel
class _Translations$playerLevel$de extends Translations$playerLevel$uk {
	_Translations$playerLevel$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wie gut kennst du Sudoku?';
	@override String get goToGame => 'Jetzt spielen';
}

// Path: auth
class _Translations$auth$de extends Translations$auth$uk {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konto';
	@override String get unavailable => 'Die Synchronisierung des Fortschritts kommt später.';
}

// Path: home
class _Translations$home$de extends Translations$home$uk {
	_Translations$home$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dein Weg durch Sudoku';
	@override String get game => 'Spielen';
	@override String get learn => 'Lernen';
	@override String get progress => 'Fortschritt';
	@override String get profile => 'Profil';
	@override String get scanner => 'Scanner';
}

// Path: game
class _Translations$game$de extends Translations$game$uk {
	_Translations$game$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Das Spielfeld kommt in der nächsten Phase.';
}

// Path: learn
class _Translations$learn$de extends Translations$learn$uk {
	_Translations$learn$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Techniklektionen kommen später.';
}

// Path: progress
class _Translations$progress$de extends Translations$progress$uk {
	_Translations$progress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Die Übersicht deiner Techniken kommt später.';
}

// Path: profile
class _Translations$profile$de extends Translations$profile$uk {
	_Translations$profile$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Profileinstellungen kommen später.';
}

// Path: scanner
class _Translations$scanner$de extends Translations$scanner$uk {
	_Translations$scanner$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Der Kameraimport folgt nach dem Grundspiel.';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Weiter',
			'common.start' => 'Starten',
			'splash.subtitle' => 'Lerne, den nächsten Zug zu erkennen.',
			'welcome.title' => 'Dein Weg durch Sudoku.',
			'onboarding.title' => 'Hier beginnt dein Lernweg.',
			'onboarding.chooseLevel' => 'Niveau wählen',
			'playerLevel.title' => 'Wie gut kennst du Sudoku?',
			'playerLevel.goToGame' => 'Jetzt spielen',
			'auth.title' => 'Konto',
			'auth.unavailable' => 'Die Synchronisierung des Fortschritts kommt später.',
			'home.title' => 'Dein Weg durch Sudoku',
			'home.game' => 'Spielen',
			'home.learn' => 'Lernen',
			'home.progress' => 'Fortschritt',
			'home.profile' => 'Profil',
			'home.scanner' => 'Scanner',
			'game.unavailable' => 'Das Spielfeld kommt in der nächsten Phase.',
			'learn.unavailable' => 'Techniklektionen kommen später.',
			'progress.unavailable' => 'Die Übersicht deiner Techniken kommt später.',
			'profile.unavailable' => 'Profileinstellungen kommen später.',
			'scanner.unavailable' => 'Der Kameraimport folgt nach dem Grundspiel.',
			_ => null,
		};
	}
}
