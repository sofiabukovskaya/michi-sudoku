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

	/// uk: 'Продовжити гру'
	String get continueGame => 'Продовжити гру';

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

	/// uk: 'Оберіть складність'
	String get chooseDifficulty => 'Оберіть складність';

	/// uk: 'Легкий'
	String get easy => 'Легкий';

	/// uk: 'Середній'
	String get medium => 'Середній';

	/// uk: 'Судоку дня'
	String get dailyTitle => 'Судоку дня';

	/// uk: 'Почати судоку дня'
	String get dailyStart => 'Почати судоку дня';

	/// uk: 'Продовжити судоку дня'
	String get dailyContinue => 'Продовжити судоку дня';

	/// uk: 'Сьогодні виконано'
	String get dailyCompleted => 'Сьогодні виконано';

	/// uk: 'Набір головоломок недоступний. Спробуйте ще раз.'
	String get contentUnavailable => 'Набір головоломок недоступний. Спробуйте ще раз.';
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

	/// uk: 'Судоку'
	String get standardTitle => 'Судоку';

	/// uk: 'Судоку дня'
	String get dailyTitle => 'Судоку дня';
}

// Path: learn
class Translations$learn$uk {
	Translations$learn$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Навчання'
	String get title => 'Навчання';

	/// uk: 'Крок за кроком до розуміння технік.'
	String get intro => 'Крок за кроком до розуміння технік.';

	/// uk: 'Нове'
	String get newLabel => 'Нове';

	/// uk: 'Вивчаєш'
	String get learningLabel => 'Вивчаєш';

	/// uk: 'Практикуєш'
	String get practicingLabel => 'Практикуєш';

	/// uk: 'Опановано'
	String get masteredLabel => 'Опановано';

	/// uk: 'План уроку'
	String get planTitle => 'План уроку';

	/// uk: 'Почати урок'
	String get lessonStart => 'Почати урок';

	/// uk: 'Далі'
	String get next => 'Далі';

	/// uk: 'Почати практику'
	String get practiceStart => 'Почати практику';

	/// uk: 'Ідея'
	String get concept => 'Ідея';

	/// uk: 'На що дивитися'
	String get lookFor => 'На що дивитися';

	/// uk: 'Чому це працює'
	String get reasoning => 'Чому це працює';

	/// uk: 'Приклад'
	String get example => 'Приклад';

	/// uk: 'Спробуй самостійно'
	String get tryIt => 'Спробуй самостійно';

	/// uk: 'Завдання $current з $total'
	String exercise({required Object current, required Object total}) => 'Завдання ${current} з ${total}';

	/// uk: 'Обери клітинку та цифру.'
	String get placementPrompt => 'Обери клітинку та цифру.';

	/// uk: 'Обери клітинку й познач усіх кандидатів, яких можна прибрати.'
	String get eliminationPrompt => 'Обери клітинку й познач усіх кандидатів, яких можна прибрати.';

	/// uk: 'Перевірити'
	String get checkAnswer => 'Перевірити';

	/// uk: 'Чудово помічено'
	String get correctTitle => 'Чудово помічено';

	/// uk: 'Не зовсім'
	String get incorrectTitle => 'Не зовсім';

	/// uk: 'Ще раз'
	String get tryAgain => 'Ще раз';

	/// uk: 'Запитати MICHI'
	String get askMichi => 'Запитати MICHI';

	/// uk: 'Наступне завдання'
	String get nextScenario => 'Наступне завдання';

	/// uk: 'Практику завершено'
	String get sessionSummary => 'Практику завершено';

	/// uk: '$correct правильно · $attempts спроб'
	String summaryStats({required Object correct, required Object attempts}) => '${correct} правильно · ${attempts} спроб';

	/// uk: '$count з MICHI'
	String hintsUsed({required Object count}) => '${count} з MICHI';

	/// uk: 'Готово'
	String get done => 'Готово';

	/// uk: 'Готуємо урок…'
	String get loading => 'Готуємо урок…';

	/// uk: 'Навчальні матеріали недоступні. Спробуй ще раз.'
	String get unavailable => 'Навчальні матеріали недоступні. Спробуй ще раз.';

	/// uk: 'Наразі немає завдань для практики.'
	String get noScenarios => 'Наразі немає завдань для практики.';

