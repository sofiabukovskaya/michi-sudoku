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
	@override late final _Translations$coach$de coach = _Translations$coach$de._(_root);
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
	@override String get continueGame => 'Spiel fortsetzen';
	@override String continueDetails({required Object date, required Object progress, required Object time}) => 'Begonnen am ${date} · ${progress} % · ${time}';
	@override String get replaceTitle => 'Neues Sudoku beginnen?';
	@override String get replaceBody => 'Das unfertige Spiel wird ersetzt.';
	@override String get keepPlaying => 'Weiterspielen';
	@override String get startNew => 'Neues beginnen';
	@override String get storageUnavailable => 'Gespeichertes Spiel nicht verfügbar. Später erneut versuchen.';
	@override String get loading => 'Gespeichertes Spiel wird gesucht…';
	@override String get learn => 'Lernen';
	@override String get progress => 'Fortschritt';
	@override String get profile => 'Profil';
	@override String get scanner => 'Scanner';
	@override String get chooseDifficulty => 'Schwierigkeit wählen';
	@override String get easy => 'Einfach';
	@override String get medium => 'Mittel';
	@override String get dailyTitle => 'Sudoku des Tages';
	@override String get dailyStart => 'Heutiges Sudoku starten';
	@override String get dailyContinue => 'Heutiges Sudoku fortsetzen';
	@override String get dailyCompleted => 'Heute abgeschlossen';
	@override String get contentUnavailable => 'Rätsel sind nicht verfügbar. Bitte erneut versuchen.';
}

// Path: game
class _Translations$game$de extends Translations$game$uk {
	_Translations$game$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tägliches Sudoku · Mittel';
	@override String get undo => 'Rückgängig';
	@override String get erase => 'Löschen';
	@override String get notes => 'Notizen';
	@override String get hint => 'Hinweis';
	@override String mistakes({required Object count}) => 'Fehler: ${count} von 3';
	@override String get notesModeOn => 'Notizmodus: Zahl antippen, um Kandidaten umzuschalten';
	@override String get row => 'Zeile';
	@override String get column => 'Spalte';
	@override String get empty => 'leer';
	@override String get given => 'vorgegeben';
	@override String get entered => 'eingetragen';
	@override String get selected => 'ausgewählt';
	@override String get error => 'falsch';
	@override String get candidates => 'Kandidaten';
	@override String get completeTitle => 'Gelöst.';
	@override String get completeBody => 'Du hast dieses Sudoku abgeschlossen.';
	@override String get backHome => 'Zur Startseite';
	@override String get pause => 'Pause';
	@override String get pausedTitle => 'Pausiert';
	@override String get resume => 'Fortsetzen';
	@override String pausedAt({required Object time}) => 'Timer angehalten bei ${time}';
	@override String get loading => 'Sudoku wird vorbereitet…';
	@override String get restoreUnavailable => 'Das Spiel konnte nicht wiederhergestellt werden.';
	@override String get saveFailed => 'Das Spiel konnte nicht gespeichert werden.';
	@override String get retrySave => 'Erneut versuchen';
	@override String completionStats({required Object mistakes, required Object hints}) => '${mistakes} Fehler · ${hints} Hinweise';
	@override String get standardTitle => 'Sudoku';
	@override String get dailyTitle => 'Sudoku des Tages';
}

