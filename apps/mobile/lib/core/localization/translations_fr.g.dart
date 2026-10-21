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
	@override String get learn => 'Apprendre';
	@override String get progress => 'Progression';
	@override String get profile => 'Profil';
	@override String get scanner => 'Scanner';
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
}

// Path: learn
class _Translations$learn$fr extends Translations$learn$uk {
	_Translations$learn$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Les leçons sur les techniques arriveront plus tard.';
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
			'home.learn' => 'Apprendre',
			'home.progress' => 'Progression',
			'home.profile' => 'Profil',
			'home.scanner' => 'Scanner',
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
			'learn.unavailable' => 'Les leçons sur les techniques arriveront plus tard.',
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
