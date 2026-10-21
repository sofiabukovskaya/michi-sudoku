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
			'learn.unavailable' => 'Lekce technik přijdou později.',
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
