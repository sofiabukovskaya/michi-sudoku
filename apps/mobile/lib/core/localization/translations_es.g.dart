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
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'MICHI';
	@override late final _Translations$common$es common = _Translations$common$es._(_root);
	@override late final _Translations$splash$es splash = _Translations$splash$es._(_root);
	@override late final _Translations$welcome$es welcome = _Translations$welcome$es._(_root);
	@override late final _Translations$onboarding$es onboarding = _Translations$onboarding$es._(_root);
	@override late final _Translations$playerLevel$es playerLevel = _Translations$playerLevel$es._(_root);
	@override late final _Translations$auth$es auth = _Translations$auth$es._(_root);
	@override late final _Translations$home$es home = _Translations$home$es._(_root);
	@override late final _Translations$game$es game = _Translations$game$es._(_root);
	@override late final _Translations$learn$es learn = _Translations$learn$es._(_root);
	@override late final _Translations$progress$es progress = _Translations$progress$es._(_root);
	@override late final _Translations$profile$es profile = _Translations$profile$es._(_root);
	@override late final _Translations$scanner$es scanner = _Translations$scanner$es._(_root);
	@override late final _Translations$coach$es coach = _Translations$coach$es._(_root);
}

// Path: common
class _Translations$common$es extends Translations$common$uk {
	_Translations$common$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get continueLabel => 'Continuar';
	@override String get start => 'Empezar';
}

// Path: splash
class _Translations$splash$es extends Translations$splash$uk {
	_Translations$splash$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Aprende a ver el siguiente paso.';
}

// Path: welcome
class _Translations$welcome$es extends Translations$welcome$uk {
	_Translations$welcome$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu camino en el sudoku.';
}

// Path: onboarding
class _Translations$onboarding$es extends Translations$onboarding$uk {
	_Translations$onboarding$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu aprendizaje empieza aquí.';
	@override String get chooseLevel => 'Elegir nivel';
}

// Path: playerLevel
class _Translations$playerLevel$es extends Translations$playerLevel$uk {
	_Translations$playerLevel$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Cuánto sabes de sudoku?';
	@override String get goToGame => 'Empezar a jugar';
}

// Path: auth
class _Translations$auth$es extends Translations$auth$uk {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cuenta';
	@override String get unavailable => 'La sincronización del progreso llegará más adelante.';
}

// Path: home
class _Translations$home$es extends Translations$home$uk {
	_Translations$home$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu camino en el sudoku';
	@override String get game => 'Jugar';
	@override String get continueGame => 'Continuar partida';
	@override String continueDetails({required Object date, required Object progress, required Object time}) => 'Iniciado el ${date} · ${progress} % · ${time}';
	@override String get replaceTitle => '¿Empezar otro sudoku?';
	@override String get replaceBody => 'Se reemplazará la partida sin terminar.';
	@override String get keepPlaying => 'Seguir jugando';
	@override String get startNew => 'Empezar uno nuevo';
	@override String get storageUnavailable => 'La partida guardada no está disponible. Inténtalo más tarde.';
	@override String get loading => 'Buscando la partida guardada…';
	@override String get learn => 'Aprender';
	@override String get progress => 'Progreso';
	@override String get profile => 'Perfil';
	@override String get scanner => 'Escáner';
	@override String get chooseDifficulty => 'Elige la dificultad';
	@override String get easy => 'Fácil';
	@override String get medium => 'Media';
	@override String get dailyTitle => 'Sudoku del día';
	@override String get dailyStart => 'Empezar el sudoku de hoy';
	@override String get dailyContinue => 'Continuar el sudoku de hoy';
	@override String get dailyCompleted => 'Completado hoy';
	@override String get contentUnavailable => 'Los sudokus no están disponibles. Inténtalo de nuevo.';
}

