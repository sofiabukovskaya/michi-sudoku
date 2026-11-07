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
	@override late final _Translations$coach$cs coach = _Translations$coach$cs._(_root);
	@override late final _Translations$why$cs why = _Translations$why$cs._(_root);
	@override late final _Translations$recommendation$cs recommendation = _Translations$recommendation$cs._(_root);
	@override late final _Translations$week$cs week = _Translations$week$cs._(_root);
	@override late final _Translations$settings$cs settings = _Translations$settings$cs._(_root);
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
	@override String get title => 'Najdi svou cestu logikou.';
	@override String get subtitle => 'Sudoku s průvodcem, který napoví, ale nevyřeší vše za tebe.';
	@override String get guest => 'Začít bez účtu';
}

// Path: onboarding
class _Translations$onboarding$cs extends Translations$onboarding$uk {
	_Translations$onboarding$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tady začíná tvoje učení.';
	@override String get chooseLevel => 'Vybrat úroveň';
	@override String get skip => 'Přeskočit';
	@override String get next => 'Dále';
	@override String get seeTitle => 'Sudoku je snazší, když víš, na co se dívat.';
	@override String get seeBody => 'MICHI vysvětluje logiku každého tahu.';
	@override String get hintsTitle => 'Nápovědy, které učí.';
	@override String get hintsBody => 'Začni jemnou nápovědou. O další požádej, když chceš.';
	@override String get patternsTitle => 'Uč se vzory, ne odpovědi.';
	@override String get patternsBody => 'Skryté jednotlivosti, dvojice, X-Wing — vlastním tempem.';
	@override String get pathTitle => 'Tvoje cesta sudoku.';
	@override String get pathBody => 'MICHI pozná, co je pro tebe těžké, a navrhne procvičení.';
}

// Path: playerLevel
class _Translations$playerLevel$cs extends Translations$playerLevel$uk {
	_Translations$playerLevel$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Jak dobře znáš sudoku?';
	@override String get goToGame => 'Začít hrát';
	@override String get subtitle => 'Podle toho vybereme první lekci a obtížnost. Změnit to můžeš kdykoli.';
	@override String get beginner => 'Teprve začínám';
	@override String get beginnerDetail => 'Pravidla a první tahy';
	@override String get basics => 'Znám základy';
	@override String get basicsDetail => 'Jednotlivá čísla a kandidáti';
	@override String get regular => 'Hraji pravidelně';
	@override String get regularDetail => 'Dvojice a ukazující dvojice';
	@override String get advanced => 'Chci výzvu';
	@override String get advancedDetail => 'X-Wing a dál';
}

// Path: auth
class _Translations$auth$cs extends Translations$auth$uk {
	_Translations$auth$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Účet';
	@override String get unavailable => 'Pokrok se ukládá v tomto zařízení.';
	@override String get apple => 'Pokračovat přes Apple';
	@override String get google => 'Pokračovat přes Google';
	@override String get emailEntry => 'Přihlásit se e-mailem';
	@override String get createTitle => 'Vytvořit účet';
	@override String get createSubtitle => 'Pokrok zůstává na tomto zařízení, dokud nebude dostupná synchronizace.';
	@override String get signInTitle => 'Vítejte zpět';
	@override String get name => 'Jméno';
	@override String get email => 'E-mail';
	@override String get password => 'Heslo';
	@override String get passwordHint => 'Alespoň 8 znaků';
	@override String get createAccount => 'Vytvořit účet';
	@override String get signIn => 'Přihlásit se';
	@override String get alreadyAccount => 'Máte už účet?';
	@override String get noAccount => 'Ještě nemáte účet?';
	@override String get forgotPassword => 'Zapomněli jste heslo?';
	@override String get resetTitle => 'Obnovení hesla';
	@override String get resetSubtitle => 'Zadejte e-mail účtu a pošleme vám odkaz pro obnovení.';
	@override String get sendLink => 'Poslat odkaz';
	@override String get resetSent => 'Pokud účet existuje, zkontrolujte e-mail s odkazem pro obnovení.';
	@override String get verifyTitle => 'Zkontrolujte e-mail';
	@override String verifySubtitle({required Object email}) => 'Poslali jsme ověřovací odkaz na ${email}.';
	@override String get checkVerification => 'Ověřil(a) jsem e-mail';
	@override String get resendVerification => 'Poslat odkaz znovu';
	@override String get verified => 'E-mail je ověřený.';
	@override String get notVerified => 'E-mail zatím není ověřený.';
	@override String get signOut => 'Odhlásit se';
	@override String get localNotSynced => 'Herní pokrok je stále uložený na tomto zařízení.';
	@override String get verifyEmail => 'Ověřit e-mail';
	@override String get errorInvalidEmail => 'Zadejte platnou e-mailovou adresu.';
	@override String get errorPasswordLength => 'Použijte alespoň 8 znaků.';
	@override String get errorNameRequired => 'Zadejte jméno.';
	@override String get errorWeakPassword => 'Toto heslo je příliš slabé.';
	@override String get errorEmailInUse => 'Účet s tímto e-mailem už existuje.';
	@override String get errorWrongCredentials => 'Zkontrolujte e-mail a heslo.';
	@override String get errorDisabled => 'Tento účet je zablokovaný.';
	@override String get errorTooMany => 'Příliš mnoho pokusů. Zkuste to později.';
	@override String get errorNetwork => 'Zkontrolujte připojení a zkuste to znovu.';
	@override String get errorUnavailable => 'Služba účtů není dostupná. Můžete dál hrát jako host.';
	@override String get errorUnexpected => 'Něco se pokazilo. Zkuste to znovu.';
	@override String get showPassword => 'Zobrazit heslo';
	@override String get hidePassword => 'Skrýt heslo';
	@override String get signOutTitle => 'Odhlásit se z účtu?';
	@override String get signOutBody => 'Místní hry zůstanou v tomto zařízení.';
	@override String get cancel => 'Zrušit';
}

// Path: home
class _Translations$home$cs extends Translations$home$uk {
	_Translations$home$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tvoje cesta sudoku';
	@override String get game => 'Hrát';
	@override String get continueGame => 'Pokračovat ve hře';
	@override String continueDetails({required Object date, required Object progress, required Object time}) => 'Začátek ${date} · ${progress} % · ${time}';
	@override String get replaceTitle => 'Začít nové sudoku?';
	@override String get replaceBody => 'Nedokončená hra bude nahrazena.';
	@override String get keepPlaying => 'Pokračovat ve hře';
	@override String get startNew => 'Začít nové';
	@override String get storageUnavailable => 'Uložená hra není dostupná. Zkus to později.';
	@override String get loading => 'Hledáme uloženou hru…';
	@override String get learn => 'Učení';
	@override String get progress => 'Pokrok';
	@override String get profile => 'Profil';
	@override String get scanner => 'Skener';
	@override String get chooseDifficulty => 'Vyberte obtížnost';
	@override String get easy => 'Lehká';
	@override String get medium => 'Střední';
	@override String get dailyTitle => 'Sudoku dne';
	@override String get dailyStart => 'Začít dnešní sudoku';
	@override String get dailyContinue => 'Pokračovat v dnešním sudoku';
	@override String get dailyCompleted => 'Dnes dokončeno';
	@override String get contentUnavailable => 'Úlohy nejsou dostupné. Zkuste to znovu.';
	@override String get advanced => 'Pokročilé';
	@override String get expert => 'Expertní';
	@override String get greeting => 'Dobré ráno';
	@override String get newPuzzle => 'Další sudoku';
	@override String get weekTitle => 'Tento týden';
	@override String get weekDetails => 'Podrobnosti';
	@override String get weekdaysShort => 'Po|Út|St|Čt|Pá|So|Ne';
	@override String get newPuzzleTitle => 'Nové sudoku';
	@override String get catalogSource => 'Vyber hlavolam';
	@override String get scanSource => 'Naskenovat sudoku';
	@override String get scanSourceDetail => 'Fotka nebo fotoaparát';
	@override String get weekStatusDone => 'Dokončeno';
	@override String get weekStatusToday => 'Dnes';
	@override String get weekStatusEmpty => 'Bez aktivity';
}

