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
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$splash$es splash = _Translations$splash$es._(_root);
	@override late final _Translations$welcome$es welcome = _Translations$welcome$es._(_root);
	@override late final _Translations$onboarding$es onboarding = _Translations$onboarding$es._(_root);
	@override late final _Translations$playerLevel$es playerLevel = _Translations$playerLevel$es._(_root);
	@override late final _Translations$auth$es auth = _Translations$auth$es._(_root);
	@override late final _Translations$home$es home = _Translations$home$es._(_root);
	@override late final _Translations$game$es game = _Translations$game$es._(_root);
	@override late final _Translations$learn$es learn = _Translations$learn$es._(_root);
	@override late final _Translations$progress$es progress = _Translations$progress$es._(_root);
	@override late final _Translations$profile$es profile = _Translations$profile$es._(_root);
	@override late final _Translations$scanner$es scanner = _Translations$scanner$es._(_root);
}

// Path: common
class _Translations$common$es extends Translations$common$uk {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Continuar';
	@override String get start => 'Empezar';
}

// Path: splash
class _Translations$splash$es extends Translations$splash$uk {
	_Translations$splash$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Aprende a ver el siguiente paso.';
}

// Path: welcome
class _Translations$welcome$es extends Translations$welcome$uk {
	_Translations$welcome$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu camino en el sudoku.';
}

// Path: onboarding
class _Translations$onboarding$es extends Translations$onboarding$uk {
	_Translations$onboarding$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu aprendizaje empieza aquí.';
	@override String get chooseLevel => 'Elegir nivel';
}

// Path: playerLevel
class _Translations$playerLevel$es extends Translations$playerLevel$uk {
	_Translations$playerLevel$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Cuánto sabes de sudoku?';
	@override String get goToGame => 'Empezar a jugar';
}

// Path: auth
class _Translations$auth$es extends Translations$auth$uk {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cuenta';
	@override String get unavailable => 'La sincronización del progreso llegará más adelante.';
}

// Path: home
class _Translations$home$es extends Translations$home$uk {
	_Translations$home$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu camino en el sudoku';
	@override String get game => 'Jugar';
	@override String get learn => 'Aprender';
	@override String get progress => 'Progreso';
	@override String get profile => 'Perfil';
	@override String get scanner => 'Escáner';
}

// Path: game
class _Translations$game$es extends Translations$game$uk {
	_Translations$game$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'El tablero llegará en la siguiente fase.';
}

// Path: learn
class _Translations$learn$es extends Translations$learn$uk {
	_Translations$learn$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Las lecciones de técnicas llegarán más adelante.';
}

// Path: progress
class _Translations$progress$es extends Translations$progress$uk {
	_Translations$progress$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'El dominio de las técnicas llegará más adelante.';
}

// Path: profile
class _Translations$profile$es extends Translations$profile$uk {
	_Translations$profile$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'La configuración del perfil llegará más adelante.';
}

// Path: scanner
class _Translations$scanner$es extends Translations$scanner$uk {
	_Translations$scanner$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'La importación con cámara llegará después del juego principal.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Continuar',
			'common.start' => 'Empezar',
			'splash.subtitle' => 'Aprende a ver el siguiente paso.',
			'welcome.title' => 'Tu camino en el sudoku.',
			'onboarding.title' => 'Tu aprendizaje empieza aquí.',
			'onboarding.chooseLevel' => 'Elegir nivel',
			'playerLevel.title' => '¿Cuánto sabes de sudoku?',
			'playerLevel.goToGame' => 'Empezar a jugar',
			'auth.title' => 'Cuenta',
			'auth.unavailable' => 'La sincronización del progreso llegará más adelante.',
			'home.title' => 'Tu camino en el sudoku',
			'home.game' => 'Jugar',
			'home.learn' => 'Aprender',
			'home.progress' => 'Progreso',
			'home.profile' => 'Perfil',
			'home.scanner' => 'Escáner',
			'game.unavailable' => 'El tablero llegará en la siguiente fase.',
			'learn.unavailable' => 'Las lecciones de técnicas llegarán más adelante.',
			'progress.unavailable' => 'El dominio de las técnicas llegará más adelante.',
			'profile.unavailable' => 'La configuración del perfil llegará más adelante.',
			'scanner.unavailable' => 'La importación con cámara llegará después del juego principal.',
			_ => null,
		};
	}
}
