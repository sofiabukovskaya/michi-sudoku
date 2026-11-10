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
	@override late final _Translations$why$de why = _Translations$why$de._(_root);
	@override late final _Translations$recommendation$de recommendation = _Translations$recommendation$de._(_root);
	@override late final _Translations$week$de week = _Translations$week$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$sync$de sync = _Translations$sync$de._(_root);
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
	@override String get title => 'Finde deinen Weg durch Logik.';
	@override String get subtitle => 'Sudoku mit einem Coach, der dir hilft, statt für dich zu lösen.';
	@override String get guest => 'Ohne Konto starten';
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$uk {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hier beginnt dein Lernweg.';
	@override String get chooseLevel => 'Niveau wählen';
	@override String get skip => 'Überspringen';
	@override String get next => 'Weiter';
	@override String get seeTitle => 'Sudoku ist leichter, wenn du weißt, worauf du achten musst.';
	@override String get seeBody => 'MICHI erklärt die Logik hinter jedem Zug.';
	@override String get hintsTitle => 'Hinweise, die etwas beibringen.';
	@override String get hintsBody => 'Beginne mit einem kleinen Hinweis. Frage bei Bedarf nach mehr.';
	@override String get patternsTitle => 'Lerne Muster statt Antworten.';
	@override String get patternsBody => 'Versteckte Singles, Paare, X-Wing — in deinem Tempo.';
	@override String get pathTitle => 'Dein Weg durch Sudoku.';
	@override String get pathBody => 'MICHI erkennt, was dir schwerfällt, und schlägt Übungen vor.';
}

// Path: playerLevel
class _Translations$playerLevel$de extends Translations$playerLevel$uk {
	_Translations$playerLevel$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wie gut kennst du Sudoku?';
	@override String get goToGame => 'Jetzt spielen';
	@override String get subtitle => 'Davon hängen die erste Lektion und der Schwierigkeitsgrad ab. Du kannst es später ändern.';
	@override String get beginner => 'Ich fange gerade an';
	@override String get beginnerDetail => 'Regeln und erste Züge';
	@override String get basics => 'Ich kenne die Grundlagen';
	@override String get basicsDetail => 'Singles und Kandidaten';
	@override String get regular => 'Ich spiele regelmäßig';
	@override String get regularDetail => 'Paare und Zeigepaare';
	@override String get advanced => 'Ich suche eine Herausforderung';
	@override String get advancedDetail => 'X-Wing und mehr';
}

// Path: auth
class _Translations$auth$de extends Translations$auth$uk {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konto';
	@override String get unavailable => 'Dein Fortschritt wird auf diesem Gerät gespeichert.';
	@override String get apple => 'Mit Apple fortfahren';
	@override String get google => 'Mit Google fortfahren';
	@override String get emailEntry => 'Mit E-Mail anmelden';
	@override String get createTitle => 'Konto erstellen';
	@override String get createSubtitle => 'Dein Fortschritt bleibt auf diesem Gerät, bis die Synchronisierung verfügbar ist.';
	@override String get signInTitle => 'Willkommen zurück';
	@override String get name => 'Name';
	@override String get email => 'E-Mail';
	@override String get password => 'Passwort';
	@override String get passwordHint => 'Mindestens 8 Zeichen';
	@override String get createAccount => 'Konto erstellen';
	@override String get signIn => 'Anmelden';
	@override String get alreadyAccount => 'Du hast schon ein Konto?';
	@override String get noAccount => 'Noch kein Konto?';
	@override String get forgotPassword => 'Passwort vergessen?';
	@override String get resetTitle => 'Passwort zurücksetzen';
	@override String get resetSubtitle => 'Gib die E-Mail deines Kontos ein. Wir senden dir einen Link.';
	@override String get sendLink => 'Link senden';
	@override String get resetSent => 'Falls das Konto existiert, prüfe deine E-Mails auf den Link.';
	@override String get verifyTitle => 'Prüfe deine E-Mails';
	@override String verifySubtitle({required Object email}) => 'Wir haben einen Bestätigungslink an ${email} gesendet.';
	@override String get checkVerification => 'Ich habe meine E-Mail bestätigt';
	@override String get resendVerification => 'Link erneut senden';
	@override String get verified => 'Deine E-Mail ist bestätigt.';
	@override String get notVerified => 'Die E-Mail ist noch nicht bestätigt.';
	@override String get signOut => 'Abmelden';
	@override String get localNotSynced => 'Dein Spielfortschritt bleibt auf diesem Gerät gespeichert.';
	@override String get verifyEmail => 'E-Mail bestätigen';
	@override String get errorInvalidEmail => 'Gib eine gültige E-Mail-Adresse ein.';
	@override String get errorPasswordLength => 'Verwende mindestens 8 Zeichen.';
	@override String get errorNameRequired => 'Gib deinen Namen ein.';
	@override String get errorWeakPassword => 'Dieses Passwort ist zu schwach.';
	@override String get errorEmailInUse => 'Für diese E-Mail gibt es bereits ein Konto.';
	@override String get errorWrongCredentials => 'Prüfe E-Mail und Passwort.';
	@override String get errorDisabled => 'Dieses Konto ist deaktiviert.';
	@override String get errorTooMany => 'Zu viele Versuche. Versuche es später erneut.';
	@override String get errorNetwork => 'Prüfe deine Verbindung und versuche es erneut.';
	@override String get errorUnavailable => 'Der Kontodienst ist nicht verfügbar. Du kannst als Gast weiterspielen.';
	@override String get errorUnexpected => 'Etwas ist schiefgegangen. Bitte versuche es erneut.';
	@override String get showPassword => 'Passwort anzeigen';
	@override String get hidePassword => 'Passwort verbergen';
	@override String get signOutTitle => 'Vom Konto abmelden?';
	@override String get signOutBody => 'Deine lokalen Spiele bleiben auf diesem Gerät.';
	@override String get cancel => 'Abbrechen';
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
	@override String get advanced => 'Fortgeschritten';
	@override String get expert => 'Experte';
	@override String get greeting => 'Guten Morgen';
	@override String get newPuzzle => 'Ein weiteres Sudoku';
	@override String get weekTitle => 'Diese Woche';
	@override String get weekDetails => 'Details';
	@override String get weekdaysShort => 'Mo|Di|Mi|Do|Fr|Sa|So';
	@override String get newPuzzleTitle => 'Neues Sudoku';
	@override String get catalogSource => 'Sudoku auswählen';
	@override String get scanSource => 'Sudoku scannen';
	@override String get scanSourceDetail => 'Foto oder Kamera';
	@override String get weekStatusDone => 'Abgeschlossen';
	@override String get weekStatusToday => 'Heute';
	@override String get weekStatusEmpty => 'Keine Aktivität';
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
	@override String get completionLogic => 'gelöste Felder';
	@override String get completionMistakes => 'Fehler';
	@override String get completionHints => 'Hinweise';
	@override String get dailyStampEarned => 'Tagesstempel erhalten';
	@override String completionPracticeTechnique({required Object technique}) => 'Nächster Schritt: ${technique}';
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
	@override String get basicsGroup => 'Grundlagen';
	@override String get intermediateGroup => 'Mittelstufe';
	@override String get advancedGroup => 'Fortgeschritten';
	@override String get nowLabel => 'Jetzt';
	@override String groupProgress({required Object completed, required Object total}) => '${completed} von ${total}';
	@override String get extraElimination => 'Dieses Muster entfernt einen der gewählten Kandidaten nicht. Prüfe die markierten Felder.';
	@override String get missingElimination => 'Weitere Kandidaten müssen entfernt werden. Folge der markierten Einheit.';
	@override String get wrongPlacement => 'Dieses Feld oder diese Ziffer passt nicht zum Schluss. Prüfe die markierte Position.';
	@override String minutes({required Object count}) => '${count} Min.';
	@override String tasks({required Object count}) => '${count} Aufgaben';
	@override String get wrongCell => 'Diese Zelle liegt außerhalb des Musters. Sieh dir die markierten Zellen an.';
	@override String get wrongDigit => 'Dieses Muster setzt diese Zahl nicht. Prüfe die Kandidaten in der markierten Zelle.';
	@override String get wrongCellAndDigit => 'Die Auswahl passt nicht zum Muster. Vergleiche die markierten Zellen und Kandidaten.';
	@override String findTechnique({required Object technique}) => 'Finde: ${technique}';
}

