// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_database.dart';

// ignore_for_file: type=lint
class $ActiveGamesTable extends ActiveGames
    with TableInfo<$ActiveGamesTable, ActiveGame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puzzleIdMeta = const VerificationMeta(
    'puzzleId',
  );
  @override
  late final GeneratedColumn<String> puzzleId = GeneratedColumn<String>(
    'puzzle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyChallengeKeyMeta = const VerificationMeta(
    'dailyChallengeKey',
  );
  @override
  late final GeneratedColumn<String> dailyChallengeKey =
      GeneratedColumn<String>(
        'daily_challenge_key',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _initialBoardMeta = const VerificationMeta(
    'initialBoard',
  );
  @override
  late final GeneratedColumn<String> initialBoard = GeneratedColumn<String>(
    'initial_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentBoardMeta = const VerificationMeta(
    'currentBoard',
  );
  @override
  late final GeneratedColumn<String> currentBoard = GeneratedColumn<String>(
    'current_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesJsonMeta = const VerificationMeta(
    'notesJson',
  );
  @override
  late final GeneratedColumn<String> notesJson = GeneratedColumn<String>(
    'notes_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _undoJsonMeta = const VerificationMeta(
    'undoJson',
  );
  @override
  late final GeneratedColumn<String> undoJson = GeneratedColumn<String>(
    'undo_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mistakesMeta = const VerificationMeta(
    'mistakes',
  );
  @override
  late final GeneratedColumn<int> mistakes = GeneratedColumn<int>(
    'mistakes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elapsedMsMeta = const VerificationMeta(
    'elapsedMs',
  );
  @override
  late final GeneratedColumn<int> elapsedMs = GeneratedColumn<int>(
    'elapsed_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _runningSinceMsMeta = const VerificationMeta(
    'runningSinceMs',
  );
  @override
  late final GeneratedColumn<int> runningSinceMs = GeneratedColumn<int>(
    'running_since_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMsMeta = const VerificationMeta(
    'startedAtMs',
  );
  @override
  late final GeneratedColumn<int> startedAtMs = GeneratedColumn<int>(
    'started_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPausedMeta = const VerificationMeta(
    'isPaused',
  );
  @override
  late final GeneratedColumn<bool> isPaused = GeneratedColumn<bool>(
    'is_paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paused" IN (0, 1))',
    ),
  );
  static const VerificationMeta _hintsRequestedMeta = const VerificationMeta(
    'hintsRequested',
  );
  @override
  late final GeneratedColumn<int> hintsRequested = GeneratedColumn<int>(
    'hints_requested',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _highestHintLevelUsedMeta =
      const VerificationMeta('highestHintLevelUsed');
  @override
  late final GeneratedColumn<int> highestHintLevelUsed = GeneratedColumn<int>(
    'highest_hint_level_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _techniqueHelpJsonMeta = const VerificationMeta(
    'techniqueHelpJson',
  );
  @override
  late final GeneratedColumn<String> techniqueHelpJson =
      GeneratedColumn<String>(
        'technique_help_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _correctEditableCellsMeta =
      const VerificationMeta('correctEditableCells');
  @override
  late final GeneratedColumn<int> correctEditableCells = GeneratedColumn<int>(
    'correct_editable_cells',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _editableCellsMeta = const VerificationMeta(
    'editableCells',
  );
  @override
  late final GeneratedColumn<int> editableCells = GeneratedColumn<int>(
    'editable_cells',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    slot,
    gameId,
    puzzleId,
    dailyChallengeKey,
    initialBoard,
    currentBoard,
    notesJson,
    undoJson,
    mistakes,
    elapsedMs,
    runningSinceMs,
    startedAtMs,
    updatedAtMs,
    isPaused,
    hintsRequested,
    highestHintLevelUsed,
    techniqueHelpJson,
    correctEditableCells,
    editableCells,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_games';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveGame> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
    }
    if (data.containsKey('daily_challenge_key')) {
      context.handle(
        _dailyChallengeKeyMeta,
        dailyChallengeKey.isAcceptableOrUnknown(
          data['daily_challenge_key']!,
          _dailyChallengeKeyMeta,
        ),
      );
    }
    if (data.containsKey('initial_board')) {
      context.handle(
        _initialBoardMeta,
        initialBoard.isAcceptableOrUnknown(
          data['initial_board']!,
          _initialBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialBoardMeta);
    }
    if (data.containsKey('current_board')) {
      context.handle(
        _currentBoardMeta,
        currentBoard.isAcceptableOrUnknown(
          data['current_board']!,
          _currentBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentBoardMeta);
    }
    if (data.containsKey('notes_json')) {
      context.handle(
        _notesJsonMeta,
        notesJson.isAcceptableOrUnknown(data['notes_json']!, _notesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_notesJsonMeta);
    }
    if (data.containsKey('undo_json')) {
      context.handle(
        _undoJsonMeta,
        undoJson.isAcceptableOrUnknown(data['undo_json']!, _undoJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_undoJsonMeta);
    }
    if (data.containsKey('mistakes')) {
      context.handle(
        _mistakesMeta,
        mistakes.isAcceptableOrUnknown(data['mistakes']!, _mistakesMeta),
      );
    } else if (isInserting) {
      context.missing(_mistakesMeta);
    }
    if (data.containsKey('elapsed_ms')) {
      context.handle(
        _elapsedMsMeta,
        elapsedMs.isAcceptableOrUnknown(data['elapsed_ms']!, _elapsedMsMeta),
      );
    } else if (isInserting) {
      context.missing(_elapsedMsMeta);
    }
    if (data.containsKey('running_since_ms')) {
      context.handle(
        _runningSinceMsMeta,
        runningSinceMs.isAcceptableOrUnknown(
          data['running_since_ms']!,
          _runningSinceMsMeta,
        ),
      );
    }
    if (data.containsKey('started_at_ms')) {
      context.handle(
        _startedAtMsMeta,
        startedAtMs.isAcceptableOrUnknown(
          data['started_at_ms']!,
          _startedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startedAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_paused')) {
      context.handle(
        _isPausedMeta,
        isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta),
      );
    } else if (isInserting) {
      context.missing(_isPausedMeta);
    }
    if (data.containsKey('hints_requested')) {
      context.handle(
        _hintsRequestedMeta,
        hintsRequested.isAcceptableOrUnknown(
          data['hints_requested']!,
          _hintsRequestedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hintsRequestedMeta);
    }
    if (data.containsKey('highest_hint_level_used')) {
      context.handle(
        _highestHintLevelUsedMeta,
        highestHintLevelUsed.isAcceptableOrUnknown(
          data['highest_hint_level_used']!,
          _highestHintLevelUsedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_highestHintLevelUsedMeta);
    }
    if (data.containsKey('technique_help_json')) {
      context.handle(
        _techniqueHelpJsonMeta,
        techniqueHelpJson.isAcceptableOrUnknown(
          data['technique_help_json']!,
          _techniqueHelpJsonMeta,
        ),
      );
    }
    if (data.containsKey('correct_editable_cells')) {
      context.handle(
        _correctEditableCellsMeta,
        correctEditableCells.isAcceptableOrUnknown(
          data['correct_editable_cells']!,
          _correctEditableCellsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctEditableCellsMeta);
    }
    if (data.containsKey('editable_cells')) {
      context.handle(
        _editableCellsMeta,
        editableCells.isAcceptableOrUnknown(
          data['editable_cells']!,
          _editableCellsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_editableCellsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slot};
  @override
  ActiveGame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveGame(
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      dailyChallengeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_challenge_key'],
      ),
      initialBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}initial_board'],
      )!,
      currentBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_board'],
      )!,
      notesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes_json'],
      )!,
      undoJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}undo_json'],
      )!,
      mistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistakes'],
      )!,
      elapsedMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_ms'],
      )!,
      runningSinceMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}running_since_ms'],
      ),
      startedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isPaused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paused'],
      )!,
      hintsRequested: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hints_requested'],
      )!,
      highestHintLevelUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}highest_hint_level_used'],
      )!,
      techniqueHelpJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technique_help_json'],
      )!,
      correctEditableCells: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_editable_cells'],
      )!,
      editableCells: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}editable_cells'],
      )!,
    );
  }

  @override
  $ActiveGamesTable createAlias(String alias) {
    return $ActiveGamesTable(attachedDatabase, alias);
  }
}