// Path: game
class _Translations$game$cs extends Translations$game$uk {
	_Translations$game$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Denní sudoku · Střední';
	@override String get undo => 'Zpět';
	@override String get erase => 'Smazat';
	@override String get notes => 'Poznámky';
	@override String get hint => 'Nápověda';
	@override String mistakes({required Object count}) => 'Chyby: ${count} ze 3';
	@override String get notesModeOn => 'Režim poznámek: čísla přepínají kandidáty';
	@override String get row => 'Řádek';
	@override String get column => 'sloupec';
	@override String get empty => 'prázdné';
	@override String get given => 'zadané';
	@override String get entered => 'vložené';
	@override String get selected => 'vybrané';
	@override String get error => 'chybné';
	@override String get candidates => 'kandidáti';
	@override String get completeTitle => 'Vyřešeno.';
	@override String get completeBody => 'Dokončili jste toto sudoku.';
	@override String get backHome => 'Zpět domů';
	@override String get pause => 'Pozastavit';
	@override String get pausedTitle => 'Pozastaveno';
	@override String get resume => 'Pokračovat';
	@override String pausedAt({required Object time}) => 'Čas se zastavil na ${time}';
	@override String get loading => 'Připravujeme sudoku…';
	@override String get restoreUnavailable => 'Hru se nepodařilo obnovit.';
	@override String get saveFailed => 'Hru se nepodařilo uložit.';
	@override String get retrySave => 'Zkusit znovu';
	@override String completionStats({required Object mistakes, required Object hints}) => '${mistakes} chyb · ${hints} nápověd';
	@override String get standardTitle => 'Sudoku';
	@override String get dailyTitle => 'Sudoku dne';
	@override String get completionLogic => 'vyřešená políčka';
	@override String get completionMistakes => 'chyby';
	@override String get completionHints => 'nápovědy';
	@override String get dailyStampEarned => 'Denní razítko získáno';
	@override String completionPracticeTechnique({required Object technique}) => 'Další krok: ${technique}';
}

// Path: learn
class _Translations$learn$cs extends Translations$learn$uk {
	_Translations$learn$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Učení';
	@override String get intro => 'Jedna technika, jeden jasný krok.';
	@override String get newLabel => 'Nové';
	@override String get learningLabel => 'Učím se';
	@override String get practicingLabel => 'Procvičuji';
	@override String get masteredLabel => 'Zvládnuto';
	@override String get planTitle => 'Plán lekce';
	@override String get lessonStart => 'Začít lekci';
	@override String get next => 'Dále';
	@override String get practiceStart => 'Začít cvičení';
	@override String get concept => 'Princip';
	@override String get lookFor => 'Čeho si všimnout';
	@override String get reasoning => 'Proč to funguje';
	@override String get example => 'Příklad';
	@override String get tryIt => 'Zkus to';
	@override String exercise({required Object current, required Object total}) => 'Úloha ${current} z ${total}';
	@override String get placementPrompt => 'Vyber políčko a číslici.';
	@override String get eliminationPrompt => 'Vyber políčko a označ všechny kandidáty k odstranění.';
	@override String get checkAnswer => 'Zkontrolovat';
	@override String get correctTitle => 'Správně';
	@override String get incorrectTitle => 'Ještě ne';
	@override String get tryAgain => 'Zkusit znovu';
	@override String get askMichi => 'Zeptat se MICHI';
	@override String get nextScenario => 'Další úloha';
	@override String get sessionSummary => 'Cvičení dokončeno';
	@override String summaryStats({required Object correct, required Object attempts}) => '${correct} správně · ${attempts} pokusů';
	@override String hintsUsed({required Object count}) => '${count} s MICHI';
	@override String get done => 'Hotovo';
	@override String get loading => 'Připravuji lekci…';
	@override String get unavailable => 'Výukový obsah není dostupný. Zkus to znovu.';
	@override String get noScenarios => 'Zatím nejsou dostupné žádné úlohy.';
	@override String get saveFailed => 'Pokrok se nepodařilo uložit. Zkus to znovu.';
	@override String get selectedForElimination => 'Označeno k odstranění';
	@override String get requiredTechniques => 'Techniky v tomto sudoku';
	@override String get helpedTechniques => 'MICHI pomohl s';
	@override String get noHints => 'Bez nápověd';
	@override String get practiceTitle => 'Cvičení';
	@override String get continueLesson => 'Pokračovat v lekci';
	@override late final _Translations$learn$lessons$cs lessons = _Translations$learn$lessons$cs._(_root);
	@override String get basicsGroup => 'Základy';
	@override String get intermediateGroup => 'Střední úroveň';
	@override String get advancedGroup => 'Pokročilá úroveň';
	@override String get nowLabel => 'Nyní';
	@override String groupProgress({required Object completed, required Object total}) => '${completed} z ${total}';
	@override String get extraElimination => 'Jeden vybraný kandidát se tímto vzorem neodstraňuje. Zkontroluj zvýrazněná pole.';
	@override String get missingElimination => 'Je třeba odstranit další kandidáty. Sleduj zvýrazněnou jednotku.';
	@override String get wrongPlacement => 'Toto pole nebo číslice neodpovídá závěru. Zkontroluj zvýrazněnou pozici.';
	@override String minutes({required Object count}) => '${count} min';
	@override String tasks({required Object count}) => '${count} úloh';
	@override String get wrongCell => 'Toto políčko není součástí vzoru. Podívej se na zvýrazněná políčka.';
	@override String get wrongDigit => 'Tuto číslici vzor neurčuje. Zkontroluj kandidáty ve zvýrazněném políčku.';
	@override String get wrongCellAndDigit => 'Výběr neodpovídá vzoru. Porovnej zvýrazněná políčka a jejich kandidáty.';
	@override String findTechnique({required Object technique}) => 'Najdi: ${technique}';
}

