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
	late final Translations$why$uk why = Translations$why$uk.internal(_root);
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

	/// uk: 'Знайди свій шлях крізь логіку.'
	String get title => 'Знайди свій шлях крізь логіку.';

	/// uk: 'Судоку з наставником, який підказує — а не розв’язує за тебе.'
	String get subtitle => 'Судоку з наставником, який підказує — а не розв’язує за тебе.';

	/// uk: 'Почати без акаунта'
	String get guest => 'Почати без акаунта';
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

	/// uk: 'Пропустити'
	String get skip => 'Пропустити';

	/// uk: 'Далі'
	String get next => 'Далі';

	/// uk: 'Судоку легше, коли знаєш, на що дивитися.'
	String get seeTitle => 'Судоку легше, коли знаєш, на що дивитися.';

	/// uk: 'MICHI пояснює логіку кожного ходу.'
	String get seeBody => 'MICHI пояснює логіку кожного ходу.';

	/// uk: 'Підказки, які вчать.'
	String get hintsTitle => 'Підказки, які вчать.';

	/// uk: 'Спершу — легкий натяк. Більше — лише коли попросиш.'
	String get hintsBody => 'Спершу — легкий натяк. Більше — лише коли попросиш.';

	/// uk: 'Вчи патерни, а не відповіді.'
	String get patternsTitle => 'Вчи патерни, а не відповіді.';

	/// uk: 'Приховані одинаки, пари, X-Wing — у власному темпі.'
	String get patternsBody => 'Приховані одинаки, пари, X-Wing — у власному темпі.';

	/// uk: 'Твій шлях у судоку.'
	String get pathTitle => 'Твій шлях у судоку.';

	/// uk: 'MICHI бачить, де тобі складно, і пропонує, що потренувати.'
	String get pathBody => 'MICHI бачить, де тобі складно, і пропонує, що потренувати.';
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

	/// uk: 'Від цього залежать перший урок і складність. Змінити можна будь-коли.'
	String get subtitle => 'Від цього залежать перший урок і складність. Змінити можна будь-коли.';

	/// uk: 'Тільки починаю'
	String get beginner => 'Тільки починаю';

	/// uk: 'Правила й перші ходи'
	String get beginnerDetail => 'Правила й перші ходи';

	/// uk: 'Знаю основи'
	String get basics => 'Знаю основи';

	/// uk: 'Одинаки й кандидати'
	String get basicsDetail => 'Одинаки й кандидати';

	/// uk: 'Розв’язую регулярно'
	String get regular => 'Розв’язую регулярно';

	/// uk: 'Пари й вказівні пари'
	String get regularDetail => 'Пари й вказівні пари';

	/// uk: 'Хочу складніших задач'
	String get advanced => 'Хочу складніших задач';

	/// uk: 'X-Wing і далі'
	String get advancedDetail => 'X-Wing і далі';
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

	/// uk: 'Складний'
	String get advanced => 'Складний';

	/// uk: 'Експертний'
	String get expert => 'Експертний';

	/// uk: 'Доброго ранку'
	String get greeting => 'Доброго ранку';

	/// uk: 'Ще одна головоломка'
	String get newPuzzle => 'Ще одна головоломка';

	/// uk: 'Цей тиждень'
	String get weekTitle => 'Цей тиждень';

	/// uk: 'Детальніше'
	String get weekDetails => 'Детальніше';

	/// uk: 'Пн|Вт|Ср|Чт|Пт|Сб|Нд'
	String get weekdaysShort => 'Пн|Вт|Ср|Чт|Пт|Сб|Нд';
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

	/// uk: 'розв’язані клітинки'
	String get completionLogic => 'розв’язані клітинки';

	/// uk: 'помилки'
	String get completionMistakes => 'помилки';

	/// uk: 'підказки'
	String get completionHints => 'підказки';

	/// uk: 'Штамп дня отримано'
	String get dailyStampEarned => 'Штамп дня отримано';

	/// uk: 'Наступний крок: $technique'
	String completionPracticeTechnique({required Object technique}) => 'Наступний крок: ${technique}';
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

	/// uk: 'Основи'
	String get basicsGroup => 'Основи';

	/// uk: 'Середній рівень'
	String get intermediateGroup => 'Середній рівень';

	/// uk: 'Просунутий рівень'
	String get advancedGroup => 'Просунутий рівень';

	/// uk: 'Зараз'
	String get nowLabel => 'Зараз';

	/// uk: '$completed з $total'
	String groupProgress({required Object completed, required Object total}) => '${completed} з ${total}';

	/// uk: 'Один вибраний кандидат цей прийом не виключає. Перевір підсвічені клітинки.'
	String get extraElimination => 'Один вибраний кандидат цей прийом не виключає. Перевір підсвічені клітинки.';

	/// uk: 'Є ще кандидати, які треба викреслити. Простеж підсвічену групу.'
	String get missingElimination => 'Є ще кандидати, які треба викреслити. Простеж підсвічену групу.';

	/// uk: 'Ця клітинка або цифра не відповідає висновку. Перевір підсвічену позицію.'
	String get wrongPlacement => 'Ця клітинка або цифра не відповідає висновку. Перевір підсвічену позицію.';
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

	/// uk: 'відкритий одинак'
	String get nakedSingle => 'відкритий одинак';

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

	/// uk: 'Прихована пара'
	String get hiddenPair => 'Прихована пара';

	/// uk: 'Лінія в блоці'
	String get boxLineReduction => 'Лінія в блоці';

	/// uk: 'Відкрита трійка'
	String get nakedTriple => 'Відкрита трійка';

	/// uk: 'X-Wing'
	String get xWing => 'X-Wing';

	/// uk: 'Дві цифри можливі лише в тих самих двох клітинках. Прибери інші кандидати.'
	String get identifyHiddenPair => 'Дві цифри можливі лише в тих самих двох клітинках. Прибери інші кандидати.';

	/// uk: 'У цій лінії цифра обмежена одним блоком. Прибери її в решті блоку.'
	String get understandBoxLine => 'У цій лінії цифра обмежена одним блоком. Прибери її в решті блоку.';

	/// uk: 'Три клітинки ділять рівно три цифри. Прибери їх з інших клітинок групи.'
	String get understandTriple => 'Три клітинки ділять рівно три цифри. Прибери їх з інших клітинок групи.';

	/// uk: 'У двох лініях цифра має ті самі два перетини. Прибери її з решти перехресних ліній.'
	String get understandXWing => 'У двох лініях цифра має ті самі два перетини. Прибери її з решти перехресних ліній.';
}