// Path: learn
class _Translations$learn$de extends Translations$learn$uk {
	_Translations$learn$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lernen';
	@override String get intro => 'Eine Technik und ein klarer Schritt nach dem anderen.';
	@override String get newLabel => 'Neu';
	@override String get learningLabel => 'Lerne ich';
	@override String get practicingLabel => 'Übe ich';
	@override String get masteredLabel => 'Gemeistert';
	@override String get planTitle => 'Lektionsplan';
	@override String get lessonStart => 'Lektion starten';
	@override String get next => 'Weiter';
	@override String get practiceStart => 'Übung starten';
	@override String get concept => 'Grundidee';
	@override String get lookFor => 'Worauf du achtest';
	@override String get reasoning => 'Warum es funktioniert';
	@override String get example => 'Beispiel';
	@override String get tryIt => 'Versuch es';
	@override String exercise({required Object current, required Object total}) => 'Aufgabe ${current} von ${total}';
	@override String get placementPrompt => 'Wähle ein Feld und eine Zahl.';
	@override String get eliminationPrompt => 'Wähle ein Feld und markiere alle Kandidaten zum Entfernen.';
	@override String get checkAnswer => 'Antwort prüfen';
	@override String get correctTitle => 'Gut erkannt';
	@override String get incorrectTitle => 'Noch nicht ganz';
	@override String get tryAgain => 'Erneut versuchen';
	@override String get askMichi => 'MICHI fragen';
	@override String get nextScenario => 'Nächste Aufgabe';
	@override String get sessionSummary => 'Übung abgeschlossen';
	@override String summaryStats({required Object correct, required Object attempts}) => '${correct} richtig · ${attempts} Versuche';
	@override String hintsUsed({required Object count}) => '${count} mit MICHI';
	@override String get done => 'Fertig';
	@override String get loading => 'Lektion wird vorbereitet…';
	@override String get unavailable => 'Lerninhalte sind nicht verfügbar. Versuch es erneut.';
	@override String get noScenarios => 'Noch keine Übungen verfügbar.';
	@override String get saveFailed => 'Fortschritt konnte nicht gespeichert werden. Versuch es erneut.';
	@override String get selectedForElimination => 'Zum Entfernen markiert';
	@override String get requiredTechniques => 'Techniken in diesem Sudoku';
	@override String get helpedTechniques => 'MICHI half bei';
	@override String get noHints => 'Keine Hinweise genutzt';
	@override String get practiceTitle => 'Übung';
	@override String get continueLesson => 'Lektion fortsetzen';
	@override late final _Translations$learn$lessons$de lessons = _Translations$learn$lessons$de._(_root);
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

// Path: coach
class _Translations$coach$de extends Translations$coach$uk {
	_Translations$coach$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String step({required Object step}) => 'Hinweis ${step} von 4';
	@override String get kTry => 'Ich versuche es';
	@override String get show => 'Anzeigen';
	@override String get see => 'Verstanden';
	@override String get more => 'Weiterer Hinweis';
	@override String get close => 'Schließen';
	@override String get showMistake => 'Fehler anzeigen';
	@override String place({required Object digit}) => '${digit} eintragen';
	@override String unitRow({required Object index}) => 'Zeile ${index}';
	@override String unitColumn({required Object index}) => 'Spalte ${index}';
	@override String unitBox({required Object index}) => 'Block ${index}';
	@override String get inspectCell => 'Sieh dir das markierte Feld an.';
	@override String inspectUnit({required Object unit}) => 'Sieh dir die markierte ${unit} an.';
	@override String get inspectCandidates => 'Welche Zahlen passen in dieses Feld?';
	@override String inspectPositions({required Object unit}) => 'Wo kann diese Zahl in der markierten ${unit} stehen?';
	@override String get inspectPair => 'Finde zwei Felder mit denselben zwei Kandidaten.';
	@override String get singleRemains => 'In diesem Feld bleibt nur ein Kandidat.';
	@override String onlyPosition({required Object unit}) => 'Für diese Zahl bleibt in der ${unit} nur eine Position.';
	@override String pairRestriction({required Object unit}) => 'Diese zwei Zahlen besetzen das markierte Paar. Anderswo in der ${unit} können sie entfallen.';
	@override String get alignment => 'Die Kandidaten liegen auf einer Linie. Außerhalb des Blocks kann die Zahl entfernt werden.';
	@override String resultPlacement({required Object digit}) => '${digit} passt nur in das markierte Feld.';
	@override String get resultEliminations => 'Entferne die durchgestrichenen Kandidaten aus den markierten Feldern.';
	@override String get resultActions => 'Wende den markierten logischen Schritt an.';
	@override String technique({required Object name}) => 'Technik: ${name}';
	@override String get nakedSingle => 'Nackter Einer';
	@override String get hiddenSingle => 'Versteckter Einer';
	@override String get nakedPair => 'Nacktes Paar';
	@override String get pointingPair => 'Zeigende Paare';
	@override String get unavailable => 'Hinweis nicht verfügbar';
	@override String get wrongTitle => 'Korrigiere zuerst den Fehler.';
	@override String get wrongBody => 'Solange eine falsche Zahl auf dem Brett steht, ist kein logischer nächster Schritt möglich.';
	@override String get stuckTitle => 'Noch kein unterstützter Schritt.';
	@override String get stuckBody => 'MICHI kann den nächsten Schritt mit den verfügbaren Techniken noch nicht erklären.';
}

// Path: learn.lessons
class _Translations$learn$lessons$de extends Translations$learn$lessons$uk {
	_Translations$learn$lessons$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learn$lessons$nakedSingle$de nakedSingle = _Translations$learn$lessons$nakedSingle$de._(_root);
	@override late final _Translations$learn$lessons$hiddenSingle$de hiddenSingle = _Translations$learn$lessons$hiddenSingle$de._(_root);
	@override late final _Translations$learn$lessons$nakedPair$de nakedPair = _Translations$learn$lessons$nakedPair$de._(_root);
	@override late final _Translations$learn$lessons$pointingPair$de pointingPair = _Translations$learn$lessons$pointingPair$de._(_root);
}

// Path: learn.lessons.nakedSingle
class _Translations$learn$lessons$nakedSingle$de extends Translations$learn$lessons$nakedSingle$uk {
	_Translations$learn$lessons$nakedSingle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'In einem leeren Feld bleibt nur eine mögliche Zahl.';
	@override String get concept => 'Kandidaten sind Zahlen, die noch in ein leeres Feld passen.';
	@override String get lookFor => 'Finde ein Feld, in dem Zeile, Spalte und Block alle Zahlen bis auf eine ausschließen.';
	@override String get reasoning => 'Ein Kandidat bleibt übrig, also gehört diese Zahl in das Feld.';
	@override String get example => 'Das markierte Feld hat nur einen erlaubten Kandidaten.';
	@override String get tryIt => 'Wähle das Feld und trage die verbleibende Zahl ein.';
}

// Path: learn.lessons.hiddenSingle
class _Translations$learn$lessons$hiddenSingle$de extends Translations$learn$lessons$hiddenSingle$uk {
	_Translations$learn$lessons$hiddenSingle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Eine Zahl hat in einer Zeile, Spalte oder einem Block nur einen Platz.';
	@override String get concept => 'Betrachte eine Zahl in der ganzen Einheit statt alle Kandidaten eines Felds.';
	@override String get lookFor => 'Finde die einzige freie Position, an der die Zahl noch stehen darf.';
	@override String get reasoning => 'Das Feld kann mehrere Kandidaten haben, aber diese Zahl nur einen Platz.';
	@override String get example => 'In der markierten Einheit bleibt ein Platz für die Zahl.';
	@override String get tryIt => 'Wähle diesen Platz und trage die Zahl ein.';
}

// Path: learn.lessons.nakedPair
class _Translations$learn$lessons$nakedPair$de extends Translations$learn$lessons$nakedPair$uk {
	_Translations$learn$lessons$nakedPair$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Zwei Felder einer Einheit haben dieselben zwei Kandidaten.';
	@override String get concept => 'Das Paar reserviert diese Zahlen für beide Felder.';
	@override String get lookFor => 'Finde zwei Felder in derselben Einheit mit genau denselben Kandidaten.';
	@override String get reasoning => 'Anderswo in der Einheit sind diese Zahlen ausgeschlossen: entferne sie dort.';
	@override String get example => 'Das markierte Paar entfernt Kandidaten aus anderen Feldern.';
	@override String get tryIt => 'Markiere alle entfernten Kandidaten. Noch keine Zahl eintragen.';
}

// Path: learn.lessons.pointingPair
class _Translations$learn$lessons$pointingPair$de extends Translations$learn$lessons$pointingPair$uk {
	_Translations$learn$lessons$pointingPair$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Zwei Kandidatenpositionen in einem Block liegen in derselben Zeile oder Spalte.';
	@override String get concept => 'Ein Block kann eine Zahl auf eine Linie beschränken.';
	@override String get lookFor => 'Finde genau zwei ausgerichtete Positionen für die Zahl im Block.';
	@override String get reasoning => 'Die Zahl bleibt im Block; entferne sie außerhalb auf derselben Linie.';
	@override String get example => 'Folge der markierten Linie aus dem Block heraus.';
	@override String get tryIt => 'Markiere alle außerhalb des Blocks entfernten Kandidaten.';
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
			'home.continueGame' => 'Spiel fortsetzen',
			'home.continueDetails' => ({required Object date, required Object progress, required Object time}) => 'Begonnen am ${date} · ${progress} % · ${time}',
			'home.replaceTitle' => 'Neues Sudoku beginnen?',
			'home.replaceBody' => 'Das unfertige Spiel wird ersetzt.',
			'home.keepPlaying' => 'Weiterspielen',
			'home.startNew' => 'Neues beginnen',
			'home.storageUnavailable' => 'Gespeichertes Spiel nicht verfügbar. Später erneut versuchen.',
			'home.loading' => 'Gespeichertes Spiel wird gesucht…',
			'home.learn' => 'Lernen',
			'home.progress' => 'Fortschritt',
			'home.profile' => 'Profil',
			'home.scanner' => 'Scanner',
			'home.chooseDifficulty' => 'Schwierigkeit wählen',
			'home.easy' => 'Einfach',
			'home.medium' => 'Mittel',
			'home.dailyTitle' => 'Sudoku des Tages',
			'home.dailyStart' => 'Heutiges Sudoku starten',
			'home.dailyContinue' => 'Heutiges Sudoku fortsetzen',
			'home.dailyCompleted' => 'Heute abgeschlossen',
			'home.contentUnavailable' => 'Rätsel sind nicht verfügbar. Bitte erneut versuchen.',
			'game.title' => 'Tägliches Sudoku · Mittel',
			'game.undo' => 'Rückgängig',
			'game.erase' => 'Löschen',
			'game.notes' => 'Notizen',
			'game.hint' => 'Hinweis',
			'game.mistakes' => ({required Object count}) => 'Fehler: ${count} von 3',
			'game.notesModeOn' => 'Notizmodus: Zahl antippen, um Kandidaten umzuschalten',
			'game.row' => 'Zeile',
			'game.column' => 'Spalte',
			'game.empty' => 'leer',
			'game.given' => 'vorgegeben',
			'game.entered' => 'eingetragen',
			'game.selected' => 'ausgewählt',
			'game.error' => 'falsch',
			'game.candidates' => 'Kandidaten',
			'game.completeTitle' => 'Gelöst.',
			'game.completeBody' => 'Du hast dieses Sudoku abgeschlossen.',
			'game.backHome' => 'Zur Startseite',
			'game.pause' => 'Pause',
			'game.pausedTitle' => 'Pausiert',
			'game.resume' => 'Fortsetzen',
			'game.pausedAt' => ({required Object time}) => 'Timer angehalten bei ${time}',
			'game.loading' => 'Sudoku wird vorbereitet…',
			'game.restoreUnavailable' => 'Das Spiel konnte nicht wiederhergestellt werden.',
			'game.saveFailed' => 'Das Spiel konnte nicht gespeichert werden.',
			'game.retrySave' => 'Erneut versuchen',
			'game.completionStats' => ({required Object mistakes, required Object hints}) => '${mistakes} Fehler · ${hints} Hinweise',
			'game.standardTitle' => 'Sudoku',
			'game.dailyTitle' => 'Sudoku des Tages',
			'learn.title' => 'Lernen',
			'learn.intro' => 'Eine Technik und ein klarer Schritt nach dem anderen.',
			'learn.newLabel' => 'Neu',
			'learn.learningLabel' => 'Lerne ich',
			'learn.practicingLabel' => 'Übe ich',
			'learn.masteredLabel' => 'Gemeistert',
			'learn.planTitle' => 'Lektionsplan',
			'learn.lessonStart' => 'Lektion starten',
			'learn.next' => 'Weiter',
			'learn.practiceStart' => 'Übung starten',
			'learn.concept' => 'Grundidee',
			'learn.lookFor' => 'Worauf du achtest',
			'learn.reasoning' => 'Warum es funktioniert',
			'learn.example' => 'Beispiel',
			'learn.tryIt' => 'Versuch es',
			'learn.exercise' => ({required Object current, required Object total}) => 'Aufgabe ${current} von ${total}',
			'learn.placementPrompt' => 'Wähle ein Feld und eine Zahl.',
			'learn.eliminationPrompt' => 'Wähle ein Feld und markiere alle Kandidaten zum Entfernen.',
			'learn.checkAnswer' => 'Antwort prüfen',
			'learn.correctTitle' => 'Gut erkannt',
			'learn.incorrectTitle' => 'Noch nicht ganz',
			'learn.tryAgain' => 'Erneut versuchen',
			'learn.askMichi' => 'MICHI fragen',
			'learn.nextScenario' => 'Nächste Aufgabe',
			'learn.sessionSummary' => 'Übung abgeschlossen',
			'learn.summaryStats' => ({required Object correct, required Object attempts}) => '${correct} richtig · ${attempts} Versuche',
			'learn.hintsUsed' => ({required Object count}) => '${count} mit MICHI',
			'learn.done' => 'Fertig',
			'learn.loading' => 'Lektion wird vorbereitet…',
			'learn.unavailable' => 'Lerninhalte sind nicht verfügbar. Versuch es erneut.',
			'learn.noScenarios' => 'Noch keine Übungen verfügbar.',
			'learn.saveFailed' => 'Fortschritt konnte nicht gespeichert werden. Versuch es erneut.',
			'learn.selectedForElimination' => 'Zum Entfernen markiert',
			'learn.requiredTechniques' => 'Techniken in diesem Sudoku',
			'learn.helpedTechniques' => 'MICHI half bei',
			'learn.noHints' => 'Keine Hinweise genutzt',
			'learn.practiceTitle' => 'Übung',
			'learn.continueLesson' => 'Lektion fortsetzen',
			'learn.lessons.nakedSingle.description' => 'In einem leeren Feld bleibt nur eine mögliche Zahl.',
			'learn.lessons.nakedSingle.concept' => 'Kandidaten sind Zahlen, die noch in ein leeres Feld passen.',
			'learn.lessons.nakedSingle.lookFor' => 'Finde ein Feld, in dem Zeile, Spalte und Block alle Zahlen bis auf eine ausschließen.',
			'learn.lessons.nakedSingle.reasoning' => 'Ein Kandidat bleibt übrig, also gehört diese Zahl in das Feld.',
			'learn.lessons.nakedSingle.example' => 'Das markierte Feld hat nur einen erlaubten Kandidaten.',
			'learn.lessons.nakedSingle.tryIt' => 'Wähle das Feld und trage die verbleibende Zahl ein.',
			'learn.lessons.hiddenSingle.description' => 'Eine Zahl hat in einer Zeile, Spalte oder einem Block nur einen Platz.',
			'learn.lessons.hiddenSingle.concept' => 'Betrachte eine Zahl in der ganzen Einheit statt alle Kandidaten eines Felds.',
			'learn.lessons.hiddenSingle.lookFor' => 'Finde die einzige freie Position, an der die Zahl noch stehen darf.',
			'learn.lessons.hiddenSingle.reasoning' => 'Das Feld kann mehrere Kandidaten haben, aber diese Zahl nur einen Platz.',
			'learn.lessons.hiddenSingle.example' => 'In der markierten Einheit bleibt ein Platz für die Zahl.',
			'learn.lessons.hiddenSingle.tryIt' => 'Wähle diesen Platz und trage die Zahl ein.',
			'learn.lessons.nakedPair.description' => 'Zwei Felder einer Einheit haben dieselben zwei Kandidaten.',
			'learn.lessons.nakedPair.concept' => 'Das Paar reserviert diese Zahlen für beide Felder.',
			'learn.lessons.nakedPair.lookFor' => 'Finde zwei Felder in derselben Einheit mit genau denselben Kandidaten.',
			'learn.lessons.nakedPair.reasoning' => 'Anderswo in der Einheit sind diese Zahlen ausgeschlossen: entferne sie dort.',
			'learn.lessons.nakedPair.example' => 'Das markierte Paar entfernt Kandidaten aus anderen Feldern.',
			'learn.lessons.nakedPair.tryIt' => 'Markiere alle entfernten Kandidaten. Noch keine Zahl eintragen.',
			'learn.lessons.pointingPair.description' => 'Zwei Kandidatenpositionen in einem Block liegen in derselben Zeile oder Spalte.',
			'learn.lessons.pointingPair.concept' => 'Ein Block kann eine Zahl auf eine Linie beschränken.',
			'learn.lessons.pointingPair.lookFor' => 'Finde genau zwei ausgerichtete Positionen für die Zahl im Block.',
			'learn.lessons.pointingPair.reasoning' => 'Die Zahl bleibt im Block; entferne sie außerhalb auf derselben Linie.',
			'learn.lessons.pointingPair.example' => 'Folge der markierten Linie aus dem Block heraus.',
			'learn.lessons.pointingPair.tryIt' => 'Markiere alle außerhalb des Blocks entfernten Kandidaten.',
			'progress.unavailable' => 'Die Übersicht deiner Techniken kommt später.',
			'profile.unavailable' => 'Profileinstellungen kommen später.',
			'scanner.unavailable' => 'Der Kameraimport folgt nach dem Grundspiel.',
			'coach.step' => ({required Object step}) => 'Hinweis ${step} von 4',
			'coach.kTry' => 'Ich versuche es',
			'coach.show' => 'Anzeigen',
			'coach.see' => 'Verstanden',
			'coach.more' => 'Weiterer Hinweis',
			'coach.close' => 'Schließen',
			'coach.showMistake' => 'Fehler anzeigen',
			'coach.place' => ({required Object digit}) => '${digit} eintragen',
			'coach.unitRow' => ({required Object index}) => 'Zeile ${index}',
			'coach.unitColumn' => ({required Object index}) => 'Spalte ${index}',
			'coach.unitBox' => ({required Object index}) => 'Block ${index}',
			'coach.inspectCell' => 'Sieh dir das markierte Feld an.',
			'coach.inspectUnit' => ({required Object unit}) => 'Sieh dir die markierte ${unit} an.',
			'coach.inspectCandidates' => 'Welche Zahlen passen in dieses Feld?',
			'coach.inspectPositions' => ({required Object unit}) => 'Wo kann diese Zahl in der markierten ${unit} stehen?',
			'coach.inspectPair' => 'Finde zwei Felder mit denselben zwei Kandidaten.',
			'coach.singleRemains' => 'In diesem Feld bleibt nur ein Kandidat.',
			'coach.onlyPosition' => ({required Object unit}) => 'Für diese Zahl bleibt in der ${unit} nur eine Position.',
			'coach.pairRestriction' => ({required Object unit}) => 'Diese zwei Zahlen besetzen das markierte Paar. Anderswo in der ${unit} können sie entfallen.',
			'coach.alignment' => 'Die Kandidaten liegen auf einer Linie. Außerhalb des Blocks kann die Zahl entfernt werden.',
			'coach.resultPlacement' => ({required Object digit}) => '${digit} passt nur in das markierte Feld.',
			'coach.resultEliminations' => 'Entferne die durchgestrichenen Kandidaten aus den markierten Feldern.',
			'coach.resultActions' => 'Wende den markierten logischen Schritt an.',
			'coach.technique' => ({required Object name}) => 'Technik: ${name}',
			'coach.nakedSingle' => 'Nackter Einer',
			'coach.hiddenSingle' => 'Versteckter Einer',
			'coach.nakedPair' => 'Nacktes Paar',
			'coach.pointingPair' => 'Zeigende Paare',
			'coach.unavailable' => 'Hinweis nicht verfügbar',
			'coach.wrongTitle' => 'Korrigiere zuerst den Fehler.',
			'coach.wrongBody' => 'Solange eine falsche Zahl auf dem Brett steht, ist kein logischer nächster Schritt möglich.',
			'coach.stuckTitle' => 'Noch kein unterstützter Schritt.',
			'coach.stuckBody' => 'MICHI kann den nächsten Schritt mit den verfügbaren Techniken noch nicht erklären.',
			_ => null,
		};
	}
}
