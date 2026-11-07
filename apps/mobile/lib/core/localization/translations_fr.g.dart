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
	@override late final _Translations$why$fr why = _Translations$why$fr._(_root);
	@override late final _Translations$recommendation$fr recommendation = _Translations$recommendation$fr._(_root);
	@override late final _Translations$week$fr week = _Translations$week$fr._(_root);
	@override late final _Translations$settings$fr settings = _Translations$settings$fr._(_root);
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
	@override String get title => 'Trouve ton chemin grâce à la logique.';
	@override String get subtitle => 'Un sudoku avec un guide qui t’aide sans résoudre à ta place.';
	@override String get guest => 'Commencer sans compte';
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$uk {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton apprentissage commence ici.';
	@override String get chooseLevel => 'Choisir ton niveau';
	@override String get skip => 'Passer';
	@override String get next => 'Suivant';
	@override String get seeTitle => 'Le sudoku devient plus simple quand tu sais où regarder.';
	@override String get seeBody => 'MICHI explique la logique de chaque coup.';
	@override String get hintsTitle => 'Des indices qui enseignent.';
	@override String get hintsBody => 'Commence par une légère piste. Demande plus si besoin.';
	@override String get patternsTitle => 'Apprends les motifs, pas les réponses.';
	@override String get patternsBody => 'Simples cachés, paires, X-Wing : à ton rythme.';
	@override String get pathTitle => 'Ton chemin dans le sudoku.';
	@override String get pathBody => 'MICHI repère tes difficultés et te suggère quoi travailler.';
}

// Path: playerLevel
class _Translations$playerLevel$fr extends Translations$playerLevel$uk {
	_Translations$playerLevel$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connais-tu bien le sudoku ?';
	@override String get goToGame => 'Commencer à jouer';
	@override String get subtitle => 'Cela détermine ta première leçon et la difficulté. Tu peux changer plus tard.';
	@override String get beginner => 'Je débute';
	@override String get beginnerDetail => 'Règles et premiers coups';
	@override String get basics => 'Je connais les bases';
	@override String get basicsDetail => 'Simples et candidats';
	@override String get regular => 'Je joue régulièrement';
	@override String get regularDetail => 'Paires et paires pointantes';
	@override String get advanced => 'Je veux un défi';
	@override String get advancedDetail => 'X-Wing et au-delà';
}