	/// uk: 'Не вдалося зберегти прогрес. Спробуй ще раз.'
	String get saveFailed => 'Не вдалося зберегти прогрес. Спробуй ще раз.';

	/// uk: 'Позначено для викреслення'
	String get selectedForElimination => 'Позначено для викреслення';

	/// uk: 'Техніки цієї головоломки'
	String get requiredTechniques => 'Техніки цієї головоломки';

	/// uk: 'MICHI допоміг із'
	String get helpedTechniques => 'MICHI допоміг із';

	/// uk: 'Підказок не було'
	String get noHints => 'Підказок не було';

	/// uk: 'Практика'
	String get practiceTitle => 'Практика';

	/// uk: 'Продовжити урок'
	String get continueLesson => 'Продовжити урок';

	late final Translations$learn$lessons$uk lessons = Translations$learn$lessons$uk.internal(_root);
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

// Path: learn.lessons
class Translations$learn$lessons$uk {
	Translations$learn$lessons$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learn$lessons$nakedSingle$uk nakedSingle = Translations$learn$lessons$nakedSingle$uk.internal(_root);
	late final Translations$learn$lessons$hiddenSingle$uk hiddenSingle = Translations$learn$lessons$hiddenSingle$uk.internal(_root);
	late final Translations$learn$lessons$nakedPair$uk nakedPair = Translations$learn$lessons$nakedPair$uk.internal(_root);
	late final Translations$learn$lessons$pointingPair$uk pointingPair = Translations$learn$lessons$pointingPair$uk.internal(_root);
}

// Path: learn.lessons.nakedSingle
class Translations$learn$lessons$nakedSingle$uk {
	Translations$learn$lessons$nakedSingle$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'У порожній клітинці залишилася лише одна можлива цифра.'
	String get description => 'У порожній клітинці залишилася лише одна можлива цифра.';

	/// uk: 'Кандидати — цифри, які ще можуть стояти в порожній клітинці.'
	String get concept => 'Кандидати — цифри, які ще можуть стояти в порожній клітинці.';

	/// uk: 'Знайди клітинку, де рядок, стовпець і блок виключають усі цифри, крім однієї.'
	String get lookFor => 'Знайди клітинку, де рядок, стовпець і блок виключають усі цифри, крім однієї.';

	/// uk: 'Залишився один кандидат, отже його потрібно поставити в цю клітинку.'
	String get reasoning => 'Залишився один кандидат, отже його потрібно поставити в цю клітинку.';

	/// uk: 'У виділеній клітинці один допустимий кандидат. Подивись, що виключають сусідні клітинки.'
	String get example => 'У виділеній клітинці один допустимий кандидат. Подивись, що виключають сусідні клітинки.';

	/// uk: 'Обери цю клітинку й постав останню можливу цифру.'
	String get tryIt => 'Обери цю клітинку й постав останню можливу цифру.';
}

// Path: learn.lessons.hiddenSingle
class Translations$learn$lessons$hiddenSingle$uk {
	Translations$learn$lessons$hiddenSingle$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Для цифри є лише одне можливе місце в рядку, стовпці або блоці.'
	String get description => 'Для цифри є лише одне можливе місце в рядку, стовпці або блоці.';

	/// uk: 'Дивись на одну цифру в групі, а не на всі кандидати однієї клітинки.'
	String get concept => 'Дивись на одну цифру в групі, а не на всі кандидати однієї клітинки.';

	/// uk: 'Знайди єдине порожнє місце, де цю цифру ще можна поставити.'
	String get lookFor => 'Знайди єдине порожнє місце, де цю цифру ще можна поставити.';

	/// uk: 'У клітинці може бути кілька кандидатів, але ця цифра має лише одне місце в групі.'
	String get reasoning => 'У клітинці може бути кілька кандидатів, але ця цифра має лише одне місце в групі.';

	/// uk: 'У виділеній групі для потрібної цифри лишилося одне місце.'
	String get example => 'У виділеній групі для потрібної цифри лишилося одне місце.';

	/// uk: 'Обери єдине місце й постав цифру.'
	String get tryIt => 'Обери єдине місце й постав цифру.';
}

// Path: learn.lessons.nakedPair
class Translations$learn$lessons$nakedPair$uk {
	Translations$learn$lessons$nakedPair$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Дві клітинки в групі мають ту саму пару кандидатів.'
	String get description => 'Дві клітинки в групі мають ту саму пару кандидатів.';