// Path: progress
class _Translations$progress$cs extends Translations$progress$uk {
	_Translations$progress$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get doingWell => 'Co ti jde';
	@override String get learningNow => 'Co se právě učíš';
	@override String get next => 'Další krok';
	@override String get noStrong => 'Nejsilnější techniky se ukážou po procvičování.';
	@override String get startLearning => 'Začít se učit';
	@override String get thisWeek => 'Tento týden';
	@override String completed({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('cs'))(n,
		one: '${n} dokončený hlavolam',
		few: '${n} dokončené hlavolamy',
		other: '${n} dokončených hlavolamů',
	);
	@override String mastery({required Object percent}) => 'Zvládnuto ${percent} %';
	@override String get openTechnique => 'Otevřít techniku';
}

// Path: profile
class _Translations$profile$cs extends Translations$profile$uk {
	_Translations$profile$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get guest => 'Host';
	@override String get localOnly => 'Postup se ukládá do tohoto zařízení.';
	@override String get puzzles => 'Hlavolamy';
	@override String get mastered => 'Zvládnuto';
	@override String get activeDays => 'Aktivní dny';
	@override String get learnRow => 'Učení';
	@override String get learnDetail => 'Techniky a cvičení';
	@override String get settingsRow => 'Nastavení';
	@override String get settingsDetail => 'Jazyk';
	@override String get activity => 'Tvoje aktivita';
}

// Path: scanner
class _Translations$scanner$cs extends Translations$scanner$uk {
	_Translations$scanner$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Skenovat sudoku';
	@override String get intro => 'Zaberte celou mřížku, vyfoťte ji nebo vyberte snímek.';
	@override String get openCamera => 'Použít fotoaparát';
	@override String get choosePhoto => 'Vybrat fotku';
	@override String get shutter => 'Vyfotit';
	@override String get frameGuide => 'Nechte všechny čtyři rohy v záběru.';
	@override String get processing => 'Čteme vaše sudoku…';
	@override String get reviewTitle => 'Zkontrolujte číslice';
	@override String get reviewBody => 'Klepnutím na políčko jej před hrou opravíte.';
	@override String get needsReview => 'Vyžaduje kontrolu';
	@override String get conflict => 'Číslice v konfliktu';
	@override String get selected => 'vybráno';
	@override String get recognized => 'rozpoznáno';
	@override String get empty => 'prázdné';
	@override String get clear => 'Vymazat';
	@override String get confirm => 'Importovat sudoku';
	@override String get rescan => 'Skenovat znovu';
	@override String get permissionIntro => 'Pro pořízení snímku povolte fotoaparát.';
	@override String get permissionDenied => 'Přístup k fotoaparátu byl zamítnut. Můžete vybrat fotku.';
	@override String get permissionSettings => 'Povolte fotoaparát v Nastavení nebo vyberte fotku.';
	@override String get noCamera => 'Fotoaparát není dostupný. Vyberte fotku.';
	@override String get openSettings => 'Otevřít Nastavení';
	@override String get imageDecodeFailure => 'Obrázek se nepodařilo přečíst. Zkuste jinou fotku.';
	@override String get noGridFound => 'Mřížka sudoku nebyla nalezena. Zaberte ji celou.';
	@override String get invalidGeometry => 'Mřížku se nepodařilo narovnat. Zkuste ostřejší fotku.';
	@override String get segmentationFailure => 'Mřížku se nepodařilo rozdělit na políčka. Zkuste to znovu.';
	@override String get recognitionFailure => 'Některé číslice se nepodařilo přečíst. Zkuste to znovu.';
	@override String get duplicateClues => 'Opravte zvýrazněné konfliktní číslice.';
	@override String get noSolution => 'Tyto číslice nemají řešení. Zkontrolujte je.';
	@override String get multipleSolutions => 'Některé číslice mohou chybět; sudoku má více řešení.';
	@override String get storageFailure => 'Importované sudoku se nepodařilo uložit. Zkuste to znovu.';
	@override String get validationFailure => 'Tuto úlohu se nepodařilo ověřit. Zkuste ji potvrdit znovu.';
	@override String get unsupportedCoach => 'MICHI zatím nemusí umět vysvětlit každý krok tohoto sudoku.';
	@override String get importedTitle => 'Importované sudoku';
	@override String lowConfidenceCount({required Object count}) => 'Políčka ke kontrole: ${count}';
}

// Path: coach
class _Translations$coach$cs extends Translations$coach$uk {
	_Translations$coach$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String step({required Object step}) => 'Nápověda ${step} ze 4';
	@override String get kTry => 'Zkusím to';
	@override String get show => 'Ukázat';
	@override String get see => 'Vidím';
	@override String get more => 'Další nápověda';
	@override String get close => 'Zavřít';
	@override String get showMistake => 'Ukázat chybu';
	@override String place({required Object digit}) => 'Vložit ${digit}';
	@override String unitRow({required Object index}) => 'řádek ${index}';
	@override String unitColumn({required Object index}) => 'sloupec ${index}';
	@override String unitBox({required Object index}) => 'blok ${index}';
	@override String get inspectCell => 'Podívejte se na zvýrazněné pole.';
	@override String inspectUnit({required Object unit}) => 'Podívejte se na zvýrazněný ${unit}.';
	@override String get inspectCandidates => 'Které číslice sem mohou patřit?';
	@override String inspectPositions({required Object unit}) => 'Kam může tato číslice patřit ve zvýrazněném ${unit}?';
	@override String get inspectPair => 'Najděte dvě pole se stejnými dvěma kandidáty.';
	@override String get singleRemains => 'V tomto poli zbývá jediný kandidát.';
	@override String onlyPosition({required Object unit}) => 'Pro tuto číslici zbývá v ${unit} jediné místo.';
	@override String pairRestriction({required Object unit}) => 'Tyto dvě číslice patří do zvýrazněné dvojice. Jinde v ${unit} je lze vyloučit.';
	@override String get alignment => 'Kandidáti leží v jedné linii, takže číslici lze vyloučit mimo blok.';
	@override String resultPlacement({required Object digit}) => '${digit} patří jen do zvýrazněného pole.';
	@override String get resultEliminations => 'Odstraňte přeškrtnuté kandidáty ze zvýrazněných polí.';
	@override String get resultActions => 'Použijte zvýrazněný logický krok.';
	@override String technique({required Object name}) => 'Technika: ${name}';
	@override String get nakedSingle => 'nahý singl';
	@override String get hiddenSingle => 'skrytý singl';
	@override String get nakedPair => 'nahá dvojice';
	@override String get pointingPair => 'ukazující dvojice';
	@override String get unavailable => 'Nápověda není dostupná';
	@override String get wrongTitle => 'Nejdřív opravte chybu.';
	@override String get wrongBody => 'Dokud je na desce chybná číslice, nelze určit logický další krok.';
	@override String get stuckTitle => 'Zatím žádný podporovaný krok.';
	@override String get stuckBody => 'MICHI zatím neumí vysvětlit další krok dostupnými technikami.';
	@override String get hiddenPair => 'Skrytá dvojice';
	@override String get boxLineReduction => 'Redukce řádek–blok';
	@override String get nakedTriple => 'Otevřená trojice';
	@override String get xWing => 'X-Wing';
	@override String get identifyHiddenPair => 'Dvě číslice jsou možné jen ve stejných dvou polích. Odstraň ostatní kandidáty.';
	@override String get understandBoxLine => 'Číslice je v řádku omezena na jeden blok. Odstraň ji jinde v bloku.';
	@override String get understandTriple => 'Tři pole sdílejí přesně tři číslice. Odstraň je z dalších polí jednotky.';
	@override String get understandXWing => 'Ve dvou řádcích má číslice stejné dva průsečíky. Odstraň ji jinde v protínajících řádcích.';
}

// Path: why
class _Translations$why$cs extends Translations$why$uk {
	_Translations$why$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vysvětlení';
	@override String whyHere({required Object digit}) => 'Proč sem patří ${digit}?';
	@override String get givenTitle => 'Toto je zadaná číslice';
	@override String get givenBody => 'Byla na desce od začátku, takže není třeba vysvětlovat její odvození. Vysvětlení jsou dostupná pro číslice, které umístíš sám.';
	@override String get unavailableTitle => 'Přímé vysvětlení zatím není';
	@override String get unavailableBody => 'MICHI nedokáže tento tah odůvodnit podporovanou technikou ve stavu před tahem.';
	@override String get lesson => 'Lekce';
	@override String get gotIt => 'Rozumím';
	@override String unitRestrictions({required Object unit, required Object digits}) => 'V ${unit} již jsou číslice: ${digits}.';
	@override String onlyCandidate({required Object digit}) => 'Řádek, sloupec a blok vylučují ostatní číslice. Sem patří jen ${digit}.';
	@override String unitSearch({required Object digit, required Object unit}) => 'Hledáme místo pro ${digit} v ${unit}.';
	@override String solePosition({required Object digit, required Object unit}) => 'Přeškrtnuté ${digit} ukazují, kam v ${unit} číslice nemůže. Zbývá jediné políčko.';
	@override String placement({required Object digit}) => 'Proto sem patří ${digit}.';
	@override String unitRow({required Object index}) => 'řádku ${index}';
	@override String unitColumn({required Object index}) => 'sloupci ${index}';
	@override String unitBox({required Object index}) => 'bloku ${index}';
}

// Path: recommendation
class _Translations$recommendation$cs extends Translations$recommendation$uk {
	_Translations$recommendation$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String focusTitle({required Object technique}) => 'Dnešní zaměření: ${technique}';
	@override String learnAction({required Object technique}) => 'Naučit se: ${technique}';
	@override String practiceAction({required Object technique}) => 'Procvičit: ${technique}';
	@override String reviewAction({required Object technique}) => 'Zopakovat: ${technique}';
	@override String duration({required Object minutes}) => '${minutes} min';
	@override String get startWithBasics => 'Začněte prvním logickým krokem.';
	@override String get repeatedCoachHelp => 'Nedávno jste potřebovali pomoc MICHI.';
	@override String get weakIndependentPractice => 'Samostatné řešení chce ještě procvičit.';
	@override String get continuePractice => 'Pokračujte v procvičování této techniky.';
	@override String get nextTechnique => 'Další krok na vaší cestě.';
	@override String get masteredNeedsReview => 'Známou techniku je dobré zopakovat.';
	@override String get allMasteredReview => 'Zopakujte si zvládnutou techniku.';
}

// Path: week
class _Translations$week$cs extends Translations$week$uk {
	_Translations$week$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tento týden';
	@override String get empty => 'Tento týden zatím nemáš dokončené sudoku. Aktivita se objeví při hraní.';
	@override String get puzzles => 'Hlavolamy';
	@override String get minutes => 'Minuty';
	@override String get daily => 'Denní';
	@override String activeDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('cs'))(n,
		one: '${n} aktivní den',
		few: '${n} aktivní dny',
		other: '${n} aktivních dní',
	);
	@override String completedDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('cs'))(n,
		one: '${n} dokončený hlavolam',
		few: '${n} dokončené hlavolamy',
		other: '${n} dokončených hlavolamů',
	);
	@override String get today => 'Dnes';
	@override String get noActivity => 'Bez aktivity';
	@override String get summary => 'Tvoje místní aktivita v sudoku';
}