// Path: why
class Translations$why$uk {
	Translations$why$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Пояснення'
	String get title => 'Пояснення';

	/// uk: 'Чому тут $digit'
	String whyHere({required Object digit}) => 'Чому тут ${digit}';

	/// uk: 'Це задана цифра головоломки'
	String get givenTitle => 'Це задана цифра головоломки';

	/// uk: 'Вона стоїть на дошці від початку, тому її не потрібно знаходити. Пояснення доступні для цифр, які ставиш ти.'
	String get givenBody => 'Вона стоїть на дошці від початку, тому її не потрібно знаходити. Пояснення доступні для цифр, які ставиш ти.';

	/// uk: 'Пояснення поки недоступне'
	String get unavailableTitle => 'Пояснення поки недоступне';

	/// uk: 'MICHI не може довести цей хід підтримуваною технікою в стані до ходу.'
	String get unavailableBody => 'MICHI не може довести цей хід підтримуваною технікою в стані до ходу.';

	/// uk: 'Урок'
	String get lesson => 'Урок';

	/// uk: 'Зрозуміло'
	String get gotIt => 'Зрозуміло';

	/// uk: 'У $unit вже стоять цифри: $digits.'
	String unitRestrictions({required Object unit, required Object digits}) => 'У ${unit} вже стоять цифри: ${digits}.';