	/// uk: 'Пара резервує дві цифри для цих клітинок.'
	String get concept => 'Пара резервує дві цифри для цих клітинок.';

	/// uk: 'Знайди дві клітинки в одному рядку, стовпці чи блоці з однаковими двома кандидатами.'
	String get lookFor => 'Знайди дві клітинки в одному рядку, стовпці чи блоці з однаковими двома кандидатами.';

	/// uk: 'Ці цифри не можуть бути в інших клітинках групи — викресли їх там.'
	String get reasoning => 'Ці цифри не можуть бути в інших клітинках групи — викресли їх там.';

	/// uk: 'Виділена пара прибирає кандидатів з інших клітинок групи.'
	String get example => 'Виділена пара прибирає кандидатів з інших клітинок групи.';

	/// uk: 'Познач усіх кандидатів, яких виключає пара. Цифру поки не став.'
	String get tryIt => 'Познач усіх кандидатів, яких виключає пара. Цифру поки не став.';
}

// Path: learn.lessons.pointingPair
class Translations$learn$lessons$pointingPair$uk {
	Translations$learn$lessons$pointingPair$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Дві позиції кандидата в блоці лежать на одному рядку чи стовпці.'
	String get description => 'Дві позиції кандидата в блоці лежать на одному рядку чи стовпці.';

	/// uk: 'Блок може обмежити цифру однією лінією.'
	String get concept => 'Блок може обмежити цифру однією лінією.';

	/// uk: 'Знайди рівно дві позиції цифри в блоці на одному рядку чи стовпці.'
	String get lookFor => 'Знайди рівно дві позиції цифри в блоці на одному рядку чи стовпці.';

	/// uk: 'Цифра залишиться в цьому блоці, тому прибери її поза блоком на спільній лінії.'
	String get reasoning => 'Цифра залишиться в цьому блоці, тому прибери її поза блоком на спільній лінії.';

	/// uk: 'Простеж за виділеною лінією поза блоком.'
	String get example => 'Простеж за виділеною лінією поза блоком.';