// Path: game
class _Translations$game$es extends Translations$game$uk {
	_Translations$game$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sudoku diario · Intermedio';
	@override String get undo => 'Deshacer';
	@override String get erase => 'Borrar';
	@override String get notes => 'Notas';
	@override String get hint => 'Pista';
	@override String mistakes({required Object count}) => 'Errores: ${count} de 3';
	@override String get notesModeOn => 'Modo notas: toca un número para alternar candidatos';
	@override String get row => 'Fila';
	@override String get column => 'columna';
	@override String get empty => 'vacía';
	@override String get given => 'inicial';
	@override String get entered => 'introducida';
	@override String get selected => 'seleccionada';
	@override String get error => 'incorrecta';
	@override String get candidates => 'candidatos';
	@override String get completeTitle => 'Resuelto.';
	@override String get completeBody => 'Has completado este sudoku.';
	@override String get backHome => 'Volver al inicio';
	@override String get pause => 'Pausar';
	@override String get pausedTitle => 'Pausado';
	@override String get resume => 'Continuar';
	@override String pausedAt({required Object time}) => 'Temporizador detenido en ${time}';
	@override String get loading => 'Preparando el sudoku…';
	@override String get restoreUnavailable => 'No se pudo restaurar la partida.';
	@override String get saveFailed => 'No se pudo guardar la partida.';
	@override String get retrySave => 'Reintentar';
	@override String completionStats({required Object mistakes, required Object hints}) => '${mistakes} errores · ${hints} pistas';
	@override String get standardTitle => 'Sudoku';
	@override String get dailyTitle => 'Sudoku del día';
}

// Path: learn
class _Translations$learn$es extends Translations$learn$uk {
	_Translations$learn$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aprender';
	@override String get intro => 'Una técnica y un paso claro cada vez.';
	@override String get newLabel => 'Nuevo';
	@override String get learningLabel => 'Aprendiendo';
	@override String get practicingLabel => 'Practicando';
	@override String get masteredLabel => 'Dominado';
	@override String get planTitle => 'Plan de la lección';
	@override String get lessonStart => 'Empezar lección';
	@override String get next => 'Siguiente';
	@override String get practiceStart => 'Empezar práctica';
	@override String get concept => 'Concepto';
	@override String get lookFor => 'Qué buscar';
	@override String get reasoning => 'Por qué funciona';
	@override String get example => 'Ejemplo';
	@override String get tryIt => 'Inténtalo';
	@override String exercise({required Object current, required Object total}) => 'Ejercicio ${current} de ${total}';
	@override String get placementPrompt => 'Elige una casilla y un número.';
	@override String get eliminationPrompt => 'Elige una casilla y marca todos los candidatos que se pueden eliminar.';
	@override String get checkAnswer => 'Comprobar';
	@override String get correctTitle => 'Bien visto';
	@override String get incorrectTitle => 'Todavía no';
	@override String get tryAgain => 'Intentar de nuevo';
	@override String get askMichi => 'Preguntar a MICHI';
	@override String get nextScenario => 'Siguiente ejercicio';
	@override String get sessionSummary => 'Práctica completada';
	@override String summaryStats({required Object correct, required Object attempts}) => '${correct} correctos · ${attempts} intentos';
	@override String hintsUsed({required Object count}) => '${count} con MICHI';
	@override String get done => 'Listo';
	@override String get loading => 'Preparando la lección…';
	@override String get unavailable => 'El contenido no está disponible. Inténtalo de nuevo.';
	@override String get noScenarios => 'Aún no hay ejercicios disponibles.';
	@override String get saveFailed => 'No se pudo guardar el progreso. Inténtalo de nuevo.';
	@override String get selectedForElimination => 'Marcado para eliminar';
	@override String get requiredTechniques => 'Técnicas de este sudoku';
	@override String get helpedTechniques => 'MICHI ayudó con';
	@override String get noHints => 'Sin pistas';
	@override String get practiceTitle => 'Práctica';
	@override String get continueLesson => 'Continuar lección';
	@override late final _Translations$learn$lessons$es lessons = _Translations$learn$lessons$es._(_root);
}

// Path: progress
class _Translations$progress$es extends Translations$progress$uk {
	_Translations$progress$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'El dominio de las técnicas llegará más adelante.';
}

// Path: profile
class _Translations$profile$es extends Translations$profile$uk {
	_Translations$profile$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'La configuración del perfil llegará más adelante.';
}

// Path: scanner
class _Translations$scanner$es extends Translations$scanner$uk {
	_Translations$scanner$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'La importación con cámara llegará después del juego principal.';
}