// Path: settings
class _Translations$settings$cs extends Translations$settings$uk {
	_Translations$settings$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nastavení';
	@override String get language => 'Jazyk';
	@override String get languageDetail => 'Vyber jazyk aplikace MICHI.';
}

// Path: learn.lessons
class _Translations$learn$lessons$cs extends Translations$learn$lessons$uk {
	_Translations$learn$lessons$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learn$lessons$nakedSingle$cs nakedSingle = _Translations$learn$lessons$nakedSingle$cs._(_root);
	@override late final _Translations$learn$lessons$hiddenSingle$cs hiddenSingle = _Translations$learn$lessons$hiddenSingle$cs._(_root);
	@override late final _Translations$learn$lessons$nakedPair$cs nakedPair = _Translations$learn$lessons$nakedPair$cs._(_root);
	@override late final _Translations$learn$lessons$pointingPair$cs pointingPair = _Translations$learn$lessons$pointingPair$cs._(_root);
	@override late final _Translations$learn$lessons$hiddenPair$cs hiddenPair = _Translations$learn$lessons$hiddenPair$cs._(_root);
	@override late final _Translations$learn$lessons$boxLineReduction$cs boxLineReduction = _Translations$learn$lessons$boxLineReduction$cs._(_root);
	@override late final _Translations$learn$lessons$nakedTriple$cs nakedTriple = _Translations$learn$lessons$nakedTriple$cs._(_root);
	@override late final _Translations$learn$lessons$xWing$cs xWing = _Translations$learn$lessons$xWing$cs._(_root);
}

// Path: learn.lessons.nakedSingle
class _Translations$learn$lessons$nakedSingle$cs extends Translations$learn$lessons$nakedSingle$uk {
	_Translations$learn$lessons$nakedSingle$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'V prázdném políčku zbývá jediná možná číslice.';
	@override String get concept => 'Kandidáti jsou číslice, které ještě mohou do prázdného políčka.';
	@override String get lookFor => 'Najdi políčko, v němž řádek, sloupec a blok vyloučí vše kromě jedné číslice.';
	@override String get reasoning => 'Zbývá jeden kandidát, proto patří právě sem.';
	@override String get example => 'Ve zvýrazněném políčku zbývá jediný kandidát.';
	@override String get tryIt => 'Vyber políčko a dosaď zbývající číslici.';
}

// Path: learn.lessons.hiddenSingle
class _Translations$learn$lessons$hiddenSingle$cs extends Translations$learn$lessons$hiddenSingle$uk {
	_Translations$learn$lessons$hiddenSingle$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Číslice má v řádku, sloupci nebo bloku jediné možné místo.';
	@override String get concept => 'Sleduj jednu číslici v celé skupině, ne všechny kandidáty jednoho políčka.';
	@override String get lookFor => 'Najdi jediné prázdné místo, kam číslice ještě může patřit.';
	@override String get reasoning => 'Políčko může mít více kandidátů, ale tato číslice má ve skupině jediný domov.';
	@override String get example => 'Ve zvýrazněné skupině zbývá jediné místo pro danou číslici.';
	@override String get tryIt => 'Vyber jediné místo a dosaď číslici.';
}

// Path: learn.lessons.nakedPair
class _Translations$learn$lessons$nakedPair$cs extends Translations$learn$lessons$nakedPair$uk {
	_Translations$learn$lessons$nakedPair$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dvě políčka ve skupině mají stejnou dvojici kandidátů.';
	@override String get concept => 'Dvojice si tyto dvě číslice vyhrazuje.';
	@override String get lookFor => 'Najdi dvě políčka ve stejné skupině se stejnými dvěma kandidáty.';
	@override String get reasoning => 'Tyto číslice už nemohou být jinde ve skupině, proto je tam odstraň.';
	@override String get example => 'Zvýrazněná dvojice odstraňuje kandidáty z dalších políček.';
	@override String get tryIt => 'Označ všechny kandidáty k odstranění. Zatím nic nedosazuj.';
}

// Path: learn.lessons.pointingPair
class _Translations$learn$lessons$pointingPair$cs extends Translations$learn$lessons$pointingPair$uk {
	_Translations$learn$lessons$pointingPair$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dvě pozice kandidáta v bloku leží na stejném řádku či sloupci.';
	@override String get concept => 'Blok může číslici omezit na jednu linii.';
	@override String get lookFor => 'Najdi právě dvě pozice pro číslici v bloku na společné linii.';
	@override String get reasoning => 'Číslice zůstane v bloku, proto ji odstraň mimo blok na stejné linii.';
	@override String get example => 'Sleduj zvýrazněnou linii mimo blok.';
	@override String get tryIt => 'Označ všechny kandidáty odstraněné mimo blok.';
}

// Path: learn.lessons.hiddenPair
class _Translations$learn$lessons$hiddenPair$cs extends Translations$learn$lessons$hiddenPair$uk {
	_Translations$learn$lessons$hiddenPair$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dvě číslice se skrývají ve stejných dvou polích.';
	@override String get concept => 'Skrytou dvojici najdeš sledováním číslic, ne shodných kandidátů.';
	@override String get lookFor => 'Najdi dvě číslice, které se v jednotce vyskytují jen ve stejných dvou polích.';
	@override String get reasoning => 'Obě číslice patří do těchto polí; ostatní kandidáti mohou pryč.';
	@override String get example => 'Zvýrazněná pole jsou jediná místa pro obě číslice.';
	@override String get tryIt => 'Odstraň nadbytečné kandidáty z těchto dvou polí.';
}

// Path: learn.lessons.boxLineReduction
class _Translations$learn$lessons$boxLineReduction$cs extends Translations$learn$lessons$boxLineReduction$uk {
	_Translations$learn$lessons$boxLineReduction$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Řádek či sloupec omezuje číslici na jeden blok.';
	@override String get concept => 'Řádek může uzamknout číslici v bloku.';
	@override String get lookFor => 'Najdi dvě nebo tři pozice číslice v jednom řádku, všechny v jednom bloku.';
	@override String get reasoning => 'Číslice musí být v bloku na tomto řádku; jinde v bloku ji odstraň.';
	@override String get example => 'Sleduj zvýrazněný řádek do bloku a najdi kandidáty mimo něj.';
	@override String get tryIt => 'Odstraň číslici z ostatních polí bloku.';
}

// Path: learn.lessons.nakedTriple
class _Translations$learn$lessons$nakedTriple$cs extends Translations$learn$lessons$nakedTriple$uk {
	_Translations$learn$lessons$nakedTriple$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Tři pole sdílejí pouze tři možné číslice.';
	@override String get concept => 'Trojice rezervuje tři číslice pro tři pole v jednotce.';
	@override String get lookFor => 'Najdi tři pole, jejichž kandidáti dohromady tvoří přesně tři číslice.';
	@override String get reasoning => 'Tři číslice tato pole obsadí, i když se jejich kandidáti liší.';
	@override String get example => 'Zvýrazněná pole mají různé dvojice, ale dohromady tři číslice.';
	@override String get tryIt => 'Odstraň tyto číslice z ostatních polí jednotky.';
}

