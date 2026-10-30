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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$fr common = _Translations$common$fr._(_root);
	@override late final _Translations$splash$fr splash = _Translations$splash$fr._(_root);
	@override late final _Translations$welcome$fr welcome = _Translations$welcome$fr._(_root);
	@override late final _Translations$onboarding$fr onboarding = _Translations$onboarding$fr._(_root);
	@override late final _Translations$playerLevel$fr playerLevel = _Translations$playerLevel$fr._(_root);
	@override late final _Translations$auth$fr auth = _Translations$auth$fr._(_root);
	@override late final _Translations$home$fr home = _Translations$home$fr._(_root);
	@override late final _Translations$game$fr game = _Translations$game$fr._(_root);
	@override late final _Translations$learn$fr learn = _Translations$learn$fr._(_root);
	@override late final _Translations$progress$fr progress = _Translations$progress$fr._(_root);
	@override late final _Translations$profile$fr profile = _Translations$profile$fr._(_root);
	@override late final _Translations$scanner$fr scanner = _Translations$scanner$fr._(_root);
	@override late final _Translations$coach$fr coach = _Translations$coach$fr._(_root);
}

// Path: common
class _Translations$common$fr extends Translations$common$uk {
	_Translations$common$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Continuer';
	@override String get start => 'Commencer';
}

// Path: splash
class _Translations$splash$fr extends Translations$splash$uk {
	_Translations$splash$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Apprends à voir le prochain coup.';
}