// Path: progress
class _Translations$progress$de extends Translations$progress$uk {
	_Translations$progress$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get doingWell => 'Was gut läuft';
	@override String get learningNow => 'Was du gerade lernst';
	@override String get next => 'Nächster Schritt';
	@override String get noStrong => 'Deine stärksten Techniken erscheinen nach dem Üben.';
	@override String get startLearning => 'Lernen beginnen';
	@override String get thisWeek => 'Diese Woche';
	@override String completed({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Sudoku abgeschlossen',
		other: '${n} Sudokus abgeschlossen',
	);
	@override String mastery({required Object percent}) => 'Beherrschung ${percent} %';
	@override String get openTechnique => 'Technik öffnen';
}

// Path: profile
class _Translations$profile$de extends Translations$profile$uk {
	_Translations$profile$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get guest => 'Gast';
	@override String get localOnly => 'Dein Fortschritt wird auf diesem Gerät gespeichert.';
	@override String get puzzles => 'Sudokus';
	@override String get mastered => 'Gemeistert';
	@override String get activeDays => 'Aktive Tage';
	@override String get learnRow => 'Lernen';
	@override String get learnDetail => 'Techniken und Übungen';
	@override String get settingsRow => 'Einstellungen';
	@override String get settingsDetail => 'Sprache';
	@override String get activity => 'Deine Aktivität';
}

// Path: scanner
class _Translations$scanner$de extends Translations$scanner$uk {
	_Translations$scanner$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sudoku scannen';
	@override String get intro => 'Nimm das ganze Gitter auf oder wähle ein Foto aus.';
	@override String get openCamera => 'Kamera verwenden';
	@override String get choosePhoto => 'Foto auswählen';
	@override String get shutter => 'Foto aufnehmen';
	@override String get frameGuide => 'Alle vier Ecken sollten im Bild sein.';
	@override String get processing => 'Sudoku wird gelesen…';
	@override String get reviewTitle => 'Zahlen prüfen';
	@override String get reviewBody => 'Tippe auf ein Feld, um es vor dem Spielen zu korrigieren.';
	@override String get needsReview => 'Prüfen';
	@override String get conflict => 'Widersprüchliche Zahl';
	@override String get selected => 'ausgewählt';
	@override String get recognized => 'erkannt';
	@override String get empty => 'leer';
	@override String get clear => 'Löschen';
	@override String get confirm => 'Sudoku importieren';
	@override String get rescan => 'Erneut scannen';
	@override String get permissionIntro => 'Erlaube den Kamerazugriff, um ein Foto aufzunehmen.';
	@override String get permissionDenied => 'Der Kamerazugriff wurde verweigert. Du kannst ein Foto wählen.';
	@override String get permissionSettings => 'Aktiviere die Kamera in den Einstellungen oder wähle ein Foto.';
	@override String get noCamera => 'Keine Kamera verfügbar. Wähle ein Foto.';
	@override String get openSettings => 'Einstellungen öffnen';
	@override String get imageDecodeFailure => 'Das Bild konnte nicht gelesen werden. Versuche ein anderes Foto.';
	@override String get noGridFound => 'Kein Sudoku-Gitter gefunden. Nimm das ganze Gitter auf.';
	@override String get invalidGeometry => 'Das Gitter konnte nicht begradigt werden. Versuche ein schärferes Foto.';
	@override String get segmentationFailure => 'Das Gitter konnte nicht in Felder geteilt werden. Versuche es erneut.';
	@override String get recognitionFailure => 'Einige Zahlen konnten nicht gelesen werden. Versuche es erneut.';
	@override String get duplicateClues => 'Korrigiere die markierten widersprüchlichen Zahlen.';
	@override String get noSolution => 'Diese Zahlen haben keine Lösung. Prüfe sie.';
	@override String get multipleSolutions => 'Möglicherweise fehlen Zahlen; dieses Sudoku hat mehrere Lösungen.';
	@override String get storageFailure => 'Das importierte Sudoku konnte nicht gespeichert werden. Versuche es erneut.';
	@override String get validationFailure => 'Dieses Sudoku konnte nicht geprüft werden. Versuche es erneut zu bestätigen.';
	@override String get unsupportedCoach => 'MICHI kann möglicherweise noch nicht jeden Schritt dieses Sudokus erklären.';
	@override String get importedTitle => 'Importiertes Sudoku';
	@override String lowConfidenceCount({required Object count}) => 'Zu prüfende Felder: ${count}';
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
	@override String get hiddenPair => 'Verstecktes Paar';
	@override String get boxLineReduction => 'Linien-Block-Reduktion';
	@override String get nakedTriple => 'Nackter Drilling';
	@override String get xWing => 'X-Wing';
	@override String get identifyHiddenPair => 'Zwei Ziffern passen nur in dieselben zwei Felder. Entferne dort andere Kandidaten.';
	@override String get understandBoxLine => 'Diese Ziffer ist in einer Linie auf einen Block beschränkt. Entferne sie sonst im Block.';
	@override String get understandTriple => 'Drei Felder teilen genau drei Ziffern. Entferne sie aus den anderen Feldern der Einheit.';
	@override String get understandXWing => 'Zwei Linien haben diese Ziffer an denselben zwei Kreuzungen. Entferne sie sonst auf den Kreuzlinien.';
}

// Path: why
class _Translations$why$de extends Translations$why$uk {
	_Translations$why$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erklärung';
	@override String whyHere({required Object digit}) => 'Warum gehört ${digit} hierhin?';
	@override String get givenTitle => 'Diese Ziffer ist vorgegeben';
	@override String get givenBody => 'Sie stand von Anfang an im Rätsel, daher gibt es keinen Lösungsschritt zu erklären. Erklärungen gibt es für Ziffern, die du selbst einträgst.';
	@override String get unavailableTitle => 'Noch keine direkte Erklärung';
	@override String get unavailableBody => 'MICHI kann diesen Zug im Zustand davor nicht mit einer unterstützten Technik begründen.';
	@override String get lesson => 'Lektion';
	@override String get gotIt => 'Verstanden';
	@override String unitRestrictions({required Object unit, required Object digits}) => 'In ${unit} stehen bereits diese Ziffern: ${digits}.';
	@override String onlyCandidate({required Object digit}) => 'Zeile, Spalte und Block schließen die anderen Zahlen aus. Hier passt nur ${digit}.';
	@override String unitSearch({required Object digit, required Object unit}) => 'Suche einen Platz für ${digit} in ${unit}.';
	@override String solePosition({required Object digit, required Object unit}) => 'Die gestrichenen ${digit} zeigen, wo die Zahl in ${unit} nicht stehen kann. Nur dieses Feld bleibt.';
	@override String placement({required Object digit}) => 'Deshalb gehört ${digit} hierhin.';
	@override String unitRow({required Object index}) => 'Zeile ${index}';
	@override String unitColumn({required Object index}) => 'Spalte ${index}';
	@override String unitBox({required Object index}) => 'Block ${index}';
}

// Path: recommendation
class _Translations$recommendation$de extends Translations$recommendation$uk {
	_Translations$recommendation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String focusTitle({required Object technique}) => 'Fokus des Tages: ${technique}';
	@override String learnAction({required Object technique}) => 'Lernen: ${technique}';
	@override String practiceAction({required Object technique}) => 'Üben: ${technique}';
	@override String reviewAction({required Object technique}) => 'Wiederholen: ${technique}';
	@override String duration({required Object minutes}) => '${minutes} Min.';
	@override String get startWithBasics => 'Beginne mit dem ersten logischen Schritt.';
	@override String get repeatedCoachHelp => 'Du hast kürzlich MICHI-Hilfe gebraucht.';
	@override String get weakIndependentPractice => 'Selbstständiges Üben sollte gefestigt werden.';
	@override String get continuePractice => 'Übe diese Technik weiter.';
	@override String get nextTechnique => 'Der nächste Schritt auf deinem Weg.';
	@override String get masteredNeedsReview => 'Eine bekannte Technik braucht Wiederholung.';
	@override String get allMasteredReview => 'Wiederhole eine bereits beherrschte Technik.';
}

// Path: week
class _Translations$week$de extends Translations$week$uk {
	_Translations$week$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Diese Woche';
	@override String get empty => 'Diese Woche hast du noch kein Sudoku abgeschlossen. Deine Aktivität erscheint beim Spielen.';
	@override String get puzzles => 'Sudokus';
	@override String get minutes => 'Minuten';
	@override String get daily => 'Täglich';
	@override String activeDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} aktiver Tag',
		other: '${n} aktive Tage',
	);
	@override String completedDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Sudoku abgeschlossen',
		other: '${n} Sudokus abgeschlossen',
	);
	@override String get today => 'Heute';
	@override String get noActivity => 'Keine Aktivität';
	@override String get summary => 'Deine lokalen Sudoku-Aktivitäten';
}