// Path: auth
class _Translations$auth$fr extends Translations$auth$uk {
	_Translations$auth$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Compte';
	@override String get unavailable => 'Ta progression est enregistrée sur cet appareil.';
	@override String get apple => 'Continuer avec Apple';
	@override String get google => 'Continuer avec Google';
	@override String get emailEntry => 'Se connecter par e-mail';
	@override String get createTitle => 'Créer un compte';
	@override String get createSubtitle => 'Ta progression reste sur cet appareil jusqu’à ce que la synchronisation soit disponible.';
	@override String get signInTitle => 'Bon retour';
	@override String get name => 'Nom';
	@override String get email => 'E-mail';
	@override String get password => 'Mot de passe';
	@override String get passwordHint => 'Au moins 8 caractères';
	@override String get createAccount => 'Créer le compte';
	@override String get signIn => 'Se connecter';
	@override String get alreadyAccount => 'Tu as déjà un compte ?';
	@override String get noAccount => 'Pas encore de compte ?';
	@override String get forgotPassword => 'Mot de passe oublié ?';
	@override String get resetTitle => 'Réinitialiser le mot de passe';
	@override String get resetSubtitle => 'Saisis l’e-mail de ton compte pour recevoir un lien de réinitialisation.';
	@override String get sendLink => 'Envoyer le lien';
	@override String get resetSent => 'Si le compte existe, vérifie tes e-mails pour trouver le lien.';
	@override String get verifyTitle => 'Vérifie tes e-mails';
	@override String verifySubtitle({required Object email}) => 'Nous avons envoyé un lien de vérification à ${email}.';
	@override String get checkVerification => 'J’ai vérifié mon e-mail';
	@override String get resendVerification => 'Renvoyer le lien';
	@override String get verified => 'Ton e-mail est vérifié.';
	@override String get notVerified => 'L’e-mail n’est pas encore vérifié.';
	@override String get signOut => 'Se déconnecter';
	@override String get localNotSynced => 'La progression du jeu reste enregistrée sur cet appareil.';
	@override String get verifyEmail => 'Vérifier l’e-mail';
	@override String get errorInvalidEmail => 'Saisis une adresse e-mail valide.';
	@override String get errorPasswordLength => 'Utilise au moins 8 caractères.';
	@override String get errorNameRequired => 'Saisis ton nom.';
	@override String get errorWeakPassword => 'Ce mot de passe est trop faible.';
	@override String get errorEmailInUse => 'Un compte utilise déjà cet e-mail.';
	@override String get errorWrongCredentials => 'Vérifie ton e-mail et ton mot de passe.';
	@override String get errorDisabled => 'Ce compte est désactivé.';
	@override String get errorTooMany => 'Trop de tentatives. Réessaie plus tard.';
	@override String get errorNetwork => 'Vérifie ta connexion et réessaie.';
	@override String get errorUnavailable => 'Le service de comptes est indisponible. Tu peux continuer sans compte.';
	@override String get errorUnexpected => 'Une erreur s’est produite. Réessaie.';
	@override String get showPassword => 'Afficher le mot de passe';
	@override String get hidePassword => 'Masquer le mot de passe';
	@override String get signOutTitle => 'Te déconnecter ?';
	@override String get signOutBody => 'Tes parties locales resteront sur cet appareil.';
	@override String get cancel => 'Annuler';
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
	@override String get advanced => 'Avancé';
	@override String get expert => 'Expert';
	@override String get greeting => 'Bonjour';
	@override String get newPuzzle => 'Un autre sudoku';
	@override String get weekTitle => 'Cette semaine';
	@override String get weekDetails => 'Détails';
	@override String get weekdaysShort => 'Lu|Ma|Me|Je|Ve|Sa|Di';
	@override String get newPuzzleTitle => 'Nouveau sudoku';
	@override String get catalogSource => 'Choisir un sudoku';
	@override String get scanSource => 'Scanner un sudoku';
	@override String get scanSourceDetail => 'Photo ou appareil photo';
	@override String get weekStatusDone => 'Terminé';
	@override String get weekStatusToday => 'Aujourd’hui';
	@override String get weekStatusEmpty => 'Aucune activité';
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
	@override String get completionLogic => 'cases résolues';
	@override String get completionMistakes => 'erreurs';
	@override String get completionHints => 'indices';
	@override String get dailyStampEarned => 'Tampon quotidien obtenu';
	@override String completionPracticeTechnique({required Object technique}) => 'Prochaine étape : ${technique}';
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
	@override String get basicsGroup => 'Bases';
	@override String get intermediateGroup => 'Niveau intermédiaire';
	@override String get advancedGroup => 'Niveau avancé';
	@override String get nowLabel => 'Maintenant';
	@override String groupProgress({required Object completed, required Object total}) => '${completed} sur ${total}';
	@override String get extraElimination => 'Ce motif ne retire pas l’un des candidats choisis. Vérifie les cases surlignées.';
	@override String get missingElimination => 'Il reste des candidats à retirer. Suis l’unité surlignée.';
	@override String get wrongPlacement => 'Cette case ou ce chiffre ne correspond pas à la déduction. Revérifie la position.';
	@override String minutes({required Object count}) => '${count} min';
	@override String tasks({required Object count}) => '${count} exercices';
	@override String get wrongCell => 'Cette case est hors du motif. Regarde les cases surlignées.';
	@override String get wrongDigit => 'Ce motif ne place pas ce chiffre. Vérifie les candidats de la case surlignée.';
	@override String get wrongCellAndDigit => 'Ce choix ne correspond pas au motif. Compare les cases surlignées et leurs candidats.';
	@override String findTechnique({required Object technique}) => 'Trouve : ${technique}';
}

// Path: progress
class _Translations$progress$fr extends Translations$progress$uk {
	_Translations$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get doingWell => 'Ce qui va bien';
	@override String get learningNow => 'Ce que tu apprends';
	@override String get next => 'Prochaine étape';
	@override String get noStrong => 'Tes techniques les plus solides apparaîtront après la pratique.';
	@override String get startLearning => 'Commencer à apprendre';
	@override String get thisWeek => 'Cette semaine';
	@override String completed({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} sudoku terminé',
		other: '${n} sudokus terminés',
	);
	@override String mastery({required Object percent}) => 'Maîtrise ${percent} %';
	@override String get openTechnique => 'Ouvrir la technique';
}

// Path: profile
class _Translations$profile$fr extends Translations$profile$uk {
	_Translations$profile$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get guest => 'Invité';
	@override String get localOnly => 'La progression est enregistrée sur cet appareil.';
	@override String get puzzles => 'Sudokus';
	@override String get mastered => 'Maîtrisées';
	@override String get activeDays => 'Jours actifs';
	@override String get learnRow => 'Apprendre';
	@override String get learnDetail => 'Techniques et pratique';
	@override String get settingsRow => 'Réglages';
	@override String get settingsDetail => 'Langue';
	@override String get activity => 'Ton activité';
}