// Path: welcome
class _Translations$welcome$fr extends Translations$welcome$uk {
	_Translations$welcome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton parcours dans le sudoku.';
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$uk {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton apprentissage commence ici.';
	@override String get chooseLevel => 'Choisir ton niveau';
}

// Path: playerLevel
class _Translations$playerLevel$fr extends Translations$playerLevel$uk {
	_Translations$playerLevel$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connais-tu bien le sudoku ?';
	@override String get goToGame => 'Commencer à jouer';
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$uk {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compte';
	@override String get unavailable => 'La synchronisation de la progression arrivera plus tard.';
}

// Path: home
class _Translations$home$fr extends Translations$home$uk {
	_Translations$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton parcours dans le sudoku';
	@override String get game => 'Jouer';
	@override String get continueGame => 'Continuer la partie';
	@override String continueDetails({required Object date, required Object progress, required Object time}) => 'Commencé le ${date} · ${progress} % · ${time}';
	@override String get replaceTitle => 'Commencer un nouveau sudoku ?';
	@override String get replaceBody => 'La partie en cours sera remplacée.';
	@override String get keepPlaying => 'Continuer la partie';
	@override String get startNew => 'Commencer un nouveau';
	@override String get storageUnavailable => 'Partie sauvegardée indisponible. Réessayez plus tard.';
	@override String get loading => 'Recherche de la partie sauvegardée…';
	@override String get learn => 'Apprendre';
	@override String get progress => 'Progression';
	@override String get profile => 'Profil';
	@override String get scanner => 'Scanner';
	@override String get chooseDifficulty => 'Choisissez une difficulté';
	@override String get easy => 'Facile';
	@override String get medium => 'Moyen';
	@override String get dailyTitle => 'Sudoku du jour';
	@override String get dailyStart => 'Commencer le sudoku du jour';
	@override String get dailyContinue => 'Reprendre le sudoku du jour';
	@override String get dailyCompleted => 'Terminé aujourd’hui';
	@override String get contentUnavailable => 'Les grilles sont indisponibles. Réessayez.';
}

// Path: game
class _Translations$game$fr extends Translations$game$uk {
	_Translations$game$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sudoku du jour · Moyen';
	@override String get undo => 'Annuler';
	@override String get erase => 'Effacer';
	@override String get notes => 'Notes';
	@override String get hint => 'Indice';
	@override String mistakes({required Object count}) => 'Erreurs : ${count} sur 3';
	@override String get notesModeOn => 'Mode notes : touchez un chiffre pour modifier les candidats';
	@override String get row => 'Ligne';
	@override String get column => 'colonne';
	@override String get empty => 'vide';
	@override String get given => 'donnée';
	@override String get entered => 'saisie';
	@override String get selected => 'sélectionnée';
	@override String get error => 'incorrecte';
	@override String get candidates => 'candidats';
	@override String get completeTitle => 'Résolu.';
	@override String get completeBody => 'Vous avez terminé ce sudoku.';
	@override String get backHome => 'Retour à l’accueil';
	@override String get pause => 'Pause';
	@override String get pausedTitle => 'En pause';
	@override String get resume => 'Reprendre';
	@override String pausedAt({required Object time}) => 'Chronomètre arrêté à ${time}';
	@override String get loading => 'Préparation du sudoku…';
	@override String get restoreUnavailable => 'Impossible de restaurer la partie.';
	@override String get saveFailed => 'Impossible de sauvegarder la partie.';
	@override String get retrySave => 'Réessayer';
	@override String completionStats({required Object mistakes, required Object hints}) => '${mistakes} erreurs · ${hints} indices';
	@override String get standardTitle => 'Sudoku';
	@override String get dailyTitle => 'Sudoku du jour';
}

// Path: learn
class _Translations$learn$fr extends Translations$learn$uk {
	_Translations$learn$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apprendre';
	@override String get intro => 'Une technique, une étape claire à la fois.';
	@override String get newLabel => 'Nouveau';
	@override String get learningLabel => 'En cours';
	@override String get practicingLabel => 'En pratique';
	@override String get masteredLabel => 'Maîtrisé';
	@override String get planTitle => 'Plan de la leçon';
	@override String get lessonStart => 'Commencer la leçon';
	@override String get next => 'Suivant';
	@override String get practiceStart => 'Commencer la pratique';
	@override String get concept => 'Concept';
	@override String get lookFor => 'À repérer';
	@override String get reasoning => 'Pourquoi ça marche';
	@override String get example => 'Exemple';
	@override String get tryIt => 'À toi de jouer';
	@override String exercise({required Object current, required Object total}) => 'Exercice ${current} sur ${total}';
	@override String get placementPrompt => 'Choisis une case et un chiffre.';
	@override String get eliminationPrompt => 'Choisis une case puis marque tous les candidats à éliminer.';
	@override String get checkAnswer => 'Vérifier';
	@override String get correctTitle => 'Bien vu';
	@override String get incorrectTitle => 'Pas tout à fait';
	@override String get tryAgain => 'Réessayer';
	@override String get askMichi => 'Demander à MICHI';
	@override String get nextScenario => 'Exercice suivant';
	@override String get sessionSummary => 'Pratique terminée';
	@override String summaryStats({required Object correct, required Object attempts}) => '${correct} corrects · ${attempts} essais';
	@override String hintsUsed({required Object count}) => '${count} avec MICHI';
	@override String get done => 'Terminé';
	@override String get loading => 'Préparation de la leçon…';
	@override String get unavailable => 'Le contenu est indisponible. Réessaie.';
	@override String get noScenarios => 'Aucun exercice disponible pour le moment.';
	@override String get saveFailed => 'Impossible d’enregistrer la progression. Réessaie.';
	@override String get selectedForElimination => 'Sélectionné pour élimination';
	@override String get requiredTechniques => 'Techniques de cette grille';
	@override String get helpedTechniques => 'MICHI a aidé avec';
	@override String get noHints => 'Aucun indice utilisé';
	@override String get practiceTitle => 'Pratique';
	@override String get continueLesson => 'Continuer la leçon';
	@override late final _Translations$learn$lessons$fr lessons = _Translations$learn$lessons$fr._(_root);
}

// Path: progress
class _Translations$progress$fr extends Translations$progress$uk {
	_Translations$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Le suivi des techniques maîtrisées arrivera plus tard.';
}

// Path: profile
class _Translations$profile$fr extends Translations$profile$uk {
	_Translations$profile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Les réglages du profil arriveront plus tard.';
}

// Path: scanner
class _Translations$scanner$fr extends Translations$scanner$uk {
	_Translations$scanner$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'L’importation par caméra suivra le jeu principal.';
}

// Path: coach
class _Translations$coach$fr extends Translations$coach$uk {
	_Translations$coach$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String step({required Object step}) => 'Indice ${step} sur 4';
	@override String get kTry => 'Je vais essayer';
	@override String get show => 'Afficher';
	@override String get see => 'Je vois';
	@override String get more => 'Autre indice';
	@override String get close => 'Fermer';
	@override String get showMistake => 'Voir l’erreur';
	@override String place({required Object digit}) => 'Placer ${digit}';
	@override String unitRow({required Object index}) => 'ligne ${index}';
	@override String unitColumn({required Object index}) => 'colonne ${index}';
	@override String unitBox({required Object index}) => 'bloc ${index}';
	@override String get inspectCell => 'Regardez la case en surbrillance.';
	@override String inspectUnit({required Object unit}) => 'Regardez la ${unit} en surbrillance.';
	@override String get inspectCandidates => 'Quels chiffres peuvent aller dans cette case ?';
	@override String inspectPositions({required Object unit}) => 'Où ce chiffre peut-il aller dans la ${unit} ?';
	@override String get inspectPair => 'Trouvez deux cases avec les mêmes deux candidats.';
	@override String get singleRemains => 'Il ne reste qu’un seul candidat dans cette case.';
	@override String onlyPosition({required Object unit}) => 'Il ne reste qu’une place pour ce chiffre dans la ${unit}.';
	@override String pairRestriction({required Object unit}) => 'Ces deux chiffres occupent la paire surlignée. Vous pouvez les éliminer ailleurs dans la ${unit}.';
	@override String get alignment => 'Les candidats sont alignés : ce chiffre peut être éliminé hors du bloc.';
	@override String resultPlacement({required Object digit}) => '${digit} ne peut aller que dans la case surlignée.';
	@override String get resultEliminations => 'Retirez les candidats barrés des cases surlignées.';
	@override String get resultActions => 'Appliquez l’étape logique surlignée.';
	@override String technique({required Object name}) => 'Technique : ${name}';
	@override String get nakedSingle => 'candidat unique';
	@override String get hiddenSingle => 'unique caché';
	@override String get nakedPair => 'paire nue';
	@override String get pointingPair => 'paire pointante';
	@override String get unavailable => 'Indice indisponible';
	@override String get wrongTitle => 'Corrigez d’abord l’erreur.';
	@override String get wrongBody => 'Impossible de trouver une étape logique tant qu’un chiffre est incorrect.';
	@override String get stuckTitle => 'Aucune étape prise en charge.';
	@override String get stuckBody => 'MICHI ne peut pas encore expliquer la prochaine étape avec les techniques disponibles.';
}

// Path: learn.lessons
class _Translations$learn$lessons$fr extends Translations$learn$lessons$uk {
	_Translations$learn$lessons$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learn$lessons$nakedSingle$fr nakedSingle = _Translations$learn$lessons$nakedSingle$fr._(_root);
	@override late final _Translations$learn$lessons$hiddenSingle$fr hiddenSingle = _Translations$learn$lessons$hiddenSingle$fr._(_root);
	@override late final _Translations$learn$lessons$nakedPair$fr nakedPair = _Translations$learn$lessons$nakedPair$fr._(_root);
	@override late final _Translations$learn$lessons$pointingPair$fr pointingPair = _Translations$learn$lessons$pointingPair$fr._(_root);
}

// Path: learn.lessons.nakedSingle
class _Translations$learn$lessons$nakedSingle$fr extends Translations$learn$lessons$nakedSingle$uk {
	_Translations$learn$lessons$nakedSingle$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Une case vide n’admet plus qu’un seul chiffre.';
	@override String get concept => 'Les candidats sont les chiffres encore possibles dans une case vide.';
	@override String get lookFor => 'Repère une case où ligne, colonne et bloc excluent tous les chiffres sauf un.';
	@override String get reasoning => 'Il reste un candidat : ce chiffre doit aller dans cette case.';
	@override String get example => 'La case surlignée n’a qu’un candidat possible.';
	@override String get tryIt => 'Choisis la case et place le chiffre restant.';
}

// Path: learn.lessons.hiddenSingle
class _Translations$learn$lessons$hiddenSingle$fr extends Translations$learn$lessons$hiddenSingle$uk {
	_Translations$learn$lessons$hiddenSingle$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Un chiffre n’a qu’une seule position dans une ligne, colonne ou bloc.';
	@override String get concept => 'Observe un chiffre dans toute une unité, pas tous les candidats d’une case.';
	@override String get lookFor => 'Trouve la seule position où ce chiffre peut encore aller.';
	@override String get reasoning => 'La case peut avoir plusieurs candidats, mais ce chiffre n’a qu’une place.';
	@override String get example => 'L’unité surlignée laisse une seule position pour le chiffre.';
	@override String get tryIt => 'Choisis cette position et place le chiffre.';
}

// Path: learn.lessons.nakedPair
class _Translations$learn$lessons$nakedPair$fr extends Translations$learn$lessons$nakedPair$uk {
	_Translations$learn$lessons$nakedPair$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Deux cases d’une unité ont les mêmes deux candidats.';
	@override String get concept => 'La paire réserve ces deux chiffres à ces deux cases.';
	@override String get lookFor => 'Repère deux cases d’une même unité avec exactement les mêmes deux candidats.';
	@override String get reasoning => 'Ces chiffres sont impossibles ailleurs dans l’unité : élimine-les.';
	@override String get example => 'La paire surlignée élimine des candidats dans d’autres cases.';
	@override String get tryIt => 'Marque tous les candidats éliminés. Aucun chiffre n’est encore placé.';
}

// Path: learn.lessons.pointingPair
class _Translations$learn$lessons$pointingPair$fr extends Translations$learn$lessons$pointingPair$uk {
	_Translations$learn$lessons$pointingPair$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Deux positions d’un candidat dans un bloc partagent une ligne ou colonne.';
	@override String get concept => 'Un bloc peut limiter un chiffre à une seule ligne.';
	@override String get lookFor => 'Trouve exactement deux positions alignées pour ce chiffre dans le bloc.';
	@override String get reasoning => 'Le chiffre reste dans le bloc : élimine-le hors du bloc sur la même ligne.';
	@override String get example => 'Suis la ligne surlignée hors du bloc.';
	@override String get tryIt => 'Marque tous les candidats éliminés hors du bloc.';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Continuer',
			'common.start' => 'Commencer',
			'splash.subtitle' => 'Apprends à voir le prochain coup.',
			'welcome.title' => 'Ton parcours dans le sudoku.',
			'onboarding.title' => 'Ton apprentissage commence ici.',
			'onboarding.chooseLevel' => 'Choisir ton niveau',
			'playerLevel.title' => 'Connais-tu bien le sudoku ?',
			'playerLevel.goToGame' => 'Commencer à jouer',
			'auth.title' => 'Compte',
			'auth.unavailable' => 'La synchronisation de la progression arrivera plus tard.',
			'home.title' => 'Ton parcours dans le sudoku',
			'home.game' => 'Jouer',
			'home.continueGame' => 'Continuer la partie',
			'home.continueDetails' => ({required Object date, required Object progress, required Object time}) => 'Commencé le ${date} · ${progress} % · ${time}',
			'home.replaceTitle' => 'Commencer un nouveau sudoku ?',
			'home.replaceBody' => 'La partie en cours sera remplacée.',
			'home.keepPlaying' => 'Continuer la partie',
			'home.startNew' => 'Commencer un nouveau',
			'home.storageUnavailable' => 'Partie sauvegardée indisponible. Réessayez plus tard.',
			'home.loading' => 'Recherche de la partie sauvegardée…',
			'home.learn' => 'Apprendre',
			'home.progress' => 'Progression',
			'home.profile' => 'Profil',
			'home.scanner' => 'Scanner',
			'home.chooseDifficulty' => 'Choisissez une difficulté',
			'home.easy' => 'Facile',
			'home.medium' => 'Moyen',
			'home.dailyTitle' => 'Sudoku du jour',
			'home.dailyStart' => 'Commencer le sudoku du jour',
			'home.dailyContinue' => 'Reprendre le sudoku du jour',
			'home.dailyCompleted' => 'Terminé aujourd’hui',
			'home.contentUnavailable' => 'Les grilles sont indisponibles. Réessayez.',
			'game.title' => 'Sudoku du jour · Moyen',
			'game.undo' => 'Annuler',
			'game.erase' => 'Effacer',
			'game.notes' => 'Notes',
			'game.hint' => 'Indice',
			'game.mistakes' => ({required Object count}) => 'Erreurs : ${count} sur 3',
			'game.notesModeOn' => 'Mode notes : touchez un chiffre pour modifier les candidats',
			'game.row' => 'Ligne',
			'game.column' => 'colonne',
			'game.empty' => 'vide',
			'game.given' => 'donnée',
			'game.entered' => 'saisie',
			'game.selected' => 'sélectionnée',
			'game.error' => 'incorrecte',
			'game.candidates' => 'candidats',
			'game.completeTitle' => 'Résolu.',
			'game.completeBody' => 'Vous avez terminé ce sudoku.',
			'game.backHome' => 'Retour à l’accueil',
			'game.pause' => 'Pause',
			'game.pausedTitle' => 'En pause',
			'game.resume' => 'Reprendre',
			'game.pausedAt' => ({required Object time}) => 'Chronomètre arrêté à ${time}',
			'game.loading' => 'Préparation du sudoku…',
			'game.restoreUnavailable' => 'Impossible de restaurer la partie.',
			'game.saveFailed' => 'Impossible de sauvegarder la partie.',
			'game.retrySave' => 'Réessayer',
			'game.completionStats' => ({required Object mistakes, required Object hints}) => '${mistakes} erreurs · ${hints} indices',
			'game.standardTitle' => 'Sudoku',
			'game.dailyTitle' => 'Sudoku du jour',
			'learn.title' => 'Apprendre',
			'learn.intro' => 'Une technique, une étape claire à la fois.',
			'learn.newLabel' => 'Nouveau',
			'learn.learningLabel' => 'En cours',
			'learn.practicingLabel' => 'En pratique',
			'learn.masteredLabel' => 'Maîtrisé',
			'learn.planTitle' => 'Plan de la leçon',
			'learn.lessonStart' => 'Commencer la leçon',
			'learn.next' => 'Suivant',
			'learn.practiceStart' => 'Commencer la pratique',
			'learn.concept' => 'Concept',
			'learn.lookFor' => 'À repérer',
			'learn.reasoning' => 'Pourquoi ça marche',
			'learn.example' => 'Exemple',
			'learn.tryIt' => 'À toi de jouer',
			'learn.exercise' => ({required Object current, required Object total}) => 'Exercice ${current} sur ${total}',
			'learn.placementPrompt' => 'Choisis une case et un chiffre.',
			'learn.eliminationPrompt' => 'Choisis une case puis marque tous les candidats à éliminer.',
			'learn.checkAnswer' => 'Vérifier',
			'learn.correctTitle' => 'Bien vu',
			'learn.incorrectTitle' => 'Pas tout à fait',
			'learn.tryAgain' => 'Réessayer',
			'learn.askMichi' => 'Demander à MICHI',
			'learn.nextScenario' => 'Exercice suivant',
			'learn.sessionSummary' => 'Pratique terminée',
			'learn.summaryStats' => ({required Object correct, required Object attempts}) => '${correct} corrects · ${attempts} essais',
			'learn.hintsUsed' => ({required Object count}) => '${count} avec MICHI',
			'learn.done' => 'Terminé',
			'learn.loading' => 'Préparation de la leçon…',
			'learn.unavailable' => 'Le contenu est indisponible. Réessaie.',
			'learn.noScenarios' => 'Aucun exercice disponible pour le moment.',
			'learn.saveFailed' => 'Impossible d’enregistrer la progression. Réessaie.',
			'learn.selectedForElimination' => 'Sélectionné pour élimination',
			'learn.requiredTechniques' => 'Techniques de cette grille',
			'learn.helpedTechniques' => 'MICHI a aidé avec',
			'learn.noHints' => 'Aucun indice utilisé',
			'learn.practiceTitle' => 'Pratique',
			'learn.continueLesson' => 'Continuer la leçon',
			'learn.lessons.nakedSingle.description' => 'Une case vide n’admet plus qu’un seul chiffre.',
			'learn.lessons.nakedSingle.concept' => 'Les candidats sont les chiffres encore possibles dans une case vide.',
			'learn.lessons.nakedSingle.lookFor' => 'Repère une case où ligne, colonne et bloc excluent tous les chiffres sauf un.',
			'learn.lessons.nakedSingle.reasoning' => 'Il reste un candidat : ce chiffre doit aller dans cette case.',
			'learn.lessons.nakedSingle.example' => 'La case surlignée n’a qu’un candidat possible.',
			'learn.lessons.nakedSingle.tryIt' => 'Choisis la case et place le chiffre restant.',
			'learn.lessons.hiddenSingle.description' => 'Un chiffre n’a qu’une seule position dans une ligne, colonne ou bloc.',
			'learn.lessons.hiddenSingle.concept' => 'Observe un chiffre dans toute une unité, pas tous les candidats d’une case.',
			'learn.lessons.hiddenSingle.lookFor' => 'Trouve la seule position où ce chiffre peut encore aller.',
			'learn.lessons.hiddenSingle.reasoning' => 'La case peut avoir plusieurs candidats, mais ce chiffre n’a qu’une place.',
			'learn.lessons.hiddenSingle.example' => 'L’unité surlignée laisse une seule position pour le chiffre.',
			'learn.lessons.hiddenSingle.tryIt' => 'Choisis cette position et place le chiffre.',
			'learn.lessons.nakedPair.description' => 'Deux cases d’une unité ont les mêmes deux candidats.',
			'learn.lessons.nakedPair.concept' => 'La paire réserve ces deux chiffres à ces deux cases.',
			'learn.lessons.nakedPair.lookFor' => 'Repère deux cases d’une même unité avec exactement les mêmes deux candidats.',
			'learn.lessons.nakedPair.reasoning' => 'Ces chiffres sont impossibles ailleurs dans l’unité : élimine-les.',
			'learn.lessons.nakedPair.example' => 'La paire surlignée élimine des candidats dans d’autres cases.',
			'learn.lessons.nakedPair.tryIt' => 'Marque tous les candidats éliminés. Aucun chiffre n’est encore placé.',
			'learn.lessons.pointingPair.description' => 'Deux positions d’un candidat dans un bloc partagent une ligne ou colonne.',
			'learn.lessons.pointingPair.concept' => 'Un bloc peut limiter un chiffre à une seule ligne.',
			'learn.lessons.pointingPair.lookFor' => 'Trouve exactement deux positions alignées pour ce chiffre dans le bloc.',
			'learn.lessons.pointingPair.reasoning' => 'Le chiffre reste dans le bloc : élimine-le hors du bloc sur la même ligne.',
			'learn.lessons.pointingPair.example' => 'Suis la ligne surlignée hors du bloc.',
			'learn.lessons.pointingPair.tryIt' => 'Marque tous les candidats éliminés hors du bloc.',
			'progress.unavailable' => 'Le suivi des techniques maîtrisées arrivera plus tard.',
			'profile.unavailable' => 'Les réglages du profil arriveront plus tard.',
			'scanner.unavailable' => 'L’importation par caméra suivra le jeu principal.',
			'coach.step' => ({required Object step}) => 'Indice ${step} sur 4',
			'coach.kTry' => 'Je vais essayer',
			'coach.show' => 'Afficher',
			'coach.see' => 'Je vois',
			'coach.more' => 'Autre indice',
			'coach.close' => 'Fermer',
			'coach.showMistake' => 'Voir l’erreur',
			'coach.place' => ({required Object digit}) => 'Placer ${digit}',
			'coach.unitRow' => ({required Object index}) => 'ligne ${index}',
			'coach.unitColumn' => ({required Object index}) => 'colonne ${index}',
			'coach.unitBox' => ({required Object index}) => 'bloc ${index}',
			'coach.inspectCell' => 'Regardez la case en surbrillance.',
			'coach.inspectUnit' => ({required Object unit}) => 'Regardez la ${unit} en surbrillance.',
			'coach.inspectCandidates' => 'Quels chiffres peuvent aller dans cette case ?',
			'coach.inspectPositions' => ({required Object unit}) => 'Où ce chiffre peut-il aller dans la ${unit} ?',
			'coach.inspectPair' => 'Trouvez deux cases avec les mêmes deux candidats.',
			'coach.singleRemains' => 'Il ne reste qu’un seul candidat dans cette case.',
			'coach.onlyPosition' => ({required Object unit}) => 'Il ne reste qu’une place pour ce chiffre dans la ${unit}.',
			'coach.pairRestriction' => ({required Object unit}) => 'Ces deux chiffres occupent la paire surlignée. Vous pouvez les éliminer ailleurs dans la ${unit}.',
			'coach.alignment' => 'Les candidats sont alignés : ce chiffre peut être éliminé hors du bloc.',
			'coach.resultPlacement' => ({required Object digit}) => '${digit} ne peut aller que dans la case surlignée.',
			'coach.resultEliminations' => 'Retirez les candidats barrés des cases surlignées.',
			'coach.resultActions' => 'Appliquez l’étape logique surlignée.',
			'coach.technique' => ({required Object name}) => 'Technique : ${name}',
			'coach.nakedSingle' => 'candidat unique',
			'coach.hiddenSingle' => 'unique caché',
			'coach.nakedPair' => 'paire nue',
			'coach.pointingPair' => 'paire pointante',
			'coach.unavailable' => 'Indice indisponible',
			'coach.wrongTitle' => 'Corrigez d’abord l’erreur.',
			'coach.wrongBody' => 'Impossible de trouver une étape logique tant qu’un chiffre est incorrect.',
			'coach.stuckTitle' => 'Aucune étape prise en charge.',
			'coach.stuckBody' => 'MICHI ne peut pas encore expliquer la prochaine étape avec les techniques disponibles.',
			_ => null,
		};
	}
}
