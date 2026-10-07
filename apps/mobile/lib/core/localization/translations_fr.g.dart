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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$splash$fr splash = _Translations$splash$fr._(_root);
	@override late final _Translations$welcome$fr welcome = _Translations$welcome$fr._(_root);
	@override late final _Translations$onboarding$fr onboarding = _Translations$onboarding$fr._(_root);
	@override late final _Translations$playerLevel$fr playerLevel = _Translations$playerLevel$fr._(_root);
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$home$fr home = _Translations$home$fr._(_root);
	@override late final _Translations$game$fr game = _Translations$game$fr._(_root);
	@override late final _Translations$learn$fr learn = _Translations$learn$fr._(_root);
	@override late final _Translations$progress$fr progress = _Translations$progress$fr._(_root);
	@override late final _Translations$profile$fr profile = _Translations$profile$fr._(_root);
	@override late final _Translations$scanner$fr scanner = _Translations$scanner$fr._(_root);
}

// Path: common
class _Translations$common$fr extends Translations$common$uk {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Continuer';
	@override String get start => 'Commencer';
}

// Path: splash
class _Translations$splash$fr extends Translations$splash$uk {
	_Translations$splash$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Apprends à voir le prochain coup.';
}

// Path: welcome
class _Translations$welcome$fr extends Translations$welcome$uk {
	_Translations$welcome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton parcours dans le sudoku.';
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$uk {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton apprentissage commence ici.';
	@override String get chooseLevel => 'Choisir ton niveau';
}

// Path: playerLevel
class _Translations$playerLevel$fr extends Translations$playerLevel$uk {
	_Translations$playerLevel$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connais-tu bien le sudoku ?';
	@override String get goToGame => 'Commencer à jouer';
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$uk {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compte';
	@override String get unavailable => 'La synchronisation de la progression arrivera plus tard.';
}

// Path: home
class _Translations$home$fr extends Translations$home$uk {
	_Translations$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton parcours dans le sudoku';
	@override String get game => 'Jouer';
	@override String get learn => 'Apprendre';
	@override String get progress => 'Progression';
	@override String get profile => 'Profil';
	@override String get scanner => 'Scanner';
}

// Path: game
class _Translations$game$fr extends Translations$game$uk {
	_Translations$game$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'La grille arrivera lors de la prochaine phase.';
}

// Path: learn
class _Translations$learn$fr extends Translations$learn$uk {
	_Translations$learn$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Les leçons sur les techniques arriveront plus tard.';
}

// Path: progress
class _Translations$progress$fr extends Translations$progress$uk {
	_Translations$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Le suivi des techniques maîtrisées arrivera plus tard.';
}

// Path: profile
class _Translations$profile$fr extends Translations$profile$uk {
	_Translations$profile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Les réglages du profil arriveront plus tard.';
}

// Path: scanner
class _Translations$scanner$fr extends Translations$scanner$uk {
	_Translations$scanner$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'L’importation par caméra suivra le jeu principal.';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Continuer',
			'common.start' => 'Commencer',
			'splash.subtitle' => 'Apprends à voir le prochain coup.',
			'welcome.title' => 'Ton parcours dans le sudoku.',
			'onboarding.title' => 'Ton apprentissage commence ici.',
			'onboarding.chooseLevel' => 'Choisir ton niveau',
			'playerLevel.title' => 'Connais-tu bien le sudoku ?',
			'playerLevel.goToGame' => 'Commencer à jouer',
			'auth.title' => 'Compte',
			'auth.unavailable' => 'La synchronisation de la progression arrivera plus tard.',
			'home.title' => 'Ton parcours dans le sudoku',
			'home.game' => 'Jouer',
			'home.learn' => 'Apprendre',
			'home.progress' => 'Progression',
			'home.profile' => 'Profil',
			'home.scanner' => 'Scanner',
			'game.unavailable' => 'La grille arrivera lors de la prochaine phase.',
			'learn.unavailable' => 'Les leçons sur les techniques arriveront plus tard.',
			'progress.unavailable' => 'Le suivi des techniques maîtrisées arrivera plus tard.',
			'profile.unavailable' => 'Les réglages du profil arriveront plus tard.',
			'scanner.unavailable' => 'L’importation par caméra suivra le jeu principal.',
			_ => null,
		};
	}
}