// Path: scanner
class _Translations$scanner$fr extends Translations$scanner$uk {
	_Translations$scanner$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Scanner un sudoku';
	@override String get intro => 'Cadrez toute la grille, puis prenez ou choisissez une photo.';
	@override String get openCamera => 'Utiliser l’appareil photo';
	@override String get choosePhoto => 'Choisir une photo';
	@override String get shutter => 'Prendre une photo';
	@override String get frameGuide => 'Gardez les quatre coins dans le cadre.';
	@override String get processing => 'Lecture du sudoku…';
	@override String get reviewTitle => 'Vérifiez les chiffres';
	@override String get reviewBody => 'Touchez une case pour la corriger avant de jouer.';
	@override String get needsReview => 'À vérifier';
	@override String get conflict => 'Chiffre en conflit';
	@override String get selected => 'sélectionnée';
	@override String get recognized => 'reconnu';
	@override String get empty => 'vide';
	@override String get clear => 'Effacer';
	@override String get confirm => 'Importer le sudoku';
	@override String get rescan => 'Scanner à nouveau';
	@override String get permissionIntro => 'Autorisez l’appareil photo pour prendre une photo.';
	@override String get permissionDenied => 'L’accès à l’appareil photo est refusé. Vous pouvez choisir une photo.';
	@override String get permissionSettings => 'Activez l’appareil photo dans Réglages ou choisissez une photo.';
	@override String get noCamera => 'Aucun appareil photo disponible. Choisissez une photo.';
	@override String get openSettings => 'Ouvrir Réglages';
	@override String get imageDecodeFailure => 'Impossible de lire cette image. Essayez une autre photo.';
	@override String get noGridFound => 'Aucune grille de sudoku trouvée. Cadrez-la entièrement.';
	@override String get invalidGeometry => 'Impossible de redresser la grille. Essayez une photo plus nette.';
	@override String get segmentationFailure => 'Impossible de découper la grille en cases. Réessayez.';
	@override String get recognitionFailure => 'Certains chiffres sont illisibles. Réessayez.';
	@override String get duplicateClues => 'Corrigez les chiffres en conflit signalés.';
	@override String get noSolution => 'Ces chiffres ne donnent aucune solution. Vérifiez-les.';
	@override String get multipleSolutions => 'Il manque peut-être des chiffres : ce sudoku a plusieurs solutions.';
	@override String get storageFailure => 'Impossible d’enregistrer le sudoku importé. Réessayez.';
	@override String get validationFailure => 'Impossible de vérifier cette grille. Réessayez de confirmer.';
	@override String get unsupportedCoach => 'MICHI ne peut pas encore expliquer chaque étape de ce sudoku.';
	@override String get importedTitle => 'Sudoku importé';
	@override String lowConfidenceCount({required Object count}) => 'Cases à vérifier : ${count}';
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
	@override String get hiddenPair => 'Paire cachée';
	@override String get boxLineReduction => 'Réduction ligne-bloc';
	@override String get nakedTriple => 'Triplet nu';
	@override String get xWing => 'X-Wing';
	@override String get identifyHiddenPair => 'Deux chiffres ne sont possibles que dans les mêmes deux cases. Retire les autres candidats.';
	@override String get understandBoxLine => 'La ligne limite ce chiffre à un bloc. Retire-le ailleurs dans ce bloc.';
	@override String get understandTriple => 'Trois cases partagent exactement trois chiffres. Retire-les des autres cases de l’unité.';
	@override String get understandXWing => 'Deux lignes ont ce chiffre aux mêmes deux intersections. Retire-le ailleurs sur les lignes croisées.';
}

// Path: why
class _Translations$why$fr extends Translations$why$uk {
	_Translations$why$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explication';
	@override String whyHere({required Object digit}) => 'Pourquoi placer ${digit} ici ?';
	@override String get givenTitle => 'Ce chiffre est donné au départ';
	@override String get givenBody => 'Il était sur la grille dès le début : aucun raisonnement n’est nécessaire pour le placer. Les explications concernent les chiffres que tu places.';
	@override String get unavailableTitle => 'Aucune explication directe pour le moment';
	@override String get unavailableBody => 'MICHI ne peut pas justifier ce coup par une technique prise en charge dans l’état précédent.';
	@override String get lesson => 'Leçon';
	@override String get gotIt => 'Compris';
	@override String unitRestrictions({required Object unit, required Object digits}) => 'Dans ${unit}, ces chiffres sont déjà placés : ${digits}.';
	@override String onlyCandidate({required Object digit}) => 'La ligne, la colonne et le bloc excluent les autres chiffres. Seul ${digit} convient ici.';
	@override String unitSearch({required Object digit, required Object unit}) => 'Cherchons où placer ${digit} dans ${unit}.';
	@override String solePosition({required Object digit, required Object unit}) => 'Les ${digit} barrés montrent où ce chiffre ne peut pas aller dans ${unit}. Il ne reste que cette case.';
	@override String placement({required Object digit}) => 'Donc ${digit} va ici.';
	@override String unitRow({required Object index}) => 'la ligne ${index}';
	@override String unitColumn({required Object index}) => 'la colonne ${index}';
	@override String unitBox({required Object index}) => 'le bloc ${index}';
}

