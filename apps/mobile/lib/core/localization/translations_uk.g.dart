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
	late final Translations$coach$uk coach = Translations$coach$uk.internal(_root);
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

	/// uk: 'Продовжити: середній'
	String get continueGame => 'Продовжити: середній';

	/// uk: 'Розпочато $date · $progress% · $time'
	String continueDetails({required Object date, required Object progress, required Object time}) => 'Розпочато ${date} · ${progress}% · ${time}';

	/// uk: 'Почати нову головоломку?'
	String get replaceTitle => 'Почати нову головоломку?';

	/// uk: 'Незавершену гру буде замінено.'
	String get replaceBody => 'Незавершену гру буде замінено.';

	/// uk: 'Продовжити гру'
	String get keepPlaying => 'Продовжити гру';

	/// uk: 'Почати нову'
	String get startNew => 'Почати нову';

	/// uk: 'Збережена гра недоступна. Спробуй пізніше.'
	String get storageUnavailable => 'Збережена гра недоступна. Спробуй пізніше.';

	/// uk: 'Шукаємо збережену гру…'
	String get loading => 'Шукаємо збережену гру…';

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

	/// uk: 'Судоку дня · Середній'
	String get title => 'Судоку дня · Середній';

	/// uk: 'Скасувати'
	String get undo => 'Скасувати';

	/// uk: 'Стерти'
	String get erase => 'Стерти';

	/// uk: 'Нотатки'
	String get notes => 'Нотатки';

	/// uk: 'Підказка'
	String get hint => 'Підказка';

	/// uk: 'Помилки: $count з 3'
	String mistakes({required Object count}) => 'Помилки: ${count} з 3';

	/// uk: 'Режим нотаток: цифри додаються як кандидати'
	String get notesModeOn => 'Режим нотаток: цифри додаються як кандидати';

	/// uk: 'Рядок'
	String get row => 'Рядок';

	/// uk: 'стовпець'
	String get column => 'стовпець';

	/// uk: 'порожня'
	String get empty => 'порожня';

	/// uk: 'задана'
	String get given => 'задана';

	/// uk: 'введена'
	String get entered => 'введена';

	/// uk: 'вибрана'
	String get selected => 'вибрана';

	/// uk: 'помилка'
	String get error => 'помилка';

	/// uk: 'кандидати'
	String get candidates => 'кандидати';

	/// uk: 'Розв’язано.'
	String get completeTitle => 'Розв’язано.';

	/// uk: 'Це судоку розв’язано.'
	String get completeBody => 'Це судоку розв’язано.';

	/// uk: 'На головну'
	String get backHome => 'На головну';

	/// uk: 'Пауза'
	String get pause => 'Пауза';

	/// uk: 'Пауза'
	String get pausedTitle => 'Пауза';

	/// uk: 'Продовжити'
	String get resume => 'Продовжити';

	/// uk: 'Таймер зупинено на $time'
	String pausedAt({required Object time}) => 'Таймер зупинено на ${time}';

	/// uk: 'Готуємо головоломку…'
	String get loading => 'Готуємо головоломку…';

	/// uk: 'Не вдалося відновити гру.'
	String get restoreUnavailable => 'Не вдалося відновити гру.';

	/// uk: 'Не вдалося зберегти гру.'
	String get saveFailed => 'Не вдалося зберегти гру.';

	/// uk: 'Повторити'
	String get retrySave => 'Повторити';

	/// uk: '$mistakes помилок · $hints підказок'
	String completionStats({required Object mistakes, required Object hints}) => '${mistakes} помилок · ${hints} підказок';
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

// Path: coach
class Translations$coach$uk {
	Translations$coach$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Підказка $step з 4'
	String step({required Object step}) => 'Підказка ${step} з 4';

	/// uk: 'Спробую'
	String get kTry => 'Спробую';

	/// uk: 'Показати'
	String get show => 'Показати';

	/// uk: 'Бачу'
	String get see => 'Бачу';

	/// uk: 'Ще підказка'
	String get more => 'Ще підказка';

	/// uk: 'Закрити'
	String get close => 'Закрити';

	/// uk: 'Показати помилку'
	String get showMistake => 'Показати помилку';

	/// uk: 'Поставити $digit'
	String place({required Object digit}) => 'Поставити ${digit}';