// Path: learn.lessons.xWing
class _Translations$learn$lessons$xWing$cs extends Translations$learn$lessons$xWing$uk {
	_Translations$learn$lessons$xWing$cs._(TranslationsCs root) : this._root = root, super.internal(root);

	final TranslationsCs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dva řádky mají číslici ve stejných dvou průsečících.';
	@override String get concept => 'X-Wing spojuje dva řádky nebo sloupce jednou číslicí.';
	@override String get lookFor => 'Najdi dva řádky, kde je číslice právě dvakrát ve stejných pozicích.';
	@override String get reasoning => 'Čtyři průsečíky rezervují číslici; jinde na protínajících řádcích ji odstraň.';
	@override String get example => 'Sleduj čtyři zvýrazněné pozice a dva protínající řádky.';
	@override String get tryIt => 'Odstraň číslici mimo čtyři pole vzoru.';
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
			'welcome.title' => 'Najdi svou cestu logikou.',
			'welcome.subtitle' => 'Sudoku s průvodcem, který napoví, ale nevyřeší vše za tebe.',
			'welcome.guest' => 'Začít bez účtu',
			'onboarding.title' => 'Tady začíná tvoje učení.',
			'onboarding.chooseLevel' => 'Vybrat úroveň',
			'onboarding.skip' => 'Přeskočit',
			'onboarding.next' => 'Dále',
			'onboarding.seeTitle' => 'Sudoku je snazší, když víš, na co se dívat.',
			'onboarding.seeBody' => 'MICHI vysvětluje logiku každého tahu.',
			'onboarding.hintsTitle' => 'Nápovědy, které učí.',
			'onboarding.hintsBody' => 'Začni jemnou nápovědou. O další požádej, když chceš.',
			'onboarding.patternsTitle' => 'Uč se vzory, ne odpovědi.',
			'onboarding.patternsBody' => 'Skryté jednotlivosti, dvojice, X-Wing — vlastním tempem.',
			'onboarding.pathTitle' => 'Tvoje cesta sudoku.',
			'onboarding.pathBody' => 'MICHI pozná, co je pro tebe těžké, a navrhne procvičení.',
			'playerLevel.title' => 'Jak dobře znáš sudoku?',
			'playerLevel.goToGame' => 'Začít hrát',
			'playerLevel.subtitle' => 'Podle toho vybereme první lekci a obtížnost. Změnit to můžeš kdykoli.',
			'playerLevel.beginner' => 'Teprve začínám',
			'playerLevel.beginnerDetail' => 'Pravidla a první tahy',
			'playerLevel.basics' => 'Znám základy',
			'playerLevel.basicsDetail' => 'Jednotlivá čísla a kandidáti',
			'playerLevel.regular' => 'Hraji pravidelně',
			'playerLevel.regularDetail' => 'Dvojice a ukazující dvojice',
			'playerLevel.advanced' => 'Chci výzvu',
			'playerLevel.advancedDetail' => 'X-Wing a dál',
			'auth.title' => 'Účet',
			'auth.unavailable' => 'Pokrok se ukládá v tomto zařízení.',
			'auth.apple' => 'Pokračovat přes Apple',
			'auth.google' => 'Pokračovat přes Google',
			'auth.emailEntry' => 'Přihlásit se e-mailem',
			'auth.createTitle' => 'Vytvořit účet',
			'auth.createSubtitle' => 'Pokrok zůstává na tomto zařízení, dokud nebude dostupná synchronizace.',
			'auth.signInTitle' => 'Vítejte zpět',
			'auth.name' => 'Jméno',
			'auth.email' => 'E-mail',
			'auth.password' => 'Heslo',
			'auth.passwordHint' => 'Alespoň 8 znaků',
			'auth.createAccount' => 'Vytvořit účet',
			'auth.signIn' => 'Přihlásit se',
			'auth.alreadyAccount' => 'Máte už účet?',
			'auth.noAccount' => 'Ještě nemáte účet?',
			'auth.forgotPassword' => 'Zapomněli jste heslo?',
			'auth.resetTitle' => 'Obnovení hesla',
			'auth.resetSubtitle' => 'Zadejte e-mail účtu a pošleme vám odkaz pro obnovení.',
			'auth.sendLink' => 'Poslat odkaz',
			'auth.resetSent' => 'Pokud účet existuje, zkontrolujte e-mail s odkazem pro obnovení.',
			'auth.verifyTitle' => 'Zkontrolujte e-mail',
			'auth.verifySubtitle' => ({required Object email}) => 'Poslali jsme ověřovací odkaz na ${email}.',
			'auth.checkVerification' => 'Ověřil(a) jsem e-mail',
			'auth.resendVerification' => 'Poslat odkaz znovu',
			'auth.verified' => 'E-mail je ověřený.',
			'auth.notVerified' => 'E-mail zatím není ověřený.',
			'auth.signOut' => 'Odhlásit se',
			'auth.localNotSynced' => 'Herní pokrok je stále uložený na tomto zařízení.',
			'auth.verifyEmail' => 'Ověřit e-mail',
			'auth.errorInvalidEmail' => 'Zadejte platnou e-mailovou adresu.',
			'auth.errorPasswordLength' => 'Použijte alespoň 8 znaků.',
			'auth.errorNameRequired' => 'Zadejte jméno.',
			'auth.errorWeakPassword' => 'Toto heslo je příliš slabé.',
			'auth.errorEmailInUse' => 'Účet s tímto e-mailem už existuje.',
			'auth.errorWrongCredentials' => 'Zkontrolujte e-mail a heslo.',
			'auth.errorDisabled' => 'Tento účet je zablokovaný.',
			'auth.errorTooMany' => 'Příliš mnoho pokusů. Zkuste to později.',
			'auth.errorNetwork' => 'Zkontrolujte připojení a zkuste to znovu.',
			'auth.errorUnavailable' => 'Služba účtů není dostupná. Můžete dál hrát jako host.',
			'auth.errorUnexpected' => 'Něco se pokazilo. Zkuste to znovu.',
			'auth.showPassword' => 'Zobrazit heslo',
			'auth.hidePassword' => 'Skrýt heslo',
			'auth.signOutTitle' => 'Odhlásit se z účtu?',
			'auth.signOutBody' => 'Místní hry zůstanou v tomto zařízení.',
			'auth.cancel' => 'Zrušit',
			'home.title' => 'Tvoje cesta sudoku',
			'home.game' => 'Hrát',
			'home.continueGame' => 'Pokračovat ve hře',
			'home.continueDetails' => ({required Object date, required Object progress, required Object time}) => 'Začátek ${date} · ${progress} % · ${time}',
			'home.replaceTitle' => 'Začít nové sudoku?',
			'home.replaceBody' => 'Nedokončená hra bude nahrazena.',
			'home.keepPlaying' => 'Pokračovat ve hře',
			'home.startNew' => 'Začít nové',
			'home.storageUnavailable' => 'Uložená hra není dostupná. Zkus to později.',
			'home.loading' => 'Hledáme uloženou hru…',
			'home.learn' => 'Učení',
			'home.progress' => 'Pokrok',
			'home.profile' => 'Profil',
			'home.scanner' => 'Skener',
			'home.chooseDifficulty' => 'Vyberte obtížnost',
			'home.easy' => 'Lehká',
			'home.medium' => 'Střední',
			'home.dailyTitle' => 'Sudoku dne',
			'home.dailyStart' => 'Začít dnešní sudoku',
			'home.dailyContinue' => 'Pokračovat v dnešním sudoku',
			'home.dailyCompleted' => 'Dnes dokončeno',
			'home.contentUnavailable' => 'Úlohy nejsou dostupné. Zkuste to znovu.',
			'home.advanced' => 'Pokročilé',
			'home.expert' => 'Expertní',
			'home.greeting' => 'Dobré ráno',
			'home.newPuzzle' => 'Další sudoku',
			'home.weekTitle' => 'Tento týden',
			'home.weekDetails' => 'Podrobnosti',
			'home.weekdaysShort' => 'Po|Út|St|Čt|Pá|So|Ne',
			'home.newPuzzleTitle' => 'Nové sudoku',
			'home.catalogSource' => 'Vyber hlavolam',
			'home.scanSource' => 'Naskenovat sudoku',
			'home.scanSourceDetail' => 'Fotka nebo fotoaparát',
			'home.weekStatusDone' => 'Dokončeno',
			'home.weekStatusToday' => 'Dnes',
			'home.weekStatusEmpty' => 'Bez aktivity',
			'game.title' => 'Denní sudoku · Střední',
			'game.undo' => 'Zpět',
			'game.erase' => 'Smazat',
			'game.notes' => 'Poznámky',
			'game.hint' => 'Nápověda',
			'game.mistakes' => ({required Object count}) => 'Chyby: ${count} ze 3',
			'game.notesModeOn' => 'Režim poznámek: čísla přepínají kandidáty',
			'game.row' => 'Řádek',
			'game.column' => 'sloupec',
			'game.empty' => 'prázdné',
			'game.given' => 'zadané',
			'game.entered' => 'vložené',
			'game.selected' => 'vybrané',
			'game.error' => 'chybné',
			'game.candidates' => 'kandidáti',
			'game.completeTitle' => 'Vyřešeno.',
			'game.completeBody' => 'Dokončili jste toto sudoku.',
			'game.backHome' => 'Zpět domů',
			'game.pause' => 'Pozastavit',
			'game.pausedTitle' => 'Pozastaveno',
			'game.resume' => 'Pokračovat',
			'game.pausedAt' => ({required Object time}) => 'Čas se zastavil na ${time}',
			'game.loading' => 'Připravujeme sudoku…',
			'game.restoreUnavailable' => 'Hru se nepodařilo obnovit.',
			'game.saveFailed' => 'Hru se nepodařilo uložit.',
			'game.retrySave' => 'Zkusit znovu',
			'game.completionStats' => ({required Object mistakes, required Object hints}) => '${mistakes} chyb · ${hints} nápověd',
			'game.standardTitle' => 'Sudoku',
			'game.dailyTitle' => 'Sudoku dne',
			'game.completionLogic' => 'vyřešená políčka',
			'game.completionMistakes' => 'chyby',
			'game.completionHints' => 'nápovědy',
			'game.dailyStampEarned' => 'Denní razítko získáno',
			'game.completionPracticeTechnique' => ({required Object technique}) => 'Další krok: ${technique}',
			'learn.title' => 'Učení',
			'learn.intro' => 'Jedna technika, jeden jasný krok.',
			'learn.newLabel' => 'Nové',
			'learn.learningLabel' => 'Učím se',
			'learn.practicingLabel' => 'Procvičuji',
			'learn.masteredLabel' => 'Zvládnuto',
			'learn.planTitle' => 'Plán lekce',
			'learn.lessonStart' => 'Začít lekci',
			'learn.next' => 'Dále',
			'learn.practiceStart' => 'Začít cvičení',
			'learn.concept' => 'Princip',
			'learn.lookFor' => 'Čeho si všimnout',
			'learn.reasoning' => 'Proč to funguje',
			'learn.example' => 'Příklad',
			'learn.tryIt' => 'Zkus to',
			'learn.exercise' => ({required Object current, required Object total}) => 'Úloha ${current} z ${total}',
			'learn.placementPrompt' => 'Vyber políčko a číslici.',
			'learn.eliminationPrompt' => 'Vyber políčko a označ všechny kandidáty k odstranění.',
			'learn.checkAnswer' => 'Zkontrolovat',
			'learn.correctTitle' => 'Správně',
			'learn.incorrectTitle' => 'Ještě ne',
			'learn.tryAgain' => 'Zkusit znovu',
			'learn.askMichi' => 'Zeptat se MICHI',
			'learn.nextScenario' => 'Další úloha',
			'learn.sessionSummary' => 'Cvičení dokončeno',
			'learn.summaryStats' => ({required Object correct, required Object attempts}) => '${correct} správně · ${attempts} pokusů',
			'learn.hintsUsed' => ({required Object count}) => '${count} s MICHI',
			'learn.done' => 'Hotovo',
			'learn.loading' => 'Připravuji lekci…',
			'learn.unavailable' => 'Výukový obsah není dostupný. Zkus to znovu.',
			'learn.noScenarios' => 'Zatím nejsou dostupné žádné úlohy.',
			'learn.saveFailed' => 'Pokrok se nepodařilo uložit. Zkus to znovu.',
			'learn.selectedForElimination' => 'Označeno k odstranění',
			'learn.requiredTechniques' => 'Techniky v tomto sudoku',
			'learn.helpedTechniques' => 'MICHI pomohl s',
			'learn.noHints' => 'Bez nápověd',
			'learn.practiceTitle' => 'Cvičení',
			'learn.continueLesson' => 'Pokračovat v lekci',
			'learn.lessons.nakedSingle.description' => 'V prázdném políčku zbývá jediná možná číslice.',
			'learn.lessons.nakedSingle.concept' => 'Kandidáti jsou číslice, které ještě mohou do prázdného políčka.',
			'learn.lessons.nakedSingle.lookFor' => 'Najdi políčko, v němž řádek, sloupec a blok vyloučí vše kromě jedné číslice.',
			'learn.lessons.nakedSingle.reasoning' => 'Zbývá jeden kandidát, proto patří právě sem.',
			'learn.lessons.nakedSingle.example' => 'Ve zvýrazněném políčku zbývá jediný kandidát.',
			'learn.lessons.nakedSingle.tryIt' => 'Vyber políčko a dosaď zbývající číslici.',
			'learn.lessons.hiddenSingle.description' => 'Číslice má v řádku, sloupci nebo bloku jediné možné místo.',
			'learn.lessons.hiddenSingle.concept' => 'Sleduj jednu číslici v celé skupině, ne všechny kandidáty jednoho políčka.',
			'learn.lessons.hiddenSingle.lookFor' => 'Najdi jediné prázdné místo, kam číslice ještě může patřit.',
			'learn.lessons.hiddenSingle.reasoning' => 'Políčko může mít více kandidátů, ale tato číslice má ve skupině jediný domov.',
			'learn.lessons.hiddenSingle.example' => 'Ve zvýrazněné skupině zbývá jediné místo pro danou číslici.',
			'learn.lessons.hiddenSingle.tryIt' => 'Vyber jediné místo a dosaď číslici.',
			'learn.lessons.nakedPair.description' => 'Dvě políčka ve skupině mají stejnou dvojici kandidátů.',
			'learn.lessons.nakedPair.concept' => 'Dvojice si tyto dvě číslice vyhrazuje.',
			'learn.lessons.nakedPair.lookFor' => 'Najdi dvě políčka ve stejné skupině se stejnými dvěma kandidáty.',
			'learn.lessons.nakedPair.reasoning' => 'Tyto číslice už nemohou být jinde ve skupině, proto je tam odstraň.',
			'learn.lessons.nakedPair.example' => 'Zvýrazněná dvojice odstraňuje kandidáty z dalších políček.',
			'learn.lessons.nakedPair.tryIt' => 'Označ všechny kandidáty k odstranění. Zatím nic nedosazuj.',
			'learn.lessons.pointingPair.description' => 'Dvě pozice kandidáta v bloku leží na stejném řádku či sloupci.',
			'learn.lessons.pointingPair.concept' => 'Blok může číslici omezit na jednu linii.',
			'learn.lessons.pointingPair.lookFor' => 'Najdi právě dvě pozice pro číslici v bloku na společné linii.',
			'learn.lessons.pointingPair.reasoning' => 'Číslice zůstane v bloku, proto ji odstraň mimo blok na stejné linii.',
			'learn.lessons.pointingPair.example' => 'Sleduj zvýrazněnou linii mimo blok.',
			'learn.lessons.pointingPair.tryIt' => 'Označ všechny kandidáty odstraněné mimo blok.',
			'learn.lessons.hiddenPair.description' => 'Dvě číslice se skrývají ve stejných dvou polích.',
			'learn.lessons.hiddenPair.concept' => 'Skrytou dvojici najdeš sledováním číslic, ne shodných kandidátů.',
			'learn.lessons.hiddenPair.lookFor' => 'Najdi dvě číslice, které se v jednotce vyskytují jen ve stejných dvou polích.',
			'learn.lessons.hiddenPair.reasoning' => 'Obě číslice patří do těchto polí; ostatní kandidáti mohou pryč.',
			'learn.lessons.hiddenPair.example' => 'Zvýrazněná pole jsou jediná místa pro obě číslice.',
			'learn.lessons.hiddenPair.tryIt' => 'Odstraň nadbytečné kandidáty z těchto dvou polí.',
			'learn.lessons.boxLineReduction.description' => 'Řádek či sloupec omezuje číslici na jeden blok.',
			'learn.lessons.boxLineReduction.concept' => 'Řádek může uzamknout číslici v bloku.',
			'learn.lessons.boxLineReduction.lookFor' => 'Najdi dvě nebo tři pozice číslice v jednom řádku, všechny v jednom bloku.',
			'learn.lessons.boxLineReduction.reasoning' => 'Číslice musí být v bloku na tomto řádku; jinde v bloku ji odstraň.',
			'learn.lessons.boxLineReduction.example' => 'Sleduj zvýrazněný řádek do bloku a najdi kandidáty mimo něj.',
			'learn.lessons.boxLineReduction.tryIt' => 'Odstraň číslici z ostatních polí bloku.',
			'learn.lessons.nakedTriple.description' => 'Tři pole sdílejí pouze tři možné číslice.',
			'learn.lessons.nakedTriple.concept' => 'Trojice rezervuje tři číslice pro tři pole v jednotce.',
			'learn.lessons.nakedTriple.lookFor' => 'Najdi tři pole, jejichž kandidáti dohromady tvoří přesně tři číslice.',
			'learn.lessons.nakedTriple.reasoning' => 'Tři číslice tato pole obsadí, i když se jejich kandidáti liší.',
			'learn.lessons.nakedTriple.example' => 'Zvýrazněná pole mají různé dvojice, ale dohromady tři číslice.',
			'learn.lessons.nakedTriple.tryIt' => 'Odstraň tyto číslice z ostatních polí jednotky.',
			'learn.lessons.xWing.description' => 'Dva řádky mají číslici ve stejných dvou průsečících.',
			'learn.lessons.xWing.concept' => 'X-Wing spojuje dva řádky nebo sloupce jednou číslicí.',
			'learn.lessons.xWing.lookFor' => 'Najdi dva řádky, kde je číslice právě dvakrát ve stejných pozicích.',
			'learn.lessons.xWing.reasoning' => 'Čtyři průsečíky rezervují číslici; jinde na protínajících řádcích ji odstraň.',
			'learn.lessons.xWing.example' => 'Sleduj čtyři zvýrazněné pozice a dva protínající řádky.',
			'learn.lessons.xWing.tryIt' => 'Odstraň číslici mimo čtyři pole vzoru.',
			'learn.basicsGroup' => 'Základy',
			'learn.intermediateGroup' => 'Střední úroveň',
			'learn.advancedGroup' => 'Pokročilá úroveň',
			'learn.nowLabel' => 'Nyní',
			'learn.groupProgress' => ({required Object completed, required Object total}) => '${completed} z ${total}',
			'learn.extraElimination' => 'Jeden vybraný kandidát se tímto vzorem neodstraňuje. Zkontroluj zvýrazněná pole.',
			'learn.missingElimination' => 'Je třeba odstranit další kandidáty. Sleduj zvýrazněnou jednotku.',
			'learn.wrongPlacement' => 'Toto pole nebo číslice neodpovídá závěru. Zkontroluj zvýrazněnou pozici.',
			'learn.minutes' => ({required Object count}) => '${count} min',
			'learn.tasks' => ({required Object count}) => '${count} úloh',
			'learn.wrongCell' => 'Toto políčko není součástí vzoru. Podívej se na zvýrazněná políčka.',
			'learn.wrongDigit' => 'Tuto číslici vzor neurčuje. Zkontroluj kandidáty ve zvýrazněném políčku.',
			'learn.wrongCellAndDigit' => 'Výběr neodpovídá vzoru. Porovnej zvýrazněná políčka a jejich kandidáty.',
			'learn.findTechnique' => ({required Object technique}) => 'Najdi: ${technique}',
			'progress.doingWell' => 'Co ti jde',
			'progress.learningNow' => 'Co se právě učíš',
			'progress.next' => 'Další krok',
			'progress.noStrong' => 'Nejsilnější techniky se ukážou po procvičování.',
			'progress.startLearning' => 'Začít se učit',
			'progress.thisWeek' => 'Tento týden',
			'progress.completed' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('cs'))(n, one: '${n} dokončený hlavolam', few: '${n} dokončené hlavolamy', other: '${n} dokončených hlavolamů', ),
			'progress.mastery' => ({required Object percent}) => 'Zvládnuto ${percent} %',
			'progress.openTechnique' => 'Otevřít techniku',
			'profile.guest' => 'Host',
			'profile.localOnly' => 'Postup se ukládá do tohoto zařízení.',
			'profile.puzzles' => 'Hlavolamy',
			'profile.mastered' => 'Zvládnuto',
			'profile.activeDays' => 'Aktivní dny',
			'profile.learnRow' => 'Učení',
			'profile.learnDetail' => 'Techniky a cvičení',
			'profile.settingsRow' => 'Nastavení',
			'profile.settingsDetail' => 'Jazyk',
			'profile.activity' => 'Tvoje aktivita',
			'scanner.title' => 'Skenovat sudoku',
			'scanner.intro' => 'Zaberte celou mřížku, vyfoťte ji nebo vyberte snímek.',
			'scanner.openCamera' => 'Použít fotoaparát',
			'scanner.choosePhoto' => 'Vybrat fotku',
			'scanner.shutter' => 'Vyfotit',
			'scanner.frameGuide' => 'Nechte všechny čtyři rohy v záběru.',
			'scanner.processing' => 'Čteme vaše sudoku…',
			'scanner.reviewTitle' => 'Zkontrolujte číslice',
			'scanner.reviewBody' => 'Klepnutím na políčko jej před hrou opravíte.',
			'scanner.needsReview' => 'Vyžaduje kontrolu',
			'scanner.conflict' => 'Číslice v konfliktu',
			'scanner.selected' => 'vybráno',
			'scanner.recognized' => 'rozpoznáno',
			'scanner.empty' => 'prázdné',
			'scanner.clear' => 'Vymazat',
			'scanner.confirm' => 'Importovat sudoku',
			'scanner.rescan' => 'Skenovat znovu',
			'scanner.permissionIntro' => 'Pro pořízení snímku povolte fotoaparát.',
			'scanner.permissionDenied' => 'Přístup k fotoaparátu byl zamítnut. Můžete vybrat fotku.',
			'scanner.permissionSettings' => 'Povolte fotoaparát v Nastavení nebo vyberte fotku.',
			'scanner.noCamera' => 'Fotoaparát není dostupný. Vyberte fotku.',
			'scanner.openSettings' => 'Otevřít Nastavení',
			'scanner.imageDecodeFailure' => 'Obrázek se nepodařilo přečíst. Zkuste jinou fotku.',
			'scanner.noGridFound' => 'Mřížka sudoku nebyla nalezena. Zaberte ji celou.',
			'scanner.invalidGeometry' => 'Mřížku se nepodařilo narovnat. Zkuste ostřejší fotku.',
			'scanner.segmentationFailure' => 'Mřížku se nepodařilo rozdělit na políčka. Zkuste to znovu.',
			'scanner.recognitionFailure' => 'Některé číslice se nepodařilo přečíst. Zkuste to znovu.',
			'scanner.duplicateClues' => 'Opravte zvýrazněné konfliktní číslice.',
			'scanner.noSolution' => 'Tyto číslice nemají řešení. Zkontrolujte je.',
			'scanner.multipleSolutions' => 'Některé číslice mohou chybět; sudoku má více řešení.',
			'scanner.storageFailure' => 'Importované sudoku se nepodařilo uložit. Zkuste to znovu.',
			'scanner.validationFailure' => 'Tuto úlohu se nepodařilo ověřit. Zkuste ji potvrdit znovu.',
			'scanner.unsupportedCoach' => 'MICHI zatím nemusí umět vysvětlit každý krok tohoto sudoku.',
			'scanner.importedTitle' => 'Importované sudoku',
			'scanner.lowConfidenceCount' => ({required Object count}) => 'Políčka ke kontrole: ${count}',
			'coach.step' => ({required Object step}) => 'Nápověda ${step} ze 4',
			'coach.kTry' => 'Zkusím to',
			'coach.show' => 'Ukázat',
			'coach.see' => 'Vidím',
			'coach.more' => 'Další nápověda',
			'coach.close' => 'Zavřít',
			'coach.showMistake' => 'Ukázat chybu',
			'coach.place' => ({required Object digit}) => 'Vložit ${digit}',
			'coach.unitRow' => ({required Object index}) => 'řádek ${index}',
			'coach.unitColumn' => ({required Object index}) => 'sloupec ${index}',
			'coach.unitBox' => ({required Object index}) => 'blok ${index}',
			'coach.inspectCell' => 'Podívejte se na zvýrazněné pole.',
			'coach.inspectUnit' => ({required Object unit}) => 'Podívejte se na zvýrazněný ${unit}.',
			'coach.inspectCandidates' => 'Které číslice sem mohou patřit?',
			'coach.inspectPositions' => ({required Object unit}) => 'Kam může tato číslice patřit ve zvýrazněném ${unit}?',
			'coach.inspectPair' => 'Najděte dvě pole se stejnými dvěma kandidáty.',
			'coach.singleRemains' => 'V tomto poli zbývá jediný kandidát.',
			'coach.onlyPosition' => ({required Object unit}) => 'Pro tuto číslici zbývá v ${unit} jediné místo.',
			'coach.pairRestriction' => ({required Object unit}) => 'Tyto dvě číslice patří do zvýrazněné dvojice. Jinde v ${unit} je lze vyloučit.',
			'coach.alignment' => 'Kandidáti leží v jedné linii, takže číslici lze vyloučit mimo blok.',
			'coach.resultPlacement' => ({required Object digit}) => '${digit} patří jen do zvýrazněného pole.',
			'coach.resultEliminations' => 'Odstraňte přeškrtnuté kandidáty ze zvýrazněných polí.',
			'coach.resultActions' => 'Použijte zvýrazněný logický krok.',
			'coach.technique' => ({required Object name}) => 'Technika: ${name}',
			'coach.nakedSingle' => 'nahý singl',
			'coach.hiddenSingle' => 'skrytý singl',
			'coach.nakedPair' => 'nahá dvojice',
			'coach.pointingPair' => 'ukazující dvojice',
			'coach.unavailable' => 'Nápověda není dostupná',
			'coach.wrongTitle' => 'Nejdřív opravte chybu.',
			'coach.wrongBody' => 'Dokud je na desce chybná číslice, nelze určit logický další krok.',
			'coach.stuckTitle' => 'Zatím žádný podporovaný krok.',
			'coach.stuckBody' => 'MICHI zatím neumí vysvětlit další krok dostupnými technikami.',
			'coach.hiddenPair' => 'Skrytá dvojice',
			'coach.boxLineReduction' => 'Redukce řádek–blok',
			'coach.nakedTriple' => 'Otevřená trojice',
			'coach.xWing' => 'X-Wing',
			'coach.identifyHiddenPair' => 'Dvě číslice jsou možné jen ve stejných dvou polích. Odstraň ostatní kandidáty.',
			'coach.understandBoxLine' => 'Číslice je v řádku omezena na jeden blok. Odstraň ji jinde v bloku.',
			'coach.understandTriple' => 'Tři pole sdílejí přesně tři číslice. Odstraň je z dalších polí jednotky.',
			'coach.understandXWing' => 'Ve dvou řádcích má číslice stejné dva průsečíky. Odstraň ji jinde v protínajících řádcích.',
			'why.title' => 'Vysvětlení',
			'why.whyHere' => ({required Object digit}) => 'Proč sem patří ${digit}?',
			'why.givenTitle' => 'Toto je zadaná číslice',
			'why.givenBody' => 'Byla na desce od začátku, takže není třeba vysvětlovat její odvození. Vysvětlení jsou dostupná pro číslice, které umístíš sám.',
			'why.unavailableTitle' => 'Přímé vysvětlení zatím není',
			'why.unavailableBody' => 'MICHI nedokáže tento tah odůvodnit podporovanou technikou ve stavu před tahem.',
			'why.lesson' => 'Lekce',
			'why.gotIt' => 'Rozumím',
			'why.unitRestrictions' => ({required Object unit, required Object digits}) => 'V ${unit} již jsou číslice: ${digits}.',
			'why.onlyCandidate' => ({required Object digit}) => 'Řádek, sloupec a blok vylučují ostatní číslice. Sem patří jen ${digit}.',
			'why.unitSearch' => ({required Object digit, required Object unit}) => 'Hledáme místo pro ${digit} v ${unit}.',
			'why.solePosition' => ({required Object digit, required Object unit}) => 'Přeškrtnuté ${digit} ukazují, kam v ${unit} číslice nemůže. Zbývá jediné políčko.',
			'why.placement' => ({required Object digit}) => 'Proto sem patří ${digit}.',
			'why.unitRow' => ({required Object index}) => 'řádku ${index}',
			'why.unitColumn' => ({required Object index}) => 'sloupci ${index}',
			'why.unitBox' => ({required Object index}) => 'bloku ${index}',
			'recommendation.focusTitle' => ({required Object technique}) => 'Dnešní zaměření: ${technique}',
			'recommendation.learnAction' => ({required Object technique}) => 'Naučit se: ${technique}',
			'recommendation.practiceAction' => ({required Object technique}) => 'Procvičit: ${technique}',
			'recommendation.reviewAction' => ({required Object technique}) => 'Zopakovat: ${technique}',
			'recommendation.duration' => ({required Object minutes}) => '${minutes} min',
			'recommendation.startWithBasics' => 'Začněte prvním logickým krokem.',
			'recommendation.repeatedCoachHelp' => 'Nedávno jste potřebovali pomoc MICHI.',
			'recommendation.weakIndependentPractice' => 'Samostatné řešení chce ještě procvičit.',
			'recommendation.continuePractice' => 'Pokračujte v procvičování této techniky.',
			'recommendation.nextTechnique' => 'Další krok na vaší cestě.',
			'recommendation.masteredNeedsReview' => 'Známou techniku je dobré zopakovat.',
			'recommendation.allMasteredReview' => 'Zopakujte si zvládnutou techniku.',
			'week.title' => 'Tento týden',
			'week.empty' => 'Tento týden zatím nemáš dokončené sudoku. Aktivita se objeví při hraní.',
			'week.puzzles' => 'Hlavolamy',
			'week.minutes' => 'Minuty',
			'week.daily' => 'Denní',
			'week.activeDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('cs'))(n, one: '${n} aktivní den', few: '${n} aktivní dny', other: '${n} aktivních dní', ),
			'week.completedDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('cs'))(n, one: '${n} dokončený hlavolam', few: '${n} dokončené hlavolamy', other: '${n} dokončených hlavolamů', ),
			'week.today' => 'Dnes',
			'week.noActivity' => 'Bez aktivity',
			'week.summary' => 'Tvoje místní aktivita v sudoku',
			'settings.title' => 'Nastavení',
			'settings.language' => 'Jazyk',
			'settings.languageDetail' => 'Vyber jazyk aplikace MICHI.',
			_ => null,
		};
	}
}
