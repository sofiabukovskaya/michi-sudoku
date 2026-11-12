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
	@override late final _Translations$why$es why = _Translations$why$es._(_root);
	@override late final _Translations$recommendation$es recommendation = _Translations$recommendation$es._(_root);
	@override late final _Translations$week$es week = _Translations$week$es._(_root);
	@override late final _Translations$settings$es settings = _Translations$settings$es._(_root);
	@override late final _Translations$sync$es sync = _Translations$sync$es._(_root);
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
	@override String get title => 'Encuentra tu camino a través de la lógica.';
	@override String get subtitle => 'Sudoku con un guía que te orienta sin resolverlo por ti.';
	@override String get guest => 'Empezar sin cuenta';
}

// Path: onboarding
class _Translations$onboarding$es extends Translations$onboarding$uk {
	_Translations$onboarding$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tu aprendizaje empieza aquí.';
	@override String get chooseLevel => 'Elegir nivel';
	@override String get skip => 'Saltar';
	@override String get next => 'Siguiente';
	@override String get seeTitle => 'El sudoku es más fácil cuando sabes dónde mirar.';
	@override String get seeBody => 'MICHI explica la lógica de cada jugada.';
	@override String get hintsTitle => 'Pistas que enseñan.';
	@override String get hintsBody => 'Empieza con una pista suave. Pide más si lo necesitas.';
	@override String get patternsTitle => 'Aprende patrones, no respuestas.';
	@override String get patternsBody => 'Singles ocultos, pares, X-Wing: a tu ritmo.';
	@override String get pathTitle => 'Tu camino por el sudoku.';
	@override String get pathBody => 'MICHI detecta lo que te cuesta y propone qué practicar.';
}

// Path: playerLevel
class _Translations$playerLevel$es extends Translations$playerLevel$uk {
	_Translations$playerLevel$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => '¿Cuánto sabes de sudoku?';
	@override String get goToGame => 'Empezar a jugar';
	@override String get subtitle => 'Esto define tu primera lección y dificultad. Puedes cambiarlo después.';
	@override String get beginner => 'Estoy empezando';
	@override String get beginnerDetail => 'Reglas y primeros pasos';
	@override String get basics => 'Conozco lo básico';
	@override String get basicsDetail => 'Singles y candidatos';
	@override String get regular => 'Juego con frecuencia';
	@override String get regularDetail => 'Pares y pares señalados';
	@override String get advanced => 'Quiero un reto';
	@override String get advancedDetail => 'X-Wing y más';
}