// Path: settings
class _Translations$settings$de extends Translations$settings$uk {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override String get language => 'Sprache';
	@override String get languageDetail => 'Wähle die Sprache für MICHI.';
}

// Path: sync
class _Translations$sync$de extends Translations$sync$uk {
	_Translations$sync$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get account => 'Konto';
	@override String get email => 'E-Mail';
	@override String get synchronization => 'Synchronisierung';
	@override String get syncing => 'Wird synchronisiert…';
	@override String get synced => 'Kürzlich synchronisiert';
	@override String lastSynced({required Object time}) => 'Zuletzt synchronisiert — ${time}';
	@override String get pending => 'Lokal gespeichert · wartet auf Synchronisierung';
	@override String get offline => 'Offline. Dein Fortschritt wird gespeichert und später synchronisiert.';
	@override String get error => 'Synchronisierungsfehler';
	@override String get retry => 'Erneut versuchen';
	@override String get guest => 'Der Fortschritt ist nur auf diesem Gerät gespeichert.';
	@override String get deleteAccount => 'Konto löschen';
	@override String get deleteTitle => 'Konto löschen?';
	@override String get deleteBody => 'Dein Konto und dein synchronisierter Fortschritt werden dauerhaft gelöscht.';
	@override String get deleteConfirm => 'Konto löschen';
	@override String get deleteFailed => 'Dein Konto konnte nicht gelöscht werden. Melde dich erneut an und versuche es noch einmal.';
	@override String get signOut => 'Abmelden';
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
	@override late final _Translations$learn$lessons$hiddenPair$de hiddenPair = _Translations$learn$lessons$hiddenPair$de._(_root);
	@override late final _Translations$learn$lessons$boxLineReduction$de boxLineReduction = _Translations$learn$lessons$boxLineReduction$de._(_root);
	@override late final _Translations$learn$lessons$nakedTriple$de nakedTriple = _Translations$learn$lessons$nakedTriple$de._(_root);
	@override late final _Translations$learn$lessons$xWing$de xWing = _Translations$learn$lessons$xWing$de._(_root);
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

// Path: learn.lessons.hiddenPair
class _Translations$learn$lessons$hiddenPair$de extends Translations$learn$lessons$hiddenPair$uk {
	_Translations$learn$lessons$hiddenPair$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Zwei Ziffern verbergen sich in denselben zwei Feldern.';
	@override String get concept => 'Suche ein verstecktes Paar nach Ziffern, nicht nach gleichen Kandidatenlisten.';
	@override String get lookFor => 'Finde zwei Ziffern, die in einer Einheit nur in denselben zwei Feldern vorkommen.';
	@override String get reasoning => 'Beide gehören in diese Felder; andere Kandidaten können dort weg.';
	@override String get example => 'Die markierten Felder sind die einzigen Plätze für beide Ziffern.';
	@override String get tryIt => 'Entferne zusätzliche Kandidaten aus diesen zwei Feldern.';
}

// Path: learn.lessons.boxLineReduction
class _Translations$learn$lessons$boxLineReduction$de extends Translations$learn$lessons$boxLineReduction$uk {
	_Translations$learn$lessons$boxLineReduction$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Eine Zeile oder Spalte begrenzt eine Ziffer auf einen Block.';
	@override String get concept => 'Eine Linie kann eine Ziffer innerhalb eines Blocks festlegen.';
	@override String get lookFor => 'Finde zwei oder drei Plätze einer Ziffer in einer Linie, alle im selben Block.';
	@override String get reasoning => 'Die Ziffer liegt in diesem Block auf der Linie; entferne sie sonst im Block.';
	@override String get example => 'Folge der markierten Linie in den Block und finde Kandidaten außerhalb.';
	@override String get tryIt => 'Entferne die Ziffer aus den anderen Feldern des Blocks.';
}

// Path: learn.lessons.nakedTriple
class _Translations$learn$lessons$nakedTriple$de extends Translations$learn$lessons$nakedTriple$uk {
	_Translations$learn$lessons$nakedTriple$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Drei Felder teilen nur drei mögliche Ziffern.';
	@override String get concept => 'Ein Drilling reserviert drei Ziffern für drei Felder einer Einheit.';
	@override String get lookFor => 'Finde drei Felder, deren Kandidaten zusammen genau drei Ziffern ergeben.';
	@override String get reasoning => 'Diese Ziffern füllen die Felder, auch wenn ihre Listen verschieden sind.';
	@override String get example => 'Die markierten Felder haben verschiedene Paare, aber insgesamt drei Ziffern.';
	@override String get tryIt => 'Entferne diese Ziffern aus den anderen Feldern der Einheit.';
}

// Path: learn.lessons.xWing
class _Translations$learn$lessons$xWing$de extends Translations$learn$lessons$xWing$uk {
	_Translations$learn$lessons$xWing$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get description => 'Zwei Linien richten eine Ziffer an zwei Kreuzungen aus.';
	@override String get concept => 'Ein X-Wing verbindet zwei Zeilen oder Spalten über eine Ziffer.';
	@override String get lookFor => 'Finde zwei Linien, in denen die Ziffer zweimal an gleichen Positionen vorkommt.';
	@override String get reasoning => 'Die vier Kreuzungen reservieren die Ziffer; entferne sie sonst auf den Kreuzlinien.';
	@override String get example => 'Verfolge die vier markierten Plätze und die zwei Kreuzlinien.';
	@override String get tryIt => 'Entferne die Ziffer außerhalb der vier Musterfelder.';
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
			'welcome.title' => 'Finde deinen Weg durch Logik.',
			'welcome.subtitle' => 'Sudoku mit einem Coach, der dir hilft, statt für dich zu lösen.',
			'welcome.guest' => 'Ohne Konto starten',
			'onboarding.title' => 'Hier beginnt dein Lernweg.',
			'onboarding.chooseLevel' => 'Niveau wählen',
			'onboarding.skip' => 'Überspringen',
			'onboarding.next' => 'Weiter',
			'onboarding.seeTitle' => 'Sudoku ist leichter, wenn du weißt, worauf du achten musst.',
			'onboarding.seeBody' => 'MICHI erklärt die Logik hinter jedem Zug.',
			'onboarding.hintsTitle' => 'Hinweise, die etwas beibringen.',
			'onboarding.hintsBody' => 'Beginne mit einem kleinen Hinweis. Frage bei Bedarf nach mehr.',
			'onboarding.patternsTitle' => 'Lerne Muster statt Antworten.',
			'onboarding.patternsBody' => 'Versteckte Singles, Paare, X-Wing — in deinem Tempo.',
			'onboarding.pathTitle' => 'Dein Weg durch Sudoku.',
			'onboarding.pathBody' => 'MICHI erkennt, was dir schwerfällt, und schlägt Übungen vor.',
			'playerLevel.title' => 'Wie gut kennst du Sudoku?',
			'playerLevel.goToGame' => 'Jetzt spielen',
			'playerLevel.subtitle' => 'Davon hängen die erste Lektion und der Schwierigkeitsgrad ab. Du kannst es später ändern.',
			'playerLevel.beginner' => 'Ich fange gerade an',
			'playerLevel.beginnerDetail' => 'Regeln und erste Züge',
			'playerLevel.basics' => 'Ich kenne die Grundlagen',
			'playerLevel.basicsDetail' => 'Singles und Kandidaten',
			'playerLevel.regular' => 'Ich spiele regelmäßig',
			'playerLevel.regularDetail' => 'Paare und Zeigepaare',
			'playerLevel.advanced' => 'Ich suche eine Herausforderung',
			'playerLevel.advancedDetail' => 'X-Wing und mehr',
			'auth.title' => 'Konto',
			'auth.unavailable' => 'Dein Fortschritt wird auf diesem Gerät gespeichert.',
			'auth.apple' => 'Mit Apple fortfahren',
			'auth.google' => 'Mit Google fortfahren',
			'auth.emailEntry' => 'Mit E-Mail anmelden',
			'auth.createTitle' => 'Konto erstellen',
			'auth.createSubtitle' => 'Dein Fortschritt bleibt auf diesem Gerät, bis die Synchronisierung verfügbar ist.',
			'auth.signInTitle' => 'Willkommen zurück',
			'auth.name' => 'Name',
			'auth.email' => 'E-Mail',
			'auth.password' => 'Passwort',
			'auth.passwordHint' => 'Mindestens 8 Zeichen',
			'auth.createAccount' => 'Konto erstellen',
			'auth.signIn' => 'Anmelden',
			'auth.alreadyAccount' => 'Du hast schon ein Konto?',
			'auth.noAccount' => 'Noch kein Konto?',
			'auth.forgotPassword' => 'Passwort vergessen?',
			'auth.resetTitle' => 'Passwort zurücksetzen',
			'auth.resetSubtitle' => 'Gib die E-Mail deines Kontos ein. Wir senden dir einen Link.',
			'auth.sendLink' => 'Link senden',
			'auth.resetSent' => 'Falls das Konto existiert, prüfe deine E-Mails auf den Link.',
			'auth.verifyTitle' => 'Prüfe deine E-Mails',
			'auth.verifySubtitle' => ({required Object email}) => 'Wir haben einen Bestätigungslink an ${email} gesendet.',
			'auth.checkVerification' => 'Ich habe meine E-Mail bestätigt',
			'auth.resendVerification' => 'Link erneut senden',
			'auth.verified' => 'Deine E-Mail ist bestätigt.',
			'auth.notVerified' => 'Die E-Mail ist noch nicht bestätigt.',
			'auth.signOut' => 'Abmelden',
			'auth.localNotSynced' => 'Dein Spielfortschritt bleibt auf diesem Gerät gespeichert.',
			'auth.verifyEmail' => 'E-Mail bestätigen',
			'auth.errorInvalidEmail' => 'Gib eine gültige E-Mail-Adresse ein.',
			'auth.errorPasswordLength' => 'Verwende mindestens 8 Zeichen.',
			'auth.errorNameRequired' => 'Gib deinen Namen ein.',
			'auth.errorWeakPassword' => 'Dieses Passwort ist zu schwach.',
			'auth.errorEmailInUse' => 'Für diese E-Mail gibt es bereits ein Konto.',
			'auth.errorWrongCredentials' => 'Prüfe E-Mail und Passwort.',
			'auth.errorDisabled' => 'Dieses Konto ist deaktiviert.',
			'auth.errorTooMany' => 'Zu viele Versuche. Versuche es später erneut.',
			'auth.errorNetwork' => 'Prüfe deine Verbindung und versuche es erneut.',
			'auth.errorUnavailable' => 'Der Kontodienst ist nicht verfügbar. Du kannst als Gast weiterspielen.',
			'auth.errorUnexpected' => 'Etwas ist schiefgegangen. Bitte versuche es erneut.',
			'auth.showPassword' => 'Passwort anzeigen',
			'auth.hidePassword' => 'Passwort verbergen',
			'auth.signOutTitle' => 'Vom Konto abmelden?',
			'auth.signOutBody' => 'Deine lokalen Spiele bleiben auf diesem Gerät.',
			'auth.cancel' => 'Abbrechen',
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
			'home.advanced' => 'Fortgeschritten',
			'home.expert' => 'Experte',
			'home.greeting' => 'Guten Morgen',
			'home.newPuzzle' => 'Ein weiteres Sudoku',
			'home.weekTitle' => 'Diese Woche',
			'home.weekDetails' => 'Details',
			'home.weekdaysShort' => 'Mo|Di|Mi|Do|Fr|Sa|So',
			'home.newPuzzleTitle' => 'Neues Sudoku',
			'home.catalogSource' => 'Sudoku auswählen',
			'home.scanSource' => 'Sudoku scannen',
			'home.scanSourceDetail' => 'Foto oder Kamera',
			'home.weekStatusDone' => 'Abgeschlossen',
			'home.weekStatusToday' => 'Heute',
			'home.weekStatusEmpty' => 'Keine Aktivität',
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
			'game.completionLogic' => 'gelöste Felder',
			'game.completionMistakes' => 'Fehler',
			'game.completionHints' => 'Hinweise',
			'game.dailyStampEarned' => 'Tagesstempel erhalten',
			'game.completionPracticeTechnique' => ({required Object technique}) => 'Nächster Schritt: ${technique}',
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
			'learn.lessons.hiddenPair.description' => 'Zwei Ziffern verbergen sich in denselben zwei Feldern.',
			'learn.lessons.hiddenPair.concept' => 'Suche ein verstecktes Paar nach Ziffern, nicht nach gleichen Kandidatenlisten.',
			'learn.lessons.hiddenPair.lookFor' => 'Finde zwei Ziffern, die in einer Einheit nur in denselben zwei Feldern vorkommen.',
			'learn.lessons.hiddenPair.reasoning' => 'Beide gehören in diese Felder; andere Kandidaten können dort weg.',
			'learn.lessons.hiddenPair.example' => 'Die markierten Felder sind die einzigen Plätze für beide Ziffern.',
			'learn.lessons.hiddenPair.tryIt' => 'Entferne zusätzliche Kandidaten aus diesen zwei Feldern.',
			'learn.lessons.boxLineReduction.description' => 'Eine Zeile oder Spalte begrenzt eine Ziffer auf einen Block.',
			'learn.lessons.boxLineReduction.concept' => 'Eine Linie kann eine Ziffer innerhalb eines Blocks festlegen.',
			'learn.lessons.boxLineReduction.lookFor' => 'Finde zwei oder drei Plätze einer Ziffer in einer Linie, alle im selben Block.',
			'learn.lessons.boxLineReduction.reasoning' => 'Die Ziffer liegt in diesem Block auf der Linie; entferne sie sonst im Block.',
			'learn.lessons.boxLineReduction.example' => 'Folge der markierten Linie in den Block und finde Kandidaten außerhalb.',
			'learn.lessons.boxLineReduction.tryIt' => 'Entferne die Ziffer aus den anderen Feldern des Blocks.',
			'learn.lessons.nakedTriple.description' => 'Drei Felder teilen nur drei mögliche Ziffern.',
			'learn.lessons.nakedTriple.concept' => 'Ein Drilling reserviert drei Ziffern für drei Felder einer Einheit.',
			'learn.lessons.nakedTriple.lookFor' => 'Finde drei Felder, deren Kandidaten zusammen genau drei Ziffern ergeben.',
			'learn.lessons.nakedTriple.reasoning' => 'Diese Ziffern füllen die Felder, auch wenn ihre Listen verschieden sind.',
			'learn.lessons.nakedTriple.example' => 'Die markierten Felder haben verschiedene Paare, aber insgesamt drei Ziffern.',
			'learn.lessons.nakedTriple.tryIt' => 'Entferne diese Ziffern aus den anderen Feldern der Einheit.',
			'learn.lessons.xWing.description' => 'Zwei Linien richten eine Ziffer an zwei Kreuzungen aus.',
			'learn.lessons.xWing.concept' => 'Ein X-Wing verbindet zwei Zeilen oder Spalten über eine Ziffer.',
			'learn.lessons.xWing.lookFor' => 'Finde zwei Linien, in denen die Ziffer zweimal an gleichen Positionen vorkommt.',
			'learn.lessons.xWing.reasoning' => 'Die vier Kreuzungen reservieren die Ziffer; entferne sie sonst auf den Kreuzlinien.',
			'learn.lessons.xWing.example' => 'Verfolge die vier markierten Plätze und die zwei Kreuzlinien.',
			'learn.lessons.xWing.tryIt' => 'Entferne die Ziffer außerhalb der vier Musterfelder.',
			'learn.basicsGroup' => 'Grundlagen',
			'learn.intermediateGroup' => 'Mittelstufe',
			'learn.advancedGroup' => 'Fortgeschritten',
			'learn.nowLabel' => 'Jetzt',
			'learn.groupProgress' => ({required Object completed, required Object total}) => '${completed} von ${total}',
			'learn.extraElimination' => 'Dieses Muster entfernt einen der gewählten Kandidaten nicht. Prüfe die markierten Felder.',
			'learn.missingElimination' => 'Weitere Kandidaten müssen entfernt werden. Folge der markierten Einheit.',
			'learn.wrongPlacement' => 'Dieses Feld oder diese Ziffer passt nicht zum Schluss. Prüfe die markierte Position.',
			'learn.minutes' => ({required Object count}) => '${count} Min.',
			'learn.tasks' => ({required Object count}) => '${count} Aufgaben',
			'learn.wrongCell' => 'Diese Zelle liegt außerhalb des Musters. Sieh dir die markierten Zellen an.',
			'learn.wrongDigit' => 'Dieses Muster setzt diese Zahl nicht. Prüfe die Kandidaten in der markierten Zelle.',
			'learn.wrongCellAndDigit' => 'Die Auswahl passt nicht zum Muster. Vergleiche die markierten Zellen und Kandidaten.',
			'learn.findTechnique' => ({required Object technique}) => 'Finde: ${technique}',
			'progress.doingWell' => 'Was gut läuft',
			'progress.learningNow' => 'Was du gerade lernst',
			'progress.next' => 'Nächster Schritt',
			'progress.noStrong' => 'Deine stärksten Techniken erscheinen nach dem Üben.',
			'progress.startLearning' => 'Lernen beginnen',
			'progress.thisWeek' => 'Diese Woche',
			'progress.completed' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Sudoku abgeschlossen', other: '${n} Sudokus abgeschlossen', ),
			'progress.mastery' => ({required Object percent}) => 'Beherrschung ${percent} %',
			'progress.openTechnique' => 'Technik öffnen',
			'profile.guest' => 'Gast',
			'profile.localOnly' => 'Dein Fortschritt wird auf diesem Gerät gespeichert.',
			'profile.puzzles' => 'Sudokus',
			'profile.mastered' => 'Gemeistert',
			'profile.activeDays' => 'Aktive Tage',
			'profile.learnRow' => 'Lernen',
			'profile.learnDetail' => 'Techniken und Übungen',
			'profile.settingsRow' => 'Einstellungen',
			'profile.settingsDetail' => 'Sprache',
			'profile.activity' => 'Deine Aktivität',
			'scanner.title' => 'Sudoku scannen',
			'scanner.intro' => 'Nimm das ganze Gitter auf oder wähle ein Foto aus.',
			'scanner.openCamera' => 'Kamera verwenden',
			'scanner.choosePhoto' => 'Foto auswählen',
			'scanner.shutter' => 'Foto aufnehmen',
			'scanner.frameGuide' => 'Alle vier Ecken sollten im Bild sein.',
			'scanner.processing' => 'Sudoku wird gelesen…',
			'scanner.reviewTitle' => 'Zahlen prüfen',
			'scanner.reviewBody' => 'Tippe auf ein Feld, um es vor dem Spielen zu korrigieren.',
			'scanner.needsReview' => 'Prüfen',
			'scanner.conflict' => 'Widersprüchliche Zahl',
			'scanner.selected' => 'ausgewählt',
			'scanner.recognized' => 'erkannt',
			'scanner.empty' => 'leer',
			'scanner.clear' => 'Löschen',
			'scanner.confirm' => 'Sudoku importieren',
			'scanner.rescan' => 'Erneut scannen',
			'scanner.permissionIntro' => 'Erlaube den Kamerazugriff, um ein Foto aufzunehmen.',
			'scanner.permissionDenied' => 'Der Kamerazugriff wurde verweigert. Du kannst ein Foto wählen.',
			'scanner.permissionSettings' => 'Aktiviere die Kamera in den Einstellungen oder wähle ein Foto.',
			'scanner.noCamera' => 'Keine Kamera verfügbar. Wähle ein Foto.',
			'scanner.openSettings' => 'Einstellungen öffnen',
			'scanner.imageDecodeFailure' => 'Das Bild konnte nicht gelesen werden. Versuche ein anderes Foto.',
			'scanner.noGridFound' => 'Kein Sudoku-Gitter gefunden. Nimm das ganze Gitter auf.',
			'scanner.invalidGeometry' => 'Das Gitter konnte nicht begradigt werden. Versuche ein schärferes Foto.',
			'scanner.segmentationFailure' => 'Das Gitter konnte nicht in Felder geteilt werden. Versuche es erneut.',
			'scanner.recognitionFailure' => 'Einige Zahlen konnten nicht gelesen werden. Versuche es erneut.',
			'scanner.duplicateClues' => 'Korrigiere die markierten widersprüchlichen Zahlen.',
			'scanner.noSolution' => 'Diese Zahlen haben keine Lösung. Prüfe sie.',
			'scanner.multipleSolutions' => 'Möglicherweise fehlen Zahlen; dieses Sudoku hat mehrere Lösungen.',
			'scanner.storageFailure' => 'Das importierte Sudoku konnte nicht gespeichert werden. Versuche es erneut.',
			'scanner.validationFailure' => 'Dieses Sudoku konnte nicht geprüft werden. Versuche es erneut zu bestätigen.',
			'scanner.unsupportedCoach' => 'MICHI kann möglicherweise noch nicht jeden Schritt dieses Sudokus erklären.',
			'scanner.importedTitle' => 'Importiertes Sudoku',
			'scanner.lowConfidenceCount' => ({required Object count}) => 'Zu prüfende Felder: ${count}',
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
			'coach.hiddenPair' => 'Verstecktes Paar',
			'coach.boxLineReduction' => 'Linien-Block-Reduktion',
			'coach.nakedTriple' => 'Nackter Drilling',
			'coach.xWing' => 'X-Wing',
			'coach.identifyHiddenPair' => 'Zwei Ziffern passen nur in dieselben zwei Felder. Entferne dort andere Kandidaten.',
			'coach.understandBoxLine' => 'Diese Ziffer ist in einer Linie auf einen Block beschränkt. Entferne sie sonst im Block.',
			'coach.understandTriple' => 'Drei Felder teilen genau drei Ziffern. Entferne sie aus den anderen Feldern der Einheit.',
			'coach.understandXWing' => 'Zwei Linien haben diese Ziffer an denselben zwei Kreuzungen. Entferne sie sonst auf den Kreuzlinien.',
			'why.title' => 'Erklärung',
			'why.whyHere' => ({required Object digit}) => 'Warum gehört ${digit} hierhin?',
			'why.givenTitle' => 'Diese Ziffer ist vorgegeben',
			'why.givenBody' => 'Sie stand von Anfang an im Rätsel, daher gibt es keinen Lösungsschritt zu erklären. Erklärungen gibt es für Ziffern, die du selbst einträgst.',
			'why.unavailableTitle' => 'Noch keine direkte Erklärung',
			'why.unavailableBody' => 'MICHI kann diesen Zug im Zustand davor nicht mit einer unterstützten Technik begründen.',
			'why.lesson' => 'Lektion',
			'why.gotIt' => 'Verstanden',
			'why.unitRestrictions' => ({required Object unit, required Object digits}) => 'In ${unit} stehen bereits diese Ziffern: ${digits}.',
			'why.onlyCandidate' => ({required Object digit}) => 'Zeile, Spalte und Block schließen die anderen Zahlen aus. Hier passt nur ${digit}.',
			'why.unitSearch' => ({required Object digit, required Object unit}) => 'Suche einen Platz für ${digit} in ${unit}.',
			'why.solePosition' => ({required Object digit, required Object unit}) => 'Die gestrichenen ${digit} zeigen, wo die Zahl in ${unit} nicht stehen kann. Nur dieses Feld bleibt.',
			'why.placement' => ({required Object digit}) => 'Deshalb gehört ${digit} hierhin.',
			'why.unitRow' => ({required Object index}) => 'Zeile ${index}',
			'why.unitColumn' => ({required Object index}) => 'Spalte ${index}',
			'why.unitBox' => ({required Object index}) => 'Block ${index}',
			'recommendation.focusTitle' => ({required Object technique}) => 'Fokus des Tages: ${technique}',
			'recommendation.learnAction' => ({required Object technique}) => 'Lernen: ${technique}',
			'recommendation.practiceAction' => ({required Object technique}) => 'Üben: ${technique}',
			'recommendation.reviewAction' => ({required Object technique}) => 'Wiederholen: ${technique}',
			'recommendation.duration' => ({required Object minutes}) => '${minutes} Min.',
			'recommendation.startWithBasics' => 'Beginne mit dem ersten logischen Schritt.',
			'recommendation.repeatedCoachHelp' => 'Du hast kürzlich MICHI-Hilfe gebraucht.',
			'recommendation.weakIndependentPractice' => 'Selbstständiges Üben sollte gefestigt werden.',
			'recommendation.continuePractice' => 'Übe diese Technik weiter.',
			'recommendation.nextTechnique' => 'Der nächste Schritt auf deinem Weg.',
			'recommendation.masteredNeedsReview' => 'Eine bekannte Technik braucht Wiederholung.',
			'recommendation.allMasteredReview' => 'Wiederhole eine bereits beherrschte Technik.',
			'week.title' => 'Diese Woche',
			'week.empty' => 'Diese Woche hast du noch kein Sudoku abgeschlossen. Deine Aktivität erscheint beim Spielen.',
			'week.puzzles' => 'Sudokus',
			'week.minutes' => 'Minuten',
			'week.daily' => 'Täglich',
			'week.activeDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} aktiver Tag', other: '${n} aktive Tage', ),
			'week.completedDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Sudoku abgeschlossen', other: '${n} Sudokus abgeschlossen', ),
			'week.today' => 'Heute',
			'week.noActivity' => 'Keine Aktivität',
			'week.summary' => 'Deine lokalen Sudoku-Aktivitäten',
			'settings.title' => 'Einstellungen',
			'settings.language' => 'Sprache',
			'settings.languageDetail' => 'Wähle die Sprache für MICHI.',
			'sync.account' => 'Konto',
			'sync.email' => 'E-Mail',
			'sync.synchronization' => 'Synchronisierung',
			'sync.syncing' => 'Wird synchronisiert…',
			'sync.synced' => 'Kürzlich synchronisiert',
			'sync.lastSynced' => ({required Object time}) => 'Zuletzt synchronisiert — ${time}',
			'sync.pending' => 'Lokal gespeichert · wartet auf Synchronisierung',
			'sync.offline' => 'Offline. Dein Fortschritt wird gespeichert und später synchronisiert.',
			'sync.error' => 'Synchronisierungsfehler',
			'sync.retry' => 'Erneut versuchen',
			'sync.guest' => 'Der Fortschritt ist nur auf diesem Gerät gespeichert.',
			'sync.deleteAccount' => 'Konto löschen',
			'sync.deleteTitle' => 'Konto löschen?',
			'sync.deleteBody' => 'Dein Konto und dein synchronisierter Fortschritt werden dauerhaft gelöscht.',
			'sync.deleteConfirm' => 'Konto löschen',
			'sync.deleteFailed' => 'Dein Konto konnte nicht gelöscht werden. Melde dich erneut an und versuche es noch einmal.',
			'sync.signOut' => 'Abmelden',
			_ => null,
		};
	}
}