class ActiveGame extends DataClass implements Insertable<ActiveGame> {
  final int slot;
  final String gameId;
  final String puzzleId;
  final String? dailyChallengeKey;
  final String initialBoard;
  final String currentBoard;
  final String notesJson;
  final String undoJson;
  final int mistakes;
  final int elapsedMs;
  final int? runningSinceMs;
  final int startedAtMs;
  final int updatedAtMs;
  final bool isPaused;
  final int hintsRequested;
  final int highestHintLevelUsed;
  final String techniqueHelpJson;
  final int correctEditableCells;
  final int editableCells;
  const ActiveGame({
    required this.slot,
    required this.gameId,
    required this.puzzleId,
    this.dailyChallengeKey,
    required this.initialBoard,
    required this.currentBoard,
    required this.notesJson,
    required this.undoJson,
    required this.mistakes,
    required this.elapsedMs,
    this.runningSinceMs,
    required this.startedAtMs,
    required this.updatedAtMs,
    required this.isPaused,
    required this.hintsRequested,
    required this.highestHintLevelUsed,
    required this.techniqueHelpJson,
    required this.correctEditableCells,
    required this.editableCells,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slot'] = Variable<int>(slot);
    map['game_id'] = Variable<String>(gameId);
    map['puzzle_id'] = Variable<String>(puzzleId);
    if (!nullToAbsent || dailyChallengeKey != null) {
      map['daily_challenge_key'] = Variable<String>(dailyChallengeKey);
    }
    map['initial_board'] = Variable<String>(initialBoard);
    map['current_board'] = Variable<String>(currentBoard);
    map['notes_json'] = Variable<String>(notesJson);
    map['undo_json'] = Variable<String>(undoJson);
    map['mistakes'] = Variable<int>(mistakes);
    map['elapsed_ms'] = Variable<int>(elapsedMs);
    if (!nullToAbsent || runningSinceMs != null) {
      map['running_since_ms'] = Variable<int>(runningSinceMs);
    }
    map['started_at_ms'] = Variable<int>(startedAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_paused'] = Variable<bool>(isPaused);
    map['hints_requested'] = Variable<int>(hintsRequested);
    map['highest_hint_level_used'] = Variable<int>(highestHintLevelUsed);
    map['technique_help_json'] = Variable<String>(techniqueHelpJson);
    map['correct_editable_cells'] = Variable<int>(correctEditableCells);
    map['editable_cells'] = Variable<int>(editableCells);
    return map;
  }

  ActiveGamesCompanion toCompanion(bool nullToAbsent) {
    return ActiveGamesCompanion(
      slot: Value(slot),
      gameId: Value(gameId),
      puzzleId: Value(puzzleId),
      dailyChallengeKey: dailyChallengeKey == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyChallengeKey),
      initialBoard: Value(initialBoard),
      currentBoard: Value(currentBoard),
      notesJson: Value(notesJson),
      undoJson: Value(undoJson),
      mistakes: Value(mistakes),
      elapsedMs: Value(elapsedMs),
      runningSinceMs: runningSinceMs == null && nullToAbsent
          ? const Value.absent()
          : Value(runningSinceMs),
      startedAtMs: Value(startedAtMs),
      updatedAtMs: Value(updatedAtMs),
      isPaused: Value(isPaused),
      hintsRequested: Value(hintsRequested),
      highestHintLevelUsed: Value(highestHintLevelUsed),
      techniqueHelpJson: Value(techniqueHelpJson),
      correctEditableCells: Value(correctEditableCells),
      editableCells: Value(editableCells),
    );
  }

  factory ActiveGame.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveGame(
      slot: serializer.fromJson<int>(json['slot']),
      gameId: serializer.fromJson<String>(json['gameId']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      dailyChallengeKey: serializer.fromJson<String?>(
        json['dailyChallengeKey'],
      ),
      initialBoard: serializer.fromJson<String>(json['initialBoard']),
      currentBoard: serializer.fromJson<String>(json['currentBoard']),
      notesJson: serializer.fromJson<String>(json['notesJson']),
      undoJson: serializer.fromJson<String>(json['undoJson']),
      mistakes: serializer.fromJson<int>(json['mistakes']),
      elapsedMs: serializer.fromJson<int>(json['elapsedMs']),
      runningSinceMs: serializer.fromJson<int?>(json['runningSinceMs']),
      startedAtMs: serializer.fromJson<int>(json['startedAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isPaused: serializer.fromJson<bool>(json['isPaused']),
      hintsRequested: serializer.fromJson<int>(json['hintsRequested']),
      highestHintLevelUsed: serializer.fromJson<int>(
        json['highestHintLevelUsed'],
      ),
      techniqueHelpJson: serializer.fromJson<String>(json['techniqueHelpJson']),
      correctEditableCells: serializer.fromJson<int>(
        json['correctEditableCells'],
      ),
      editableCells: serializer.fromJson<int>(json['editableCells']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slot': serializer.toJson<int>(slot),
      'gameId': serializer.toJson<String>(gameId),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'dailyChallengeKey': serializer.toJson<String?>(dailyChallengeKey),
      'initialBoard': serializer.toJson<String>(initialBoard),
      'currentBoard': serializer.toJson<String>(currentBoard),
      'notesJson': serializer.toJson<String>(notesJson),
      'undoJson': serializer.toJson<String>(undoJson),
      'mistakes': serializer.toJson<int>(mistakes),
      'elapsedMs': serializer.toJson<int>(elapsedMs),
      'runningSinceMs': serializer.toJson<int?>(runningSinceMs),
      'startedAtMs': serializer.toJson<int>(startedAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isPaused': serializer.toJson<bool>(isPaused),
      'hintsRequested': serializer.toJson<int>(hintsRequested),
      'highestHintLevelUsed': serializer.toJson<int>(highestHintLevelUsed),
      'techniqueHelpJson': serializer.toJson<String>(techniqueHelpJson),
      'correctEditableCells': serializer.toJson<int>(correctEditableCells),
      'editableCells': serializer.toJson<int>(editableCells),
    };
  }

  ActiveGame copyWith({
    int? slot,
    String? gameId,
    String? puzzleId,
    Value<String?> dailyChallengeKey = const Value.absent(),
    String? initialBoard,
    String? currentBoard,
    String? notesJson,
    String? undoJson,
    int? mistakes,
    int? elapsedMs,
    Value<int?> runningSinceMs = const Value.absent(),
    int? startedAtMs,
    int? updatedAtMs,
    bool? isPaused,
    int? hintsRequested,
    int? highestHintLevelUsed,
    String? techniqueHelpJson,
    int? correctEditableCells,
    int? editableCells,
  }) => ActiveGame(
    slot: slot ?? this.slot,
    gameId: gameId ?? this.gameId,
    puzzleId: puzzleId ?? this.puzzleId,
    dailyChallengeKey: dailyChallengeKey.present
        ? dailyChallengeKey.value
        : this.dailyChallengeKey,
    initialBoard: initialBoard ?? this.initialBoard,
    currentBoard: currentBoard ?? this.currentBoard,
    notesJson: notesJson ?? this.notesJson,
    undoJson: undoJson ?? this.undoJson,
    mistakes: mistakes ?? this.mistakes,
    elapsedMs: elapsedMs ?? this.elapsedMs,
    runningSinceMs: runningSinceMs.present
        ? runningSinceMs.value
        : this.runningSinceMs,
    startedAtMs: startedAtMs ?? this.startedAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isPaused: isPaused ?? this.isPaused,
    hintsRequested: hintsRequested ?? this.hintsRequested,
    highestHintLevelUsed: highestHintLevelUsed ?? this.highestHintLevelUsed,
    techniqueHelpJson: techniqueHelpJson ?? this.techniqueHelpJson,
    correctEditableCells: correctEditableCells ?? this.correctEditableCells,
    editableCells: editableCells ?? this.editableCells,
  );
  ActiveGame copyWithCompanion(ActiveGamesCompanion data) {
    return ActiveGame(
      slot: data.slot.present ? data.slot.value : this.slot,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      dailyChallengeKey: data.dailyChallengeKey.present
          ? data.dailyChallengeKey.value
          : this.dailyChallengeKey,
      initialBoard: data.initialBoard.present
          ? data.initialBoard.value
          : this.initialBoard,
      currentBoard: data.currentBoard.present
          ? data.currentBoard.value
          : this.currentBoard,
      notesJson: data.notesJson.present ? data.notesJson.value : this.notesJson,
      undoJson: data.undoJson.present ? data.undoJson.value : this.undoJson,
      mistakes: data.mistakes.present ? data.mistakes.value : this.mistakes,
      elapsedMs: data.elapsedMs.present ? data.elapsedMs.value : this.elapsedMs,
      runningSinceMs: data.runningSinceMs.present
          ? data.runningSinceMs.value
          : this.runningSinceMs,
      startedAtMs: data.startedAtMs.present
          ? data.startedAtMs.value
          : this.startedAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      hintsRequested: data.hintsRequested.present
          ? data.hintsRequested.value
          : this.hintsRequested,
      highestHintLevelUsed: data.highestHintLevelUsed.present
          ? data.highestHintLevelUsed.value
          : this.highestHintLevelUsed,
      techniqueHelpJson: data.techniqueHelpJson.present
          ? data.techniqueHelpJson.value
          : this.techniqueHelpJson,
      correctEditableCells: data.correctEditableCells.present
          ? data.correctEditableCells.value
          : this.correctEditableCells,
      editableCells: data.editableCells.present
          ? data.editableCells.value
          : this.editableCells,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveGame(')
          ..write('slot: $slot, ')
          ..write('gameId: $gameId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('dailyChallengeKey: $dailyChallengeKey, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('currentBoard: $currentBoard, ')
          ..write('notesJson: $notesJson, ')
          ..write('undoJson: $undoJson, ')
          ..write('mistakes: $mistakes, ')
          ..write('elapsedMs: $elapsedMs, ')
          ..write('runningSinceMs: $runningSinceMs, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isPaused: $isPaused, ')
          ..write('hintsRequested: $hintsRequested, ')
          ..write('highestHintLevelUsed: $highestHintLevelUsed, ')
          ..write('techniqueHelpJson: $techniqueHelpJson, ')
          ..write('correctEditableCells: $correctEditableCells, ')
          ..write('editableCells: $editableCells')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    slot,
    gameId,
    puzzleId,
    dailyChallengeKey,
    initialBoard,
    currentBoard,
    notesJson,
    undoJson,
    mistakes,
    elapsedMs,
    runningSinceMs,
    startedAtMs,
    updatedAtMs,
    isPaused,
    hintsRequested,
    highestHintLevelUsed,
    techniqueHelpJson,
    correctEditableCells,
    editableCells,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveGame &&
          other.slot == this.slot &&
          other.gameId == this.gameId &&
          other.puzzleId == this.puzzleId &&
          other.dailyChallengeKey == this.dailyChallengeKey &&
          other.initialBoard == this.initialBoard &&
          other.currentBoard == this.currentBoard &&
          other.notesJson == this.notesJson &&
          other.undoJson == this.undoJson &&
          other.mistakes == this.mistakes &&
          other.elapsedMs == this.elapsedMs &&
          other.runningSinceMs == this.runningSinceMs &&
          other.startedAtMs == this.startedAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isPaused == this.isPaused &&
          other.hintsRequested == this.hintsRequested &&
          other.highestHintLevelUsed == this.highestHintLevelUsed &&
          other.techniqueHelpJson == this.techniqueHelpJson &&
          other.correctEditableCells == this.correctEditableCells &&
          other.editableCells == this.editableCells);
}

class ActiveGamesCompanion extends UpdateCompanion<ActiveGame> {
  final Value<int> slot;
  final Value<String> gameId;
  final Value<String> puzzleId;
  final Value<String?> dailyChallengeKey;
  final Value<String> initialBoard;
  final Value<String> currentBoard;
  final Value<String> notesJson;
  final Value<String> undoJson;
  final Value<int> mistakes;
  final Value<int> elapsedMs;
  final Value<int?> runningSinceMs;
  final Value<int> startedAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isPaused;
  final Value<int> hintsRequested;
  final Value<int> highestHintLevelUsed;
  final Value<String> techniqueHelpJson;
  final Value<int> correctEditableCells;
  final Value<int> editableCells;
  const ActiveGamesCompanion({
    this.slot = const Value.absent(),
    this.gameId = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.dailyChallengeKey = const Value.absent(),
    this.initialBoard = const Value.absent(),
    this.currentBoard = const Value.absent(),
    this.notesJson = const Value.absent(),
    this.undoJson = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.elapsedMs = const Value.absent(),
    this.runningSinceMs = const Value.absent(),
    this.startedAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.hintsRequested = const Value.absent(),
    this.highestHintLevelUsed = const Value.absent(),
    this.techniqueHelpJson = const Value.absent(),
    this.correctEditableCells = const Value.absent(),
    this.editableCells = const Value.absent(),
  });
  ActiveGamesCompanion.insert({
    this.slot = const Value.absent(),
    required String gameId,
    required String puzzleId,
    this.dailyChallengeKey = const Value.absent(),
    required String initialBoard,
    required String currentBoard,
    required String notesJson,
    required String undoJson,
    required int mistakes,
    required int elapsedMs,
    this.runningSinceMs = const Value.absent(),
    required int startedAtMs,
    required int updatedAtMs,
    required bool isPaused,
    required int hintsRequested,
    required int highestHintLevelUsed,
    this.techniqueHelpJson = const Value.absent(),
    required int correctEditableCells,
    required int editableCells,
  }) : gameId = Value(gameId),
       puzzleId = Value(puzzleId),
       initialBoard = Value(initialBoard),
       currentBoard = Value(currentBoard),
       notesJson = Value(notesJson),
       undoJson = Value(undoJson),
       mistakes = Value(mistakes),
       elapsedMs = Value(elapsedMs),
       startedAtMs = Value(startedAtMs),
       updatedAtMs = Value(updatedAtMs),
       isPaused = Value(isPaused),
       hintsRequested = Value(hintsRequested),
       highestHintLevelUsed = Value(highestHintLevelUsed),
       correctEditableCells = Value(correctEditableCells),
       editableCells = Value(editableCells);
  static Insertable<ActiveGame> custom({
    Expression<int>? slot,
    Expression<String>? gameId,
    Expression<String>? puzzleId,
    Expression<String>? dailyChallengeKey,
    Expression<String>? initialBoard,
    Expression<String>? currentBoard,
    Expression<String>? notesJson,
    Expression<String>? undoJson,
    Expression<int>? mistakes,
    Expression<int>? elapsedMs,
    Expression<int>? runningSinceMs,
    Expression<int>? startedAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isPaused,
    Expression<int>? hintsRequested,
    Expression<int>? highestHintLevelUsed,
    Expression<String>? techniqueHelpJson,
    Expression<int>? correctEditableCells,
    Expression<int>? editableCells,
  }) {
    return RawValuesInsertable({
      if (slot != null) 'slot': slot,
      if (gameId != null) 'game_id': gameId,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (dailyChallengeKey != null) 'daily_challenge_key': dailyChallengeKey,
      if (initialBoard != null) 'initial_board': initialBoard,
      if (currentBoard != null) 'current_board': currentBoard,
      if (notesJson != null) 'notes_json': notesJson,
      if (undoJson != null) 'undo_json': undoJson,
      if (mistakes != null) 'mistakes': mistakes,
      if (elapsedMs != null) 'elapsed_ms': elapsedMs,
      if (runningSinceMs != null) 'running_since_ms': runningSinceMs,
      if (startedAtMs != null) 'started_at_ms': startedAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isPaused != null) 'is_paused': isPaused,
      if (hintsRequested != null) 'hints_requested': hintsRequested,
      if (highestHintLevelUsed != null)
        'highest_hint_level_used': highestHintLevelUsed,
      if (techniqueHelpJson != null) 'technique_help_json': techniqueHelpJson,
      if (correctEditableCells != null)
        'correct_editable_cells': correctEditableCells,
      if (editableCells != null) 'editable_cells': editableCells,
    });
  }

  ActiveGamesCompanion copyWith({
    Value<int>? slot,
    Value<String>? gameId,
    Value<String>? puzzleId,
    Value<String?>? dailyChallengeKey,
    Value<String>? initialBoard,
    Value<String>? currentBoard,
    Value<String>? notesJson,
    Value<String>? undoJson,
    Value<int>? mistakes,
    Value<int>? elapsedMs,
    Value<int?>? runningSinceMs,
    Value<int>? startedAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isPaused,
    Value<int>? hintsRequested,
    Value<int>? highestHintLevelUsed,
    Value<String>? techniqueHelpJson,
    Value<int>? correctEditableCells,
    Value<int>? editableCells,
  }) {
    return ActiveGamesCompanion(
      slot: slot ?? this.slot,
      gameId: gameId ?? this.gameId,
      puzzleId: puzzleId ?? this.puzzleId,
      dailyChallengeKey: dailyChallengeKey ?? this.dailyChallengeKey,
      initialBoard: initialBoard ?? this.initialBoard,
      currentBoard: currentBoard ?? this.currentBoard,
      notesJson: notesJson ?? this.notesJson,
      undoJson: undoJson ?? this.undoJson,
      mistakes: mistakes ?? this.mistakes,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      runningSinceMs: runningSinceMs ?? this.runningSinceMs,
      startedAtMs: startedAtMs ?? this.startedAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isPaused: isPaused ?? this.isPaused,
      hintsRequested: hintsRequested ?? this.hintsRequested,
      highestHintLevelUsed: highestHintLevelUsed ?? this.highestHintLevelUsed,
      techniqueHelpJson: techniqueHelpJson ?? this.techniqueHelpJson,
      correctEditableCells: correctEditableCells ?? this.correctEditableCells,
      editableCells: editableCells ?? this.editableCells,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (dailyChallengeKey.present) {
      map['daily_challenge_key'] = Variable<String>(dailyChallengeKey.value);
    }
    if (initialBoard.present) {
      map['initial_board'] = Variable<String>(initialBoard.value);
    }
    if (currentBoard.present) {
      map['current_board'] = Variable<String>(currentBoard.value);
    }
    if (notesJson.present) {
      map['notes_json'] = Variable<String>(notesJson.value);
    }
    if (undoJson.present) {
      map['undo_json'] = Variable<String>(undoJson.value);
    }
    if (mistakes.present) {
      map['mistakes'] = Variable<int>(mistakes.value);
    }
    if (elapsedMs.present) {
      map['elapsed_ms'] = Variable<int>(elapsedMs.value);
    }
    if (runningSinceMs.present) {
      map['running_since_ms'] = Variable<int>(runningSinceMs.value);
    }
    if (startedAtMs.present) {
      map['started_at_ms'] = Variable<int>(startedAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<bool>(isPaused.value);
    }
    if (hintsRequested.present) {
      map['hints_requested'] = Variable<int>(hintsRequested.value);
    }
    if (highestHintLevelUsed.present) {
      map['highest_hint_level_used'] = Variable<int>(
        highestHintLevelUsed.value,
      );
    }
    if (techniqueHelpJson.present) {
      map['technique_help_json'] = Variable<String>(techniqueHelpJson.value);
    }
    if (correctEditableCells.present) {
      map['correct_editable_cells'] = Variable<int>(correctEditableCells.value);
    }
    if (editableCells.present) {
      map['editable_cells'] = Variable<int>(editableCells.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveGamesCompanion(')
          ..write('slot: $slot, ')
          ..write('gameId: $gameId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('dailyChallengeKey: $dailyChallengeKey, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('currentBoard: $currentBoard, ')
          ..write('notesJson: $notesJson, ')
          ..write('undoJson: $undoJson, ')
          ..write('mistakes: $mistakes, ')
          ..write('elapsedMs: $elapsedMs, ')
          ..write('runningSinceMs: $runningSinceMs, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isPaused: $isPaused, ')
          ..write('hintsRequested: $hintsRequested, ')
          ..write('highestHintLevelUsed: $highestHintLevelUsed, ')
          ..write('techniqueHelpJson: $techniqueHelpJson, ')
          ..write('correctEditableCells: $correctEditableCells, ')
          ..write('editableCells: $editableCells')
          ..write(')'))
        .toString();
  }
}

class $CompletedGamesTable extends CompletedGames
    with TableInfo<$CompletedGamesTable, CompletedGameRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletedGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puzzleIdMeta = const VerificationMeta(
    'puzzleId',
  );
  @override
  late final GeneratedColumn<String> puzzleId = GeneratedColumn<String>(
    'puzzle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyChallengeKeyMeta = const VerificationMeta(
    'dailyChallengeKey',
  );
  @override
  late final GeneratedColumn<String> dailyChallengeKey =
      GeneratedColumn<String>(
        'daily_challenge_key',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _initialBoardMeta = const VerificationMeta(
    'initialBoard',
  );
  @override
  late final GeneratedColumn<String> initialBoard = GeneratedColumn<String>(
    'initial_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedBoardMeta = const VerificationMeta(
    'completedBoard',
  );
  @override
  late final GeneratedColumn<String> completedBoard = GeneratedColumn<String>(
    'completed_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMsMeta = const VerificationMeta(
    'startedAtMs',
  );
  @override
  late final GeneratedColumn<int> startedAtMs = GeneratedColumn<int>(
    'started_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMsMeta = const VerificationMeta(
    'completedAtMs',
  );
  @override
  late final GeneratedColumn<int> completedAtMs = GeneratedColumn<int>(
    'completed_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elapsedMsMeta = const VerificationMeta(
    'elapsedMs',
  );
  @override
  late final GeneratedColumn<int> elapsedMs = GeneratedColumn<int>(
    'elapsed_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mistakesMeta = const VerificationMeta(
    'mistakes',
  );
  @override
  late final GeneratedColumn<int> mistakes = GeneratedColumn<int>(
    'mistakes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintsRequestedMeta = const VerificationMeta(
    'hintsRequested',
  );
  @override
  late final GeneratedColumn<int> hintsRequested = GeneratedColumn<int>(
    'hints_requested',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _highestHintLevelUsedMeta =
      const VerificationMeta('highestHintLevelUsed');
  @override
  late final GeneratedColumn<int> highestHintLevelUsed = GeneratedColumn<int>(
    'highest_hint_level_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _techniqueHelpJsonMeta = const VerificationMeta(
    'techniqueHelpJson',
  );
  @override
  late final GeneratedColumn<String> techniqueHelpJson =
      GeneratedColumn<String>(
        'technique_help_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    gameId,
    puzzleId,
    dailyChallengeKey,
    initialBoard,
    completedBoard,
    startedAtMs,
    completedAtMs,
    elapsedMs,
    mistakes,
    hintsRequested,
    highestHintLevelUsed,
    techniqueHelpJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completed_games';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletedGameRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
    }
    if (data.containsKey('daily_challenge_key')) {
      context.handle(
        _dailyChallengeKeyMeta,
        dailyChallengeKey.isAcceptableOrUnknown(
          data['daily_challenge_key']!,
          _dailyChallengeKeyMeta,
        ),
      );
    }
    if (data.containsKey('initial_board')) {
      context.handle(
        _initialBoardMeta,
        initialBoard.isAcceptableOrUnknown(
          data['initial_board']!,
          _initialBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialBoardMeta);
    }
    if (data.containsKey('completed_board')) {
      context.handle(
        _completedBoardMeta,
        completedBoard.isAcceptableOrUnknown(
          data['completed_board']!,
          _completedBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedBoardMeta);
    }
    if (data.containsKey('started_at_ms')) {
      context.handle(
        _startedAtMsMeta,
        startedAtMs.isAcceptableOrUnknown(
          data['started_at_ms']!,
          _startedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startedAtMsMeta);
    }
    if (data.containsKey('completed_at_ms')) {
      context.handle(
        _completedAtMsMeta,
        completedAtMs.isAcceptableOrUnknown(
          data['completed_at_ms']!,
          _completedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMsMeta);
    }
    if (data.containsKey('elapsed_ms')) {
      context.handle(
        _elapsedMsMeta,
        elapsedMs.isAcceptableOrUnknown(data['elapsed_ms']!, _elapsedMsMeta),
      );
    } else if (isInserting) {
      context.missing(_elapsedMsMeta);
    }
    if (data.containsKey('mistakes')) {
      context.handle(
        _mistakesMeta,
        mistakes.isAcceptableOrUnknown(data['mistakes']!, _mistakesMeta),
      );
    } else if (isInserting) {
      context.missing(_mistakesMeta);
    }
    if (data.containsKey('hints_requested')) {
      context.handle(
        _hintsRequestedMeta,
        hintsRequested.isAcceptableOrUnknown(
          data['hints_requested']!,
          _hintsRequestedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hintsRequestedMeta);
    }
    if (data.containsKey('highest_hint_level_used')) {
      context.handle(
        _highestHintLevelUsedMeta,
        highestHintLevelUsed.isAcceptableOrUnknown(
          data['highest_hint_level_used']!,
          _highestHintLevelUsedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_highestHintLevelUsedMeta);
    }
    if (data.containsKey('technique_help_json')) {
      context.handle(
        _techniqueHelpJsonMeta,
        techniqueHelpJson.isAcceptableOrUnknown(
          data['technique_help_json']!,
          _techniqueHelpJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gameId};
  @override
  CompletedGameRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedGameRow(
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      dailyChallengeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_challenge_key'],
      ),
      initialBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}initial_board'],
      )!,
      completedBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_board'],
      )!,
      startedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at_ms'],
      )!,
      completedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_at_ms'],
      )!,
      elapsedMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_ms'],
      )!,
      mistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistakes'],
      )!,
      hintsRequested: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hints_requested'],
      )!,
      highestHintLevelUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}highest_hint_level_used'],
      )!,
      techniqueHelpJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technique_help_json'],
      )!,
    );
  }

  @override
  $CompletedGamesTable createAlias(String alias) {
    return $CompletedGamesTable(attachedDatabase, alias);
  }
}

class CompletedGameRow extends DataClass
    implements Insertable<CompletedGameRow> {
  final String gameId;
  final String puzzleId;
  final String? dailyChallengeKey;
  final String initialBoard;
  final String completedBoard;
  final int startedAtMs;
  final int completedAtMs;
  final int elapsedMs;
  final int mistakes;
  final int hintsRequested;
  final int highestHintLevelUsed;
  final String techniqueHelpJson;
  const CompletedGameRow({
    required this.gameId,
    required this.puzzleId,
    this.dailyChallengeKey,
    required this.initialBoard,
    required this.completedBoard,
    required this.startedAtMs,
    required this.completedAtMs,
    required this.elapsedMs,
    required this.mistakes,
    required this.hintsRequested,
    required this.highestHintLevelUsed,
    required this.techniqueHelpJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['game_id'] = Variable<String>(gameId);
    map['puzzle_id'] = Variable<String>(puzzleId);
    if (!nullToAbsent || dailyChallengeKey != null) {
      map['daily_challenge_key'] = Variable<String>(dailyChallengeKey);
    }
    map['initial_board'] = Variable<String>(initialBoard);
    map['completed_board'] = Variable<String>(completedBoard);
    map['started_at_ms'] = Variable<int>(startedAtMs);
    map['completed_at_ms'] = Variable<int>(completedAtMs);
    map['elapsed_ms'] = Variable<int>(elapsedMs);
    map['mistakes'] = Variable<int>(mistakes);
    map['hints_requested'] = Variable<int>(hintsRequested);
    map['highest_hint_level_used'] = Variable<int>(highestHintLevelUsed);
    map['technique_help_json'] = Variable<String>(techniqueHelpJson);
    return map;
  }

  CompletedGamesCompanion toCompanion(bool nullToAbsent) {
    return CompletedGamesCompanion(
      gameId: Value(gameId),
      puzzleId: Value(puzzleId),
      dailyChallengeKey: dailyChallengeKey == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyChallengeKey),
      initialBoard: Value(initialBoard),
      completedBoard: Value(completedBoard),
      startedAtMs: Value(startedAtMs),
      completedAtMs: Value(completedAtMs),
      elapsedMs: Value(elapsedMs),
      mistakes: Value(mistakes),
      hintsRequested: Value(hintsRequested),
      highestHintLevelUsed: Value(highestHintLevelUsed),
      techniqueHelpJson: Value(techniqueHelpJson),
    );
  }

  factory CompletedGameRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletedGameRow(
      gameId: serializer.fromJson<String>(json['gameId']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      dailyChallengeKey: serializer.fromJson<String?>(
        json['dailyChallengeKey'],
      ),
      initialBoard: serializer.fromJson<String>(json['initialBoard']),
      completedBoard: serializer.fromJson<String>(json['completedBoard']),
      startedAtMs: serializer.fromJson<int>(json['startedAtMs']),
      completedAtMs: serializer.fromJson<int>(json['completedAtMs']),
      elapsedMs: serializer.fromJson<int>(json['elapsedMs']),
      mistakes: serializer.fromJson<int>(json['mistakes']),
      hintsRequested: serializer.fromJson<int>(json['hintsRequested']),
      highestHintLevelUsed: serializer.fromJson<int>(
        json['highestHintLevelUsed'],
      ),
      techniqueHelpJson: serializer.fromJson<String>(json['techniqueHelpJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gameId': serializer.toJson<String>(gameId),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'dailyChallengeKey': serializer.toJson<String?>(dailyChallengeKey),
      'initialBoard': serializer.toJson<String>(initialBoard),
      'completedBoard': serializer.toJson<String>(completedBoard),
      'startedAtMs': serializer.toJson<int>(startedAtMs),
      'completedAtMs': serializer.toJson<int>(completedAtMs),
      'elapsedMs': serializer.toJson<int>(elapsedMs),
      'mistakes': serializer.toJson<int>(mistakes),
      'hintsRequested': serializer.toJson<int>(hintsRequested),
      'highestHintLevelUsed': serializer.toJson<int>(highestHintLevelUsed),
      'techniqueHelpJson': serializer.toJson<String>(techniqueHelpJson),
    };
  }

  CompletedGameRow copyWith({
    String? gameId,
    String? puzzleId,
    Value<String?> dailyChallengeKey = const Value.absent(),
    String? initialBoard,
    String? completedBoard,
    int? startedAtMs,
    int? completedAtMs,
    int? elapsedMs,
    int? mistakes,
    int? hintsRequested,
    int? highestHintLevelUsed,
    String? techniqueHelpJson,
  }) => CompletedGameRow(
    gameId: gameId ?? this.gameId,
    puzzleId: puzzleId ?? this.puzzleId,
    dailyChallengeKey: dailyChallengeKey.present
        ? dailyChallengeKey.value
        : this.dailyChallengeKey,
    initialBoard: initialBoard ?? this.initialBoard,
    completedBoard: completedBoard ?? this.completedBoard,
    startedAtMs: startedAtMs ?? this.startedAtMs,
    completedAtMs: completedAtMs ?? this.completedAtMs,
    elapsedMs: elapsedMs ?? this.elapsedMs,
    mistakes: mistakes ?? this.mistakes,
    hintsRequested: hintsRequested ?? this.hintsRequested,
    highestHintLevelUsed: highestHintLevelUsed ?? this.highestHintLevelUsed,
    techniqueHelpJson: techniqueHelpJson ?? this.techniqueHelpJson,
  );
  CompletedGameRow copyWithCompanion(CompletedGamesCompanion data) {
    return CompletedGameRow(
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      dailyChallengeKey: data.dailyChallengeKey.present
          ? data.dailyChallengeKey.value
          : this.dailyChallengeKey,
      initialBoard: data.initialBoard.present
          ? data.initialBoard.value
          : this.initialBoard,
      completedBoard: data.completedBoard.present
          ? data.completedBoard.value
          : this.completedBoard,
      startedAtMs: data.startedAtMs.present
          ? data.startedAtMs.value
          : this.startedAtMs,
      completedAtMs: data.completedAtMs.present
          ? data.completedAtMs.value
          : this.completedAtMs,
      elapsedMs: data.elapsedMs.present ? data.elapsedMs.value : this.elapsedMs,
      mistakes: data.mistakes.present ? data.mistakes.value : this.mistakes,
      hintsRequested: data.hintsRequested.present
          ? data.hintsRequested.value
          : this.hintsRequested,
      highestHintLevelUsed: data.highestHintLevelUsed.present
          ? data.highestHintLevelUsed.value
          : this.highestHintLevelUsed,
      techniqueHelpJson: data.techniqueHelpJson.present
          ? data.techniqueHelpJson.value
          : this.techniqueHelpJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletedGameRow(')
          ..write('gameId: $gameId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('dailyChallengeKey: $dailyChallengeKey, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('completedBoard: $completedBoard, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('completedAtMs: $completedAtMs, ')
          ..write('elapsedMs: $elapsedMs, ')
          ..write('mistakes: $mistakes, ')
          ..write('hintsRequested: $hintsRequested, ')
          ..write('highestHintLevelUsed: $highestHintLevelUsed, ')
          ..write('techniqueHelpJson: $techniqueHelpJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    gameId,
    puzzleId,
    dailyChallengeKey,
    initialBoard,
    completedBoard,
    startedAtMs,
    completedAtMs,
    elapsedMs,
    mistakes,
    hintsRequested,
    highestHintLevelUsed,
    techniqueHelpJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedGameRow &&
          other.gameId == this.gameId &&
          other.puzzleId == this.puzzleId &&
          other.dailyChallengeKey == this.dailyChallengeKey &&
          other.initialBoard == this.initialBoard &&
          other.completedBoard == this.completedBoard &&
          other.startedAtMs == this.startedAtMs &&
          other.completedAtMs == this.completedAtMs &&
          other.elapsedMs == this.elapsedMs &&
          other.mistakes == this.mistakes &&
          other.hintsRequested == this.hintsRequested &&
          other.highestHintLevelUsed == this.highestHintLevelUsed &&
          other.techniqueHelpJson == this.techniqueHelpJson);
}

class CompletedGamesCompanion extends UpdateCompanion<CompletedGameRow> {
  final Value<String> gameId;
  final Value<String> puzzleId;
  final Value<String?> dailyChallengeKey;
  final Value<String> initialBoard;
  final Value<String> completedBoard;
  final Value<int> startedAtMs;
  final Value<int> completedAtMs;
  final Value<int> elapsedMs;
  final Value<int> mistakes;
  final Value<int> hintsRequested;
  final Value<int> highestHintLevelUsed;
  final Value<String> techniqueHelpJson;
  final Value<int> rowid;
  const CompletedGamesCompanion({
    this.gameId = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.dailyChallengeKey = const Value.absent(),
    this.initialBoard = const Value.absent(),
    this.completedBoard = const Value.absent(),
    this.startedAtMs = const Value.absent(),
    this.completedAtMs = const Value.absent(),
    this.elapsedMs = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.hintsRequested = const Value.absent(),
    this.highestHintLevelUsed = const Value.absent(),
    this.techniqueHelpJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompletedGamesCompanion.insert({
    required String gameId,
    required String puzzleId,
    this.dailyChallengeKey = const Value.absent(),
    required String initialBoard,
    required String completedBoard,
    required int startedAtMs,
    required int completedAtMs,
    required int elapsedMs,
    required int mistakes,
    required int hintsRequested,
    required int highestHintLevelUsed,
    this.techniqueHelpJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : gameId = Value(gameId),
       puzzleId = Value(puzzleId),
       initialBoard = Value(initialBoard),
       completedBoard = Value(completedBoard),
       startedAtMs = Value(startedAtMs),
       completedAtMs = Value(completedAtMs),
       elapsedMs = Value(elapsedMs),
       mistakes = Value(mistakes),
       hintsRequested = Value(hintsRequested),
       highestHintLevelUsed = Value(highestHintLevelUsed);
  static Insertable<CompletedGameRow> custom({
    Expression<String>? gameId,
    Expression<String>? puzzleId,
    Expression<String>? dailyChallengeKey,
    Expression<String>? initialBoard,
    Expression<String>? completedBoard,
    Expression<int>? startedAtMs,
    Expression<int>? completedAtMs,
    Expression<int>? elapsedMs,
    Expression<int>? mistakes,
    Expression<int>? hintsRequested,
    Expression<int>? highestHintLevelUsed,
    Expression<String>? techniqueHelpJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (gameId != null) 'game_id': gameId,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (dailyChallengeKey != null) 'daily_challenge_key': dailyChallengeKey,
      if (initialBoard != null) 'initial_board': initialBoard,
      if (completedBoard != null) 'completed_board': completedBoard,
      if (startedAtMs != null) 'started_at_ms': startedAtMs,
      if (completedAtMs != null) 'completed_at_ms': completedAtMs,
      if (elapsedMs != null) 'elapsed_ms': elapsedMs,
      if (mistakes != null) 'mistakes': mistakes,
      if (hintsRequested != null) 'hints_requested': hintsRequested,
      if (highestHintLevelUsed != null)
        'highest_hint_level_used': highestHintLevelUsed,
      if (techniqueHelpJson != null) 'technique_help_json': techniqueHelpJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompletedGamesCompanion copyWith({
    Value<String>? gameId,
    Value<String>? puzzleId,
    Value<String?>? dailyChallengeKey,
    Value<String>? initialBoard,
    Value<String>? completedBoard,
    Value<int>? startedAtMs,
    Value<int>? completedAtMs,
    Value<int>? elapsedMs,
    Value<int>? mistakes,
    Value<int>? hintsRequested,
    Value<int>? highestHintLevelUsed,
    Value<String>? techniqueHelpJson,
    Value<int>? rowid,
  }) {
    return CompletedGamesCompanion(
      gameId: gameId ?? this.gameId,
      puzzleId: puzzleId ?? this.puzzleId,
      dailyChallengeKey: dailyChallengeKey ?? this.dailyChallengeKey,
      initialBoard: initialBoard ?? this.initialBoard,
      completedBoard: completedBoard ?? this.completedBoard,
      startedAtMs: startedAtMs ?? this.startedAtMs,
      completedAtMs: completedAtMs ?? this.completedAtMs,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      mistakes: mistakes ?? this.mistakes,
      hintsRequested: hintsRequested ?? this.hintsRequested,
      highestHintLevelUsed: highestHintLevelUsed ?? this.highestHintLevelUsed,
      techniqueHelpJson: techniqueHelpJson ?? this.techniqueHelpJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (dailyChallengeKey.present) {
      map['daily_challenge_key'] = Variable<String>(dailyChallengeKey.value);
    }
    if (initialBoard.present) {
      map['initial_board'] = Variable<String>(initialBoard.value);
    }
    if (completedBoard.present) {
      map['completed_board'] = Variable<String>(completedBoard.value);
    }
    if (startedAtMs.present) {
      map['started_at_ms'] = Variable<int>(startedAtMs.value);
    }
    if (completedAtMs.present) {
      map['completed_at_ms'] = Variable<int>(completedAtMs.value);
    }
    if (elapsedMs.present) {
      map['elapsed_ms'] = Variable<int>(elapsedMs.value);
    }
    if (mistakes.present) {
      map['mistakes'] = Variable<int>(mistakes.value);
    }
    if (hintsRequested.present) {
      map['hints_requested'] = Variable<int>(hintsRequested.value);
    }
    if (highestHintLevelUsed.present) {
      map['highest_hint_level_used'] = Variable<int>(
        highestHintLevelUsed.value,
      );
    }
    if (techniqueHelpJson.present) {
      map['technique_help_json'] = Variable<String>(techniqueHelpJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletedGamesCompanion(')
          ..write('gameId: $gameId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('dailyChallengeKey: $dailyChallengeKey, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('completedBoard: $completedBoard, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('completedAtMs: $completedAtMs, ')
          ..write('elapsedMs: $elapsedMs, ')
          ..write('mistakes: $mistakes, ')
          ..write('hintsRequested: $hintsRequested, ')
          ..write('highestHintLevelUsed: $highestHintLevelUsed, ')
          ..write('techniqueHelpJson: $techniqueHelpJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TechniqueProgressEntriesTable extends TechniqueProgressEntries
    with TableInfo<$TechniqueProgressEntriesTable, TechniqueProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TechniqueProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _techniqueIdMeta = const VerificationMeta(
    'techniqueId',
  );
  @override
  late final GeneratedColumn<String> techniqueId = GeneratedColumn<String>(
    'technique_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAttemptsMeta = const VerificationMeta(
    'correctAttempts',
  );
  @override
  late final GeneratedColumn<int> correctAttempts = GeneratedColumn<int>(
    'correct_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstTryCorrectMeta = const VerificationMeta(
    'firstTryCorrect',
  );
  @override
  late final GeneratedColumn<int> firstTryCorrect = GeneratedColumn<int>(
    'first_try_correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _independentStreakMeta = const VerificationMeta(
    'independentStreak',
  );
  @override
  late final GeneratedColumn<int> independentStreak = GeneratedColumn<int>(
    'independent_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionHintSuccessesMeta =
      const VerificationMeta('directionHintSuccesses');
  @override
  late final GeneratedColumn<int> directionHintSuccesses = GeneratedColumn<int>(
    'direction_hint_successes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusHintSuccessesMeta =
      const VerificationMeta('focusHintSuccesses');
  @override
  late final GeneratedColumn<int> focusHintSuccesses = GeneratedColumn<int>(
    'focus_hint_successes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasoningHintSuccessesMeta =
      const VerificationMeta('reasoningHintSuccesses');
  @override
  late final GeneratedColumn<int> reasoningHintSuccesses = GeneratedColumn<int>(
    'reasoning_hint_successes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultHintSuccessesMeta =
      const VerificationMeta('resultHintSuccesses');
  @override
  late final GeneratedColumn<int> resultHintSuccesses = GeneratedColumn<int>(
    'result_hint_successes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastPracticedAtMsMeta = const VerificationMeta(
    'lastPracticedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastPracticedAtMs = GeneratedColumn<int>(
    'last_practiced_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    techniqueId,
    attempts,
    correctAttempts,
    firstTryCorrect,
    independentStreak,
    directionHintSuccesses,
    focusHintSuccesses,
    reasoningHintSuccesses,
    resultHintSuccesses,
    lastPracticedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'technique_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TechniqueProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('technique_id')) {
      context.handle(
        _techniqueIdMeta,
        techniqueId.isAcceptableOrUnknown(
          data['technique_id']!,
          _techniqueIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_techniqueIdMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    } else if (isInserting) {
      context.missing(_attemptsMeta);
    }
    if (data.containsKey('correct_attempts')) {
      context.handle(
        _correctAttemptsMeta,
        correctAttempts.isAcceptableOrUnknown(
          data['correct_attempts']!,
          _correctAttemptsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAttemptsMeta);
    }
    if (data.containsKey('first_try_correct')) {
      context.handle(
        _firstTryCorrectMeta,
        firstTryCorrect.isAcceptableOrUnknown(
          data['first_try_correct']!,
          _firstTryCorrectMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstTryCorrectMeta);
    }
    if (data.containsKey('independent_streak')) {
      context.handle(
        _independentStreakMeta,
        independentStreak.isAcceptableOrUnknown(
          data['independent_streak']!,
          _independentStreakMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_independentStreakMeta);
    }
    if (data.containsKey('direction_hint_successes')) {
      context.handle(
        _directionHintSuccessesMeta,
        directionHintSuccesses.isAcceptableOrUnknown(
          data['direction_hint_successes']!,
          _directionHintSuccessesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_directionHintSuccessesMeta);
    }
    if (data.containsKey('focus_hint_successes')) {
      context.handle(
        _focusHintSuccessesMeta,
        focusHintSuccesses.isAcceptableOrUnknown(
          data['focus_hint_successes']!,
          _focusHintSuccessesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_focusHintSuccessesMeta);
    }
    if (data.containsKey('reasoning_hint_successes')) {
      context.handle(
        _reasoningHintSuccessesMeta,
        reasoningHintSuccesses.isAcceptableOrUnknown(
          data['reasoning_hint_successes']!,
          _reasoningHintSuccessesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reasoningHintSuccessesMeta);
    }
    if (data.containsKey('result_hint_successes')) {
      context.handle(
        _resultHintSuccessesMeta,
        resultHintSuccesses.isAcceptableOrUnknown(
          data['result_hint_successes']!,
          _resultHintSuccessesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resultHintSuccessesMeta);
    }
    if (data.containsKey('last_practiced_at_ms')) {
      context.handle(
        _lastPracticedAtMsMeta,
        lastPracticedAtMs.isAcceptableOrUnknown(
          data['last_practiced_at_ms']!,
          _lastPracticedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {techniqueId};
  @override
  TechniqueProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TechniqueProgressRow(
      techniqueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technique_id'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      correctAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_attempts'],
      )!,
      firstTryCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}first_try_correct'],
      )!,
      independentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}independent_streak'],
      )!,
      directionHintSuccesses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}direction_hint_successes'],
      )!,
      focusHintSuccesses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_hint_successes'],
      )!,
      reasoningHintSuccesses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reasoning_hint_successes'],
      )!,
      resultHintSuccesses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}result_hint_successes'],
      )!,
      lastPracticedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_practiced_at_ms'],
      ),
    );
  }

  @override
  $TechniqueProgressEntriesTable createAlias(String alias) {
    return $TechniqueProgressEntriesTable(attachedDatabase, alias);
  }
}

class TechniqueProgressRow extends DataClass
    implements Insertable<TechniqueProgressRow> {
  final String techniqueId;
  final int attempts;
  final int correctAttempts;
  final int firstTryCorrect;
  final int independentStreak;
  final int directionHintSuccesses;
  final int focusHintSuccesses;
  final int reasoningHintSuccesses;
  final int resultHintSuccesses;
  final int? lastPracticedAtMs;
  const TechniqueProgressRow({
    required this.techniqueId,
    required this.attempts,
    required this.correctAttempts,
    required this.firstTryCorrect,
    required this.independentStreak,
    required this.directionHintSuccesses,
    required this.focusHintSuccesses,
    required this.reasoningHintSuccesses,
    required this.resultHintSuccesses,
    this.lastPracticedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['technique_id'] = Variable<String>(techniqueId);
    map['attempts'] = Variable<int>(attempts);
    map['correct_attempts'] = Variable<int>(correctAttempts);
    map['first_try_correct'] = Variable<int>(firstTryCorrect);
    map['independent_streak'] = Variable<int>(independentStreak);
    map['direction_hint_successes'] = Variable<int>(directionHintSuccesses);
    map['focus_hint_successes'] = Variable<int>(focusHintSuccesses);
    map['reasoning_hint_successes'] = Variable<int>(reasoningHintSuccesses);
    map['result_hint_successes'] = Variable<int>(resultHintSuccesses);
    if (!nullToAbsent || lastPracticedAtMs != null) {
      map['last_practiced_at_ms'] = Variable<int>(lastPracticedAtMs);
    }
    return map;
  }

  TechniqueProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return TechniqueProgressEntriesCompanion(
      techniqueId: Value(techniqueId),
      attempts: Value(attempts),
      correctAttempts: Value(correctAttempts),
      firstTryCorrect: Value(firstTryCorrect),
      independentStreak: Value(independentStreak),
      directionHintSuccesses: Value(directionHintSuccesses),
      focusHintSuccesses: Value(focusHintSuccesses),
      reasoningHintSuccesses: Value(reasoningHintSuccesses),
      resultHintSuccesses: Value(resultHintSuccesses),
      lastPracticedAtMs: lastPracticedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPracticedAtMs),
    );
  }

  factory TechniqueProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TechniqueProgressRow(
      techniqueId: serializer.fromJson<String>(json['techniqueId']),
      attempts: serializer.fromJson<int>(json['attempts']),
      correctAttempts: serializer.fromJson<int>(json['correctAttempts']),
      firstTryCorrect: serializer.fromJson<int>(json['firstTryCorrect']),
      independentStreak: serializer.fromJson<int>(json['independentStreak']),
      directionHintSuccesses: serializer.fromJson<int>(
        json['directionHintSuccesses'],
      ),
      focusHintSuccesses: serializer.fromJson<int>(json['focusHintSuccesses']),
      reasoningHintSuccesses: serializer.fromJson<int>(
        json['reasoningHintSuccesses'],
      ),
      resultHintSuccesses: serializer.fromJson<int>(
        json['resultHintSuccesses'],
      ),
      lastPracticedAtMs: serializer.fromJson<int?>(json['lastPracticedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'techniqueId': serializer.toJson<String>(techniqueId),
      'attempts': serializer.toJson<int>(attempts),
      'correctAttempts': serializer.toJson<int>(correctAttempts),
      'firstTryCorrect': serializer.toJson<int>(firstTryCorrect),
      'independentStreak': serializer.toJson<int>(independentStreak),
      'directionHintSuccesses': serializer.toJson<int>(directionHintSuccesses),
      'focusHintSuccesses': serializer.toJson<int>(focusHintSuccesses),
      'reasoningHintSuccesses': serializer.toJson<int>(reasoningHintSuccesses),
      'resultHintSuccesses': serializer.toJson<int>(resultHintSuccesses),
      'lastPracticedAtMs': serializer.toJson<int?>(lastPracticedAtMs),
    };
  }

  TechniqueProgressRow copyWith({
    String? techniqueId,
    int? attempts,
    int? correctAttempts,
    int? firstTryCorrect,
    int? independentStreak,
    int? directionHintSuccesses,
    int? focusHintSuccesses,
    int? reasoningHintSuccesses,
    int? resultHintSuccesses,
    Value<int?> lastPracticedAtMs = const Value.absent(),
  }) => TechniqueProgressRow(
    techniqueId: techniqueId ?? this.techniqueId,
    attempts: attempts ?? this.attempts,
    correctAttempts: correctAttempts ?? this.correctAttempts,
    firstTryCorrect: firstTryCorrect ?? this.firstTryCorrect,
    independentStreak: independentStreak ?? this.independentStreak,
    directionHintSuccesses:
        directionHintSuccesses ?? this.directionHintSuccesses,
    focusHintSuccesses: focusHintSuccesses ?? this.focusHintSuccesses,
    reasoningHintSuccesses:
        reasoningHintSuccesses ?? this.reasoningHintSuccesses,
    resultHintSuccesses: resultHintSuccesses ?? this.resultHintSuccesses,
    lastPracticedAtMs: lastPracticedAtMs.present
        ? lastPracticedAtMs.value
        : this.lastPracticedAtMs,
  );
  TechniqueProgressRow copyWithCompanion(
    TechniqueProgressEntriesCompanion data,
  ) {
    return TechniqueProgressRow(
      techniqueId: data.techniqueId.present
          ? data.techniqueId.value
          : this.techniqueId,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      correctAttempts: data.correctAttempts.present
          ? data.correctAttempts.value
          : this.correctAttempts,
      firstTryCorrect: data.firstTryCorrect.present
          ? data.firstTryCorrect.value
          : this.firstTryCorrect,
      independentStreak: data.independentStreak.present
          ? data.independentStreak.value
          : this.independentStreak,
      directionHintSuccesses: data.directionHintSuccesses.present
          ? data.directionHintSuccesses.value
          : this.directionHintSuccesses,
      focusHintSuccesses: data.focusHintSuccesses.present
          ? data.focusHintSuccesses.value
          : this.focusHintSuccesses,
      reasoningHintSuccesses: data.reasoningHintSuccesses.present
          ? data.reasoningHintSuccesses.value
          : this.reasoningHintSuccesses,
      resultHintSuccesses: data.resultHintSuccesses.present
          ? data.resultHintSuccesses.value
          : this.resultHintSuccesses,
      lastPracticedAtMs: data.lastPracticedAtMs.present
          ? data.lastPracticedAtMs.value
          : this.lastPracticedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TechniqueProgressRow(')
          ..write('techniqueId: $techniqueId, ')
          ..write('attempts: $attempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('firstTryCorrect: $firstTryCorrect, ')
          ..write('independentStreak: $independentStreak, ')
          ..write('directionHintSuccesses: $directionHintSuccesses, ')
          ..write('focusHintSuccesses: $focusHintSuccesses, ')
          ..write('reasoningHintSuccesses: $reasoningHintSuccesses, ')
          ..write('resultHintSuccesses: $resultHintSuccesses, ')
          ..write('lastPracticedAtMs: $lastPracticedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    techniqueId,
    attempts,
    correctAttempts,
    firstTryCorrect,
    independentStreak,
    directionHintSuccesses,
    focusHintSuccesses,
    reasoningHintSuccesses,
    resultHintSuccesses,
    lastPracticedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TechniqueProgressRow &&
          other.techniqueId == this.techniqueId &&
          other.attempts == this.attempts &&
          other.correctAttempts == this.correctAttempts &&
          other.firstTryCorrect == this.firstTryCorrect &&
          other.independentStreak == this.independentStreak &&
          other.directionHintSuccesses == this.directionHintSuccesses &&
          other.focusHintSuccesses == this.focusHintSuccesses &&
          other.reasoningHintSuccesses == this.reasoningHintSuccesses &&
          other.resultHintSuccesses == this.resultHintSuccesses &&
          other.lastPracticedAtMs == this.lastPracticedAtMs);
}

class TechniqueProgressEntriesCompanion
    extends UpdateCompanion<TechniqueProgressRow> {
  final Value<String> techniqueId;
  final Value<int> attempts;
  final Value<int> correctAttempts;
  final Value<int> firstTryCorrect;
  final Value<int> independentStreak;
  final Value<int> directionHintSuccesses;
  final Value<int> focusHintSuccesses;
  final Value<int> reasoningHintSuccesses;
  final Value<int> resultHintSuccesses;
  final Value<int?> lastPracticedAtMs;
  final Value<int> rowid;
  const TechniqueProgressEntriesCompanion({
    this.techniqueId = const Value.absent(),
    this.attempts = const Value.absent(),
    this.correctAttempts = const Value.absent(),
    this.firstTryCorrect = const Value.absent(),
    this.independentStreak = const Value.absent(),
    this.directionHintSuccesses = const Value.absent(),
    this.focusHintSuccesses = const Value.absent(),
    this.reasoningHintSuccesses = const Value.absent(),
    this.resultHintSuccesses = const Value.absent(),
    this.lastPracticedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TechniqueProgressEntriesCompanion.insert({
    required String techniqueId,
    required int attempts,
    required int correctAttempts,
    required int firstTryCorrect,
    required int independentStreak,
    required int directionHintSuccesses,
    required int focusHintSuccesses,
    required int reasoningHintSuccesses,
    required int resultHintSuccesses,
    this.lastPracticedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : techniqueId = Value(techniqueId),
       attempts = Value(attempts),
       correctAttempts = Value(correctAttempts),
       firstTryCorrect = Value(firstTryCorrect),
       independentStreak = Value(independentStreak),
       directionHintSuccesses = Value(directionHintSuccesses),
       focusHintSuccesses = Value(focusHintSuccesses),
       reasoningHintSuccesses = Value(reasoningHintSuccesses),
       resultHintSuccesses = Value(resultHintSuccesses);
  static Insertable<TechniqueProgressRow> custom({
    Expression<String>? techniqueId,
    Expression<int>? attempts,
    Expression<int>? correctAttempts,
    Expression<int>? firstTryCorrect,
    Expression<int>? independentStreak,
    Expression<int>? directionHintSuccesses,
    Expression<int>? focusHintSuccesses,
    Expression<int>? reasoningHintSuccesses,
    Expression<int>? resultHintSuccesses,
    Expression<int>? lastPracticedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (techniqueId != null) 'technique_id': techniqueId,
      if (attempts != null) 'attempts': attempts,
      if (correctAttempts != null) 'correct_attempts': correctAttempts,
      if (firstTryCorrect != null) 'first_try_correct': firstTryCorrect,
      if (independentStreak != null) 'independent_streak': independentStreak,
      if (directionHintSuccesses != null)
        'direction_hint_successes': directionHintSuccesses,
      if (focusHintSuccesses != null)
        'focus_hint_successes': focusHintSuccesses,
      if (reasoningHintSuccesses != null)
        'reasoning_hint_successes': reasoningHintSuccesses,
      if (resultHintSuccesses != null)
        'result_hint_successes': resultHintSuccesses,
      if (lastPracticedAtMs != null) 'last_practiced_at_ms': lastPracticedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TechniqueProgressEntriesCompanion copyWith({
    Value<String>? techniqueId,
    Value<int>? attempts,
    Value<int>? correctAttempts,
    Value<int>? firstTryCorrect,
    Value<int>? independentStreak,
    Value<int>? directionHintSuccesses,
    Value<int>? focusHintSuccesses,
    Value<int>? reasoningHintSuccesses,
    Value<int>? resultHintSuccesses,
    Value<int?>? lastPracticedAtMs,
    Value<int>? rowid,
  }) {
    return TechniqueProgressEntriesCompanion(
      techniqueId: techniqueId ?? this.techniqueId,
      attempts: attempts ?? this.attempts,
      correctAttempts: correctAttempts ?? this.correctAttempts,
      firstTryCorrect: firstTryCorrect ?? this.firstTryCorrect,
      independentStreak: independentStreak ?? this.independentStreak,
      directionHintSuccesses:
          directionHintSuccesses ?? this.directionHintSuccesses,
      focusHintSuccesses: focusHintSuccesses ?? this.focusHintSuccesses,
      reasoningHintSuccesses:
          reasoningHintSuccesses ?? this.reasoningHintSuccesses,
      resultHintSuccesses: resultHintSuccesses ?? this.resultHintSuccesses,
      lastPracticedAtMs: lastPracticedAtMs ?? this.lastPracticedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (techniqueId.present) {
      map['technique_id'] = Variable<String>(techniqueId.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (correctAttempts.present) {
      map['correct_attempts'] = Variable<int>(correctAttempts.value);
    }
    if (firstTryCorrect.present) {
      map['first_try_correct'] = Variable<int>(firstTryCorrect.value);
    }
    if (independentStreak.present) {
      map['independent_streak'] = Variable<int>(independentStreak.value);
    }
    if (directionHintSuccesses.present) {
      map['direction_hint_successes'] = Variable<int>(
        directionHintSuccesses.value,
      );
    }
    if (focusHintSuccesses.present) {
      map['focus_hint_successes'] = Variable<int>(focusHintSuccesses.value);
    }
    if (reasoningHintSuccesses.present) {
      map['reasoning_hint_successes'] = Variable<int>(
        reasoningHintSuccesses.value,
      );
    }
    if (resultHintSuccesses.present) {
      map['result_hint_successes'] = Variable<int>(resultHintSuccesses.value);
    }
    if (lastPracticedAtMs.present) {
      map['last_practiced_at_ms'] = Variable<int>(lastPracticedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TechniqueProgressEntriesCompanion(')
          ..write('techniqueId: $techniqueId, ')
          ..write('attempts: $attempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('firstTryCorrect: $firstTryCorrect, ')
          ..write('independentStreak: $independentStreak, ')
          ..write('directionHintSuccesses: $directionHintSuccesses, ')
          ..write('focusHintSuccesses: $focusHintSuccesses, ')
          ..write('reasoningHintSuccesses: $reasoningHintSuccesses, ')
          ..write('resultHintSuccesses: $resultHintSuccesses, ')
          ..write('lastPracticedAtMs: $lastPracticedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$GameDatabase extends GeneratedDatabase {
  _$GameDatabase(QueryExecutor e) : super(e);
  $GameDatabaseManager get managers => $GameDatabaseManager(this);
  late final $ActiveGamesTable activeGames = $ActiveGamesTable(this);
  late final $CompletedGamesTable completedGames = $CompletedGamesTable(this);
  late final $TechniqueProgressEntriesTable techniqueProgressEntries =
      $TechniqueProgressEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    activeGames,
    completedGames,
    techniqueProgressEntries,
  ];
}

typedef $$ActiveGamesTableCreateCompanionBuilder =
    ActiveGamesCompanion Function({
      Value<int> slot,
      required String gameId,
      required String puzzleId,
      Value<String?> dailyChallengeKey,
      required String initialBoard,
      required String currentBoard,
      required String notesJson,
      required String undoJson,
      required int mistakes,
      required int elapsedMs,
      Value<int?> runningSinceMs,
      required int startedAtMs,
      required int updatedAtMs,
      required bool isPaused,
      required int hintsRequested,
      required int highestHintLevelUsed,
      Value<String> techniqueHelpJson,
      required int correctEditableCells,
      required int editableCells,
    });
typedef $$ActiveGamesTableUpdateCompanionBuilder =
    ActiveGamesCompanion Function({
      Value<int> slot,
      Value<String> gameId,
      Value<String> puzzleId,
      Value<String?> dailyChallengeKey,
      Value<String> initialBoard,
      Value<String> currentBoard,
      Value<String> notesJson,
      Value<String> undoJson,
      Value<int> mistakes,
      Value<int> elapsedMs,
      Value<int?> runningSinceMs,
      Value<int> startedAtMs,
      Value<int> updatedAtMs,
      Value<bool> isPaused,
      Value<int> hintsRequested,
      Value<int> highestHintLevelUsed,
      Value<String> techniqueHelpJson,
      Value<int> correctEditableCells,
      Value<int> editableCells,
    });

class $$ActiveGamesTableFilterComposer
    extends Composer<_$GameDatabase, $ActiveGamesTable> {
  $$ActiveGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dailyChallengeKey => $composableBuilder(
    column: $table.dailyChallengeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentBoard => $composableBuilder(
    column: $table.currentBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notesJson => $composableBuilder(
    column: $table.notesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get undoJson => $composableBuilder(
    column: $table.undoJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedMs => $composableBuilder(
    column: $table.elapsedMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runningSinceMs => $composableBuilder(
    column: $table.runningSinceMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintsRequested => $composableBuilder(
    column: $table.hintsRequested,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get highestHintLevelUsed => $composableBuilder(
    column: $table.highestHintLevelUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techniqueHelpJson => $composableBuilder(
    column: $table.techniqueHelpJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctEditableCells => $composableBuilder(
    column: $table.correctEditableCells,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get editableCells => $composableBuilder(
    column: $table.editableCells,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActiveGamesTableOrderingComposer
    extends Composer<_$GameDatabase, $ActiveGamesTable> {
  $$ActiveGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dailyChallengeKey => $composableBuilder(
    column: $table.dailyChallengeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentBoard => $composableBuilder(
    column: $table.currentBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notesJson => $composableBuilder(
    column: $table.notesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get undoJson => $composableBuilder(
    column: $table.undoJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedMs => $composableBuilder(
    column: $table.elapsedMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runningSinceMs => $composableBuilder(
    column: $table.runningSinceMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaused => $composableBuilder(
    column: $table.isPaused,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintsRequested => $composableBuilder(
    column: $table.hintsRequested,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get highestHintLevelUsed => $composableBuilder(
    column: $table.highestHintLevelUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techniqueHelpJson => $composableBuilder(
    column: $table.techniqueHelpJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctEditableCells => $composableBuilder(
    column: $table.correctEditableCells,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get editableCells => $composableBuilder(
    column: $table.editableCells,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActiveGamesTableAnnotationComposer
    extends Composer<_$GameDatabase, $ActiveGamesTable> {
  $$ActiveGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<String> get gameId =>
      $composableBuilder(column: $table.gameId, builder: (column) => column);

  GeneratedColumn<String> get puzzleId =>
      $composableBuilder(column: $table.puzzleId, builder: (column) => column);

  GeneratedColumn<String> get dailyChallengeKey => $composableBuilder(
    column: $table.dailyChallengeKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentBoard => $composableBuilder(
    column: $table.currentBoard,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notesJson =>
      $composableBuilder(column: $table.notesJson, builder: (column) => column);

  GeneratedColumn<String> get undoJson =>
      $composableBuilder(column: $table.undoJson, builder: (column) => column);

  GeneratedColumn<int> get mistakes =>
      $composableBuilder(column: $table.mistakes, builder: (column) => column);

  GeneratedColumn<int> get elapsedMs =>
      $composableBuilder(column: $table.elapsedMs, builder: (column) => column);

  GeneratedColumn<int> get runningSinceMs => $composableBuilder(
    column: $table.runningSinceMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<int> get hintsRequested => $composableBuilder(
    column: $table.hintsRequested,
    builder: (column) => column,
  );

  GeneratedColumn<int> get highestHintLevelUsed => $composableBuilder(
    column: $table.highestHintLevelUsed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get techniqueHelpJson => $composableBuilder(
    column: $table.techniqueHelpJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctEditableCells => $composableBuilder(
    column: $table.correctEditableCells,
    builder: (column) => column,
  );

  GeneratedColumn<int> get editableCells => $composableBuilder(
    column: $table.editableCells,
    builder: (column) => column,
  );
}

class $$ActiveGamesTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $ActiveGamesTable,
          ActiveGame,
          $$ActiveGamesTableFilterComposer,
          $$ActiveGamesTableOrderingComposer,
          $$ActiveGamesTableAnnotationComposer,
          $$ActiveGamesTableCreateCompanionBuilder,
          $$ActiveGamesTableUpdateCompanionBuilder,
          (
            ActiveGame,
            BaseReferences<_$GameDatabase, $ActiveGamesTable, ActiveGame>,
          ),
          ActiveGame,
          PrefetchHooks Function()
        > {
  $$ActiveGamesTableTableManager(_$GameDatabase db, $ActiveGamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActiveGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActiveGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActiveGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<String?> dailyChallengeKey = const Value.absent(),
                Value<String> initialBoard = const Value.absent(),
                Value<String> currentBoard = const Value.absent(),
                Value<String> notesJson = const Value.absent(),
                Value<String> undoJson = const Value.absent(),
                Value<int> mistakes = const Value.absent(),
                Value<int> elapsedMs = const Value.absent(),
                Value<int?> runningSinceMs = const Value.absent(),
                Value<int> startedAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isPaused = const Value.absent(),
                Value<int> hintsRequested = const Value.absent(),
                Value<int> highestHintLevelUsed = const Value.absent(),
                Value<String> techniqueHelpJson = const Value.absent(),
                Value<int> correctEditableCells = const Value.absent(),
                Value<int> editableCells = const Value.absent(),
              }) => ActiveGamesCompanion(
                slot: slot,
                gameId: gameId,
                puzzleId: puzzleId,
                dailyChallengeKey: dailyChallengeKey,
                initialBoard: initialBoard,
                currentBoard: currentBoard,
                notesJson: notesJson,
                undoJson: undoJson,
                mistakes: mistakes,
                elapsedMs: elapsedMs,
                runningSinceMs: runningSinceMs,
                startedAtMs: startedAtMs,
                updatedAtMs: updatedAtMs,
                isPaused: isPaused,
                hintsRequested: hintsRequested,
                highestHintLevelUsed: highestHintLevelUsed,
                techniqueHelpJson: techniqueHelpJson,
                correctEditableCells: correctEditableCells,
                editableCells: editableCells,
              ),
          createCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                required String gameId,
                required String puzzleId,
                Value<String?> dailyChallengeKey = const Value.absent(),
                required String initialBoard,
                required String currentBoard,
                required String notesJson,
                required String undoJson,
                required int mistakes,
                required int elapsedMs,
                Value<int?> runningSinceMs = const Value.absent(),
                required int startedAtMs,
                required int updatedAtMs,
                required bool isPaused,
                required int hintsRequested,
                required int highestHintLevelUsed,
                Value<String> techniqueHelpJson = const Value.absent(),
                required int correctEditableCells,
                required int editableCells,
              }) => ActiveGamesCompanion.insert(
                slot: slot,
                gameId: gameId,
                puzzleId: puzzleId,
                dailyChallengeKey: dailyChallengeKey,
                initialBoard: initialBoard,
                currentBoard: currentBoard,
                notesJson: notesJson,
                undoJson: undoJson,
                mistakes: mistakes,
                elapsedMs: elapsedMs,
                runningSinceMs: runningSinceMs,
                startedAtMs: startedAtMs,
                updatedAtMs: updatedAtMs,
                isPaused: isPaused,
                hintsRequested: hintsRequested,
                highestHintLevelUsed: highestHintLevelUsed,
                techniqueHelpJson: techniqueHelpJson,
                correctEditableCells: correctEditableCells,
                editableCells: editableCells,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActiveGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $ActiveGamesTable,
      ActiveGame,
      $$ActiveGamesTableFilterComposer,
      $$ActiveGamesTableOrderingComposer,
      $$ActiveGamesTableAnnotationComposer,
      $$ActiveGamesTableCreateCompanionBuilder,
      $$ActiveGamesTableUpdateCompanionBuilder,
      (
        ActiveGame,
        BaseReferences<_$GameDatabase, $ActiveGamesTable, ActiveGame>,
      ),
      ActiveGame,
      PrefetchHooks Function()
    >;
typedef $$CompletedGamesTableCreateCompanionBuilder =
    CompletedGamesCompanion Function({
      required String gameId,
      required String puzzleId,
      Value<String?> dailyChallengeKey,
      required String initialBoard,
      required String completedBoard,
      required int startedAtMs,
      required int completedAtMs,
      required int elapsedMs,
      required int mistakes,
      required int hintsRequested,
      required int highestHintLevelUsed,
      Value<String> techniqueHelpJson,
      Value<int> rowid,
    });
typedef $$CompletedGamesTableUpdateCompanionBuilder =
    CompletedGamesCompanion Function({
      Value<String> gameId,
      Value<String> puzzleId,
      Value<String?> dailyChallengeKey,
      Value<String> initialBoard,
      Value<String> completedBoard,
      Value<int> startedAtMs,
      Value<int> completedAtMs,
      Value<int> elapsedMs,
      Value<int> mistakes,
      Value<int> hintsRequested,
      Value<int> highestHintLevelUsed,
      Value<String> techniqueHelpJson,
      Value<int> rowid,
    });

class $$CompletedGamesTableFilterComposer
    extends Composer<_$GameDatabase, $CompletedGamesTable> {
  $$CompletedGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dailyChallengeKey => $composableBuilder(
    column: $table.dailyChallengeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedBoard => $composableBuilder(
    column: $table.completedBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedAtMs => $composableBuilder(
    column: $table.completedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedMs => $composableBuilder(
    column: $table.elapsedMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintsRequested => $composableBuilder(
    column: $table.hintsRequested,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get highestHintLevelUsed => $composableBuilder(
    column: $table.highestHintLevelUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techniqueHelpJson => $composableBuilder(
    column: $table.techniqueHelpJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompletedGamesTableOrderingComposer
    extends Composer<_$GameDatabase, $CompletedGamesTable> {
  $$CompletedGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dailyChallengeKey => $composableBuilder(
    column: $table.dailyChallengeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedBoard => $composableBuilder(
    column: $table.completedBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedAtMs => $composableBuilder(
    column: $table.completedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedMs => $composableBuilder(
    column: $table.elapsedMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintsRequested => $composableBuilder(
    column: $table.hintsRequested,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get highestHintLevelUsed => $composableBuilder(
    column: $table.highestHintLevelUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techniqueHelpJson => $composableBuilder(
    column: $table.techniqueHelpJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompletedGamesTableAnnotationComposer
    extends Composer<_$GameDatabase, $CompletedGamesTable> {
  $$CompletedGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get gameId =>
      $composableBuilder(column: $table.gameId, builder: (column) => column);

  GeneratedColumn<String> get puzzleId =>
      $composableBuilder(column: $table.puzzleId, builder: (column) => column);

  GeneratedColumn<String> get dailyChallengeKey => $composableBuilder(
    column: $table.dailyChallengeKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedBoard => $composableBuilder(
    column: $table.completedBoard,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedAtMs => $composableBuilder(
    column: $table.completedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedMs =>
      $composableBuilder(column: $table.elapsedMs, builder: (column) => column);

  GeneratedColumn<int> get mistakes =>
      $composableBuilder(column: $table.mistakes, builder: (column) => column);

  GeneratedColumn<int> get hintsRequested => $composableBuilder(
    column: $table.hintsRequested,
    builder: (column) => column,
  );

  GeneratedColumn<int> get highestHintLevelUsed => $composableBuilder(
    column: $table.highestHintLevelUsed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get techniqueHelpJson => $composableBuilder(
    column: $table.techniqueHelpJson,
    builder: (column) => column,
  );
}

class $$CompletedGamesTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $CompletedGamesTable,
          CompletedGameRow,
          $$CompletedGamesTableFilterComposer,
          $$CompletedGamesTableOrderingComposer,
          $$CompletedGamesTableAnnotationComposer,
          $$CompletedGamesTableCreateCompanionBuilder,
          $$CompletedGamesTableUpdateCompanionBuilder,
          (
            CompletedGameRow,
            BaseReferences<
              _$GameDatabase,
              $CompletedGamesTable,
              CompletedGameRow
            >,
          ),
          CompletedGameRow,
          PrefetchHooks Function()
        > {
  $$CompletedGamesTableTableManager(
    _$GameDatabase db,
    $CompletedGamesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletedGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletedGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletedGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> gameId = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<String?> dailyChallengeKey = const Value.absent(),
                Value<String> initialBoard = const Value.absent(),
                Value<String> completedBoard = const Value.absent(),
                Value<int> startedAtMs = const Value.absent(),
                Value<int> completedAtMs = const Value.absent(),
                Value<int> elapsedMs = const Value.absent(),
                Value<int> mistakes = const Value.absent(),
                Value<int> hintsRequested = const Value.absent(),
                Value<int> highestHintLevelUsed = const Value.absent(),
                Value<String> techniqueHelpJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletedGamesCompanion(
                gameId: gameId,
                puzzleId: puzzleId,
                dailyChallengeKey: dailyChallengeKey,
                initialBoard: initialBoard,
                completedBoard: completedBoard,
                startedAtMs: startedAtMs,
                completedAtMs: completedAtMs,
                elapsedMs: elapsedMs,
                mistakes: mistakes,
                hintsRequested: hintsRequested,
                highestHintLevelUsed: highestHintLevelUsed,
                techniqueHelpJson: techniqueHelpJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String gameId,
                required String puzzleId,
                Value<String?> dailyChallengeKey = const Value.absent(),
                required String initialBoard,
                required String completedBoard,
                required int startedAtMs,
                required int completedAtMs,
                required int elapsedMs,
                required int mistakes,
                required int hintsRequested,
                required int highestHintLevelUsed,
                Value<String> techniqueHelpJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompletedGamesCompanion.insert(
                gameId: gameId,
                puzzleId: puzzleId,
                dailyChallengeKey: dailyChallengeKey,
                initialBoard: initialBoard,
                completedBoard: completedBoard,
                startedAtMs: startedAtMs,
                completedAtMs: completedAtMs,
                elapsedMs: elapsedMs,
                mistakes: mistakes,
                hintsRequested: hintsRequested,
                highestHintLevelUsed: highestHintLevelUsed,
                techniqueHelpJson: techniqueHelpJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompletedGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $CompletedGamesTable,
      CompletedGameRow,
      $$CompletedGamesTableFilterComposer,
      $$CompletedGamesTableOrderingComposer,
      $$CompletedGamesTableAnnotationComposer,
      $$CompletedGamesTableCreateCompanionBuilder,
      $$CompletedGamesTableUpdateCompanionBuilder,
      (
        CompletedGameRow,
        BaseReferences<_$GameDatabase, $CompletedGamesTable, CompletedGameRow>,
      ),
      CompletedGameRow,
      PrefetchHooks Function()
    >;
typedef $$TechniqueProgressEntriesTableCreateCompanionBuilder =
    TechniqueProgressEntriesCompanion Function({
      required String techniqueId,
      required int attempts,
      required int correctAttempts,
      required int firstTryCorrect,
      required int independentStreak,
      required int directionHintSuccesses,
      required int focusHintSuccesses,
      required int reasoningHintSuccesses,
      required int resultHintSuccesses,
      Value<int?> lastPracticedAtMs,
      Value<int> rowid,
    });
typedef $$TechniqueProgressEntriesTableUpdateCompanionBuilder =
    TechniqueProgressEntriesCompanion Function({
      Value<String> techniqueId,
      Value<int> attempts,
      Value<int> correctAttempts,
      Value<int> firstTryCorrect,
      Value<int> independentStreak,
      Value<int> directionHintSuccesses,
      Value<int> focusHintSuccesses,
      Value<int> reasoningHintSuccesses,
      Value<int> resultHintSuccesses,
      Value<int?> lastPracticedAtMs,
      Value<int> rowid,
    });

class $$TechniqueProgressEntriesTableFilterComposer
    extends Composer<_$GameDatabase, $TechniqueProgressEntriesTable> {
  $$TechniqueProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAttempts => $composableBuilder(
    column: $table.correctAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get firstTryCorrect => $composableBuilder(
    column: $table.firstTryCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get independentStreak => $composableBuilder(
    column: $table.independentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get directionHintSuccesses => $composableBuilder(
    column: $table.directionHintSuccesses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusHintSuccesses => $composableBuilder(
    column: $table.focusHintSuccesses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reasoningHintSuccesses => $composableBuilder(
    column: $table.reasoningHintSuccesses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get resultHintSuccesses => $composableBuilder(
    column: $table.resultHintSuccesses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastPracticedAtMs => $composableBuilder(
    column: $table.lastPracticedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TechniqueProgressEntriesTableOrderingComposer
    extends Composer<_$GameDatabase, $TechniqueProgressEntriesTable> {
  $$TechniqueProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAttempts => $composableBuilder(
    column: $table.correctAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get firstTryCorrect => $composableBuilder(
    column: $table.firstTryCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get independentStreak => $composableBuilder(
    column: $table.independentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get directionHintSuccesses => $composableBuilder(
    column: $table.directionHintSuccesses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusHintSuccesses => $composableBuilder(
    column: $table.focusHintSuccesses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reasoningHintSuccesses => $composableBuilder(
    column: $table.reasoningHintSuccesses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get resultHintSuccesses => $composableBuilder(
    column: $table.resultHintSuccesses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastPracticedAtMs => $composableBuilder(
    column: $table.lastPracticedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TechniqueProgressEntriesTableAnnotationComposer
    extends Composer<_$GameDatabase, $TechniqueProgressEntriesTable> {
  $$TechniqueProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<int> get correctAttempts => $composableBuilder(
    column: $table.correctAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get firstTryCorrect => $composableBuilder(
    column: $table.firstTryCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get independentStreak => $composableBuilder(
    column: $table.independentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get directionHintSuccesses => $composableBuilder(
    column: $table.directionHintSuccesses,
    builder: (column) => column,
  );

  GeneratedColumn<int> get focusHintSuccesses => $composableBuilder(
    column: $table.focusHintSuccesses,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reasoningHintSuccesses => $composableBuilder(
    column: $table.reasoningHintSuccesses,
    builder: (column) => column,
  );

  GeneratedColumn<int> get resultHintSuccesses => $composableBuilder(
    column: $table.resultHintSuccesses,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastPracticedAtMs => $composableBuilder(
    column: $table.lastPracticedAtMs,
    builder: (column) => column,
  );
}

class $$TechniqueProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $TechniqueProgressEntriesTable,
          TechniqueProgressRow,
          $$TechniqueProgressEntriesTableFilterComposer,
          $$TechniqueProgressEntriesTableOrderingComposer,
          $$TechniqueProgressEntriesTableAnnotationComposer,
          $$TechniqueProgressEntriesTableCreateCompanionBuilder,
          $$TechniqueProgressEntriesTableUpdateCompanionBuilder,
          (
            TechniqueProgressRow,
            BaseReferences<
              _$GameDatabase,
              $TechniqueProgressEntriesTable,
              TechniqueProgressRow
            >,
          ),
          TechniqueProgressRow,
          PrefetchHooks Function()
        > {
  $$TechniqueProgressEntriesTableTableManager(
    _$GameDatabase db,
    $TechniqueProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TechniqueProgressEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TechniqueProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TechniqueProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> techniqueId = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> correctAttempts = const Value.absent(),
                Value<int> firstTryCorrect = const Value.absent(),
                Value<int> independentStreak = const Value.absent(),
                Value<int> directionHintSuccesses = const Value.absent(),
                Value<int> focusHintSuccesses = const Value.absent(),
                Value<int> reasoningHintSuccesses = const Value.absent(),
                Value<int> resultHintSuccesses = const Value.absent(),
                Value<int?> lastPracticedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TechniqueProgressEntriesCompanion(
                techniqueId: techniqueId,
                attempts: attempts,
                correctAttempts: correctAttempts,
                firstTryCorrect: firstTryCorrect,
                independentStreak: independentStreak,
                directionHintSuccesses: directionHintSuccesses,
                focusHintSuccesses: focusHintSuccesses,
                reasoningHintSuccesses: reasoningHintSuccesses,
                resultHintSuccesses: resultHintSuccesses,
                lastPracticedAtMs: lastPracticedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String techniqueId,
                required int attempts,
                required int correctAttempts,
                required int firstTryCorrect,
                required int independentStreak,
                required int directionHintSuccesses,
                required int focusHintSuccesses,
                required int reasoningHintSuccesses,
                required int resultHintSuccesses,
                Value<int?> lastPracticedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TechniqueProgressEntriesCompanion.insert(
                techniqueId: techniqueId,
                attempts: attempts,
                correctAttempts: correctAttempts,
                firstTryCorrect: firstTryCorrect,
                independentStreak: independentStreak,
                directionHintSuccesses: directionHintSuccesses,
                focusHintSuccesses: focusHintSuccesses,
                reasoningHintSuccesses: reasoningHintSuccesses,
                resultHintSuccesses: resultHintSuccesses,
                lastPracticedAtMs: lastPracticedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TechniqueProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $TechniqueProgressEntriesTable,
      TechniqueProgressRow,
      $$TechniqueProgressEntriesTableFilterComposer,
      $$TechniqueProgressEntriesTableOrderingComposer,
      $$TechniqueProgressEntriesTableAnnotationComposer,
      $$TechniqueProgressEntriesTableCreateCompanionBuilder,
      $$TechniqueProgressEntriesTableUpdateCompanionBuilder,
      (
        TechniqueProgressRow,
        BaseReferences<
          _$GameDatabase,
          $TechniqueProgressEntriesTable,
          TechniqueProgressRow
        >,
      ),
      TechniqueProgressRow,
      PrefetchHooks Function()
    >;

class $GameDatabaseManager {
  final _$GameDatabase _db;
  $GameDatabaseManager(this._db);
  $$ActiveGamesTableTableManager get activeGames =>
      $$ActiveGamesTableTableManager(_db, _db.activeGames);
  $$CompletedGamesTableTableManager get completedGames =>
      $$CompletedGamesTableTableManager(_db, _db.completedGames);
  $$TechniqueProgressEntriesTableTableManager get techniqueProgressEntries =>
      $$TechniqueProgressEntriesTableTableManager(
        _db,
        _db.techniqueProgressEntries,
      );
}