	/// uk: 'Познач усіх кандидатів, яких можна прибрати поза блоком.'
	String get tryIt => 'Познач усіх кандидатів, яких можна прибрати поза блоком.';
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
			'home.continueGame' => 'Продовжити гру',
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
			'home.chooseDifficulty' => 'Оберіть складність',
			'home.easy' => 'Легкий',
			'home.medium' => 'Середній',
			'home.dailyTitle' => 'Судоку дня',
			'home.dailyStart' => 'Почати судоку дня',
			'home.dailyContinue' => 'Продовжити судоку дня',
			'home.dailyCompleted' => 'Сьогодні виконано',
			'home.contentUnavailable' => 'Набір головоломок недоступний. Спробуйте ще раз.',
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
			'game.standardTitle' => 'Судоку',
			'game.dailyTitle' => 'Судоку дня',
			'learn.title' => 'Навчання',
			'learn.intro' => 'Крок за кроком до розуміння технік.',
			'learn.newLabel' => 'Нове',
			'learn.learningLabel' => 'Вивчаєш',
			'learn.practicingLabel' => 'Практикуєш',
			'learn.masteredLabel' => 'Опановано',
			'learn.planTitle' => 'План уроку',
			'learn.lessonStart' => 'Почати урок',
			'learn.next' => 'Далі',
			'learn.practiceStart' => 'Почати практику',
			'learn.concept' => 'Ідея',
			'learn.lookFor' => 'На що дивитися',
			'learn.reasoning' => 'Чому це працює',
			'learn.example' => 'Приклад',
			'learn.tryIt' => 'Спробуй самостійно',
			'learn.exercise' => ({required Object current, required Object total}) => 'Завдання ${current} з ${total}',
			'learn.placementPrompt' => 'Обери клітинку та цифру.',
			'learn.eliminationPrompt' => 'Обери клітинку й познач усіх кандидатів, яких можна прибрати.',
			'learn.checkAnswer' => 'Перевірити',
			'learn.correctTitle' => 'Чудово помічено',
			'learn.incorrectTitle' => 'Не зовсім',
			'learn.tryAgain' => 'Ще раз',
			'learn.askMichi' => 'Запитати MICHI',
			'learn.nextScenario' => 'Наступне завдання',
			'learn.sessionSummary' => 'Практику завершено',
			'learn.summaryStats' => ({required Object correct, required Object attempts}) => '${correct} правильно · ${attempts} спроб',
			'learn.hintsUsed' => ({required Object count}) => '${count} з MICHI',
			'learn.done' => 'Готово',
			'learn.loading' => 'Готуємо урок…',
			'learn.unavailable' => 'Навчальні матеріали недоступні. Спробуй ще раз.',
			'learn.noScenarios' => 'Наразі немає завдань для практики.',
			'learn.saveFailed' => 'Не вдалося зберегти прогрес. Спробуй ще раз.',
			'learn.selectedForElimination' => 'Позначено для викреслення',
			'learn.requiredTechniques' => 'Техніки цієї головоломки',
			'learn.helpedTechniques' => 'MICHI допоміг із',
			'learn.noHints' => 'Підказок не було',
			'learn.practiceTitle' => 'Практика',
			'learn.continueLesson' => 'Продовжити урок',
			'learn.lessons.nakedSingle.description' => 'У порожній клітинці залишилася лише одна можлива цифра.',
			'learn.lessons.nakedSingle.concept' => 'Кандидати — цифри, які ще можуть стояти в порожній клітинці.',
			'learn.lessons.nakedSingle.lookFor' => 'Знайди клітинку, де рядок, стовпець і блок виключають усі цифри, крім однієї.',
			'learn.lessons.nakedSingle.reasoning' => 'Залишився один кандидат, отже його потрібно поставити в цю клітинку.',
			'learn.lessons.nakedSingle.example' => 'У виділеній клітинці один допустимий кандидат. Подивись, що виключають сусідні клітинки.',
			'learn.lessons.nakedSingle.tryIt' => 'Обери цю клітинку й постав останню можливу цифру.',
			'learn.lessons.hiddenSingle.description' => 'Для цифри є лише одне можливе місце в рядку, стовпці або блоці.',
			'learn.lessons.hiddenSingle.concept' => 'Дивись на одну цифру в групі, а не на всі кандидати однієї клітинки.',
			'learn.lessons.hiddenSingle.lookFor' => 'Знайди єдине порожнє місце, де цю цифру ще можна поставити.',
			'learn.lessons.hiddenSingle.reasoning' => 'У клітинці може бути кілька кандидатів, але ця цифра має лише одне місце в групі.',
			'learn.lessons.hiddenSingle.example' => 'У виділеній групі для потрібної цифри лишилося одне місце.',
			'learn.lessons.hiddenSingle.tryIt' => 'Обери єдине місце й постав цифру.',
			'learn.lessons.nakedPair.description' => 'Дві клітинки в групі мають ту саму пару кандидатів.',
			'learn.lessons.nakedPair.concept' => 'Пара резервує дві цифри для цих клітинок.',
			'learn.lessons.nakedPair.lookFor' => 'Знайди дві клітинки в одному рядку, стовпці чи блоці з однаковими двома кандидатами.',
			'learn.lessons.nakedPair.reasoning' => 'Ці цифри не можуть бути в інших клітинках групи — викресли їх там.',
			'learn.lessons.nakedPair.example' => 'Виділена пара прибирає кандидатів з інших клітинок групи.',
			'learn.lessons.nakedPair.tryIt' => 'Познач усіх кандидатів, яких виключає пара. Цифру поки не став.',
			'learn.lessons.pointingPair.description' => 'Дві позиції кандидата в блоці лежать на одному рядку чи стовпці.',
			'learn.lessons.pointingPair.concept' => 'Блок може обмежити цифру однією лінією.',
			'learn.lessons.pointingPair.lookFor' => 'Знайди рівно дві позиції цифри в блоці на одному рядку чи стовпці.',
			'learn.lessons.pointingPair.reasoning' => 'Цифра залишиться в цьому блоці, тому прибери її поза блоком на спільній лінії.',
			'learn.lessons.pointingPair.example' => 'Простеж за виділеною лінією поза блоком.',
			'learn.lessons.pointingPair.tryIt' => 'Познач усіх кандидатів, яких можна прибрати поза блоком.',
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