// Path: auth
class _Translations$auth$es extends Translations$auth$uk {
	_Translations$auth$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cuenta';
	@override String get unavailable => 'Tu progreso se guarda en este dispositivo.';
	@override String get apple => 'Continuar con Apple';
	@override String get google => 'Continuar con Google';
	@override String get emailEntry => 'Iniciar sesión con correo';
	@override String get createTitle => 'Crear una cuenta';
	@override String get createSubtitle => 'Tu progreso permanece en este dispositivo hasta que la sincronización esté disponible.';
	@override String get signInTitle => 'Qué alegría verte de nuevo';
	@override String get name => 'Nombre';
	@override String get email => 'Correo electrónico';
	@override String get password => 'Contraseña';
	@override String get passwordHint => 'Al menos 8 caracteres';
	@override String get createAccount => 'Crear cuenta';
	@override String get signIn => 'Iniciar sesión';
	@override String get alreadyAccount => '¿Ya tienes una cuenta?';
	@override String get noAccount => '¿No tienes cuenta?';
	@override String get forgotPassword => '¿Olvidaste la contraseña?';
	@override String get resetTitle => 'Restablecer contraseña';
	@override String get resetSubtitle => 'Introduce el correo de tu cuenta y te enviaremos un enlace.';
	@override String get sendLink => 'Enviar enlace';
	@override String get resetSent => 'Si la cuenta existe, revisa tu correo para encontrar el enlace.';
	@override String get verifyTitle => 'Revisa tu correo';
	@override String verifySubtitle({required Object email}) => 'Enviamos un enlace de verificación a ${email}.';
	@override String get checkVerification => 'Ya verifiqué mi correo';
	@override String get resendVerification => 'Reenviar enlace';
	@override String get verified => 'Tu correo está verificado.';
	@override String get notVerified => 'El correo aún no está verificado.';
	@override String get signOut => 'Cerrar sesión';
	@override String get localNotSynced => 'El progreso del juego sigue guardado en este dispositivo.';
	@override String get verifyEmail => 'Verificar correo';
	@override String get errorInvalidEmail => 'Introduce un correo válido.';
	@override String get errorPasswordLength => 'Usa al menos 8 caracteres.';
	@override String get errorNameRequired => 'Introduce tu nombre.';
	@override String get errorWeakPassword => 'Esta contraseña es demasiado débil.';
	@override String get errorEmailInUse => 'Ya existe una cuenta con este correo.';
	@override String get errorWrongCredentials => 'Revisa el correo y la contraseña.';
	@override String get errorDisabled => 'Esta cuenta está deshabilitada.';
	@override String get errorTooMany => 'Demasiados intentos. Vuelve más tarde.';
	@override String get errorNetwork => 'Revisa tu conexión e inténtalo de nuevo.';
	@override String get errorUnavailable => 'El servicio de cuentas no está disponible. Puedes seguir jugando como invitado.';
	@override String get errorUnexpected => 'Algo salió mal. Inténtalo de nuevo.';
	@override String get showPassword => 'Mostrar contraseña';
	@override String get hidePassword => 'Ocultar contraseña';
	@override String get signOutTitle => '¿Cerrar sesión?';
	@override String get signOutBody => 'Tus partidas locales permanecerán en este dispositivo.';
	@override String get cancel => 'Cancelar';
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
	@override String get advanced => 'Avanzado';
	@override String get expert => 'Experto';
	@override String get greeting => 'Buenos días';
	@override String get newPuzzle => 'Otro sudoku';
	@override String get weekTitle => 'Esta semana';
	@override String get weekDetails => 'Detalles';
	@override String get weekdaysShort => 'Lu|Ma|Mi|Ju|Vi|Sá|Do';
	@override String get newPuzzleTitle => 'Nuevo sudoku';
	@override String get catalogSource => 'Elige un sudoku';
	@override String get scanSource => 'Escanear sudoku';
	@override String get scanSourceDetail => 'Foto o cámara';
	@override String get weekStatusDone => 'Completado';
	@override String get weekStatusToday => 'Hoy';
	@override String get weekStatusEmpty => 'Sin actividad';
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
	@override String get completionLogic => 'casillas resueltas';
	@override String get completionMistakes => 'errores';
	@override String get completionHints => 'pistas';
	@override String get dailyStampEarned => 'Sello diario conseguido';
	@override String completionPracticeTechnique({required Object technique}) => 'Siguiente paso: ${technique}';
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
	@override String get basicsGroup => 'Fundamentos';
	@override String get intermediateGroup => 'Nivel intermedio';
	@override String get advancedGroup => 'Nivel avanzado';
	@override String get nowLabel => 'Ahora';
	@override String groupProgress({required Object completed, required Object total}) => '${completed} de ${total}';
	@override String get extraElimination => 'Este patrón no elimina uno de los candidatos elegidos. Revisa las celdas resaltadas.';
	@override String get missingElimination => 'Quedan candidatos por eliminar. Sigue la unidad resaltada.';
	@override String get wrongPlacement => 'Esa celda o dígito no coincide con la deducción. Revisa la posición resaltada.';
	@override String minutes({required Object count}) => '${count} min';
	@override String tasks({required Object count}) => '${count} ejercicios';
	@override String get wrongCell => 'Esta casilla está fuera del patrón. Mira las casillas resaltadas.';
	@override String get wrongDigit => 'El patrón no coloca ese número. Revisa los candidatos de la casilla resaltada.';
	@override String get wrongCellAndDigit => 'La selección no coincide con el patrón. Compara las casillas resaltadas y sus candidatos.';
	@override String findTechnique({required Object technique}) => 'Encuentra: ${technique}';
}