// Path: recommendation
class _Translations$recommendation$fr extends Translations$recommendation$uk {
	_Translations$recommendation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String focusTitle({required Object technique}) => 'Objectif du jour : ${technique}';
	@override String learnAction({required Object technique}) => 'Apprendre : ${technique}';
	@override String practiceAction({required Object technique}) => 'S’entraîner : ${technique}';
	@override String reviewAction({required Object technique}) => 'Réviser : ${technique}';
	@override String duration({required Object minutes}) => '${minutes} min';
	@override String get startWithBasics => 'Commencez par le premier pas logique.';
	@override String get repeatedCoachHelp => 'Vous avez récemment eu besoin de MICHI.';
	@override String get weakIndependentPractice => 'La pratique autonome mérite d’être renforcée.';
	@override String get continuePractice => 'Continuez à pratiquer cette technique.';
	@override String get nextTechnique => 'La prochaine étape de votre parcours.';
	@override String get masteredNeedsReview => 'Une technique connue mérite une révision.';
	@override String get allMasteredReview => 'Révisez une technique déjà maîtrisée.';
}

// Path: week
class _Translations$week$fr extends Translations$week$uk {
	_Translations$week$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cette semaine';
	@override String get empty => 'Aucun sudoku terminé cette semaine. Ton activité apparaîtra quand tu joueras.';
	@override String get puzzles => 'Sudokus';
	@override String get minutes => 'Minutes';
	@override String get daily => 'Quotidiens';
	@override String activeDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} jour actif',
		other: '${n} jours actifs',
	);
	@override String completedDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n,
		one: '${n} sudoku terminé',
		other: '${n} sudokus terminés',
	);
	@override String get today => 'Aujourd’hui';
	@override String get noActivity => 'Aucune activité';
	@override String get summary => 'Ton activité locale de sudoku';
}