	/// uk: 'рядок $index'
	String unitRow({required Object index}) => 'рядок ${index}';

	/// uk: 'стовпець $index'
	String unitColumn({required Object index}) => 'стовпець ${index}';

	/// uk: 'блок $index'
	String unitBox({required Object index}) => 'блок ${index}';

	/// uk: 'Подивись на виділену клітинку.'
	String get inspectCell => 'Подивись на виділену клітинку.';

	/// uk: 'Подивись на виділений $unit.'
	String inspectUnit({required Object unit}) => 'Подивись на виділений ${unit}.';

	/// uk: 'Які цифри можуть стояти в цій клітинці?'
	String get inspectCandidates => 'Які цифри можуть стояти в цій клітинці?';

	/// uk: 'Де ця цифра може стояти у виділеному $unit?'
	String inspectPositions({required Object unit}) => 'Де ця цифра може стояти у виділеному ${unit}?';

	/// uk: 'Знайди дві клітинки з однаковою парою кандидатів.'
	String get inspectPair => 'Знайди дві клітинки з однаковою парою кандидатів.';

	/// uk: 'У цій клітинці лишається один кандидат.'
	String get singleRemains => 'У цій клітинці лишається один кандидат.';

	/// uk: 'Для цієї цифри в $unit лишається одне місце.'
	String onlyPosition({required Object unit}) => 'Для цієї цифри в ${unit} лишається одне місце.';

	/// uk: 'Ці дві цифри займають виділену пару. В інших клітинках $unit їх можна виключити.'
	String pairRestriction({required Object unit}) => 'Ці дві цифри займають виділену пару. В інших клітинках ${unit} їх можна виключити.';

	/// uk: 'Кандидати лежать на одній лінії, тому поза блоком цю цифру можна виключити.'
	String get alignment => 'Кандидати лежать на одній лінії, тому поза блоком цю цифру можна виключити.';

	/// uk: '$digit може стояти тільки тут.'
	String resultPlacement({required Object digit}) => '${digit} може стояти тільки тут.';

	/// uk: 'Виключи перекреслених кандидатів із виділених клітинок.'
	String get resultEliminations => 'Виключи перекреслених кандидатів із виділених клітинок.';

	/// uk: 'Виконай виділений логічний крок.'
	String get resultActions => 'Виконай виділений логічний крок.';

	/// uk: 'Техніка: $name'
	String technique({required Object name}) => 'Техніка: ${name}';

	/// uk: 'голий одинак'
	String get nakedSingle => 'голий одинак';

	/// uk: 'прихований одинак'
	String get hiddenSingle => 'прихований одинак';

	/// uk: 'гола пара'
	String get nakedPair => 'гола пара';

	/// uk: 'вказівна пара'
	String get pointingPair => 'вказівна пара';

	/// uk: 'Підказка недоступна'
	String get unavailable => 'Підказка недоступна';

	/// uk: 'Спершу виправ помилку.'
	String get wrongTitle => 'Спершу виправ помилку.';

	/// uk: 'З неправильною цифрою на дошці логічний хід знайти неможливо.'
	String get wrongBody => 'З неправильною цифрою на дошці логічний хід знайти неможливо.';

	/// uk: 'Поки немає відомого кроку.'
	String get stuckTitle => 'Поки немає відомого кроку.';