// Path: progress
class _Translations$progress$es extends Translations$progress$uk {
	_Translations$progress$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get doingWell => 'Lo que haces bien';
	@override String get learningNow => 'Lo que aprendes ahora';
	@override String get next => 'Siguiente paso';
	@override String get noStrong => 'Tus técnicas más fuertes aparecerán después de practicar.';
	@override String get startLearning => 'Empezar a aprender';
	@override String get thisWeek => 'Esta semana';
	@override String completed({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sudoku completado',
		other: '${n} sudokus completados',
	);
	@override String mastery({required Object percent}) => 'Dominio ${percent} %';
	@override String get openTechnique => 'Abrir técnica';
}

// Path: profile
class _Translations$profile$es extends Translations$profile$uk {
	_Translations$profile$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get guest => 'Invitado';
	@override String get localOnly => 'El progreso se guarda en este dispositivo.';
	@override String get puzzles => 'Sudokus';
	@override String get mastered => 'Dominadas';
	@override String get activeDays => 'Días activos';
	@override String get learnRow => 'Aprender';
	@override String get learnDetail => 'Técnicas y práctica';
	@override String get settingsRow => 'Ajustes';
	@override String get settingsDetail => 'Idioma';
	@override String get activity => 'Tu actividad';
}

// Path: scanner
class _Translations$scanner$es extends Translations$scanner$uk {
	_Translations$scanner$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Escanear sudoku';
	@override String get intro => 'Encuadra toda la cuadrícula y haz una foto o elige una.';
	@override String get openCamera => 'Usar cámara';
	@override String get choosePhoto => 'Elegir foto';
	@override String get shutter => 'Hacer foto';
	@override String get frameGuide => 'Mantén las cuatro esquinas dentro del encuadre.';
	@override String get processing => 'Leyendo tu sudoku…';
	@override String get reviewTitle => 'Revisa los números';
	@override String get reviewBody => 'Toca una casilla para corregirla antes de jugar.';
	@override String get needsReview => 'Revisar';
	@override String get conflict => 'Número en conflicto';
	@override String get selected => 'seleccionada';
	@override String get recognized => 'reconocido';
	@override String get empty => 'vacía';
	@override String get clear => 'Borrar';
	@override String get confirm => 'Importar sudoku';
	@override String get rescan => 'Escanear de nuevo';
	@override String get permissionIntro => 'Permite el acceso a la cámara para hacer una foto.';
	@override String get permissionDenied => 'Se denegó el acceso a la cámara. Puedes elegir una foto.';
	@override String get permissionSettings => 'Activa la cámara en Ajustes o elige una foto.';
	@override String get noCamera => 'La cámara no está disponible. Elige una foto.';
	@override String get openSettings => 'Abrir Ajustes';
	@override String get imageDecodeFailure => 'No pudimos leer la imagen. Prueba con otra foto.';
	@override String get noGridFound => 'No encontramos la cuadrícula. Inclúyela entera e inténtalo de nuevo.';
	@override String get invalidGeometry => 'No pudimos enderezar la cuadrícula. Prueba con una foto más nítida.';
	@override String get segmentationFailure => 'No pudimos dividir la cuadrícula en casillas. Inténtalo de nuevo.';
	@override String get recognitionFailure => 'No pudimos leer algunos números. Inténtalo de nuevo.';
	@override String get duplicateClues => 'Corrige los números en conflicto resaltados.';
	@override String get noSolution => 'Estos números no tienen solución. Revísalos.';
	@override String get multipleSolutions => 'Pueden faltar números; este sudoku tiene varias soluciones.';
	@override String get storageFailure => 'No pudimos guardar el sudoku importado. Inténtalo de nuevo.';
	@override String get validationFailure => 'No se pudo comprobar este sudoku. Vuelve a confirmar.';
	@override String get unsupportedCoach => 'MICHI quizá aún no pueda explicar todos los pasos de este sudoku.';
	@override String get importedTitle => 'Sudoku importado';
	@override String lowConfidenceCount({required Object count}) => 'Casillas para revisar: ${count}';
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
	@override String get hiddenPair => 'Par oculto';
	@override String get boxLineReduction => 'Reducción línea-caja';
	@override String get nakedTriple => 'Trío desnudo';
	@override String get xWing => 'X-Wing';
	@override String get identifyHiddenPair => 'Dos dígitos solo caben en las mismas dos celdas. Elimina los demás candidatos.';
	@override String get understandBoxLine => 'La línea limita este dígito a una caja. Elimínalo del resto de la caja.';
	@override String get understandTriple => 'Tres celdas comparten exactamente tres dígitos. Elimínalos de las otras celdas de la unidad.';
	@override String get understandXWing => 'Dos líneas tienen este dígito en los mismos dos cruces. Elimínalo de los demás cruces.';
}

// Path: why
class _Translations$why$es extends Translations$why$uk {
	_Translations$why$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Explicación';
	@override String whyHere({required Object digit}) => '¿Por qué va el ${digit} aquí?';
	@override String get givenTitle => 'Esta cifra es una pista inicial';
	@override String get givenBody => 'Estaba en el tablero desde el principio, así que no hay un paso lógico que explicar. Hay explicaciones para las cifras que colocas tú.';
	@override String get unavailableTitle => 'Aún no hay explicación directa';
	@override String get unavailableBody => 'MICHI no puede demostrar este movimiento con una técnica compatible en el estado anterior.';
	@override String get lesson => 'Lección';
	@override String get gotIt => 'Entendido';
	@override String unitRestrictions({required Object unit, required Object digits}) => 'En ${unit} ya están estas cifras: ${digits}.';
	@override String onlyCandidate({required Object digit}) => 'La fila, columna y bloque descartan los demás números. Aquí solo cabe ${digit}.';
	@override String unitSearch({required Object digit, required Object unit}) => 'Buscamos un lugar para el ${digit} en ${unit}.';
	@override String solePosition({required Object digit, required Object unit}) => 'Los ${digit} tachados muestran dónde no puede ir en ${unit}. Solo queda esta casilla.';
	@override String placement({required Object digit}) => 'Por eso aquí va el ${digit}.';
	@override String unitRow({required Object index}) => 'la fila ${index}';
	@override String unitColumn({required Object index}) => 'la columna ${index}';
	@override String unitBox({required Object index}) => 'el bloque ${index}';
}

// Path: recommendation
class _Translations$recommendation$es extends Translations$recommendation$uk {
	_Translations$recommendation$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String focusTitle({required Object technique}) => 'Enfoque de hoy: ${technique}';
	@override String learnAction({required Object technique}) => 'Aprender: ${technique}';
	@override String practiceAction({required Object technique}) => 'Practicar: ${technique}';
	@override String reviewAction({required Object technique}) => 'Repasar: ${technique}';
	@override String duration({required Object minutes}) => '${minutes} min';
	@override String get startWithBasics => 'Empieza por el primer paso lógico.';
	@override String get repeatedCoachHelp => 'Hace poco necesitaste ayuda de MICHI.';
	@override String get weakIndependentPractice => 'Conviene reforzar la práctica independiente.';
	@override String get continuePractice => 'Sigue practicando esta técnica.';
	@override String get nextTechnique => 'El siguiente paso en tu camino.';
	@override String get masteredNeedsReview => 'Conviene repasar una técnica conocida.';
	@override String get allMasteredReview => 'Repasa una técnica que ya dominas.';
}

// Path: week
class _Translations$week$es extends Translations$week$uk {
	_Translations$week$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Esta semana';
	@override String get empty => 'Aún no has completado sudokus esta semana. Tu actividad aparecerá cuando juegues.';
	@override String get puzzles => 'Sudokus';
	@override String get minutes => 'Minutos';
	@override String get daily => 'Diarios';
	@override String activeDays({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} día activo',
		other: '${n} días activos',
	);
	@override String completedDay({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n,
		one: '${n} sudoku completado',
		other: '${n} sudokus completados',
	);
	@override String get today => 'Hoy';
	@override String get noActivity => 'Sin actividad';
	@override String get summary => 'Tu actividad local de sudoku';
}

// Path: settings
class _Translations$settings$es extends Translations$settings$uk {
	_Translations$settings$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get general => 'General';
	@override String get title => 'Ajustes';
	@override String get language => 'Idioma';
	@override String get languageDetail => 'Elige el idioma de MICHI.';
	@override String get reminders => 'Recordatorios';
	@override String get dailyReminder => 'Cada día a las 08:00';
	@override String get reminderSignIn => 'Inicia sesión para activar los recordatorios.';
	@override String get reminderPermission => 'Permite las notificaciones en los ajustes del dispositivo.';
	@override String get reminderUnavailable => 'Las notificaciones no están disponibles en este dispositivo.';
}

// Path: sync
class _Translations$sync$es extends Translations$sync$uk {
	_Translations$sync$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get account => 'Cuenta';
	@override String get email => 'Correo electrónico';
	@override String get synchronization => 'Sincronización';
	@override String get syncing => 'Sincronizando…';
	@override String get synced => 'Sincronizado recientemente';
	@override String lastSynced({required Object time}) => 'Última sincronización — ${time}';
	@override String get pending => 'Guardado en el dispositivo · pendiente de sincronización';
	@override String get offline => 'Sin conexión. Tu progreso se guardará y se sincronizará después.';
	@override String get error => 'Error de sincronización';
	@override String get retry => 'Reintentar';
	@override String get guest => 'El progreso solo se guarda en este dispositivo.';
	@override String get deleteAccount => 'Eliminar cuenta';
	@override String get deleteTitle => '¿Eliminar tu cuenta?';
	@override String get deleteBody => 'Tu cuenta y el progreso sincronizado se eliminarán definitivamente.';
	@override String get deleteConfirm => 'Eliminar cuenta';
	@override String get deleteFailed => 'No se pudo eliminar tu cuenta. Vuelve a iniciar sesión e inténtalo.';
	@override String get signOut => 'Cerrar sesión';
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
	@override late final _Translations$learn$lessons$hiddenPair$es hiddenPair = _Translations$learn$lessons$hiddenPair$es._(_root);
	@override late final _Translations$learn$lessons$boxLineReduction$es boxLineReduction = _Translations$learn$lessons$boxLineReduction$es._(_root);
	@override late final _Translations$learn$lessons$nakedTriple$es nakedTriple = _Translations$learn$lessons$nakedTriple$es._(_root);
	@override late final _Translations$learn$lessons$xWing$es xWing = _Translations$learn$lessons$xWing$es._(_root);
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

// Path: learn.lessons.hiddenPair
class _Translations$learn$lessons$hiddenPair$es extends Translations$learn$lessons$hiddenPair$uk {
	_Translations$learn$lessons$hiddenPair$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dos dígitos se esconden en las mismas dos celdas.';
	@override String get concept => 'Busca un par oculto siguiendo dígitos, no listas iguales.';
	@override String get lookFor => 'Encuentra dos dígitos que solo aparezcan en las mismas dos celdas de una unidad.';
	@override String get reasoning => 'Ambos pertenecen a esas celdas; elimina allí los otros candidatos.';
	@override String get example => 'Las celdas resaltadas son las únicas posiciones de ambos dígitos.';
	@override String get tryIt => 'Elimina los candidatos extra de esas dos celdas.';
}

// Path: learn.lessons.boxLineReduction
class _Translations$learn$lessons$boxLineReduction$es extends Translations$learn$lessons$boxLineReduction$uk {
	_Translations$learn$lessons$boxLineReduction$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Una fila o columna limita un dígito a una caja.';
	@override String get concept => 'Una línea puede fijar un dígito dentro de una caja.';
	@override String get lookFor => 'Busca dos o tres posiciones de un dígito en una línea, todas en la misma caja.';
	@override String get reasoning => 'El dígito estará en esa caja y línea; elimínalo del resto de la caja.';
	@override String get example => 'Sigue la línea resaltada dentro de la caja y busca candidatos fuera de ella.';
	@override String get tryIt => 'Elimina el dígito de las otras celdas de la caja.';
}

// Path: learn.lessons.nakedTriple
class _Translations$learn$lessons$nakedTriple$es extends Translations$learn$lessons$nakedTriple$uk {
	_Translations$learn$lessons$nakedTriple$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Tres celdas comparten solo tres dígitos candidatos.';
	@override String get concept => 'Un trío reserva tres dígitos para tres celdas de una unidad.';
	@override String get lookFor => 'Busca tres celdas cuya unión de candidatos tenga exactamente tres dígitos.';
	@override String get reasoning => 'Los tres dígitos llenarán esas celdas aunque sus listas sean distintas.';
	@override String get example => 'Las celdas resaltadas tienen pares distintos, pero solo tres dígitos en total.';
	@override String get tryIt => 'Elimina esos dígitos del resto de la unidad.';
}

// Path: learn.lessons.xWing
class _Translations$learn$lessons$xWing$es extends Translations$learn$lessons$xWing$uk {
	_Translations$learn$lessons$xWing$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get description => 'Dos líneas alinean un dígito en dos cruces.';
	@override String get concept => 'X-Wing une dos filas o columnas mediante un candidato.';
	@override String get lookFor => 'Busca dos líneas donde el dígito aparezca dos veces en las mismas posiciones.';
	@override String get reasoning => 'Los cuatro cruces reservan el dígito; elimínalo del resto de las líneas cruzadas.';
	@override String get example => 'Sigue las cuatro posiciones resaltadas y las dos líneas cruzadas.';
	@override String get tryIt => 'Elimina el dígito fuera de las cuatro celdas del patrón.';
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
			'welcome.title' => 'Encuentra tu camino a través de la lógica.',
			'welcome.subtitle' => 'Sudoku con un guía que te orienta sin resolverlo por ti.',
			'welcome.guest' => 'Empezar sin cuenta',
			'onboarding.title' => 'Tu aprendizaje empieza aquí.',
			'onboarding.chooseLevel' => 'Elegir nivel',
			'onboarding.skip' => 'Saltar',
			'onboarding.next' => 'Siguiente',
			'onboarding.seeTitle' => 'El sudoku es más fácil cuando sabes dónde mirar.',
			'onboarding.seeBody' => 'MICHI explica la lógica de cada jugada.',
			'onboarding.hintsTitle' => 'Pistas que enseñan.',
			'onboarding.hintsBody' => 'Empieza con una pista suave. Pide más si lo necesitas.',
			'onboarding.patternsTitle' => 'Aprende patrones, no respuestas.',
			'onboarding.patternsBody' => 'Singles ocultos, pares, X-Wing: a tu ritmo.',
			'onboarding.pathTitle' => 'Tu camino por el sudoku.',
			'onboarding.pathBody' => 'MICHI detecta lo que te cuesta y propone qué practicar.',
			'playerLevel.title' => '¿Cuánto sabes de sudoku?',
			'playerLevel.goToGame' => 'Empezar a jugar',
			'playerLevel.subtitle' => 'Esto define tu primera lección y dificultad. Puedes cambiarlo después.',
			'playerLevel.beginner' => 'Estoy empezando',
			'playerLevel.beginnerDetail' => 'Reglas y primeros pasos',
			'playerLevel.basics' => 'Conozco lo básico',
			'playerLevel.basicsDetail' => 'Singles y candidatos',
			'playerLevel.regular' => 'Juego con frecuencia',
			'playerLevel.regularDetail' => 'Pares y pares señalados',
			'playerLevel.advanced' => 'Quiero un reto',
			'playerLevel.advancedDetail' => 'X-Wing y más',
			'auth.title' => 'Cuenta',
			'auth.unavailable' => 'Tu progreso se guarda en este dispositivo.',
			'auth.apple' => 'Continuar con Apple',
			'auth.google' => 'Continuar con Google',
			'auth.emailEntry' => 'Iniciar sesión con correo',
			'auth.createTitle' => 'Crear una cuenta',
			'auth.createSubtitle' => 'Tu progreso permanece en este dispositivo hasta que la sincronización esté disponible.',
			'auth.signInTitle' => 'Qué alegría verte de nuevo',
			'auth.name' => 'Nombre',
			'auth.email' => 'Correo electrónico',
			'auth.password' => 'Contraseña',
			'auth.passwordHint' => 'Al menos 8 caracteres',
			'auth.createAccount' => 'Crear cuenta',
			'auth.signIn' => 'Iniciar sesión',
			'auth.alreadyAccount' => '¿Ya tienes una cuenta?',
			'auth.noAccount' => '¿No tienes cuenta?',
			'auth.forgotPassword' => '¿Olvidaste la contraseña?',
			'auth.resetTitle' => 'Restablecer contraseña',
			'auth.resetSubtitle' => 'Introduce el correo de tu cuenta y te enviaremos un enlace.',
			'auth.sendLink' => 'Enviar enlace',
			'auth.resetSent' => 'Si la cuenta existe, revisa tu correo para encontrar el enlace.',
			'auth.verifyTitle' => 'Revisa tu correo',
			'auth.verifySubtitle' => ({required Object email}) => 'Enviamos un enlace de verificación a ${email}.',
			'auth.checkVerification' => 'Ya verifiqué mi correo',
			'auth.resendVerification' => 'Reenviar enlace',
			'auth.verified' => 'Tu correo está verificado.',
			'auth.notVerified' => 'El correo aún no está verificado.',
			'auth.signOut' => 'Cerrar sesión',
			'auth.localNotSynced' => 'El progreso del juego sigue guardado en este dispositivo.',
			'auth.verifyEmail' => 'Verificar correo',
			'auth.errorInvalidEmail' => 'Introduce un correo válido.',
			'auth.errorPasswordLength' => 'Usa al menos 8 caracteres.',
			'auth.errorNameRequired' => 'Introduce tu nombre.',
			'auth.errorWeakPassword' => 'Esta contraseña es demasiado débil.',
			'auth.errorEmailInUse' => 'Ya existe una cuenta con este correo.',
			'auth.errorWrongCredentials' => 'Revisa el correo y la contraseña.',
			'auth.errorDisabled' => 'Esta cuenta está deshabilitada.',
			'auth.errorTooMany' => 'Demasiados intentos. Vuelve más tarde.',
			'auth.errorNetwork' => 'Revisa tu conexión e inténtalo de nuevo.',
			'auth.errorUnavailable' => 'El servicio de cuentas no está disponible. Puedes seguir jugando como invitado.',
			'auth.errorUnexpected' => 'Algo salió mal. Inténtalo de nuevo.',
			'auth.showPassword' => 'Mostrar contraseña',
			'auth.hidePassword' => 'Ocultar contraseña',
			'auth.signOutTitle' => '¿Cerrar sesión?',
			'auth.signOutBody' => 'Tus partidas locales permanecerán en este dispositivo.',
			'auth.cancel' => 'Cancelar',
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
			'home.advanced' => 'Avanzado',
			'home.expert' => 'Experto',
			'home.greeting' => 'Buenos días',
			'home.newPuzzle' => 'Otro sudoku',
			'home.weekTitle' => 'Esta semana',
			'home.weekDetails' => 'Detalles',
			'home.weekdaysShort' => 'Lu|Ma|Mi|Ju|Vi|Sá|Do',
			'home.newPuzzleTitle' => 'Nuevo sudoku',
			'home.catalogSource' => 'Elige un sudoku',
			'home.scanSource' => 'Escanear sudoku',
			'home.scanSourceDetail' => 'Foto o cámara',
			'home.weekStatusDone' => 'Completado',
			'home.weekStatusToday' => 'Hoy',
			'home.weekStatusEmpty' => 'Sin actividad',
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
			'game.completionLogic' => 'casillas resueltas',
			'game.completionMistakes' => 'errores',
			'game.completionHints' => 'pistas',
			'game.dailyStampEarned' => 'Sello diario conseguido',
			'game.completionPracticeTechnique' => ({required Object technique}) => 'Siguiente paso: ${technique}',
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
			'learn.lessons.hiddenPair.description' => 'Dos dígitos se esconden en las mismas dos celdas.',
			'learn.lessons.hiddenPair.concept' => 'Busca un par oculto siguiendo dígitos, no listas iguales.',
			'learn.lessons.hiddenPair.lookFor' => 'Encuentra dos dígitos que solo aparezcan en las mismas dos celdas de una unidad.',
			'learn.lessons.hiddenPair.reasoning' => 'Ambos pertenecen a esas celdas; elimina allí los otros candidatos.',
			'learn.lessons.hiddenPair.example' => 'Las celdas resaltadas son las únicas posiciones de ambos dígitos.',
			'learn.lessons.hiddenPair.tryIt' => 'Elimina los candidatos extra de esas dos celdas.',
			'learn.lessons.boxLineReduction.description' => 'Una fila o columna limita un dígito a una caja.',
			'learn.lessons.boxLineReduction.concept' => 'Una línea puede fijar un dígito dentro de una caja.',
			'learn.lessons.boxLineReduction.lookFor' => 'Busca dos o tres posiciones de un dígito en una línea, todas en la misma caja.',
			'learn.lessons.boxLineReduction.reasoning' => 'El dígito estará en esa caja y línea; elimínalo del resto de la caja.',
			'learn.lessons.boxLineReduction.example' => 'Sigue la línea resaltada dentro de la caja y busca candidatos fuera de ella.',
			'learn.lessons.boxLineReduction.tryIt' => 'Elimina el dígito de las otras celdas de la caja.',
			'learn.lessons.nakedTriple.description' => 'Tres celdas comparten solo tres dígitos candidatos.',
			'learn.lessons.nakedTriple.concept' => 'Un trío reserva tres dígitos para tres celdas de una unidad.',
			'learn.lessons.nakedTriple.lookFor' => 'Busca tres celdas cuya unión de candidatos tenga exactamente tres dígitos.',
			'learn.lessons.nakedTriple.reasoning' => 'Los tres dígitos llenarán esas celdas aunque sus listas sean distintas.',
			'learn.lessons.nakedTriple.example' => 'Las celdas resaltadas tienen pares distintos, pero solo tres dígitos en total.',
			'learn.lessons.nakedTriple.tryIt' => 'Elimina esos dígitos del resto de la unidad.',
			'learn.lessons.xWing.description' => 'Dos líneas alinean un dígito en dos cruces.',
			'learn.lessons.xWing.concept' => 'X-Wing une dos filas o columnas mediante un candidato.',
			'learn.lessons.xWing.lookFor' => 'Busca dos líneas donde el dígito aparezca dos veces en las mismas posiciones.',
			'learn.lessons.xWing.reasoning' => 'Los cuatro cruces reservan el dígito; elimínalo del resto de las líneas cruzadas.',
			'learn.lessons.xWing.example' => 'Sigue las cuatro posiciones resaltadas y las dos líneas cruzadas.',
			'learn.lessons.xWing.tryIt' => 'Elimina el dígito fuera de las cuatro celdas del patrón.',
			'learn.basicsGroup' => 'Fundamentos',
			'learn.intermediateGroup' => 'Nivel intermedio',
			'learn.advancedGroup' => 'Nivel avanzado',
			'learn.nowLabel' => 'Ahora',
			'learn.groupProgress' => ({required Object completed, required Object total}) => '${completed} de ${total}',
			'learn.extraElimination' => 'Este patrón no elimina uno de los candidatos elegidos. Revisa las celdas resaltadas.',
			'learn.missingElimination' => 'Quedan candidatos por eliminar. Sigue la unidad resaltada.',
			'learn.wrongPlacement' => 'Esa celda o dígito no coincide con la deducción. Revisa la posición resaltada.',
			'learn.minutes' => ({required Object count}) => '${count} min',
			'learn.tasks' => ({required Object count}) => '${count} ejercicios',
			'learn.wrongCell' => 'Esta casilla está fuera del patrón. Mira las casillas resaltadas.',
			'learn.wrongDigit' => 'El patrón no coloca ese número. Revisa los candidatos de la casilla resaltada.',
			'learn.wrongCellAndDigit' => 'La selección no coincide con el patrón. Compara las casillas resaltadas y sus candidatos.',
			'learn.findTechnique' => ({required Object technique}) => 'Encuentra: ${technique}',
			'progress.doingWell' => 'Lo que haces bien',
			'progress.learningNow' => 'Lo que aprendes ahora',
			'progress.next' => 'Siguiente paso',
			'progress.noStrong' => 'Tus técnicas más fuertes aparecerán después de practicar.',
			'progress.startLearning' => 'Empezar a aprender',
			'progress.thisWeek' => 'Esta semana',
			'progress.completed' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sudoku completado', other: '${n} sudokus completados', ),
			'progress.mastery' => ({required Object percent}) => 'Dominio ${percent} %',
			'progress.openTechnique' => 'Abrir técnica',
			'profile.guest' => 'Invitado',
			'profile.localOnly' => 'El progreso se guarda en este dispositivo.',
			'profile.puzzles' => 'Sudokus',
			'profile.mastered' => 'Dominadas',
			'profile.activeDays' => 'Días activos',
			'profile.learnRow' => 'Aprender',
			'profile.learnDetail' => 'Técnicas y práctica',
			'profile.settingsRow' => 'Ajustes',
			'profile.settingsDetail' => 'Idioma',
			'profile.activity' => 'Tu actividad',
			'scanner.title' => 'Escanear sudoku',
			'scanner.intro' => 'Encuadra toda la cuadrícula y haz una foto o elige una.',
			'scanner.openCamera' => 'Usar cámara',
			'scanner.choosePhoto' => 'Elegir foto',
			'scanner.shutter' => 'Hacer foto',
			'scanner.frameGuide' => 'Mantén las cuatro esquinas dentro del encuadre.',
			'scanner.processing' => 'Leyendo tu sudoku…',
			'scanner.reviewTitle' => 'Revisa los números',
			'scanner.reviewBody' => 'Toca una casilla para corregirla antes de jugar.',
			'scanner.needsReview' => 'Revisar',
			'scanner.conflict' => 'Número en conflicto',
			'scanner.selected' => 'seleccionada',
			'scanner.recognized' => 'reconocido',
			'scanner.empty' => 'vacía',
			'scanner.clear' => 'Borrar',
			'scanner.confirm' => 'Importar sudoku',
			'scanner.rescan' => 'Escanear de nuevo',
			'scanner.permissionIntro' => 'Permite el acceso a la cámara para hacer una foto.',
			'scanner.permissionDenied' => 'Se denegó el acceso a la cámara. Puedes elegir una foto.',
			'scanner.permissionSettings' => 'Activa la cámara en Ajustes o elige una foto.',
			'scanner.noCamera' => 'La cámara no está disponible. Elige una foto.',
			'scanner.openSettings' => 'Abrir Ajustes',
			'scanner.imageDecodeFailure' => 'No pudimos leer la imagen. Prueba con otra foto.',
			'scanner.noGridFound' => 'No encontramos la cuadrícula. Inclúyela entera e inténtalo de nuevo.',
			'scanner.invalidGeometry' => 'No pudimos enderezar la cuadrícula. Prueba con una foto más nítida.',
			'scanner.segmentationFailure' => 'No pudimos dividir la cuadrícula en casillas. Inténtalo de nuevo.',
			'scanner.recognitionFailure' => 'No pudimos leer algunos números. Inténtalo de nuevo.',
			'scanner.duplicateClues' => 'Corrige los números en conflicto resaltados.',
			'scanner.noSolution' => 'Estos números no tienen solución. Revísalos.',
			'scanner.multipleSolutions' => 'Pueden faltar números; este sudoku tiene varias soluciones.',
			'scanner.storageFailure' => 'No pudimos guardar el sudoku importado. Inténtalo de nuevo.',
			'scanner.validationFailure' => 'No se pudo comprobar este sudoku. Vuelve a confirmar.',
			'scanner.unsupportedCoach' => 'MICHI quizá aún no pueda explicar todos los pasos de este sudoku.',
			'scanner.importedTitle' => 'Sudoku importado',
			'scanner.lowConfidenceCount' => ({required Object count}) => 'Casillas para revisar: ${count}',
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
			'coach.hiddenPair' => 'Par oculto',
			'coach.boxLineReduction' => 'Reducción línea-caja',
			'coach.nakedTriple' => 'Trío desnudo',
			'coach.xWing' => 'X-Wing',
			'coach.identifyHiddenPair' => 'Dos dígitos solo caben en las mismas dos celdas. Elimina los demás candidatos.',
			'coach.understandBoxLine' => 'La línea limita este dígito a una caja. Elimínalo del resto de la caja.',
			'coach.understandTriple' => 'Tres celdas comparten exactamente tres dígitos. Elimínalos de las otras celdas de la unidad.',
			'coach.understandXWing' => 'Dos líneas tienen este dígito en los mismos dos cruces. Elimínalo de los demás cruces.',
			'why.title' => 'Explicación',
			'why.whyHere' => ({required Object digit}) => '¿Por qué va el ${digit} aquí?',
			'why.givenTitle' => 'Esta cifra es una pista inicial',
			'why.givenBody' => 'Estaba en el tablero desde el principio, así que no hay un paso lógico que explicar. Hay explicaciones para las cifras que colocas tú.',
			'why.unavailableTitle' => 'Aún no hay explicación directa',
			'why.unavailableBody' => 'MICHI no puede demostrar este movimiento con una técnica compatible en el estado anterior.',
			'why.lesson' => 'Lección',
			'why.gotIt' => 'Entendido',
			'why.unitRestrictions' => ({required Object unit, required Object digits}) => 'En ${unit} ya están estas cifras: ${digits}.',
			'why.onlyCandidate' => ({required Object digit}) => 'La fila, columna y bloque descartan los demás números. Aquí solo cabe ${digit}.',
			'why.unitSearch' => ({required Object digit, required Object unit}) => 'Buscamos un lugar para el ${digit} en ${unit}.',
			'why.solePosition' => ({required Object digit, required Object unit}) => 'Los ${digit} tachados muestran dónde no puede ir en ${unit}. Solo queda esta casilla.',
			'why.placement' => ({required Object digit}) => 'Por eso aquí va el ${digit}.',
			'why.unitRow' => ({required Object index}) => 'la fila ${index}',
			'why.unitColumn' => ({required Object index}) => 'la columna ${index}',
			'why.unitBox' => ({required Object index}) => 'el bloque ${index}',
			'recommendation.focusTitle' => ({required Object technique}) => 'Enfoque de hoy: ${technique}',
			'recommendation.learnAction' => ({required Object technique}) => 'Aprender: ${technique}',
			'recommendation.practiceAction' => ({required Object technique}) => 'Practicar: ${technique}',
			'recommendation.reviewAction' => ({required Object technique}) => 'Repasar: ${technique}',
			'recommendation.duration' => ({required Object minutes}) => '${minutes} min',
			'recommendation.startWithBasics' => 'Empieza por el primer paso lógico.',
			'recommendation.repeatedCoachHelp' => 'Hace poco necesitaste ayuda de MICHI.',
			'recommendation.weakIndependentPractice' => 'Conviene reforzar la práctica independiente.',
			'recommendation.continuePractice' => 'Sigue practicando esta técnica.',
			'recommendation.nextTechnique' => 'El siguiente paso en tu camino.',
			'recommendation.masteredNeedsReview' => 'Conviene repasar una técnica conocida.',
			'recommendation.allMasteredReview' => 'Repasa una técnica que ya dominas.',
			'week.title' => 'Esta semana',
			'week.empty' => 'Aún no has completado sudokus esta semana. Tu actividad aparecerá cuando juegues.',
			'week.puzzles' => 'Sudokus',
			'week.minutes' => 'Minutos',
			'week.daily' => 'Diarios',
			'week.activeDays' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} día activo', other: '${n} días activos', ),
			'week.completedDay' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(n, one: '${n} sudoku completado', other: '${n} sudokus completados', ),
			'week.today' => 'Hoy',
			'week.noActivity' => 'Sin actividad',
			'week.summary' => 'Tu actividad local de sudoku',
			'settings.general' => 'General',
			'settings.title' => 'Ajustes',
			'settings.language' => 'Idioma',
			'settings.languageDetail' => 'Elige el idioma de MICHI.',
			'settings.reminders' => 'Recordatorios',
			'settings.dailyReminder' => 'Cada día a las 08:00',
			'settings.reminderSignIn' => 'Inicia sesión para activar los recordatorios.',
			'settings.reminderPermission' => 'Permite las notificaciones en los ajustes del dispositivo.',
			'settings.reminderUnavailable' => 'Las notificaciones no están disponibles en este dispositivo.',
			'sync.account' => 'Cuenta',
			'sync.email' => 'Correo electrónico',
			'sync.synchronization' => 'Sincronización',
			'sync.syncing' => 'Sincronizando…',
			'sync.synced' => 'Sincronizado recientemente',
			'sync.lastSynced' => ({required Object time}) => 'Última sincronización — ${time}',
			'sync.pending' => 'Guardado en el dispositivo · pendiente de sincronización',
			'sync.offline' => 'Sin conexión. Tu progreso se guardará y se sincronizará después.',
			'sync.error' => 'Error de sincronización',
			'sync.retry' => 'Reintentar',
			'sync.guest' => 'El progreso solo se guarda en este dispositivo.',
			'sync.deleteAccount' => 'Eliminar cuenta',
			'sync.deleteTitle' => '¿Eliminar tu cuenta?',
			'sync.deleteBody' => 'Tu cuenta y el progreso sincronizado se eliminarán definitivamente.',
			'sync.deleteConfirm' => 'Eliminar cuenta',
			'sync.deleteFailed' => 'No se pudo eliminar tu cuenta. Vuelve a iniciar sesión e inténtalo.',
			'sync.signOut' => 'Cerrar sesión',
			_ => null,
		};
	}
}