// Path: settings
class _Translations$settings$fr extends Translations$settings$uk {
	_Translations$settings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réglages';
	@override String get language => 'Langue';
	@override String get languageDetail => 'Choisis la langue de MICHI.';
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
	@override late final _Translations$learn$lessons$hiddenPair$fr hiddenPair = _Translations$learn$lessons$hiddenPair$fr._(_root);
	@override late final _Translations$learn$lessons$boxLineReduction$fr boxLineReduction = _Translations$learn$lessons$boxLineReduction$fr._(_root);
	@override late final _Translations$learn$lessons$nakedTriple$fr nakedTriple = _Translations$learn$lessons$nakedTriple$fr._(_root);
	@override late final _Translations$learn$lessons$xWing$fr xWing = _Translations$learn$lessons$xWing$fr._(_root);
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

// Path: learn.lessons.hiddenPair
class _Translations$learn$lessons$hiddenPair$fr extends Translations$learn$lessons$hiddenPair$uk {
	_Translations$learn$lessons$hiddenPair$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Deux chiffres se cachent dans les mêmes deux cases.';
	@override String get concept => 'Cherche une paire cachée par chiffre, pas par listes identiques.';
	@override String get lookFor => 'Trouve deux chiffres possibles uniquement dans les mêmes deux cases d’une unité.';
	@override String get reasoning => 'Ces chiffres occupent ces cases ; les autres candidats peuvent être retirés.';
	@override String get example => 'Les cases surlignées sont les seules positions des deux chiffres.';
	@override String get tryIt => 'Retire les candidats supplémentaires de ces deux cases.';
}

// Path: learn.lessons.boxLineReduction
class _Translations$learn$lessons$boxLineReduction$fr extends Translations$learn$lessons$boxLineReduction$uk {
	_Translations$learn$lessons$boxLineReduction$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Une ligne ou colonne limite un chiffre à un bloc.';
	@override String get concept => 'Une ligne peut fixer un chiffre dans un bloc.';
	@override String get lookFor => 'Trouve deux ou trois positions d’un chiffre sur une ligne, toutes dans un bloc.';
	@override String get reasoning => 'Le chiffre est dans ce bloc sur la ligne ; retire-le ailleurs dans le bloc.';
	@override String get example => 'Suis la ligne surlignée dans le bloc et repère les candidats à l’extérieur.';
	@override String get tryIt => 'Retire le chiffre des autres cases du bloc.';
}

// Path: learn.lessons.nakedTriple
class _Translations$learn$lessons$nakedTriple$fr extends Translations$learn$lessons$nakedTriple$uk {
	_Translations$learn$lessons$nakedTriple$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Trois cases partagent seulement trois chiffres candidats.';
	@override String get concept => 'Un triplet réserve trois chiffres à trois cases d’une unité.';
	@override String get lookFor => 'Trouve trois cases dont l’union des candidats contient exactement trois chiffres.';
	@override String get reasoning => 'Ces chiffres remplissent les cases, même si leurs listes diffèrent.';
	@override String get example => 'Les cases surlignées ont des paires différentes mais trois chiffres en tout.';
	@override String get tryIt => 'Retire ces chiffres des autres cases de l’unité.';
}

// Path: learn.lessons.xWing
class _Translations$learn$lessons$xWing$fr extends Translations$learn$lessons$xWing$uk {
	_Translations$learn$lessons$xWing$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get description => 'Deux lignes alignent un chiffre sur deux intersections.';
	@override String get concept => 'Le X-Wing lie deux lignes ou colonnes par un chiffre candidat.';
	@override String get lookFor => 'Trouve deux lignes où le chiffre apparaît deux fois aux mêmes positions.';
	@override String get reasoning => 'Les quatre intersections réservent le chiffre ; retire-le ailleurs sur les lignes croisées.';
	@override String get example => 'Suis les quatre positions surlignées et les deux lignes croisées.';
	@override String get tryIt => 'Retire le chiffre hors des quatre cases du motif.';
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
			'welcome.title' => 'Trouve ton chemin grâce à la logique.',
			'welcome.subtitle' => 'Un sudoku avec un guide qui t’aide sans résoudre à ta place.',
			'welcome.guest' => 'Commencer sans compte',
			'onboarding.title' => 'Ton apprentissage commence ici.',
			'onboarding.chooseLevel' => 'Choisir ton niveau',
			'onboarding.skip' => 'Passer',
			'onboarding.next' => 'Suivant',
			'onboarding.seeTitle' => 'Le sudoku devient plus simple quand tu sais où regarder.',
			'onboarding.seeBody' => 'MICHI explique la logique de chaque coup.',
			'onboarding.hintsTitle' => 'Des indices qui enseignent.',
			'onboarding.hintsBody' => 'Commence par une légère piste. Demande plus si besoin.',
			'onboarding.patternsTitle' => 'Apprends les motifs, pas les réponses.',
			'onboarding.patternsBody' => 'Simples cachés, paires, X-Wing : à ton rythme.',
			'onboarding.pathTitle' => 'Ton chemin dans le sudoku.',
			'onboarding.pathBody' => 'MICHI repère tes difficultés et te suggère quoi travailler.',
			'playerLevel.title' => 'Connais-tu bien le sudoku ?',
			'playerLevel.goToGame' => 'Commencer à jouer',
			'playerLevel.subtitle' => 'Cela détermine ta première leçon et la difficulté. Tu peux changer plus tard.',
			'playerLevel.beginner' => 'Je débute',
			'playerLevel.beginnerDetail' => 'Règles et premiers coups',
			'playerLevel.basics' => 'Je connais les bases',
			'playerLevel.basicsDetail' => 'Simples et candidats',
			'playerLevel.regular' => 'Je joue régulièrement',
			'playerLevel.regularDetail' => 'Paires et paires pointantes',
			'playerLevel.advanced' => 'Je veux un défi',
			'playerLevel.advancedDetail' => 'X-Wing et au-delà',
			'auth.title' => 'Compte',
			'auth.unavailable' => 'Ta progression est enregistrée sur cet appareil.',
			'auth.apple' => 'Continuer avec Apple',
			'auth.google' => 'Continuer avec Google',
			'auth.emailEntry' => 'Se connecter par e-mail',
			'auth.createTitle' => 'Créer un compte',
			'auth.createSubtitle' => 'Ta progression reste sur cet appareil jusqu’à ce que la synchronisation soit disponible.',
			'auth.signInTitle' => 'Bon retour',
			'auth.name' => 'Nom',
			'auth.email' => 'E-mail',
			'auth.password' => 'Mot de passe',
			'auth.passwordHint' => 'Au moins 8 caractères',
			'auth.createAccount' => 'Créer le compte',
			'auth.signIn' => 'Se connecter',
			'auth.alreadyAccount' => 'Tu as déjà un compte ?',
			'auth.noAccount' => 'Pas encore de compte ?',
			'auth.forgotPassword' => 'Mot de passe oublié ?',
			'auth.resetTitle' => 'Réinitialiser le mot de passe',
			'auth.resetSubtitle' => 'Saisis l’e-mail de ton compte pour recevoir un lien de réinitialisation.',
			'auth.sendLink' => 'Envoyer le lien',
			'auth.resetSent' => 'Si le compte existe, vérifie tes e-mails pour trouver le lien.',
			'auth.verifyTitle' => 'Vérifie tes e-mails',
			'auth.verifySubtitle' => ({required Object email}) => 'Nous avons envoyé un lien de vérification à ${email}.',
			'auth.checkVerification' => 'J’ai vérifié mon e-mail',
			'auth.resendVerification' => 'Renvoyer le lien',
			'auth.verified' => 'Ton e-mail est vérifié.',
			'auth.notVerified' => 'L’e-mail n’est pas encore vérifié.',
			'auth.signOut' => 'Se déconnecter',
			'auth.localNotSynced' => 'La progression du jeu reste enregistrée sur cet appareil.',
			'auth.verifyEmail' => 'Vérifier l’e-mail',
			'auth.errorInvalidEmail' => 'Saisis une adresse e-mail valide.',
			'auth.errorPasswordLength' => 'Utilise au moins 8 caractères.',
			'auth.errorNameRequired' => 'Saisis ton nom.',
			'auth.errorWeakPassword' => 'Ce mot de passe est trop faible.',
			'auth.errorEmailInUse' => 'Un compte utilise déjà cet e-mail.',
			'auth.errorWrongCredentials' => 'Vérifie ton e-mail et ton mot de passe.',
			'auth.errorDisabled' => 'Ce compte est désactivé.',
			'auth.errorTooMany' => 'Trop de tentatives. Réessaie plus tard.',
			'auth.errorNetwork' => 'Vérifie ta connexion et réessaie.',
			'auth.errorUnavailable' => 'Le service de comptes est indisponible. Tu peux continuer sans compte.',
			'auth.errorUnexpected' => 'Une erreur s’est produite. Réessaie.',
			'auth.showPassword' => 'Afficher le mot de passe',
			'auth.hidePassword' => 'Masquer le mot de passe',
			'auth.signOutTitle' => 'Te déconnecter ?',
			'auth.signOutBody' => 'Tes parties locales resteront sur cet appareil.',
			'auth.cancel' => 'Annuler',
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
			'home.advanced' => 'Avancé',
			'home.expert' => 'Expert',
			'home.greeting' => 'Bonjour',
			'home.newPuzzle' => 'Un autre sudoku',
			'home.weekTitle' => 'Cette semaine',
			'home.weekDetails' => 'Détails',
			'home.weekdaysShort' => 'Lu|Ma|Me|Je|Ve|Sa|Di',
			'home.newPuzzleTitle' => 'Nouveau sudoku',
			'home.catalogSource' => 'Choisir un sudoku',
			'home.scanSource' => 'Scanner un sudoku',
			'home.scanSourceDetail' => 'Photo ou appareil photo',
			'home.weekStatusDone' => 'Terminé',
			'home.weekStatusToday' => 'Aujourd’hui',
			'home.weekStatusEmpty' => 'Aucune activité',
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
			'game.completionLogic' => 'cases résolues',
			'game.completionMistakes' => 'erreurs',
			'game.completionHints' => 'indices',
			'game.dailyStampEarned' => 'Tampon quotidien obtenu',
			'game.completionPracticeTechnique' => ({required Object technique}) => 'Prochaine étape : ${technique}',
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
			'learn.lessons.hiddenPair.description' => 'Deux chiffres se cachent dans les mêmes deux cases.',
			'learn.lessons.hiddenPair.concept' => 'Cherche une paire cachée par chiffre, pas par listes identiques.',
			'learn.lessons.hiddenPair.lookFor' => 'Trouve deux chiffres possibles uniquement dans les mêmes deux cases d’une unité.',
			'learn.lessons.hiddenPair.reasoning' => 'Ces chiffres occupent ces cases ; les autres candidats peuvent être retirés.',
			'learn.lessons.hiddenPair.example' => 'Les cases surlignées sont les seules positions des deux chiffres.',
			'learn.lessons.hiddenPair.tryIt' => 'Retire les candidats supplémentaires de ces deux cases.',
			'learn.lessons.boxLineReduction.description' => 'Une ligne ou colonne limite un chiffre à un bloc.',
			'learn.lessons.boxLineReduction.concept' => 'Une ligne peut fixer un chiffre dans un bloc.',
			'learn.lessons.boxLineReduction.lookFor' => 'Trouve deux ou trois positions d’un chiffre sur une ligne, toutes dans un bloc.',
			'learn.lessons.boxLineReduction.reasoning' => 'Le chiffre est dans ce bloc sur la ligne ; retire-le ailleurs dans le bloc.',
			'learn.lessons.boxLineReduction.example' => 'Suis la ligne surlignée dans le bloc et repère les candidats à l’extérieur.',
			'learn.lessons.boxLineReduction.tryIt' => 'Retire le chiffre des autres cases du bloc.',
			'learn.lessons.nakedTriple.description' => 'Trois cases partagent seulement trois chiffres candidats.',
			'learn.lessons.nakedTriple.concept' => 'Un triplet réserve trois chiffres à trois cases d’une unité.',
			'learn.lessons.nakedTriple.lookFor' => 'Trouve trois cases dont l’union des candidats contient exactement trois chiffres.',
			'learn.lessons.nakedTriple.reasoning' => 'Ces chiffres remplissent les cases, même si leurs listes diffèrent.',
			'learn.lessons.nakedTriple.example' => 'Les cases surlignées ont des paires différentes mais trois chiffres en tout.',
			'learn.lessons.nakedTriple.tryIt' => 'Retire ces chiffres des autres cases de l’unité.',
			'learn.lessons.xWing.description' => 'Deux lignes alignent un chiffre sur deux intersections.',
			'learn.lessons.xWing.concept' => 'Le X-Wing lie deux lignes ou colonnes par un chiffre candidat.',
			'learn.lessons.xWing.lookFor' => 'Trouve deux lignes où le chiffre apparaît deux fois aux mêmes positions.',
			'learn.lessons.xWing.reasoning' => 'Les quatre intersections réservent le chiffre ; retire-le ailleurs sur les lignes croisées.',
			'learn.lessons.xWing.example' => 'Suis les quatre positions surlignées et les deux lignes croisées.',
			'learn.lessons.xWing.tryIt' => 'Retire le chiffre hors des quatre cases du motif.',
			'learn.basicsGroup' => 'Bases',
			'learn.intermediateGroup' => 'Niveau intermédiaire',
			'learn.advancedGroup' => 'Niveau avancé',
			'learn.nowLabel' => 'Maintenant',
			'learn.groupProgress' => ({required Object completed, required Object total}) => '${completed} sur ${total}',
			'learn.extraElimination' => 'Ce motif ne retire pas l’un des candidats choisis. Vérifie les cases surlignées.',
			'learn.missingElimination' => 'Il reste des candidats à retirer. Suis l’unité surlignée.',
			'learn.wrongPlacement' => 'Cette case ou ce chiffre ne correspond pas à la déduction. Revérifie la position.',
			'learn.minutes' => ({required Object count}) => '${count} min',
			'learn.tasks' => ({required Object count}) => '${count} exercices',
			'learn.wrongCell' => 'Cette case est hors du motif. Regarde les cases surlignées.',
			'learn.wrongDigit' => 'Ce motif ne place pas ce chiffre. Vérifie les candidats de la case surlignée.',
			'learn.wrongCellAndDigit' => 'Ce choix ne correspond pas au motif. Compare les cases surlignées et leurs candidats.',
			'learn.findTechnique' => ({required Object technique}) => 'Trouve : ${technique}',
			'progress.doingWell' => 'Ce qui va bien',
			'progress.learningNow' => 'Ce que tu apprends',
			'progress.next' => 'Prochaine étape',
			'progress.noStrong' => 'Tes techniques les plus solides apparaîtront après la pratique.',
			'progress.startLearning' => 'Commencer à apprendre',
			'progress.thisWeek' => 'Cette semaine',
			'progress.completed' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} sudoku terminé', other: '${n} sudokus terminés', ),
			'progress.mastery' => ({required Object percent}) => 'Maîtrise ${percent} %',
			'progress.openTechnique' => 'Ouvrir la technique',
			'profile.guest' => 'Invité',
			'profile.localOnly' => 'La progression est enregistrée sur cet appareil.',
			'profile.puzzles' => 'Sudokus',
			'profile.mastered' => 'Maîtrisées',
			'profile.activeDays' => 'Jours actifs',
			'profile.learnRow' => 'Apprendre',
			'profile.learnDetail' => 'Techniques et pratique',
			'profile.settingsRow' => 'Réglages',
			'profile.settingsDetail' => 'Langue',
			'profile.activity' => 'Ton activité',
			'scanner.title' => 'Scanner un sudoku',
			'scanner.intro' => 'Cadrez toute la grille, puis prenez ou choisissez une photo.',
			'scanner.openCamera' => 'Utiliser l’appareil photo',
			'scanner.choosePhoto' => 'Choisir une photo',
			'scanner.shutter' => 'Prendre une photo',
			'scanner.frameGuide' => 'Gardez les quatre coins dans le cadre.',
			'scanner.processing' => 'Lecture du sudoku…',
			'scanner.reviewTitle' => 'Vérifiez les chiffres',
			'scanner.reviewBody' => 'Touchez une case pour la corriger avant de jouer.',
			'scanner.needsReview' => 'À vérifier',
			'scanner.conflict' => 'Chiffre en conflit',
			'scanner.selected' => 'sélectionnée',
			'scanner.recognized' => 'reconnu',
			'scanner.empty' => 'vide',
			'scanner.clear' => 'Effacer',
			'scanner.confirm' => 'Importer le sudoku',
			'scanner.rescan' => 'Scanner à nouveau',
			'scanner.permissionIntro' => 'Autorisez l’appareil photo pour prendre une photo.',
			'scanner.permissionDenied' => 'L’accès à l’appareil photo est refusé. Vous pouvez choisir une photo.',
			'scanner.permissionSettings' => 'Activez l’appareil photo dans Réglages ou choisissez une photo.',
			'scanner.noCamera' => 'Aucun appareil photo disponible. Choisissez une photo.',
			'scanner.openSettings' => 'Ouvrir Réglages',
			'scanner.imageDecodeFailure' => 'Impossible de lire cette image. Essayez une autre photo.',
			'scanner.noGridFound' => 'Aucune grille de sudoku trouvée. Cadrez-la entièrement.',
			'scanner.invalidGeometry' => 'Impossible de redresser la grille. Essayez une photo plus nette.',
			'scanner.segmentationFailure' => 'Impossible de découper la grille en cases. Réessayez.',
			'scanner.recognitionFailure' => 'Certains chiffres sont illisibles. Réessayez.',
			'scanner.duplicateClues' => 'Corrigez les chiffres en conflit signalés.',
			'scanner.noSolution' => 'Ces chiffres ne donnent aucune solution. Vérifiez-les.',
			'scanner.multipleSolutions' => 'Il manque peut-être des chiffres : ce sudoku a plusieurs solutions.',
			'scanner.storageFailure' => 'Impossible d’enregistrer le sudoku importé. Réessayez.',
			'scanner.validationFailure' => 'Impossible de vérifier cette grille. Réessayez de confirmer.',
			'scanner.unsupportedCoach' => 'MICHI ne peut pas encore expliquer chaque étape de ce sudoku.',
			'scanner.importedTitle' => 'Sudoku importé',
			'scanner.lowConfidenceCount' => ({required Object count}) => 'Cases à vérifier : ${count}',
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
			'coach.hiddenPair' => 'Paire cachée',
			'coach.boxLineReduction' => 'Réduction ligne-bloc',
			'coach.nakedTriple' => 'Triplet nu',
			'coach.xWing' => 'X-Wing',
			'coach.identifyHiddenPair' => 'Deux chiffres ne sont possibles que dans les mêmes deux cases. Retire les autres candidats.',
			'coach.understandBoxLine' => 'La ligne limite ce chiffre à un bloc. Retire-le ailleurs dans ce bloc.',
			'coach.understandTriple' => 'Trois cases partagent exactement trois chiffres. Retire-les des autres cases de l’unité.',
			'coach.understandXWing' => 'Deux lignes ont ce chiffre aux mêmes deux intersections. Retire-le ailleurs sur les lignes croisées.',
			'why.title' => 'Explication',
			'why.whyHere' => ({required Object digit}) => 'Pourquoi placer ${digit} ici ?',
			'why.givenTitle' => 'Ce chiffre est donné au départ',
			'why.givenBody' => 'Il était sur la grille dès le début : aucun raisonnement n’est nécessaire pour le placer. Les explications concernent les chiffres que tu places.',
			'why.unavailableTitle' => 'Aucune explication directe pour le moment',
			'why.unavailableBody' => 'MICHI ne peut pas justifier ce coup par une technique prise en charge dans l’état précédent.',
			'why.lesson' => 'Leçon',
			'why.gotIt' => 'Compris',
			'why.unitRestrictions' => ({required Object unit, required Object digits}) => 'Dans ${unit}, ces chiffres sont déjà placés : ${digits}.',
			'why.onlyCandidate' => ({required Object digit}) => 'La ligne, la colonne et le bloc excluent les autres chiffres. Seul ${digit} convient ici.',
			'why.unitSearch' => ({required Object digit, required Object unit}) => 'Cherchons où placer ${digit} dans ${unit}.',
			'why.solePosition' => ({required Object digit, required Object unit}) => 'Les ${digit} barrés montrent où ce chiffre ne peut pas aller dans ${unit}. Il ne reste que cette case.',
			'why.placement' => ({required Object digit}) => 'Donc ${digit} va ici.',
			'why.unitRow' => ({required Object index}) => 'la ligne ${index}',
			'why.unitColumn' => ({required Object index}) => 'la colonne ${index}',
			'why.unitBox' => ({required Object index}) => 'le bloc ${index}',
			'recommendation.focusTitle' => ({required Object technique}) => 'Objectif du jour : ${technique}',
			'recommendation.learnAction' => ({required Object technique}) => 'Apprendre : ${technique}',
			'recommendation.practiceAction' => ({required Object technique}) => 'S’entraîner : ${technique}',
			'recommendation.reviewAction' => ({required Object technique}) => 'Réviser : ${technique}',
			'recommendation.duration' => ({required Object minutes}) => '${minutes} min',
			'recommendation.startWithBasics' => 'Commencez par le premier pas logique.',
			'recommendation.repeatedCoachHelp' => 'Vous avez récemment eu besoin de MICHI.',
			'recommendation.weakIndependentPractice' => 'La pratique autonome mérite d’être renforcée.',
			'recommendation.continuePractice' => 'Continuez à pratiquer cette technique.',
			'recommendation.nextTechnique' => 'La prochaine étape de votre parcours.',
			'recommendation.masteredNeedsReview' => 'Une technique connue mérite une révision.',
			'recommendation.allMasteredReview' => 'Révisez une technique déjà maîtrisée.',
			'week.title' => 'Cette semaine',
			'week.empty' => 'Aucun sudoku terminé cette semaine. Ton activité apparaîtra quand tu joueras.',
			'week.puzzles' => 'Sudokus',
			'week.minutes' => 'Minutes',
			'week.daily' => 'Quotidiens',
			'week.activeDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} jour actif', other: '${n} jours actifs', ),
			'week.completedDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(n, one: '${n} sudoku terminé', other: '${n} sudokus terminés', ),
			'week.today' => 'Aujourd’hui',
			'week.noActivity' => 'Aucune activité',
			'week.summary' => 'Ton activité locale de sudoku',
			'settings.title' => 'Réglages',
			'settings.language' => 'Langue',
			'settings.languageDetail' => 'Choisis la langue de MICHI.',
			_ => null,
		};
	}
}
