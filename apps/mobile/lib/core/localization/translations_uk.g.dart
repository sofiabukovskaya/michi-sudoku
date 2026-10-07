///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsUk = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.uk,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uk>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// uk: 'MICHI'
	String get appName => 'MICHI';

	late final Translations$common$uk common = Translations$common$uk.internal(_root);
	late final Translations$splash$uk splash = Translations$splash$uk.internal(_root);
	late final Translations$welcome$uk welcome = Translations$welcome$uk.internal(_root);
	late final Translations$onboarding$uk onboarding = Translations$onboarding$uk.internal(_root);
	late final Translations$playerLevel$uk playerLevel = Translations$playerLevel$uk.internal(_root);
	late final Translations$auth$uk auth = Translations$auth$uk.internal(_root);
	late final Translations$home$uk home = Translations$home$uk.internal(_root);
	late final Translations$game$uk game = Translations$game$uk.internal(_root);
	late final Translations$learn$uk learn = Translations$learn$uk.internal(_root);
	late final Translations$progress$uk progress = Translations$progress$uk.internal(_root);
	late final Translations$profile$uk profile = Translations$profile$uk.internal(_root);
	late final Translations$scanner$uk scanner = Translations$scanner$uk.internal(_root);
}

// Path: common
class Translations$common$uk {
	Translations$common$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Продовжити'
	String get continueLabel => 'Продовжити';

	/// uk: 'Почати'
	String get start => 'Почати';
}

// Path: splash
class Translations$splash$uk {
	Translations$splash$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Вчися бачити наступний хід.'
	String get subtitle => 'Вчися бачити наступний хід.';
}

// Path: welcome
class Translations$welcome$uk {
	Translations$welcome$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Твій шлях у судоку.'
	String get title => 'Твій шлях у судоку.';
}

// Path: onboarding
class Translations$onboarding$uk {
	Translations$onboarding$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Навчання починається тут.'
	String get title => 'Навчання починається тут.';

	/// uk: 'Обрати рівень'
	String get chooseLevel => 'Обрати рівень';
}

// Path: playerLevel
class Translations$playerLevel$uk {
	Translations$playerLevel$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Як добре ти знаєш судоку?'
	String get title => 'Як добре ти знаєш судоку?';

	/// uk: 'До гри'
	String get goToGame => 'До гри';
}

// Path: auth
class Translations$auth$uk {
	Translations$auth$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Акаунт'
	String get title => 'Акаунт';

	/// uk: 'Синхронізація прогресу з’явиться пізніше.'
	String get unavailable => 'Синхронізація прогресу з’явиться пізніше.';
}

// Path: home
class Translations$home$uk {
	Translations$home$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Твій шлях у судоку'
	String get title => 'Твій шлях у судоку';

	/// uk: 'Гра'
	String get game => 'Гра';

	/// uk: 'Навчання'
	String get learn => 'Навчання';

	/// uk: 'Прогрес'
	String get progress => 'Прогрес';

	/// uk: 'Профіль'
	String get profile => 'Профіль';

	/// uk: 'Сканер'
	String get scanner => 'Сканер';
}

// Path: game
class Translations$game$uk {
	Translations$game$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Ігрове поле з’явиться у наступній фазі.'
	String get unavailable => 'Ігрове поле з’явиться у наступній фазі.';
}

// Path: learn
class Translations$learn$uk {
	Translations$learn$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Уроки технік з’являться пізніше.'
	String get unavailable => 'Уроки технік з’являться пізніше.';
}

// Path: progress
class Translations$progress$uk {
	Translations$progress$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Майстерність технік з’явиться пізніше.'
	String get unavailable => 'Майстерність технік з’явиться пізніше.';
}

// Path: profile
class Translations$profile$uk {
	Translations$profile$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Налаштування профілю з’являться пізніше.'
	String get unavailable => 'Налаштування профілю з’являться пізніше.';
}

// Path: scanner
class Translations$scanner$uk {
	Translations$scanner$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Імпорт із камери з’явиться після основної гри.'
	String get unavailable => 'Імпорт із камери з’явиться після основної гри.';
}

/// The flat map containing all translations for locale <uk>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Продовжити',
			'common.start' => 'Почати',
			'splash.subtitle' => 'Вчися бачити наступний хід.',
			'welcome.title' => 'Твій шлях у судоку.',
			'onboarding.title' => 'Навчання починається тут.',
			'onboarding.chooseLevel' => 'Обрати рівень',
			'playerLevel.title' => 'Як добре ти знаєш судоку?',
			'playerLevel.goToGame' => 'До гри',
			'auth.title' => 'Акаунт',
			'auth.unavailable' => 'Синхронізація прогресу з’явиться пізніше.',
			'home.title' => 'Твій шлях у судоку',
			'home.game' => 'Гра',
			'home.learn' => 'Навчання',
			'home.progress' => 'Прогрес',
			'home.profile' => 'Профіль',
			'home.scanner' => 'Сканер',
			'game.unavailable' => 'Ігрове поле з’явиться у наступній фазі.',
			'learn.unavailable' => 'Уроки технік з’являться пізніше.',
			'progress.unavailable' => 'Майстерність технік з’явиться пізніше.',
			'profile.unavailable' => 'Налаштування профілю з’являться пізніше.',
			'scanner.unavailable' => 'Імпорт із камери з’явиться після основної гри.',
			_ => null,
		};
	}
}