// Path: coach
class _Translations$coach$es extends Translations$coach$uk {
	_Translations$coach$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String step({required Object step}) => 'Pista ${step} de 4';
	@override String get kTry => 'Lo intentaré';
	@override String get show => 'Mostrar';
	@override String get see => 'Ya veo';
	@override String get more => 'Otra pista';
	@override String get close => 'Cerrar';
	@override String get showMistake => 'Mostrar error';
	@override String place({required Object digit}) => 'Colocar ${digit}';
	@override String unitRow({required Object index}) => 'fila ${index}';
	@override String unitColumn({required Object index}) => 'columna ${index}';
	@override String unitBox({required Object index}) => 'bloque ${index}';
	@override String get inspectCell => 'Mira la casilla resaltada.';
	@override String inspectUnit({required Object unit}) => 'Mira la ${unit} resaltada.';
	@override String get inspectCandidates => '¿Qué números pueden ir aquí?';
	@override String inspectPositions({required Object unit}) => '¿Dónde puede ir este número en la ${unit} resaltada?';
	@override String get inspectPair => 'Encuentra dos casillas con los mismos dos candidatos.';
	@override String get singleRemains => 'Solo queda un candidato en esta casilla.';
	@override String onlyPosition({required Object unit}) => 'Solo queda un lugar para este número en la ${unit}.';
	@override String pairRestriction({required Object unit}) => 'Estos dos números ocupan el par resaltado. Puedes eliminarlos en otras casillas de la ${unit}.';
	@override String get alignment => 'Los candidatos están alineados, así que este número se elimina fuera del bloque.';
	@override String resultPlacement({required Object digit}) => '${digit} solo puede ir en la casilla resaltada.';
	@override String get resultEliminations => 'Elimina los candidatos tachados de las casillas resaltadas.';
	@override String get resultActions => 'Aplica el paso lógico resaltado.';
	@override String technique({required Object name}) => 'Técnica: ${name}';
	@override String get nakedSingle => 'único candidato';
	@override String get hiddenSingle => 'único oculto';
	@override String get nakedPair => 'par desnudo';
	@override String get pointingPair => 'par apuntador';
	@override String get unavailable => 'Pista no disponible';
	@override String get wrongTitle => 'Corrige primero el error.';
	@override String get wrongBody => 'No se puede encontrar un paso lógico mientras haya un número incorrecto.';
	@override String get stuckTitle => 'Aún no hay un paso compatible.';
	@override String get stuckBody => 'MICHI todavía no puede explicar el siguiente paso con las técnicas disponibles.';
}

// Path: learn.lessons
class _Translations$learn$lessons$es extends Translations$learn$lessons$uk {
	_Translations$learn$lessons$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learn$lessons$nakedSingle$es nakedSingle = _Translations$learn$lessons$nakedSingle$es._(_root);
	@override late final _Translations$learn$lessons$hiddenSingle$es hiddenSingle = _Translations$learn$lessons$hiddenSingle$es._(_root);
	@override late final _Translations$learn$lessons$nakedPair$es nakedPair = _Translations$learn$lessons$nakedPair$es._(_root);
	@override late final _Translations$learn$lessons$pointingPair$es pointingPair = _Translations$learn$lessons$pointingPair$es._(_root);
}

// Path: learn.lessons.nakedSingle
class _Translations$learn$lessons$nakedSingle$es extends Translations$learn$lessons$nakedSingle$uk {
	_Translations$learn$lessons$nakedSingle$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Una casilla vacía solo admite un número.';
	@override String get concept => 'Los candidatos son los números que aún pueden ir en una casilla vacía.';
	@override String get lookFor => 'Busca una casilla donde fila, columna y bloque descarten todos menos uno.';
	@override String get reasoning => 'Queda un candidato, así que ese número debe ir allí.';
	@override String get example => 'La casilla resaltada tiene un solo candidato legal.';
	@override String get tryIt => 'Elige la casilla y coloca el número restante.';
}

// Path: learn.lessons.hiddenSingle
class _Translations$learn$lessons$hiddenSingle$es extends Translations$learn$lessons$hiddenSingle$uk {
	_Translations$learn$lessons$hiddenSingle$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Un número solo tiene una posición en una fila, columna o bloque.';
	@override String get concept => 'Observa un número en toda la unidad, no todos los candidatos de una casilla.';
	@override String get lookFor => 'Busca la única posición donde aún cabe ese número.';
	@override String get reasoning => 'La casilla puede tener varios candidatos, pero el número solo tiene un lugar.';
	@override String get example => 'La unidad resaltada deja una única posición para ese número.';
	@override String get tryIt => 'Elige la posición única y coloca el número.';
}

