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
			'progress.unavailable' => 'Přehled zvládnutých technik přijde později.',
			'profile.unavailable' => 'Nastavení profilu přijde později.',
			'scanner.unavailable' => 'Import z fotoaparátu přijde po základní hře.',
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
			_ => null,
		};
	}
}