	/// uk: 'MICHI поки не може пояснити наступний хід доступними техніками.'
	String get stuckBody => 'MICHI поки не може пояснити наступний хід доступними техніками.';
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
			'home.continueGame' => 'Продовжити: середній',
			'home.continueDetails' => ({required Object date, required Object progress, required Object time}) => 'Розпочато ${date} · ${progress}% · ${time}',
			'home.replaceTitle' => 'Почати нову головоломку?',
			'home.replaceBody' => 'Незавершену гру буде замінено.',
			'home.keepPlaying' => 'Продовжити гру',
			'home.startNew' => 'Почати нову',
			'home.storageUnavailable' => 'Збережена гра недоступна. Спробуй пізніше.',
			'home.loading' => 'Шукаємо збережену гру…',
			'home.learn' => 'Навчання',
			'home.progress' => 'Прогрес',
			'home.profile' => 'Профіль',
			'home.scanner' => 'Сканер',
			'game.title' => 'Судоку дня · Середній',
			'game.undo' => 'Скасувати',
			'game.erase' => 'Стерти',
			'game.notes' => 'Нотатки',
			'game.hint' => 'Підказка',
			'game.mistakes' => ({required Object count}) => 'Помилки: ${count} з 3',
			'game.notesModeOn' => 'Режим нотаток: цифри додаються як кандидати',
			'game.row' => 'Рядок',
			'game.column' => 'стовпець',
			'game.empty' => 'порожня',
			'game.given' => 'задана',
			'game.entered' => 'введена',
			'game.selected' => 'вибрана',
			'game.error' => 'помилка',
			'game.candidates' => 'кандидати',
			'game.completeTitle' => 'Розв’язано.',
			'game.completeBody' => 'Це судоку розв’язано.',
			'game.backHome' => 'На головну',
			'game.pause' => 'Пауза',
			'game.pausedTitle' => 'Пауза',
			'game.resume' => 'Продовжити',
			'game.pausedAt' => ({required Object time}) => 'Таймер зупинено на ${time}',
			'game.loading' => 'Готуємо головоломку…',
			'game.restoreUnavailable' => 'Не вдалося відновити гру.',
			'game.saveFailed' => 'Не вдалося зберегти гру.',
			'game.retrySave' => 'Повторити',
			'game.completionStats' => ({required Object mistakes, required Object hints}) => '${mistakes} помилок · ${hints} підказок',
			'learn.unavailable' => 'Уроки технік з’являться пізніше.',
			'progress.unavailable' => 'Майстерність технік з’явиться пізніше.',
			'profile.unavailable' => 'Налаштування профілю з’являться пізніше.',
			'scanner.unavailable' => 'Імпорт із камери з’явиться після основної гри.',
			'coach.step' => ({required Object step}) => 'Підказка ${step} з 4',
			'coach.kTry' => 'Спробую',
			'coach.show' => 'Показати',
			'coach.see' => 'Бачу',
			'coach.more' => 'Ще підказка',
			'coach.close' => 'Закрити',
			'coach.showMistake' => 'Показати помилку',
			'coach.place' => ({required Object digit}) => 'Поставити ${digit}',
			'coach.unitRow' => ({required Object index}) => 'рядок ${index}',
			'coach.unitColumn' => ({required Object index}) => 'стовпець ${index}',
			'coach.unitBox' => ({required Object index}) => 'блок ${index}',
			'coach.inspectCell' => 'Подивись на виділену клітинку.',
			'coach.inspectUnit' => ({required Object unit}) => 'Подивись на виділений ${unit}.',
			'coach.inspectCandidates' => 'Які цифри можуть стояти в цій клітинці?',
			'coach.inspectPositions' => ({required Object unit}) => 'Де ця цифра може стояти у виділеному ${unit}?',
			'coach.inspectPair' => 'Знайди дві клітинки з однаковою парою кандидатів.',
			'coach.singleRemains' => 'У цій клітинці лишається один кандидат.',
			'coach.onlyPosition' => ({required Object unit}) => 'Для цієї цифри в ${unit} лишається одне місце.',
			'coach.pairRestriction' => ({required Object unit}) => 'Ці дві цифри займають виділену пару. В інших клітинках ${unit} їх можна виключити.',
			'coach.alignment' => 'Кандидати лежать на одній лінії, тому поза блоком цю цифру можна виключити.',
			'coach.resultPlacement' => ({required Object digit}) => '${digit} може стояти тільки тут.',
			'coach.resultEliminations' => 'Виключи перекреслених кандидатів із виділених клітинок.',
			'coach.resultActions' => 'Виконай виділений логічний крок.',
			'coach.technique' => ({required Object name}) => 'Техніка: ${name}',
			'coach.nakedSingle' => 'голий одинак',
			'coach.hiddenSingle' => 'прихований одинак',
			'coach.nakedPair' => 'гола пара',
			'coach.pointingPair' => 'вказівна пара',
			'coach.unavailable' => 'Підказка недоступна',
			'coach.wrongTitle' => 'Спершу виправ помилку.',
			'coach.wrongBody' => 'З неправильною цифрою на дошці логічний хід знайти неможливо.',
			'coach.stuckTitle' => 'Поки немає відомого кроку.',
			'coach.stuckBody' => 'MICHI поки не може пояснити наступний хід доступними техніками.',
			_ => null,
		};
	}
}