// Path: learn.lessons.nakedPair
class _Translations$learn$lessons$nakedPair$es extends Translations$learn$lessons$nakedPair$uk {
	_Translations$learn$lessons$nakedPair$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dos casillas de una unidad comparten los mismos dos candidatos.';
	@override String get concept => 'La pareja reserva esos dos números para ambas casillas.';
	@override String get lookFor => 'Busca dos casillas de la misma unidad con los mismos dos candidatos.';
	@override String get reasoning => 'Esos números no pueden estar en otras casillas de la unidad: elimínalos.';
	@override String get example => 'La pareja resaltada elimina candidatos en otras casillas.';
	@override String get tryIt => 'Marca todos los candidatos eliminados. Aún no coloques ningún número.';
}

// Path: learn.lessons.pointingPair
class _Translations$learn$lessons$pointingPair$es extends Translations$learn$lessons$pointingPair$uk {
	_Translations$learn$lessons$pointingPair$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dos posiciones de un candidato en un bloque comparten fila o columna.';
	@override String get concept => 'El bloque puede restringir un número a una sola línea.';
	@override String get lookFor => 'Busca exactamente dos posiciones del número alineadas dentro del bloque.';
	@override String get reasoning => 'El número queda dentro del bloque; elimínalo fuera del bloque en la misma línea.';
	@override String get example => 'Sigue la línea resaltada fuera del bloque.';
	@override String get tryIt => 'Marca todos los candidatos eliminados fuera del bloque.';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'MICHI',
			'common.continueLabel' => 'Continuar',
			'common.start' => 'Empezar',
			'splash.subtitle' => 'Aprende a ver el siguiente paso.',
			'welcome.title' => 'Tu camino en el sudoku.',
			'onboarding.title' => 'Tu aprendizaje empieza aquí.',
			'onboarding.chooseLevel' => 'Elegir nivel',
			'playerLevel.title' => '¿Cuánto sabes de sudoku?',
			'playerLevel.goToGame' => 'Empezar a jugar',
			'auth.title' => 'Cuenta',
			'auth.unavailable' => 'La sincronización del progreso llegará más adelante.',
			'home.title' => 'Tu camino en el sudoku',
			'home.game' => 'Jugar',
			'home.continueGame' => 'Continuar partida',
			'home.continueDetails' => ({required Object date, required Object progress, required Object time}) => 'Iniciado el ${date} · ${progress} % · ${time}',
			'home.replaceTitle' => '¿Empezar otro sudoku?',
			'home.replaceBody' => 'Se reemplazará la partida sin terminar.',
			'home.keepPlaying' => 'Seguir jugando',
			'home.startNew' => 'Empezar uno nuevo',
			'home.storageUnavailable' => 'La partida guardada no está disponible. Inténtalo más tarde.',
			'home.loading' => 'Buscando la partida guardada…',
			'home.learn' => 'Aprender',
			'home.progress' => 'Progreso',
			'home.profile' => 'Perfil',
			'home.scanner' => 'Escáner',
			'home.chooseDifficulty' => 'Elige la dificultad',
			'home.easy' => 'Fácil',
			'home.medium' => 'Media',
			'home.dailyTitle' => 'Sudoku del día',
			'home.dailyStart' => 'Empezar el sudoku de hoy',
			'home.dailyContinue' => 'Continuar el sudoku de hoy',
			'home.dailyCompleted' => 'Completado hoy',
			'home.contentUnavailable' => 'Los sudokus no están disponibles. Inténtalo de nuevo.',
			'game.title' => 'Sudoku diario · Intermedio',
			'game.undo' => 'Deshacer',
			'game.erase' => 'Borrar',
			'game.notes' => 'Notas',
			'game.hint' => 'Pista',
			'game.mistakes' => ({required Object count}) => 'Errores: ${count} de 3',
			'game.notesModeOn' => 'Modo notas: toca un número para alternar candidatos',
			'game.row' => 'Fila',
			'game.column' => 'columna',
			'game.empty' => 'vacía',
			'game.given' => 'inicial',
			'game.entered' => 'introducida',
			'game.selected' => 'seleccionada',
			'game.error' => 'incorrecta',
			'game.candidates' => 'candidatos',
			'game.completeTitle' => 'Resuelto.',
			'game.completeBody' => 'Has completado este sudoku.',
			'game.backHome' => 'Volver al inicio',
			'game.pause' => 'Pausar',
			'game.pausedTitle' => 'Pausado',
			'game.resume' => 'Continuar',
			'game.pausedAt' => ({required Object time}) => 'Temporizador detenido en ${time}',
			'game.loading' => 'Preparando el sudoku…',
			'game.restoreUnavailable' => 'No se pudo restaurar la partida.',
			'game.saveFailed' => 'No se pudo guardar la partida.',
			'game.retrySave' => 'Reintentar',
			'game.completionStats' => ({required Object mistakes, required Object hints}) => '${mistakes} errores · ${hints} pistas',
			'game.standardTitle' => 'Sudoku',
			'game.dailyTitle' => 'Sudoku del día',
			'learn.title' => 'Aprender',
			'learn.intro' => 'Una técnica y un paso claro cada vez.',
			'learn.newLabel' => 'Nuevo',
			'learn.learningLabel' => 'Aprendiendo',
			'learn.practicingLabel' => 'Practicando',
			'learn.masteredLabel' => 'Dominado',
			'learn.planTitle' => 'Plan de la lección',
			'learn.lessonStart' => 'Empezar lección',
			'learn.next' => 'Siguiente',
			'learn.practiceStart' => 'Empezar práctica',
			'learn.concept' => 'Concepto',
			'learn.lookFor' => 'Qué buscar',
			'learn.reasoning' => 'Por qué funciona',
			'learn.example' => 'Ejemplo',
			'learn.tryIt' => 'Inténtalo',
			'learn.exercise' => ({required Object current, required Object total}) => 'Ejercicio ${current} de ${total}',
			'learn.placementPrompt' => 'Elige una casilla y un número.',
			'learn.eliminationPrompt' => 'Elige una casilla y marca todos los candidatos que se pueden eliminar.',
			'learn.checkAnswer' => 'Comprobar',
			'learn.correctTitle' => 'Bien visto',
			'learn.incorrectTitle' => 'Todavía no',
			'learn.tryAgain' => 'Intentar de nuevo',
			'learn.askMichi' => 'Preguntar a MICHI',
			'learn.nextScenario' => 'Siguiente ejercicio',
			'learn.sessionSummary' => 'Práctica completada',
			'learn.summaryStats' => ({required Object correct, required Object attempts}) => '${correct} correctos · ${attempts} intentos',
			'learn.hintsUsed' => ({required Object count}) => '${count} con MICHI',
			'learn.done' => 'Listo',
			'learn.loading' => 'Preparando la lección…',
			'learn.unavailable' => 'El contenido no está disponible. Inténtalo de nuevo.',
			'learn.noScenarios' => 'Aún no hay ejercicios disponibles.',
			'learn.saveFailed' => 'No se pudo guardar el progreso. Inténtalo de nuevo.',
			'learn.selectedForElimination' => 'Marcado para eliminar',
			'learn.requiredTechniques' => 'Técnicas de este sudoku',
			'learn.helpedTechniques' => 'MICHI ayudó con',
			'learn.noHints' => 'Sin pistas',
			'learn.practiceTitle' => 'Práctica',
			'learn.continueLesson' => 'Continuar lección',
			'learn.lessons.nakedSingle.description' => 'Una casilla vacía solo admite un número.',
			'learn.lessons.nakedSingle.concept' => 'Los candidatos son los números que aún pueden ir en una casilla vacía.',
			'learn.lessons.nakedSingle.lookFor' => 'Busca una casilla donde fila, columna y bloque descarten todos menos uno.',
			'learn.lessons.nakedSingle.reasoning' => 'Queda un candidato, así que ese número debe ir allí.',
			'learn.lessons.nakedSingle.example' => 'La casilla resaltada tiene un solo candidato legal.',
			'learn.lessons.nakedSingle.tryIt' => 'Elige la casilla y coloca el número restante.',
			'learn.lessons.hiddenSingle.description' => 'Un número solo tiene una posición en una fila, columna o bloque.',
			'learn.lessons.hiddenSingle.concept' => 'Observa un número en toda la unidad, no todos los candidatos de una casilla.',
			'learn.lessons.hiddenSingle.lookFor' => 'Busca la única posición donde aún cabe ese número.',
			'learn.lessons.hiddenSingle.reasoning' => 'La casilla puede tener varios candidatos, pero el número solo tiene un lugar.',
			'learn.lessons.hiddenSingle.example' => 'La unidad resaltada deja una única posición para ese número.',
			'learn.lessons.hiddenSingle.tryIt' => 'Elige la posición única y coloca el número.',
			'learn.lessons.nakedPair.description' => 'Dos casillas de una unidad comparten los mismos dos candidatos.',
			'learn.lessons.nakedPair.concept' => 'La pareja reserva esos dos números para ambas casillas.',
			'learn.lessons.nakedPair.lookFor' => 'Busca dos casillas de la misma unidad con los mismos dos candidatos.',
			'learn.lessons.nakedPair.reasoning' => 'Esos números no pueden estar en otras casillas de la unidad: elimínalos.',
			'learn.lessons.nakedPair.example' => 'La pareja resaltada elimina candidatos en otras casillas.',
			'learn.lessons.nakedPair.tryIt' => 'Marca todos los candidatos eliminados. Aún no coloques ningún número.',
			'learn.lessons.pointingPair.description' => 'Dos posiciones de un candidato en un bloque comparten fila o columna.',
			'learn.lessons.pointingPair.concept' => 'El bloque puede restringir un número a una sola línea.',
			'learn.lessons.pointingPair.lookFor' => 'Busca exactamente dos posiciones del número alineadas dentro del bloque.',
			'learn.lessons.pointingPair.reasoning' => 'El número queda dentro del bloque; elimínalo fuera del bloque en la misma línea.',
			'learn.lessons.pointingPair.example' => 'Sigue la línea resaltada fuera del bloque.',
			'learn.lessons.pointingPair.tryIt' => 'Marca todos los candidatos eliminados fuera del bloque.',
			'progress.unavailable' => 'El dominio de las técnicas llegará más adelante.',
			'profile.unavailable' => 'La configuración del perfil llegará más adelante.',
			'scanner.unavailable' => 'La importación con cámara llegará después del juego principal.',
			'coach.step' => ({required Object step}) => 'Pista ${step} de 4',
			'coach.kTry' => 'Lo intentaré',
			'coach.show' => 'Mostrar',
			'coach.see' => 'Ya veo',
			'coach.more' => 'Otra pista',
			'coach.close' => 'Cerrar',
			'coach.showMistake' => 'Mostrar error',
			'coach.place' => ({required Object digit}) => 'Colocar ${digit}',
			'coach.unitRow' => ({required Object index}) => 'fila ${index}',
			'coach.unitColumn' => ({required Object index}) => 'columna ${index}',
			'coach.unitBox' => ({required Object index}) => 'bloque ${index}',
			'coach.inspectCell' => 'Mira la casilla resaltada.',
			'coach.inspectUnit' => ({required Object unit}) => 'Mira la ${unit} resaltada.',
			'coach.inspectCandidates' => '¿Qué números pueden ir aquí?',
			'coach.inspectPositions' => ({required Object unit}) => '¿Dónde puede ir este número en la ${unit} resaltada?',
			'coach.inspectPair' => 'Encuentra dos casillas con los mismos dos candidatos.',
			'coach.singleRemains' => 'Solo queda un candidato en esta casilla.',
			'coach.onlyPosition' => ({required Object unit}) => 'Solo queda un lugar para este número en la ${unit}.',
			'coach.pairRestriction' => ({required Object unit}) => 'Estos dos números ocupan el par resaltado. Puedes eliminarlos en otras casillas de la ${unit}.',
			'coach.alignment' => 'Los candidatos están alineados, así que este número se elimina fuera del bloque.',
			'coach.resultPlacement' => ({required Object digit}) => '${digit} solo puede ir en la casilla resaltada.',
			'coach.resultEliminations' => 'Elimina los candidatos tachados de las casillas resaltadas.',
			'coach.resultActions' => 'Aplica el paso lógico resaltado.',
			'coach.technique' => ({required Object name}) => 'Técnica: ${name}',
			'coach.nakedSingle' => 'único candidato',
			'coach.hiddenSingle' => 'único oculto',
			'coach.nakedPair' => 'par desnudo',
			'coach.pointingPair' => 'par apuntador',
			'coach.unavailable' => 'Pista no disponible',
			'coach.wrongTitle' => 'Corrige primero el error.',
			'coach.wrongBody' => 'No se puede encontrar un paso lógico mientras haya un número incorrecto.',
			'coach.stuckTitle' => 'Aún no hay un paso compatible.',
			'coach.stuckBody' => 'MICHI todavía no puede explicar el siguiente paso con las técnicas disponibles.',
			_ => null,
		};
	}
}