	/// uk: 'У цій клітинці можлива лише цифра $digit.'
	String onlyCandidate({required Object digit}) => 'У цій клітинці можлива лише цифра ${digit}.';

	/// uk: 'Шукаємо місце для $digit у $unit.'
	String unitSearch({required Object digit, required Object unit}) => 'Шукаємо місце для ${digit} у ${unit}.';

	/// uk: 'Лише ця клітинка у $unit може містити $digit.'
	String solePosition({required Object unit, required Object digit}) => 'Лише ця клітинка у ${unit} може містити ${digit}.';

	/// uk: 'Отже, тут стоїть $digit.'
	String placement({required Object digit}) => 'Отже, тут стоїть ${digit}.';

	/// uk: 'рядку $index'
	String unitRow({required Object index}) => 'рядку ${index}';

	/// uk: 'стовпці $index'
	String unitColumn({required Object index}) => 'стовпці ${index}';

	/// uk: 'блоці $index'
	String unitBox({required Object index}) => 'блоці ${index}';
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
	late final Translations$learn$lessons$hiddenPair$uk hiddenPair = Translations$learn$lessons$hiddenPair$uk.internal(_root);
	late final Translations$learn$lessons$boxLineReduction$uk boxLineReduction = Translations$learn$lessons$boxLineReduction$uk.internal(_root);
	late final Translations$learn$lessons$nakedTriple$uk nakedTriple = Translations$learn$lessons$nakedTriple$uk.internal(_root);
	late final Translations$learn$lessons$xWing$uk xWing = Translations$learn$lessons$xWing$uk.internal(_root);
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

// Path: learn.lessons.hiddenPair
class Translations$learn$lessons$hiddenPair$uk {
	Translations$learn$lessons$hiddenPair$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Дві цифри приховані в тих самих двох клітинках.'
	String get description => 'Дві цифри приховані в тих самих двох клітинках.';

	/// uk: 'Приховану пару шукаємо за цифрами, а не за однаковими наборами кандидатів.'
	String get concept => 'Приховану пару шукаємо за цифрами, а не за однаковими наборами кандидатів.';

	/// uk: 'Знайди дві цифри, кожна з яких можлива лише в тих самих двох клітинках групи.'
	String get lookFor => 'Знайди дві цифри, кожна з яких можлива лише в тих самих двох клітинках групи.';

	/// uk: 'Обидві цифри належать цим клітинкам; решту кандидатів у них можна прибрати.'
	String get reasoning => 'Обидві цифри належать цим клітинкам; решту кандидатів у них можна прибрати.';

	/// uk: 'Підсвічені клітинки — єдині місця для обох цифр.'
	String get example => 'Підсвічені клітинки — єдині місця для обох цифр.';

	/// uk: 'Прибери зайвих кандидатів із цих двох клітинок.'
	String get tryIt => 'Прибери зайвих кандидатів із цих двох клітинок.';
}

// Path: learn.lessons.boxLineReduction
class Translations$learn$lessons$boxLineReduction$uk {
	Translations$learn$lessons$boxLineReduction$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Рядок або стовпець обмежує цифру одним блоком.'
	String get description => 'Рядок або стовпець обмежує цифру одним блоком.';

	/// uk: 'Лінія може замкнути цифру всередині блоку.'
	String get concept => 'Лінія може замкнути цифру всередині блоку.';

	/// uk: 'Знайди два чи три місця для цифри в одній лінії, усі в одному блоці.'
	String get lookFor => 'Знайди два чи три місця для цифри в одній лінії, усі в одному блоці.';

	/// uk: 'Цифра мусить бути в цьому блоці на лінії, тож прибери її поза лінією.'
	String get reasoning => 'Цифра мусить бути в цьому блоці на лінії, тож прибери її поза лінією.';

	/// uk: 'Простеж підсвічену лінію в блоці та знайди кандидати поза нею.'
	String get example => 'Простеж підсвічену лінію в блоці та знайди кандидати поза нею.';

	/// uk: 'Прибери цифру з інших клітинок блоку.'
	String get tryIt => 'Прибери цифру з інших клітинок блоку.';
}

// Path: learn.lessons.nakedTriple
class Translations$learn$lessons$nakedTriple$uk {
	Translations$learn$lessons$nakedTriple$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Три клітинки ділять лише три цифри-кандидати.'
	String get description => 'Три клітинки ділять лише три цифри-кандидати.';

	/// uk: 'Трійка резервує три цифри для трьох клітинок однієї групи.'
	String get concept => 'Трійка резервує три цифри для трьох клітинок однієї групи.';

	/// uk: 'Знайди три клітинки, у яких разом рівно три кандидати.'
	String get lookFor => 'Знайди три клітинки, у яких разом рівно три кандидати.';

	/// uk: 'Ці три цифри заповнять клітинки, навіть якщо набори кандидатів різні.'
	String get reasoning => 'Ці три цифри заповнять клітинки, навіть якщо набори кандидатів різні.';

	/// uk: 'Підсвічені клітинки мають різні пари, але разом лише три цифри.'
	String get example => 'Підсвічені клітинки мають різні пари, але разом лише три цифри.';

	/// uk: 'Прибери ці цифри з решти клітинок групи.'
	String get tryIt => 'Прибери ці цифри з решти клітинок групи.';
}

// Path: learn.lessons.xWing
class Translations$learn$lessons$xWing$uk {
	Translations$learn$lessons$xWing$uk.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uk: 'Дві лінії вирівнюють одну цифру у двох перетинах.'
	String get description => 'Дві лінії вирівнюють одну цифру у двох перетинах.';

	/// uk: 'X-Wing пов’язує два рядки або два стовпці одним кандидатом.'
	String get concept => 'X-Wing пов’язує два рядки або два стовпці одним кандидатом.';

	/// uk: 'Знайди дві лінії, де цифра можлива рівно двічі в однакових позиціях.'
	String get lookFor => 'Знайди дві лінії, де цифра можлива рівно двічі в однакових позиціях.';

	/// uk: 'Чотири перетини резервують цифру; прибери її в решті перехресних ліній.'
	String get reasoning => 'Чотири перетини резервують цифру; прибери її в решті перехресних ліній.';

	/// uk: 'Простеж чотири підсвічені позиції та дві перехресні лінії.'
	String get example => 'Простеж чотири підсвічені позиції та дві перехресні лінії.';

	/// uk: 'Прибери цифру поза чотирма клітинками візерунка.'
	String get tryIt => 'Прибери цифру поза чотирма клітинками візерунка.';
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
			'welcome.title' => 'Знайди свій шлях крізь логіку.',
			'welcome.subtitle' => 'Судоку з наставником, який підказує — а не розв’язує за тебе.',
			'welcome.guest' => 'Почати без акаунта',
			'onboarding.title' => 'Навчання починається тут.',
			'onboarding.chooseLevel' => 'Обрати рівень',
			'onboarding.skip' => 'Пропустити',
			'onboarding.next' => 'Далі',
			'onboarding.seeTitle' => 'Судоку легше, коли знаєш, на що дивитися.',
			'onboarding.seeBody' => 'MICHI пояснює логіку кожного ходу.',
			'onboarding.hintsTitle' => 'Підказки, які вчать.',
			'onboarding.hintsBody' => 'Спершу — легкий натяк. Більше — лише коли попросиш.',
			'onboarding.patternsTitle' => 'Вчи патерни, а не відповіді.',
			'onboarding.patternsBody' => 'Приховані одинаки, пари, X-Wing — у власному темпі.',
			'onboarding.pathTitle' => 'Твій шлях у судоку.',
			'onboarding.pathBody' => 'MICHI бачить, де тобі складно, і пропонує, що потренувати.',
			'playerLevel.title' => 'Як добре ти знаєш судоку?',
			'playerLevel.goToGame' => 'До гри',
			'playerLevel.subtitle' => 'Від цього залежать перший урок і складність. Змінити можна будь-коли.',
			'playerLevel.beginner' => 'Тільки починаю',
			'playerLevel.beginnerDetail' => 'Правила й перші ходи',
			'playerLevel.basics' => 'Знаю основи',
			'playerLevel.basicsDetail' => 'Одинаки й кандидати',
			'playerLevel.regular' => 'Розв’язую регулярно',
			'playerLevel.regularDetail' => 'Пари й вказівні пари',
			'playerLevel.advanced' => 'Хочу складніших задач',
			'playerLevel.advancedDetail' => 'X-Wing і далі',
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
			'home.advanced' => 'Складний',
			'home.expert' => 'Експертний',
			'home.greeting' => 'Доброго ранку',
			'home.newPuzzle' => 'Ще одна головоломка',
			'home.weekTitle' => 'Цей тиждень',
			'home.weekDetails' => 'Детальніше',
			'home.weekdaysShort' => 'Пн|Вт|Ср|Чт|Пт|Сб|Нд',
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
			'game.completionLogic' => 'розв’язані клітинки',
			'game.completionMistakes' => 'помилки',
			'game.completionHints' => 'підказки',
			'game.dailyStampEarned' => 'Штамп дня отримано',
			'game.completionPracticeTechnique' => ({required Object technique}) => 'Наступний крок: ${technique}',
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
			'learn.lessons.hiddenPair.description' => 'Дві цифри приховані в тих самих двох клітинках.',
			'learn.lessons.hiddenPair.concept' => 'Приховану пару шукаємо за цифрами, а не за однаковими наборами кандидатів.',
			'learn.lessons.hiddenPair.lookFor' => 'Знайди дві цифри, кожна з яких можлива лише в тих самих двох клітинках групи.',
			'learn.lessons.hiddenPair.reasoning' => 'Обидві цифри належать цим клітинкам; решту кандидатів у них можна прибрати.',
			'learn.lessons.hiddenPair.example' => 'Підсвічені клітинки — єдині місця для обох цифр.',
			'learn.lessons.hiddenPair.tryIt' => 'Прибери зайвих кандидатів із цих двох клітинок.',
			'learn.lessons.boxLineReduction.description' => 'Рядок або стовпець обмежує цифру одним блоком.',
			'learn.lessons.boxLineReduction.concept' => 'Лінія може замкнути цифру всередині блоку.',
			'learn.lessons.boxLineReduction.lookFor' => 'Знайди два чи три місця для цифри в одній лінії, усі в одному блоці.',
			'learn.lessons.boxLineReduction.reasoning' => 'Цифра мусить бути в цьому блоці на лінії, тож прибери її поза лінією.',
			'learn.lessons.boxLineReduction.example' => 'Простеж підсвічену лінію в блоці та знайди кандидати поза нею.',
			'learn.lessons.boxLineReduction.tryIt' => 'Прибери цифру з інших клітинок блоку.',
			'learn.lessons.nakedTriple.description' => 'Три клітинки ділять лише три цифри-кандидати.',
			'learn.lessons.nakedTriple.concept' => 'Трійка резервує три цифри для трьох клітинок однієї групи.',
			'learn.lessons.nakedTriple.lookFor' => 'Знайди три клітинки, у яких разом рівно три кандидати.',
			'learn.lessons.nakedTriple.reasoning' => 'Ці три цифри заповнять клітинки, навіть якщо набори кандидатів різні.',
			'learn.lessons.nakedTriple.example' => 'Підсвічені клітинки мають різні пари, але разом лише три цифри.',
			'learn.lessons.nakedTriple.tryIt' => 'Прибери ці цифри з решти клітинок групи.',
			'learn.lessons.xWing.description' => 'Дві лінії вирівнюють одну цифру у двох перетинах.',
			'learn.lessons.xWing.concept' => 'X-Wing пов’язує два рядки або два стовпці одним кандидатом.',
			'learn.lessons.xWing.lookFor' => 'Знайди дві лінії, де цифра можлива рівно двічі в однакових позиціях.',
			'learn.lessons.xWing.reasoning' => 'Чотири перетини резервують цифру; прибери її в решті перехресних ліній.',
			'learn.lessons.xWing.example' => 'Простеж чотири підсвічені позиції та дві перехресні лінії.',
			'learn.lessons.xWing.tryIt' => 'Прибери цифру поза чотирма клітинками візерунка.',
			'learn.basicsGroup' => 'Основи',
			'learn.intermediateGroup' => 'Середній рівень',
			'learn.advancedGroup' => 'Просунутий рівень',
			'learn.nowLabel' => 'Зараз',
			'learn.groupProgress' => ({required Object completed, required Object total}) => '${completed} з ${total}',
			'learn.extraElimination' => 'Один вибраний кандидат цей прийом не виключає. Перевір підсвічені клітинки.',
			'learn.missingElimination' => 'Є ще кандидати, які треба викреслити. Простеж підсвічену групу.',
			'learn.wrongPlacement' => 'Ця клітинка або цифра не відповідає висновку. Перевір підсвічену позицію.',
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
			'coach.nakedSingle' => 'відкритий одинак',
			'coach.hiddenSingle' => 'прихований одинак',
			'coach.nakedPair' => 'гола пара',
			'coach.pointingPair' => 'вказівна пара',
			'coach.unavailable' => 'Підказка недоступна',
			'coach.wrongTitle' => 'Спершу виправ помилку.',
			'coach.wrongBody' => 'З неправильною цифрою на дошці логічний хід знайти неможливо.',
			'coach.stuckTitle' => 'Поки немає відомого кроку.',
			'coach.stuckBody' => 'MICHI поки не може пояснити наступний хід доступними техніками.',
			'coach.hiddenPair' => 'Прихована пара',
			'coach.boxLineReduction' => 'Лінія в блоці',
			'coach.nakedTriple' => 'Відкрита трійка',
			'coach.xWing' => 'X-Wing',
			'coach.identifyHiddenPair' => 'Дві цифри можливі лише в тих самих двох клітинках. Прибери інші кандидати.',
			'coach.understandBoxLine' => 'У цій лінії цифра обмежена одним блоком. Прибери її в решті блоку.',
			'coach.understandTriple' => 'Три клітинки ділять рівно три цифри. Прибери їх з інших клітинок групи.',
			'coach.understandXWing' => 'У двох лініях цифра має ті самі два перетини. Прибери її з решти перехресних ліній.',
			'why.title' => 'Пояснення',
			'why.whyHere' => ({required Object digit}) => 'Чому тут ${digit}',
			'why.givenTitle' => 'Це задана цифра головоломки',
			'why.givenBody' => 'Вона стоїть на дошці від початку, тому її не потрібно знаходити. Пояснення доступні для цифр, які ставиш ти.',
			'why.unavailableTitle' => 'Пояснення поки недоступне',
			'why.unavailableBody' => 'MICHI не може довести цей хід підтримуваною технікою в стані до ходу.',
			'why.lesson' => 'Урок',
			'why.gotIt' => 'Зрозуміло',
			'why.unitRestrictions' => ({required Object unit, required Object digits}) => 'У ${unit} вже стоять цифри: ${digits}.',
			'why.onlyCandidate' => ({required Object digit}) => 'У цій клітинці можлива лише цифра ${digit}.',
			'why.unitSearch' => ({required Object digit, required Object unit}) => 'Шукаємо місце для ${digit} у ${unit}.',
			'why.solePosition' => ({required Object unit, required Object digit}) => 'Лише ця клітинка у ${unit} може містити ${digit}.',
			'why.placement' => ({required Object digit}) => 'Отже, тут стоїть ${digit}.',
			'why.unitRow' => ({required Object index}) => 'рядку ${index}',
			'why.unitColumn' => ({required Object index}) => 'стовпці ${index}',
			'why.unitBox' => ({required Object index}) => 'блоці ${index}',
			_ => null,
		};
	}
}
