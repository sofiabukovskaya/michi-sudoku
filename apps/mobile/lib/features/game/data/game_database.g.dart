// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_database.dart';

// ignore_for_file: type=lint
class $ActiveGamesTable extends ActiveGames
    with TableInfo<$ActiveGamesTable, ActiveGame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('guest'),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _reasoningJsonMeta = const VerificationMeta(
    'reasoningJson',
  );
  @override
  late final GeneratedColumn<String> reasoningJson = GeneratedColumn<String>(
    'reasoning_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
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
    profileId,
    slot,
    gameId,
    puzzleId,
    dailyChallengeKey,
    initialBoard,
    currentBoard,
    notesJson,
    undoJson,
    reasoningJson,
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
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
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
    if (data.containsKey('reasoning_json')) {
      context.handle(
        _reasoningJsonMeta,
        reasoningJson.isAcceptableOrUnknown(
          data['reasoning_json']!,
          _reasoningJsonMeta,
        ),
      );
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
  Set<GeneratedColumn> get $primaryKey => {profileId, slot};
  @override
  ActiveGame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveGame(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
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
      reasoningJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reasoning_json'],
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
  final String profileId;
  final int slot;
  final String gameId;
  final String puzzleId;
  final String? dailyChallengeKey;
  final String initialBoard;
  final String currentBoard;
  final String notesJson;
  final String undoJson;
  final String reasoningJson;
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
    required this.profileId,
    required this.slot,
    required this.gameId,
    required this.puzzleId,
    this.dailyChallengeKey,
    required this.initialBoard,
    required this.currentBoard,
    required this.notesJson,
    required this.undoJson,
    required this.reasoningJson,
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
    map['profile_id'] = Variable<String>(profileId);
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
    map['reasoning_json'] = Variable<String>(reasoningJson);
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
      profileId: Value(profileId),
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
      reasoningJson: Value(reasoningJson),
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
      profileId: serializer.fromJson<String>(json['profileId']),
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
      reasoningJson: serializer.fromJson<String>(json['reasoningJson']),
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
      'profileId': serializer.toJson<String>(profileId),
      'slot': serializer.toJson<int>(slot),
      'gameId': serializer.toJson<String>(gameId),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'dailyChallengeKey': serializer.toJson<String?>(dailyChallengeKey),
      'initialBoard': serializer.toJson<String>(initialBoard),
      'currentBoard': serializer.toJson<String>(currentBoard),
      'notesJson': serializer.toJson<String>(notesJson),
      'undoJson': serializer.toJson<String>(undoJson),
      'reasoningJson': serializer.toJson<String>(reasoningJson),
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
    String? profileId,
    int? slot,
    String? gameId,
    String? puzzleId,
    Value<String?> dailyChallengeKey = const Value.absent(),
    String? initialBoard,
    String? currentBoard,
    String? notesJson,
    String? undoJson,
    String? reasoningJson,
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
    profileId: profileId ?? this.profileId,
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
    reasoningJson: reasoningJson ?? this.reasoningJson,
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
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
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
      reasoningJson: data.reasoningJson.present
          ? data.reasoningJson.value
          : this.reasoningJson,
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
          ..write('profileId: $profileId, ')
          ..write('slot: $slot, ')
          ..write('gameId: $gameId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('dailyChallengeKey: $dailyChallengeKey, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('currentBoard: $currentBoard, ')
          ..write('notesJson: $notesJson, ')
          ..write('undoJson: $undoJson, ')
          ..write('reasoningJson: $reasoningJson, ')
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
  int get hashCode => Object.hashAll([
    profileId,
    slot,
    gameId,
    puzzleId,
    dailyChallengeKey,
    initialBoard,
    currentBoard,
    notesJson,
    undoJson,
    reasoningJson,
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
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveGame &&
          other.profileId == this.profileId &&
          other.slot == this.slot &&
          other.gameId == this.gameId &&
          other.puzzleId == this.puzzleId &&
          other.dailyChallengeKey == this.dailyChallengeKey &&
          other.initialBoard == this.initialBoard &&
          other.currentBoard == this.currentBoard &&
          other.notesJson == this.notesJson &&
          other.undoJson == this.undoJson &&
          other.reasoningJson == this.reasoningJson &&
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
  final Value<String> profileId;
  final Value<int> slot;
  final Value<String> gameId;
  final Value<String> puzzleId;
  final Value<String?> dailyChallengeKey;
  final Value<String> initialBoard;
  final Value<String> currentBoard;
  final Value<String> notesJson;
  final Value<String> undoJson;
  final Value<String> reasoningJson;
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
  final Value<int> rowid;
  const ActiveGamesCompanion({
    this.profileId = const Value.absent(),
    this.slot = const Value.absent(),
    this.gameId = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.dailyChallengeKey = const Value.absent(),
    this.initialBoard = const Value.absent(),
    this.currentBoard = const Value.absent(),
    this.notesJson = const Value.absent(),
    this.undoJson = const Value.absent(),
    this.reasoningJson = const Value.absent(),
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
    this.rowid = const Value.absent(),
  });
  ActiveGamesCompanion.insert({
    this.profileId = const Value.absent(),
    required int slot,
    required String gameId,
    required String puzzleId,
    this.dailyChallengeKey = const Value.absent(),
    required String initialBoard,
    required String currentBoard,
    required String notesJson,
    required String undoJson,
    this.reasoningJson = const Value.absent(),
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
    this.rowid = const Value.absent(),
  }) : slot = Value(slot),
       gameId = Value(gameId),
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
    Expression<String>? profileId,
    Expression<int>? slot,
    Expression<String>? gameId,
    Expression<String>? puzzleId,
    Expression<String>? dailyChallengeKey,
    Expression<String>? initialBoard,
    Expression<String>? currentBoard,
    Expression<String>? notesJson,
    Expression<String>? undoJson,
    Expression<String>? reasoningJson,
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
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (slot != null) 'slot': slot,
      if (gameId != null) 'game_id': gameId,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (dailyChallengeKey != null) 'daily_challenge_key': dailyChallengeKey,
      if (initialBoard != null) 'initial_board': initialBoard,
      if (currentBoard != null) 'current_board': currentBoard,
      if (notesJson != null) 'notes_json': notesJson,
      if (undoJson != null) 'undo_json': undoJson,
      if (reasoningJson != null) 'reasoning_json': reasoningJson,
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
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActiveGamesCompanion copyWith({
    Value<String>? profileId,
    Value<int>? slot,
    Value<String>? gameId,
    Value<String>? puzzleId,
    Value<String?>? dailyChallengeKey,
    Value<String>? initialBoard,
    Value<String>? currentBoard,
    Value<String>? notesJson,
    Value<String>? undoJson,
    Value<String>? reasoningJson,
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
    Value<int>? rowid,
  }) {
    return ActiveGamesCompanion(
      profileId: profileId ?? this.profileId,
      slot: slot ?? this.slot,
      gameId: gameId ?? this.gameId,
      puzzleId: puzzleId ?? this.puzzleId,
      dailyChallengeKey: dailyChallengeKey ?? this.dailyChallengeKey,
      initialBoard: initialBoard ?? this.initialBoard,
      currentBoard: currentBoard ?? this.currentBoard,
      notesJson: notesJson ?? this.notesJson,
      undoJson: undoJson ?? this.undoJson,
      reasoningJson: reasoningJson ?? this.reasoningJson,
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
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
    if (reasoningJson.present) {
      map['reasoning_json'] = Variable<String>(reasoningJson.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveGamesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('slot: $slot, ')
          ..write('gameId: $gameId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('dailyChallengeKey: $dailyChallengeKey, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('currentBoard: $currentBoard, ')
          ..write('notesJson: $notesJson, ')
          ..write('undoJson: $undoJson, ')
          ..write('reasoningJson: $reasoningJson, ')
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
          ..write('editableCells: $editableCells, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('guest'),
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
    profileId,
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
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
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
  Set<GeneratedColumn> get $primaryKey => {profileId, gameId};
  @override
  CompletedGameRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedGameRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
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
  final String profileId;
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
    required this.profileId,
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
    map['profile_id'] = Variable<String>(profileId);
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
      profileId: Value(profileId),
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
      profileId: serializer.fromJson<String>(json['profileId']),
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
      'profileId': serializer.toJson<String>(profileId),
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
    String? profileId,
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
    profileId: profileId ?? this.profileId,
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
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
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
          ..write('profileId: $profileId, ')
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
    profileId,
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
          other.profileId == this.profileId &&
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
  final Value<String> profileId;
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
    this.profileId = const Value.absent(),
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
    this.profileId = const Value.absent(),
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
    Expression<String>? profileId,
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
      if (profileId != null) 'profile_id': profileId,
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
    Value<String>? profileId,
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
      profileId: profileId ?? this.profileId,
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
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
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
          ..write('profileId: $profileId, ')
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
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('guest'),
  );
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
  static const VerificationMeta _masteredEverMeta = const VerificationMeta(
    'masteredEver',
  );
  @override
  late final GeneratedColumn<bool> masteredEver = GeneratedColumn<bool>(
    'mastered_ever',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mastered_ever" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    profileId,
    techniqueId,
    attempts,
    correctAttempts,
    firstTryCorrect,
    independentStreak,
    masteredEver,
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
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
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
    if (data.containsKey('mastered_ever')) {
      context.handle(
        _masteredEverMeta,
        masteredEver.isAcceptableOrUnknown(
          data['mastered_ever']!,
          _masteredEverMeta,
        ),
      );
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
  Set<GeneratedColumn> get $primaryKey => {profileId, techniqueId};
  @override
  TechniqueProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TechniqueProgressRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
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
      masteredEver: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mastered_ever'],
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
  final String profileId;
  final String techniqueId;
  final int attempts;
  final int correctAttempts;
  final int firstTryCorrect;
  final int independentStreak;
  final bool masteredEver;
  final int directionHintSuccesses;
  final int focusHintSuccesses;
  final int reasoningHintSuccesses;
  final int resultHintSuccesses;
  final int? lastPracticedAtMs;
  const TechniqueProgressRow({
    required this.profileId,
    required this.techniqueId,
    required this.attempts,
    required this.correctAttempts,
    required this.firstTryCorrect,
    required this.independentStreak,
    required this.masteredEver,
    required this.directionHintSuccesses,
    required this.focusHintSuccesses,
    required this.reasoningHintSuccesses,
    required this.resultHintSuccesses,
    this.lastPracticedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['technique_id'] = Variable<String>(techniqueId);
    map['attempts'] = Variable<int>(attempts);
    map['correct_attempts'] = Variable<int>(correctAttempts);
    map['first_try_correct'] = Variable<int>(firstTryCorrect);
    map['independent_streak'] = Variable<int>(independentStreak);
    map['mastered_ever'] = Variable<bool>(masteredEver);
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
      profileId: Value(profileId),
      techniqueId: Value(techniqueId),
      attempts: Value(attempts),
      correctAttempts: Value(correctAttempts),
      firstTryCorrect: Value(firstTryCorrect),
      independentStreak: Value(independentStreak),
      masteredEver: Value(masteredEver),
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
      profileId: serializer.fromJson<String>(json['profileId']),
      techniqueId: serializer.fromJson<String>(json['techniqueId']),
      attempts: serializer.fromJson<int>(json['attempts']),
      correctAttempts: serializer.fromJson<int>(json['correctAttempts']),
      firstTryCorrect: serializer.fromJson<int>(json['firstTryCorrect']),
      independentStreak: serializer.fromJson<int>(json['independentStreak']),
      masteredEver: serializer.fromJson<bool>(json['masteredEver']),
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
      'profileId': serializer.toJson<String>(profileId),
      'techniqueId': serializer.toJson<String>(techniqueId),
      'attempts': serializer.toJson<int>(attempts),
      'correctAttempts': serializer.toJson<int>(correctAttempts),
      'firstTryCorrect': serializer.toJson<int>(firstTryCorrect),
      'independentStreak': serializer.toJson<int>(independentStreak),
      'masteredEver': serializer.toJson<bool>(masteredEver),
      'directionHintSuccesses': serializer.toJson<int>(directionHintSuccesses),
      'focusHintSuccesses': serializer.toJson<int>(focusHintSuccesses),
      'reasoningHintSuccesses': serializer.toJson<int>(reasoningHintSuccesses),
      'resultHintSuccesses': serializer.toJson<int>(resultHintSuccesses),
      'lastPracticedAtMs': serializer.toJson<int?>(lastPracticedAtMs),
    };
  }

  TechniqueProgressRow copyWith({
    String? profileId,
    String? techniqueId,
    int? attempts,
    int? correctAttempts,
    int? firstTryCorrect,
    int? independentStreak,
    bool? masteredEver,
    int? directionHintSuccesses,
    int? focusHintSuccesses,
    int? reasoningHintSuccesses,
    int? resultHintSuccesses,
    Value<int?> lastPracticedAtMs = const Value.absent(),
  }) => TechniqueProgressRow(
    profileId: profileId ?? this.profileId,
    techniqueId: techniqueId ?? this.techniqueId,
    attempts: attempts ?? this.attempts,
    correctAttempts: correctAttempts ?? this.correctAttempts,
    firstTryCorrect: firstTryCorrect ?? this.firstTryCorrect,
    independentStreak: independentStreak ?? this.independentStreak,
    masteredEver: masteredEver ?? this.masteredEver,
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
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
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
      masteredEver: data.masteredEver.present
          ? data.masteredEver.value
          : this.masteredEver,
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
          ..write('profileId: $profileId, ')
          ..write('techniqueId: $techniqueId, ')
          ..write('attempts: $attempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('firstTryCorrect: $firstTryCorrect, ')
          ..write('independentStreak: $independentStreak, ')
          ..write('masteredEver: $masteredEver, ')
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
    profileId,
    techniqueId,
    attempts,
    correctAttempts,
    firstTryCorrect,
    independentStreak,
    masteredEver,
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
          other.profileId == this.profileId &&
          other.techniqueId == this.techniqueId &&
          other.attempts == this.attempts &&
          other.correctAttempts == this.correctAttempts &&
          other.firstTryCorrect == this.firstTryCorrect &&
          other.independentStreak == this.independentStreak &&
          other.masteredEver == this.masteredEver &&
          other.directionHintSuccesses == this.directionHintSuccesses &&
          other.focusHintSuccesses == this.focusHintSuccesses &&
          other.reasoningHintSuccesses == this.reasoningHintSuccesses &&
          other.resultHintSuccesses == this.resultHintSuccesses &&
          other.lastPracticedAtMs == this.lastPracticedAtMs);
}

class TechniqueProgressEntriesCompanion
    extends UpdateCompanion<TechniqueProgressRow> {
  final Value<String> profileId;
  final Value<String> techniqueId;
  final Value<int> attempts;
  final Value<int> correctAttempts;
  final Value<int> firstTryCorrect;
  final Value<int> independentStreak;
  final Value<bool> masteredEver;
  final Value<int> directionHintSuccesses;
  final Value<int> focusHintSuccesses;
  final Value<int> reasoningHintSuccesses;
  final Value<int> resultHintSuccesses;
  final Value<int?> lastPracticedAtMs;
  final Value<int> rowid;
  const TechniqueProgressEntriesCompanion({
    this.profileId = const Value.absent(),
    this.techniqueId = const Value.absent(),
    this.attempts = const Value.absent(),
    this.correctAttempts = const Value.absent(),
    this.firstTryCorrect = const Value.absent(),
    this.independentStreak = const Value.absent(),
    this.masteredEver = const Value.absent(),
    this.directionHintSuccesses = const Value.absent(),
    this.focusHintSuccesses = const Value.absent(),
    this.reasoningHintSuccesses = const Value.absent(),
    this.resultHintSuccesses = const Value.absent(),
    this.lastPracticedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TechniqueProgressEntriesCompanion.insert({
    this.profileId = const Value.absent(),
    required String techniqueId,
    required int attempts,
    required int correctAttempts,
    required int firstTryCorrect,
    required int independentStreak,
    this.masteredEver = const Value.absent(),
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
    Expression<String>? profileId,
    Expression<String>? techniqueId,
    Expression<int>? attempts,
    Expression<int>? correctAttempts,
    Expression<int>? firstTryCorrect,
    Expression<int>? independentStreak,
    Expression<bool>? masteredEver,
    Expression<int>? directionHintSuccesses,
    Expression<int>? focusHintSuccesses,
    Expression<int>? reasoningHintSuccesses,
    Expression<int>? resultHintSuccesses,
    Expression<int>? lastPracticedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (techniqueId != null) 'technique_id': techniqueId,
      if (attempts != null) 'attempts': attempts,
      if (correctAttempts != null) 'correct_attempts': correctAttempts,
      if (firstTryCorrect != null) 'first_try_correct': firstTryCorrect,
      if (independentStreak != null) 'independent_streak': independentStreak,
      if (masteredEver != null) 'mastered_ever': masteredEver,
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
    Value<String>? profileId,
    Value<String>? techniqueId,
    Value<int>? attempts,
    Value<int>? correctAttempts,
    Value<int>? firstTryCorrect,
    Value<int>? independentStreak,
    Value<bool>? masteredEver,
    Value<int>? directionHintSuccesses,
    Value<int>? focusHintSuccesses,
    Value<int>? reasoningHintSuccesses,
    Value<int>? resultHintSuccesses,
    Value<int?>? lastPracticedAtMs,
    Value<int>? rowid,
  }) {
    return TechniqueProgressEntriesCompanion(
      profileId: profileId ?? this.profileId,
      techniqueId: techniqueId ?? this.techniqueId,
      attempts: attempts ?? this.attempts,
      correctAttempts: correctAttempts ?? this.correctAttempts,
      firstTryCorrect: firstTryCorrect ?? this.firstTryCorrect,
      independentStreak: independentStreak ?? this.independentStreak,
      masteredEver: masteredEver ?? this.masteredEver,
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
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
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
    if (masteredEver.present) {
      map['mastered_ever'] = Variable<bool>(masteredEver.value);
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
          ..write('profileId: $profileId, ')
          ..write('techniqueId: $techniqueId, ')
          ..write('attempts: $attempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('firstTryCorrect: $firstTryCorrect, ')
          ..write('independentStreak: $independentStreak, ')
          ..write('masteredEver: $masteredEver, ')
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

class $DailyLearningFocusesTable extends DailyLearningFocuses
    with TableInfo<$DailyLearningFocusesTable, DailyLearningFocusRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLearningFocusesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('guest'),
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  static const VerificationMeta _actionIdMeta = const VerificationMeta(
    'actionId',
  );
  @override
  late final GeneratedColumn<String> actionId = GeneratedColumn<String>(
    'action_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonIdMeta = const VerificationMeta(
    'reasonId',
  );
  @override
  late final GeneratedColumn<String> reasonId = GeneratedColumn<String>(
    'reason_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedMinutesMeta = const VerificationMeta(
    'estimatedMinutes',
  );
  @override
  late final GeneratedColumn<int> estimatedMinutes = GeneratedColumn<int>(
    'estimated_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evidenceJsonMeta = const VerificationMeta(
    'evidenceJson',
  );
  @override
  late final GeneratedColumn<String> evidenceJson = GeneratedColumn<String>(
    'evidence_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    localDate,
    techniqueId,
    actionId,
    reasonId,
    estimatedMinutes,
    evidenceJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_learning_focuses';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLearningFocusRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
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
    if (data.containsKey('action_id')) {
      context.handle(
        _actionIdMeta,
        actionId.isAcceptableOrUnknown(data['action_id']!, _actionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_actionIdMeta);
    }
    if (data.containsKey('reason_id')) {
      context.handle(
        _reasonIdMeta,
        reasonId.isAcceptableOrUnknown(data['reason_id']!, _reasonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonIdMeta);
    }
    if (data.containsKey('estimated_minutes')) {
      context.handle(
        _estimatedMinutesMeta,
        estimatedMinutes.isAcceptableOrUnknown(
          data['estimated_minutes']!,
          _estimatedMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedMinutesMeta);
    }
    if (data.containsKey('evidence_json')) {
      context.handle(
        _evidenceJsonMeta,
        evidenceJson.isAcceptableOrUnknown(
          data['evidence_json']!,
          _evidenceJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evidenceJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, localDate};
  @override
  DailyLearningFocusRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLearningFocusRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      techniqueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technique_id'],
      )!,
      actionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_id'],
      )!,
      reasonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason_id'],
      )!,
      estimatedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_minutes'],
      )!,
      evidenceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evidence_json'],
      )!,
    );
  }

  @override
  $DailyLearningFocusesTable createAlias(String alias) {
    return $DailyLearningFocusesTable(attachedDatabase, alias);
  }
}

class DailyLearningFocusRow extends DataClass
    implements Insertable<DailyLearningFocusRow> {
  final String profileId;
  final String localDate;
  final String techniqueId;
  final String actionId;
  final String reasonId;
  final int estimatedMinutes;
  final String evidenceJson;
  const DailyLearningFocusRow({
    required this.profileId,
    required this.localDate,
    required this.techniqueId,
    required this.actionId,
    required this.reasonId,
    required this.estimatedMinutes,
    required this.evidenceJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['local_date'] = Variable<String>(localDate);
    map['technique_id'] = Variable<String>(techniqueId);
    map['action_id'] = Variable<String>(actionId);
    map['reason_id'] = Variable<String>(reasonId);
    map['estimated_minutes'] = Variable<int>(estimatedMinutes);
    map['evidence_json'] = Variable<String>(evidenceJson);
    return map;
  }

  DailyLearningFocusesCompanion toCompanion(bool nullToAbsent) {
    return DailyLearningFocusesCompanion(
      profileId: Value(profileId),
      localDate: Value(localDate),
      techniqueId: Value(techniqueId),
      actionId: Value(actionId),
      reasonId: Value(reasonId),
      estimatedMinutes: Value(estimatedMinutes),
      evidenceJson: Value(evidenceJson),
    );
  }

  factory DailyLearningFocusRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLearningFocusRow(
      profileId: serializer.fromJson<String>(json['profileId']),
      localDate: serializer.fromJson<String>(json['localDate']),
      techniqueId: serializer.fromJson<String>(json['techniqueId']),
      actionId: serializer.fromJson<String>(json['actionId']),
      reasonId: serializer.fromJson<String>(json['reasonId']),
      estimatedMinutes: serializer.fromJson<int>(json['estimatedMinutes']),
      evidenceJson: serializer.fromJson<String>(json['evidenceJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'localDate': serializer.toJson<String>(localDate),
      'techniqueId': serializer.toJson<String>(techniqueId),
      'actionId': serializer.toJson<String>(actionId),
      'reasonId': serializer.toJson<String>(reasonId),
      'estimatedMinutes': serializer.toJson<int>(estimatedMinutes),
      'evidenceJson': serializer.toJson<String>(evidenceJson),
    };
  }

  DailyLearningFocusRow copyWith({
    String? profileId,
    String? localDate,
    String? techniqueId,
    String? actionId,
    String? reasonId,
    int? estimatedMinutes,
    String? evidenceJson,
  }) => DailyLearningFocusRow(
    profileId: profileId ?? this.profileId,
    localDate: localDate ?? this.localDate,
    techniqueId: techniqueId ?? this.techniqueId,
    actionId: actionId ?? this.actionId,
    reasonId: reasonId ?? this.reasonId,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    evidenceJson: evidenceJson ?? this.evidenceJson,
  );
  DailyLearningFocusRow copyWithCompanion(DailyLearningFocusesCompanion data) {
    return DailyLearningFocusRow(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      techniqueId: data.techniqueId.present
          ? data.techniqueId.value
          : this.techniqueId,
      actionId: data.actionId.present ? data.actionId.value : this.actionId,
      reasonId: data.reasonId.present ? data.reasonId.value : this.reasonId,
      estimatedMinutes: data.estimatedMinutes.present
          ? data.estimatedMinutes.value
          : this.estimatedMinutes,
      evidenceJson: data.evidenceJson.present
          ? data.evidenceJson.value
          : this.evidenceJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLearningFocusRow(')
          ..write('profileId: $profileId, ')
          ..write('localDate: $localDate, ')
          ..write('techniqueId: $techniqueId, ')
          ..write('actionId: $actionId, ')
          ..write('reasonId: $reasonId, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('evidenceJson: $evidenceJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    localDate,
    techniqueId,
    actionId,
    reasonId,
    estimatedMinutes,
    evidenceJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLearningFocusRow &&
          other.profileId == this.profileId &&
          other.localDate == this.localDate &&
          other.techniqueId == this.techniqueId &&
          other.actionId == this.actionId &&
          other.reasonId == this.reasonId &&
          other.estimatedMinutes == this.estimatedMinutes &&
          other.evidenceJson == this.evidenceJson);
}

class DailyLearningFocusesCompanion
    extends UpdateCompanion<DailyLearningFocusRow> {
  final Value<String> profileId;
  final Value<String> localDate;
  final Value<String> techniqueId;
  final Value<String> actionId;
  final Value<String> reasonId;
  final Value<int> estimatedMinutes;
  final Value<String> evidenceJson;
  final Value<int> rowid;
  const DailyLearningFocusesCompanion({
    this.profileId = const Value.absent(),
    this.localDate = const Value.absent(),
    this.techniqueId = const Value.absent(),
    this.actionId = const Value.absent(),
    this.reasonId = const Value.absent(),
    this.estimatedMinutes = const Value.absent(),
    this.evidenceJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyLearningFocusesCompanion.insert({
    this.profileId = const Value.absent(),
    required String localDate,
    required String techniqueId,
    required String actionId,
    required String reasonId,
    required int estimatedMinutes,
    required String evidenceJson,
    this.rowid = const Value.absent(),
  }) : localDate = Value(localDate),
       techniqueId = Value(techniqueId),
       actionId = Value(actionId),
       reasonId = Value(reasonId),
       estimatedMinutes = Value(estimatedMinutes),
       evidenceJson = Value(evidenceJson);
  static Insertable<DailyLearningFocusRow> custom({
    Expression<String>? profileId,
    Expression<String>? localDate,
    Expression<String>? techniqueId,
    Expression<String>? actionId,
    Expression<String>? reasonId,
    Expression<int>? estimatedMinutes,
    Expression<String>? evidenceJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (localDate != null) 'local_date': localDate,
      if (techniqueId != null) 'technique_id': techniqueId,
      if (actionId != null) 'action_id': actionId,
      if (reasonId != null) 'reason_id': reasonId,
      if (estimatedMinutes != null) 'estimated_minutes': estimatedMinutes,
      if (evidenceJson != null) 'evidence_json': evidenceJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyLearningFocusesCompanion copyWith({
    Value<String>? profileId,
    Value<String>? localDate,
    Value<String>? techniqueId,
    Value<String>? actionId,
    Value<String>? reasonId,
    Value<int>? estimatedMinutes,
    Value<String>? evidenceJson,
    Value<int>? rowid,
  }) {
    return DailyLearningFocusesCompanion(
      profileId: profileId ?? this.profileId,
      localDate: localDate ?? this.localDate,
      techniqueId: techniqueId ?? this.techniqueId,
      actionId: actionId ?? this.actionId,
      reasonId: reasonId ?? this.reasonId,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      evidenceJson: evidenceJson ?? this.evidenceJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (techniqueId.present) {
      map['technique_id'] = Variable<String>(techniqueId.value);
    }
    if (actionId.present) {
      map['action_id'] = Variable<String>(actionId.value);
    }
    if (reasonId.present) {
      map['reason_id'] = Variable<String>(reasonId.value);
    }
    if (estimatedMinutes.present) {
      map['estimated_minutes'] = Variable<int>(estimatedMinutes.value);
    }
    if (evidenceJson.present) {
      map['evidence_json'] = Variable<String>(evidenceJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLearningFocusesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('localDate: $localDate, ')
          ..write('techniqueId: $techniqueId, ')
          ..write('actionId: $actionId, ')
          ..write('reasonId: $reasonId, ')
          ..write('estimatedMinutes: $estimatedMinutes, ')
          ..write('evidenceJson: $evidenceJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportedPuzzlesTable extends ImportedPuzzles
    with TableInfo<$ImportedPuzzlesTable, ImportedPuzzleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportedPuzzlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('guest'),
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
  static const VerificationMeta _humanSolverFullySupportedMeta =
      const VerificationMeta('humanSolverFullySupported');
  @override
  late final GeneratedColumn<bool> humanSolverFullySupported =
      GeneratedColumn<bool>(
        'human_solver_fully_supported',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("human_solver_fully_supported" IN (0, 1))',
        ),
      );
  static const VerificationMeta _requiredTechniquesJsonMeta =
      const VerificationMeta('requiredTechniquesJson');
  @override
  late final GeneratedColumn<String> requiredTechniquesJson =
      GeneratedColumn<String>(
        'required_techniques_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _importedAtMsMeta = const VerificationMeta(
    'importedAtMs',
  );
  @override
  late final GeneratedColumn<int> importedAtMs = GeneratedColumn<int>(
    'imported_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    puzzleId,
    initialBoard,
    humanSolverFullySupported,
    requiredTechniquesJson,
    importedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'imported_puzzles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportedPuzzleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
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
    if (data.containsKey('human_solver_fully_supported')) {
      context.handle(
        _humanSolverFullySupportedMeta,
        humanSolverFullySupported.isAcceptableOrUnknown(
          data['human_solver_fully_supported']!,
          _humanSolverFullySupportedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_humanSolverFullySupportedMeta);
    }
    if (data.containsKey('required_techniques_json')) {
      context.handle(
        _requiredTechniquesJsonMeta,
        requiredTechniquesJson.isAcceptableOrUnknown(
          data['required_techniques_json']!,
          _requiredTechniquesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requiredTechniquesJsonMeta);
    }
    if (data.containsKey('imported_at_ms')) {
      context.handle(
        _importedAtMsMeta,
        importedAtMs.isAcceptableOrUnknown(
          data['imported_at_ms']!,
          _importedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_importedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, puzzleId};
  @override
  ImportedPuzzleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportedPuzzleRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      initialBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}initial_board'],
      )!,
      humanSolverFullySupported: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}human_solver_fully_supported'],
      )!,
      requiredTechniquesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}required_techniques_json'],
      )!,
      importedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_at_ms'],
      )!,
    );
  }

  @override
  $ImportedPuzzlesTable createAlias(String alias) {
    return $ImportedPuzzlesTable(attachedDatabase, alias);
  }
}

class ImportedPuzzleRow extends DataClass
    implements Insertable<ImportedPuzzleRow> {
  final String profileId;
  final String puzzleId;
  final String initialBoard;
  final bool humanSolverFullySupported;
  final String requiredTechniquesJson;
  final int importedAtMs;
  const ImportedPuzzleRow({
    required this.profileId,
    required this.puzzleId,
    required this.initialBoard,
    required this.humanSolverFullySupported,
    required this.requiredTechniquesJson,
    required this.importedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['puzzle_id'] = Variable<String>(puzzleId);
    map['initial_board'] = Variable<String>(initialBoard);
    map['human_solver_fully_supported'] = Variable<bool>(
      humanSolverFullySupported,
    );
    map['required_techniques_json'] = Variable<String>(requiredTechniquesJson);
    map['imported_at_ms'] = Variable<int>(importedAtMs);
    return map;
  }

  ImportedPuzzlesCompanion toCompanion(bool nullToAbsent) {
    return ImportedPuzzlesCompanion(
      profileId: Value(profileId),
      puzzleId: Value(puzzleId),
      initialBoard: Value(initialBoard),
      humanSolverFullySupported: Value(humanSolverFullySupported),
      requiredTechniquesJson: Value(requiredTechniquesJson),
      importedAtMs: Value(importedAtMs),
    );
  }

  factory ImportedPuzzleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportedPuzzleRow(
      profileId: serializer.fromJson<String>(json['profileId']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      initialBoard: serializer.fromJson<String>(json['initialBoard']),
      humanSolverFullySupported: serializer.fromJson<bool>(
        json['humanSolverFullySupported'],
      ),
      requiredTechniquesJson: serializer.fromJson<String>(
        json['requiredTechniquesJson'],
      ),
      importedAtMs: serializer.fromJson<int>(json['importedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'initialBoard': serializer.toJson<String>(initialBoard),
      'humanSolverFullySupported': serializer.toJson<bool>(
        humanSolverFullySupported,
      ),
      'requiredTechniquesJson': serializer.toJson<String>(
        requiredTechniquesJson,
      ),
      'importedAtMs': serializer.toJson<int>(importedAtMs),
    };
  }

  ImportedPuzzleRow copyWith({
    String? profileId,
    String? puzzleId,
    String? initialBoard,
    bool? humanSolverFullySupported,
    String? requiredTechniquesJson,
    int? importedAtMs,
  }) => ImportedPuzzleRow(
    profileId: profileId ?? this.profileId,
    puzzleId: puzzleId ?? this.puzzleId,
    initialBoard: initialBoard ?? this.initialBoard,
    humanSolverFullySupported:
        humanSolverFullySupported ?? this.humanSolverFullySupported,
    requiredTechniquesJson:
        requiredTechniquesJson ?? this.requiredTechniquesJson,
    importedAtMs: importedAtMs ?? this.importedAtMs,
  );
  ImportedPuzzleRow copyWithCompanion(ImportedPuzzlesCompanion data) {
    return ImportedPuzzleRow(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      initialBoard: data.initialBoard.present
          ? data.initialBoard.value
          : this.initialBoard,
      humanSolverFullySupported: data.humanSolverFullySupported.present
          ? data.humanSolverFullySupported.value
          : this.humanSolverFullySupported,
      requiredTechniquesJson: data.requiredTechniquesJson.present
          ? data.requiredTechniquesJson.value
          : this.requiredTechniquesJson,
      importedAtMs: data.importedAtMs.present
          ? data.importedAtMs.value
          : this.importedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportedPuzzleRow(')
          ..write('profileId: $profileId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('humanSolverFullySupported: $humanSolverFullySupported, ')
          ..write('requiredTechniquesJson: $requiredTechniquesJson, ')
          ..write('importedAtMs: $importedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    puzzleId,
    initialBoard,
    humanSolverFullySupported,
    requiredTechniquesJson,
    importedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportedPuzzleRow &&
          other.profileId == this.profileId &&
          other.puzzleId == this.puzzleId &&
          other.initialBoard == this.initialBoard &&
          other.humanSolverFullySupported == this.humanSolverFullySupported &&
          other.requiredTechniquesJson == this.requiredTechniquesJson &&
          other.importedAtMs == this.importedAtMs);
}

class ImportedPuzzlesCompanion extends UpdateCompanion<ImportedPuzzleRow> {
  final Value<String> profileId;
  final Value<String> puzzleId;
  final Value<String> initialBoard;
  final Value<bool> humanSolverFullySupported;
  final Value<String> requiredTechniquesJson;
  final Value<int> importedAtMs;
  final Value<int> rowid;
  const ImportedPuzzlesCompanion({
    this.profileId = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.initialBoard = const Value.absent(),
    this.humanSolverFullySupported = const Value.absent(),
    this.requiredTechniquesJson = const Value.absent(),
    this.importedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportedPuzzlesCompanion.insert({
    this.profileId = const Value.absent(),
    required String puzzleId,
    required String initialBoard,
    required bool humanSolverFullySupported,
    required String requiredTechniquesJson,
    required int importedAtMs,
    this.rowid = const Value.absent(),
  }) : puzzleId = Value(puzzleId),
       initialBoard = Value(initialBoard),
       humanSolverFullySupported = Value(humanSolverFullySupported),
       requiredTechniquesJson = Value(requiredTechniquesJson),
       importedAtMs = Value(importedAtMs);
  static Insertable<ImportedPuzzleRow> custom({
    Expression<String>? profileId,
    Expression<String>? puzzleId,
    Expression<String>? initialBoard,
    Expression<bool>? humanSolverFullySupported,
    Expression<String>? requiredTechniquesJson,
    Expression<int>? importedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (initialBoard != null) 'initial_board': initialBoard,
      if (humanSolverFullySupported != null)
        'human_solver_fully_supported': humanSolverFullySupported,
      if (requiredTechniquesJson != null)
        'required_techniques_json': requiredTechniquesJson,
      if (importedAtMs != null) 'imported_at_ms': importedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportedPuzzlesCompanion copyWith({
    Value<String>? profileId,
    Value<String>? puzzleId,
    Value<String>? initialBoard,
    Value<bool>? humanSolverFullySupported,
    Value<String>? requiredTechniquesJson,
    Value<int>? importedAtMs,
    Value<int>? rowid,
  }) {
    return ImportedPuzzlesCompanion(
      profileId: profileId ?? this.profileId,
      puzzleId: puzzleId ?? this.puzzleId,
      initialBoard: initialBoard ?? this.initialBoard,
      humanSolverFullySupported:
          humanSolverFullySupported ?? this.humanSolverFullySupported,
      requiredTechniquesJson:
          requiredTechniquesJson ?? this.requiredTechniquesJson,
      importedAtMs: importedAtMs ?? this.importedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (initialBoard.present) {
      map['initial_board'] = Variable<String>(initialBoard.value);
    }
    if (humanSolverFullySupported.present) {
      map['human_solver_fully_supported'] = Variable<bool>(
        humanSolverFullySupported.value,
      );
    }
    if (requiredTechniquesJson.present) {
      map['required_techniques_json'] = Variable<String>(
        requiredTechniquesJson.value,
      );
    }
    if (importedAtMs.present) {
      map['imported_at_ms'] = Variable<int>(importedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportedPuzzlesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('humanSolverFullySupported: $humanSolverFullySupported, ')
          ..write('requiredTechniquesJson: $requiredTechniquesJson, ')
          ..write('importedAtMs: $importedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String key;
  final String value;
  const SyncMetadataData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(key: Value(key), value: Value(value));
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncMetadataData copyWith({String? key, String? value}) =>
      SyncMetadataData(key: key ?? this.key, value: value ?? this.value);
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxTable extends SyncOutbox
    with TableInfo<$SyncOutboxTable, SyncOutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptCountMeta = const VerificationMeta(
    'attemptCount',
  );
  @override
  late final GeneratedColumn<int> attemptCount = GeneratedColumn<int>(
    'attempt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastAttemptAtMsMeta = const VerificationMeta(
    'lastAttemptAtMs',
  );
  @override
  late final GeneratedColumn<int> lastAttemptAtMs = GeneratedColumn<int>(
    'last_attempt_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    entityType,
    entityId,
    revision,
    createdAtMs,
    attemptCount,
    lastAttemptAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncOutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('attempt_count')) {
      context.handle(
        _attemptCountMeta,
        attemptCount.isAcceptableOrUnknown(
          data['attempt_count']!,
          _attemptCountMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at_ms')) {
      context.handle(
        _lastAttemptAtMsMeta,
        lastAttemptAtMs.isAcceptableOrUnknown(
          data['last_attempt_at_ms']!,
          _lastAttemptAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, entityType, entityId};
  @override
  SyncOutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOutboxData(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      attemptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_count'],
      )!,
      lastAttemptAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_attempt_at_ms'],
      ),
    );
  }

  @override
  $SyncOutboxTable createAlias(String alias) {
    return $SyncOutboxTable(attachedDatabase, alias);
  }
}

class SyncOutboxData extends DataClass implements Insertable<SyncOutboxData> {
  final String profileId;
  final String entityType;
  final String entityId;
  final int revision;
  final int createdAtMs;
  final int attemptCount;
  final int? lastAttemptAtMs;
  const SyncOutboxData({
    required this.profileId,
    required this.entityType,
    required this.entityId,
    required this.revision,
    required this.createdAtMs,
    required this.attemptCount,
    this.lastAttemptAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['revision'] = Variable<int>(revision);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['attempt_count'] = Variable<int>(attemptCount);
    if (!nullToAbsent || lastAttemptAtMs != null) {
      map['last_attempt_at_ms'] = Variable<int>(lastAttemptAtMs);
    }
    return map;
  }

  SyncOutboxCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxCompanion(
      profileId: Value(profileId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      revision: Value(revision),
      createdAtMs: Value(createdAtMs),
      attemptCount: Value(attemptCount),
      lastAttemptAtMs: lastAttemptAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAtMs),
    );
  }

  factory SyncOutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOutboxData(
      profileId: serializer.fromJson<String>(json['profileId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      revision: serializer.fromJson<int>(json['revision']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      attemptCount: serializer.fromJson<int>(json['attemptCount']),
      lastAttemptAtMs: serializer.fromJson<int?>(json['lastAttemptAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'revision': serializer.toJson<int>(revision),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'attemptCount': serializer.toJson<int>(attemptCount),
      'lastAttemptAtMs': serializer.toJson<int?>(lastAttemptAtMs),
    };
  }

  SyncOutboxData copyWith({
    String? profileId,
    String? entityType,
    String? entityId,
    int? revision,
    int? createdAtMs,
    int? attemptCount,
    Value<int?> lastAttemptAtMs = const Value.absent(),
  }) => SyncOutboxData(
    profileId: profileId ?? this.profileId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    revision: revision ?? this.revision,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    attemptCount: attemptCount ?? this.attemptCount,
    lastAttemptAtMs: lastAttemptAtMs.present
        ? lastAttemptAtMs.value
        : this.lastAttemptAtMs,
  );
  SyncOutboxData copyWithCompanion(SyncOutboxCompanion data) {
    return SyncOutboxData(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      revision: data.revision.present ? data.revision.value : this.revision,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      attemptCount: data.attemptCount.present
          ? data.attemptCount.value
          : this.attemptCount,
      lastAttemptAtMs: data.lastAttemptAtMs.present
          ? data.lastAttemptAtMs.value
          : this.lastAttemptAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxData(')
          ..write('profileId: $profileId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('revision: $revision, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastAttemptAtMs: $lastAttemptAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    profileId,
    entityType,
    entityId,
    revision,
    createdAtMs,
    attemptCount,
    lastAttemptAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOutboxData &&
          other.profileId == this.profileId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.revision == this.revision &&
          other.createdAtMs == this.createdAtMs &&
          other.attemptCount == this.attemptCount &&
          other.lastAttemptAtMs == this.lastAttemptAtMs);
}

class SyncOutboxCompanion extends UpdateCompanion<SyncOutboxData> {
  final Value<String> profileId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<int> revision;
  final Value<int> createdAtMs;
  final Value<int> attemptCount;
  final Value<int?> lastAttemptAtMs;
  final Value<int> rowid;
  const SyncOutboxCompanion({
    this.profileId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.revision = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.attemptCount = const Value.absent(),
    this.lastAttemptAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxCompanion.insert({
    required String profileId,
    required String entityType,
    required String entityId,
    this.revision = const Value.absent(),
    required int createdAtMs,
    this.attemptCount = const Value.absent(),
    this.lastAttemptAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       createdAtMs = Value(createdAtMs);
  static Insertable<SyncOutboxData> custom({
    Expression<String>? profileId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<int>? revision,
    Expression<int>? createdAtMs,
    Expression<int>? attemptCount,
    Expression<int>? lastAttemptAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (revision != null) 'revision': revision,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (attemptCount != null) 'attempt_count': attemptCount,
      if (lastAttemptAtMs != null) 'last_attempt_at_ms': lastAttemptAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxCompanion copyWith({
    Value<String>? profileId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<int>? revision,
    Value<int>? createdAtMs,
    Value<int>? attemptCount,
    Value<int?>? lastAttemptAtMs,
    Value<int>? rowid,
  }) {
    return SyncOutboxCompanion(
      profileId: profileId ?? this.profileId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      revision: revision ?? this.revision,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      attemptCount: attemptCount ?? this.attemptCount,
      lastAttemptAtMs: lastAttemptAtMs ?? this.lastAttemptAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (attemptCount.present) {
      map['attempt_count'] = Variable<int>(attemptCount.value);
    }
    if (lastAttemptAtMs.present) {
      map['last_attempt_at_ms'] = Variable<int>(lastAttemptAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxCompanion(')
          ..write('profileId: $profileId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('revision: $revision, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('attemptCount: $attemptCount, ')
          ..write('lastAttemptAtMs: $lastAttemptAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TechniqueContributionsTable extends TechniqueContributions
    with TableInfo<$TechniqueContributionsTable, TechniqueContribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TechniqueContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
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
  static const VerificationMeta _bestIndependentStreakMeta =
      const VerificationMeta('bestIndependentStreak');
  @override
  late final GeneratedColumn<int> bestIndependentStreak = GeneratedColumn<int>(
    'best_independent_streak',
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
    profileId,
    techniqueId,
    sourceId,
    attempts,
    correctAttempts,
    firstTryCorrect,
    independentStreak,
    bestIndependentStreak,
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
  static const String $name = 'technique_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TechniqueContribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
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
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
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
    if (data.containsKey('best_independent_streak')) {
      context.handle(
        _bestIndependentStreakMeta,
        bestIndependentStreak.isAcceptableOrUnknown(
          data['best_independent_streak']!,
          _bestIndependentStreakMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bestIndependentStreakMeta);
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
  Set<GeneratedColumn> get $primaryKey => {profileId, techniqueId, sourceId};
  @override
  TechniqueContribution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TechniqueContribution(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      techniqueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technique_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
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
      bestIndependentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_independent_streak'],
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
  $TechniqueContributionsTable createAlias(String alias) {
    return $TechniqueContributionsTable(attachedDatabase, alias);
  }
}

class TechniqueContribution extends DataClass
    implements Insertable<TechniqueContribution> {
  final String profileId;
  final String techniqueId;
  final String sourceId;
  final int attempts;
  final int correctAttempts;
  final int firstTryCorrect;
  final int independentStreak;
  final int bestIndependentStreak;
  final int directionHintSuccesses;
  final int focusHintSuccesses;
  final int reasoningHintSuccesses;
  final int resultHintSuccesses;
  final int? lastPracticedAtMs;
  const TechniqueContribution({
    required this.profileId,
    required this.techniqueId,
    required this.sourceId,
    required this.attempts,
    required this.correctAttempts,
    required this.firstTryCorrect,
    required this.independentStreak,
    required this.bestIndependentStreak,
    required this.directionHintSuccesses,
    required this.focusHintSuccesses,
    required this.reasoningHintSuccesses,
    required this.resultHintSuccesses,
    this.lastPracticedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['technique_id'] = Variable<String>(techniqueId);
    map['source_id'] = Variable<String>(sourceId);
    map['attempts'] = Variable<int>(attempts);
    map['correct_attempts'] = Variable<int>(correctAttempts);
    map['first_try_correct'] = Variable<int>(firstTryCorrect);
    map['independent_streak'] = Variable<int>(independentStreak);
    map['best_independent_streak'] = Variable<int>(bestIndependentStreak);
    map['direction_hint_successes'] = Variable<int>(directionHintSuccesses);
    map['focus_hint_successes'] = Variable<int>(focusHintSuccesses);
    map['reasoning_hint_successes'] = Variable<int>(reasoningHintSuccesses);
    map['result_hint_successes'] = Variable<int>(resultHintSuccesses);
    if (!nullToAbsent || lastPracticedAtMs != null) {
      map['last_practiced_at_ms'] = Variable<int>(lastPracticedAtMs);
    }
    return map;
  }

  TechniqueContributionsCompanion toCompanion(bool nullToAbsent) {
    return TechniqueContributionsCompanion(
      profileId: Value(profileId),
      techniqueId: Value(techniqueId),
      sourceId: Value(sourceId),
      attempts: Value(attempts),
      correctAttempts: Value(correctAttempts),
      firstTryCorrect: Value(firstTryCorrect),
      independentStreak: Value(independentStreak),
      bestIndependentStreak: Value(bestIndependentStreak),
      directionHintSuccesses: Value(directionHintSuccesses),
      focusHintSuccesses: Value(focusHintSuccesses),
      reasoningHintSuccesses: Value(reasoningHintSuccesses),
      resultHintSuccesses: Value(resultHintSuccesses),
      lastPracticedAtMs: lastPracticedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPracticedAtMs),
    );
  }

  factory TechniqueContribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TechniqueContribution(
      profileId: serializer.fromJson<String>(json['profileId']),
      techniqueId: serializer.fromJson<String>(json['techniqueId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      attempts: serializer.fromJson<int>(json['attempts']),
      correctAttempts: serializer.fromJson<int>(json['correctAttempts']),
      firstTryCorrect: serializer.fromJson<int>(json['firstTryCorrect']),
      independentStreak: serializer.fromJson<int>(json['independentStreak']),
      bestIndependentStreak: serializer.fromJson<int>(
        json['bestIndependentStreak'],
      ),
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
      'profileId': serializer.toJson<String>(profileId),
      'techniqueId': serializer.toJson<String>(techniqueId),
      'sourceId': serializer.toJson<String>(sourceId),
      'attempts': serializer.toJson<int>(attempts),
      'correctAttempts': serializer.toJson<int>(correctAttempts),
      'firstTryCorrect': serializer.toJson<int>(firstTryCorrect),
      'independentStreak': serializer.toJson<int>(independentStreak),
      'bestIndependentStreak': serializer.toJson<int>(bestIndependentStreak),
      'directionHintSuccesses': serializer.toJson<int>(directionHintSuccesses),
      'focusHintSuccesses': serializer.toJson<int>(focusHintSuccesses),
      'reasoningHintSuccesses': serializer.toJson<int>(reasoningHintSuccesses),
      'resultHintSuccesses': serializer.toJson<int>(resultHintSuccesses),
      'lastPracticedAtMs': serializer.toJson<int?>(lastPracticedAtMs),
    };
  }

  TechniqueContribution copyWith({
    String? profileId,
    String? techniqueId,
    String? sourceId,
    int? attempts,
    int? correctAttempts,
    int? firstTryCorrect,
    int? independentStreak,
    int? bestIndependentStreak,
    int? directionHintSuccesses,
    int? focusHintSuccesses,
    int? reasoningHintSuccesses,
    int? resultHintSuccesses,
    Value<int?> lastPracticedAtMs = const Value.absent(),
  }) => TechniqueContribution(
    profileId: profileId ?? this.profileId,
    techniqueId: techniqueId ?? this.techniqueId,
    sourceId: sourceId ?? this.sourceId,
    attempts: attempts ?? this.attempts,
    correctAttempts: correctAttempts ?? this.correctAttempts,
    firstTryCorrect: firstTryCorrect ?? this.firstTryCorrect,
    independentStreak: independentStreak ?? this.independentStreak,
    bestIndependentStreak: bestIndependentStreak ?? this.bestIndependentStreak,
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
  TechniqueContribution copyWithCompanion(
    TechniqueContributionsCompanion data,
  ) {
    return TechniqueContribution(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      techniqueId: data.techniqueId.present
          ? data.techniqueId.value
          : this.techniqueId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
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
      bestIndependentStreak: data.bestIndependentStreak.present
          ? data.bestIndependentStreak.value
          : this.bestIndependentStreak,
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
    return (StringBuffer('TechniqueContribution(')
          ..write('profileId: $profileId, ')
          ..write('techniqueId: $techniqueId, ')
          ..write('sourceId: $sourceId, ')
          ..write('attempts: $attempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('firstTryCorrect: $firstTryCorrect, ')
          ..write('independentStreak: $independentStreak, ')
          ..write('bestIndependentStreak: $bestIndependentStreak, ')
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
    profileId,
    techniqueId,
    sourceId,
    attempts,
    correctAttempts,
    firstTryCorrect,
    independentStreak,
    bestIndependentStreak,
    directionHintSuccesses,
    focusHintSuccesses,
    reasoningHintSuccesses,
    resultHintSuccesses,
    lastPracticedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TechniqueContribution &&
          other.profileId == this.profileId &&
          other.techniqueId == this.techniqueId &&
          other.sourceId == this.sourceId &&
          other.attempts == this.attempts &&
          other.correctAttempts == this.correctAttempts &&
          other.firstTryCorrect == this.firstTryCorrect &&
          other.independentStreak == this.independentStreak &&
          other.bestIndependentStreak == this.bestIndependentStreak &&
          other.directionHintSuccesses == this.directionHintSuccesses &&
          other.focusHintSuccesses == this.focusHintSuccesses &&
          other.reasoningHintSuccesses == this.reasoningHintSuccesses &&
          other.resultHintSuccesses == this.resultHintSuccesses &&
          other.lastPracticedAtMs == this.lastPracticedAtMs);
}

class TechniqueContributionsCompanion
    extends UpdateCompanion<TechniqueContribution> {
  final Value<String> profileId;
  final Value<String> techniqueId;
  final Value<String> sourceId;
  final Value<int> attempts;
  final Value<int> correctAttempts;
  final Value<int> firstTryCorrect;
  final Value<int> independentStreak;
  final Value<int> bestIndependentStreak;
  final Value<int> directionHintSuccesses;
  final Value<int> focusHintSuccesses;
  final Value<int> reasoningHintSuccesses;
  final Value<int> resultHintSuccesses;
  final Value<int?> lastPracticedAtMs;
  final Value<int> rowid;
  const TechniqueContributionsCompanion({
    this.profileId = const Value.absent(),
    this.techniqueId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.attempts = const Value.absent(),
    this.correctAttempts = const Value.absent(),
    this.firstTryCorrect = const Value.absent(),
    this.independentStreak = const Value.absent(),
    this.bestIndependentStreak = const Value.absent(),
    this.directionHintSuccesses = const Value.absent(),
    this.focusHintSuccesses = const Value.absent(),
    this.reasoningHintSuccesses = const Value.absent(),
    this.resultHintSuccesses = const Value.absent(),
    this.lastPracticedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TechniqueContributionsCompanion.insert({
    required String profileId,
    required String techniqueId,
    required String sourceId,
    required int attempts,
    required int correctAttempts,
    required int firstTryCorrect,
    required int independentStreak,
    required int bestIndependentStreak,
    required int directionHintSuccesses,
    required int focusHintSuccesses,
    required int reasoningHintSuccesses,
    required int resultHintSuccesses,
    this.lastPracticedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       techniqueId = Value(techniqueId),
       sourceId = Value(sourceId),
       attempts = Value(attempts),
       correctAttempts = Value(correctAttempts),
       firstTryCorrect = Value(firstTryCorrect),
       independentStreak = Value(independentStreak),
       bestIndependentStreak = Value(bestIndependentStreak),
       directionHintSuccesses = Value(directionHintSuccesses),
       focusHintSuccesses = Value(focusHintSuccesses),
       reasoningHintSuccesses = Value(reasoningHintSuccesses),
       resultHintSuccesses = Value(resultHintSuccesses);
  static Insertable<TechniqueContribution> custom({
    Expression<String>? profileId,
    Expression<String>? techniqueId,
    Expression<String>? sourceId,
    Expression<int>? attempts,
    Expression<int>? correctAttempts,
    Expression<int>? firstTryCorrect,
    Expression<int>? independentStreak,
    Expression<int>? bestIndependentStreak,
    Expression<int>? directionHintSuccesses,
    Expression<int>? focusHintSuccesses,
    Expression<int>? reasoningHintSuccesses,
    Expression<int>? resultHintSuccesses,
    Expression<int>? lastPracticedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (techniqueId != null) 'technique_id': techniqueId,
      if (sourceId != null) 'source_id': sourceId,
      if (attempts != null) 'attempts': attempts,
      if (correctAttempts != null) 'correct_attempts': correctAttempts,
      if (firstTryCorrect != null) 'first_try_correct': firstTryCorrect,
      if (independentStreak != null) 'independent_streak': independentStreak,
      if (bestIndependentStreak != null)
        'best_independent_streak': bestIndependentStreak,
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

  TechniqueContributionsCompanion copyWith({
    Value<String>? profileId,
    Value<String>? techniqueId,
    Value<String>? sourceId,
    Value<int>? attempts,
    Value<int>? correctAttempts,
    Value<int>? firstTryCorrect,
    Value<int>? independentStreak,
    Value<int>? bestIndependentStreak,
    Value<int>? directionHintSuccesses,
    Value<int>? focusHintSuccesses,
    Value<int>? reasoningHintSuccesses,
    Value<int>? resultHintSuccesses,
    Value<int?>? lastPracticedAtMs,
    Value<int>? rowid,
  }) {
    return TechniqueContributionsCompanion(
      profileId: profileId ?? this.profileId,
      techniqueId: techniqueId ?? this.techniqueId,
      sourceId: sourceId ?? this.sourceId,
      attempts: attempts ?? this.attempts,
      correctAttempts: correctAttempts ?? this.correctAttempts,
      firstTryCorrect: firstTryCorrect ?? this.firstTryCorrect,
      independentStreak: independentStreak ?? this.independentStreak,
      bestIndependentStreak:
          bestIndependentStreak ?? this.bestIndependentStreak,
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
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (techniqueId.present) {
      map['technique_id'] = Variable<String>(techniqueId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
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
    if (bestIndependentStreak.present) {
      map['best_independent_streak'] = Variable<int>(
        bestIndependentStreak.value,
      );
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
    return (StringBuffer('TechniqueContributionsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('techniqueId: $techniqueId, ')
          ..write('sourceId: $sourceId, ')
          ..write('attempts: $attempts, ')
          ..write('correctAttempts: $correctAttempts, ')
          ..write('firstTryCorrect: $firstTryCorrect, ')
          ..write('independentStreak: $independentStreak, ')
          ..write('bestIndependentStreak: $bestIndependentStreak, ')
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

class $DailyCompletionsTable extends DailyCompletions
    with TableInfo<$DailyCompletionsTable, DailyCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _challengeKeyMeta = const VerificationMeta(
    'challengeKey',
  );
  @override
  late final GeneratedColumn<String> challengeKey = GeneratedColumn<String>(
    'challenge_key',
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
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    challengeKey,
    puzzleId,
    gameId,
    completedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('challenge_key')) {
      context.handle(
        _challengeKeyMeta,
        challengeKey.isAcceptableOrUnknown(
          data['challenge_key']!,
          _challengeKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_challengeKeyMeta);
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, challengeKey};
  @override
  DailyCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCompletion(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      challengeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_key'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      completedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_at_ms'],
      )!,
    );
  }

  @override
  $DailyCompletionsTable createAlias(String alias) {
    return $DailyCompletionsTable(attachedDatabase, alias);
  }
}

class DailyCompletion extends DataClass implements Insertable<DailyCompletion> {
  final String profileId;
  final String challengeKey;
  final String puzzleId;
  final String gameId;
  final int completedAtMs;
  const DailyCompletion({
    required this.profileId,
    required this.challengeKey,
    required this.puzzleId,
    required this.gameId,
    required this.completedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['challenge_key'] = Variable<String>(challengeKey);
    map['puzzle_id'] = Variable<String>(puzzleId);
    map['game_id'] = Variable<String>(gameId);
    map['completed_at_ms'] = Variable<int>(completedAtMs);
    return map;
  }

  DailyCompletionsCompanion toCompanion(bool nullToAbsent) {
    return DailyCompletionsCompanion(
      profileId: Value(profileId),
      challengeKey: Value(challengeKey),
      puzzleId: Value(puzzleId),
      gameId: Value(gameId),
      completedAtMs: Value(completedAtMs),
    );
  }

  factory DailyCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCompletion(
      profileId: serializer.fromJson<String>(json['profileId']),
      challengeKey: serializer.fromJson<String>(json['challengeKey']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      gameId: serializer.fromJson<String>(json['gameId']),
      completedAtMs: serializer.fromJson<int>(json['completedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'challengeKey': serializer.toJson<String>(challengeKey),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'gameId': serializer.toJson<String>(gameId),
      'completedAtMs': serializer.toJson<int>(completedAtMs),
    };
  }

  DailyCompletion copyWith({
    String? profileId,
    String? challengeKey,
    String? puzzleId,
    String? gameId,
    int? completedAtMs,
  }) => DailyCompletion(
    profileId: profileId ?? this.profileId,
    challengeKey: challengeKey ?? this.challengeKey,
    puzzleId: puzzleId ?? this.puzzleId,
    gameId: gameId ?? this.gameId,
    completedAtMs: completedAtMs ?? this.completedAtMs,
  );
  DailyCompletion copyWithCompanion(DailyCompletionsCompanion data) {
    return DailyCompletion(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      challengeKey: data.challengeKey.present
          ? data.challengeKey.value
          : this.challengeKey,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      completedAtMs: data.completedAtMs.present
          ? data.completedAtMs.value
          : this.completedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCompletion(')
          ..write('profileId: $profileId, ')
          ..write('challengeKey: $challengeKey, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('gameId: $gameId, ')
          ..write('completedAtMs: $completedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(profileId, challengeKey, puzzleId, gameId, completedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCompletion &&
          other.profileId == this.profileId &&
          other.challengeKey == this.challengeKey &&
          other.puzzleId == this.puzzleId &&
          other.gameId == this.gameId &&
          other.completedAtMs == this.completedAtMs);
}

class DailyCompletionsCompanion extends UpdateCompanion<DailyCompletion> {
  final Value<String> profileId;
  final Value<String> challengeKey;
  final Value<String> puzzleId;
  final Value<String> gameId;
  final Value<int> completedAtMs;
  final Value<int> rowid;
  const DailyCompletionsCompanion({
    this.profileId = const Value.absent(),
    this.challengeKey = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.gameId = const Value.absent(),
    this.completedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCompletionsCompanion.insert({
    required String profileId,
    required String challengeKey,
    required String puzzleId,
    required String gameId,
    required int completedAtMs,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       challengeKey = Value(challengeKey),
       puzzleId = Value(puzzleId),
       gameId = Value(gameId),
       completedAtMs = Value(completedAtMs);
  static Insertable<DailyCompletion> custom({
    Expression<String>? profileId,
    Expression<String>? challengeKey,
    Expression<String>? puzzleId,
    Expression<String>? gameId,
    Expression<int>? completedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (challengeKey != null) 'challenge_key': challengeKey,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (gameId != null) 'game_id': gameId,
      if (completedAtMs != null) 'completed_at_ms': completedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCompletionsCompanion copyWith({
    Value<String>? profileId,
    Value<String>? challengeKey,
    Value<String>? puzzleId,
    Value<String>? gameId,
    Value<int>? completedAtMs,
    Value<int>? rowid,
  }) {
    return DailyCompletionsCompanion(
      profileId: profileId ?? this.profileId,
      challengeKey: challengeKey ?? this.challengeKey,
      puzzleId: puzzleId ?? this.puzzleId,
      gameId: gameId ?? this.gameId,
      completedAtMs: completedAtMs ?? this.completedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (challengeKey.present) {
      map['challenge_key'] = Variable<String>(challengeKey.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (completedAtMs.present) {
      map['completed_at_ms'] = Variable<int>(completedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCompletionsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('challengeKey: $challengeKey, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('gameId: $gameId, ')
          ..write('completedAtMs: $completedAtMs, ')
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
  late final $DailyLearningFocusesTable dailyLearningFocuses =
      $DailyLearningFocusesTable(this);
  late final $ImportedPuzzlesTable importedPuzzles = $ImportedPuzzlesTable(
    this,
  );
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  late final $SyncOutboxTable syncOutbox = $SyncOutboxTable(this);
  late final $TechniqueContributionsTable techniqueContributions =
      $TechniqueContributionsTable(this);
  late final $DailyCompletionsTable dailyCompletions = $DailyCompletionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    activeGames,
    completedGames,
    techniqueProgressEntries,
    dailyLearningFocuses,
    importedPuzzles,
    syncMetadata,
    syncOutbox,
    techniqueContributions,
    dailyCompletions,
  ];
}

typedef $$ActiveGamesTableCreateCompanionBuilder =
    ActiveGamesCompanion Function({
      Value<String> profileId,
      required int slot,
      required String gameId,
      required String puzzleId,
      Value<String?> dailyChallengeKey,
      required String initialBoard,
      required String currentBoard,
      required String notesJson,
      required String undoJson,
      Value<String> reasoningJson,
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
      Value<int> rowid,
    });
typedef $$ActiveGamesTableUpdateCompanionBuilder =
    ActiveGamesCompanion Function({
      Value<String> profileId,
      Value<int> slot,
      Value<String> gameId,
      Value<String> puzzleId,
      Value<String?> dailyChallengeKey,
      Value<String> initialBoard,
      Value<String> currentBoard,
      Value<String> notesJson,
      Value<String> undoJson,
      Value<String> reasoningJson,
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
      Value<int> rowid,
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
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

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

  ColumnFilters<String> get reasoningJson => $composableBuilder(
    column: $table.reasoningJson,
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
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

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

  ColumnOrderings<String> get reasoningJson => $composableBuilder(
    column: $table.reasoningJson,
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
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

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

  GeneratedColumn<String> get reasoningJson => $composableBuilder(
    column: $table.reasoningJson,
    builder: (column) => column,
  );

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
                Value<String> profileId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<String?> dailyChallengeKey = const Value.absent(),
                Value<String> initialBoard = const Value.absent(),
                Value<String> currentBoard = const Value.absent(),
                Value<String> notesJson = const Value.absent(),
                Value<String> undoJson = const Value.absent(),
                Value<String> reasoningJson = const Value.absent(),
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
                Value<int> rowid = const Value.absent(),
              }) => ActiveGamesCompanion(
                profileId: profileId,
                slot: slot,
                gameId: gameId,
                puzzleId: puzzleId,
                dailyChallengeKey: dailyChallengeKey,
                initialBoard: initialBoard,
                currentBoard: currentBoard,
                notesJson: notesJson,
                undoJson: undoJson,
                reasoningJson: reasoningJson,
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
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                required int slot,
                required String gameId,
                required String puzzleId,
                Value<String?> dailyChallengeKey = const Value.absent(),
                required String initialBoard,
                required String currentBoard,
                required String notesJson,
                required String undoJson,
                Value<String> reasoningJson = const Value.absent(),
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
                Value<int> rowid = const Value.absent(),
              }) => ActiveGamesCompanion.insert(
                profileId: profileId,
                slot: slot,
                gameId: gameId,
                puzzleId: puzzleId,
                dailyChallengeKey: dailyChallengeKey,
                initialBoard: initialBoard,
                currentBoard: currentBoard,
                notesJson: notesJson,
                undoJson: undoJson,
                reasoningJson: reasoningJson,
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
                rowid: rowid,
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
      Value<String> profileId,
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
      Value<String> profileId,
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
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
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
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
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
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

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
                Value<String> profileId = const Value.absent(),
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
                profileId: profileId,
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
                Value<String> profileId = const Value.absent(),
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
                profileId: profileId,
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
      Value<String> profileId,
      required String techniqueId,
      required int attempts,
      required int correctAttempts,
      required int firstTryCorrect,
      required int independentStreak,
      Value<bool> masteredEver,
      required int directionHintSuccesses,
      required int focusHintSuccesses,
      required int reasoningHintSuccesses,
      required int resultHintSuccesses,
      Value<int?> lastPracticedAtMs,
      Value<int> rowid,
    });
typedef $$TechniqueProgressEntriesTableUpdateCompanionBuilder =
    TechniqueProgressEntriesCompanion Function({
      Value<String> profileId,
      Value<String> techniqueId,
      Value<int> attempts,
      Value<int> correctAttempts,
      Value<int> firstTryCorrect,
      Value<int> independentStreak,
      Value<bool> masteredEver,
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
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

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

  ColumnFilters<bool> get masteredEver => $composableBuilder(
    column: $table.masteredEver,
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
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

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

  ColumnOrderings<bool> get masteredEver => $composableBuilder(
    column: $table.masteredEver,
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
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

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

  GeneratedColumn<bool> get masteredEver => $composableBuilder(
    column: $table.masteredEver,
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
                Value<String> profileId = const Value.absent(),
                Value<String> techniqueId = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> correctAttempts = const Value.absent(),
                Value<int> firstTryCorrect = const Value.absent(),
                Value<int> independentStreak = const Value.absent(),
                Value<bool> masteredEver = const Value.absent(),
                Value<int> directionHintSuccesses = const Value.absent(),
                Value<int> focusHintSuccesses = const Value.absent(),
                Value<int> reasoningHintSuccesses = const Value.absent(),
                Value<int> resultHintSuccesses = const Value.absent(),
                Value<int?> lastPracticedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TechniqueProgressEntriesCompanion(
                profileId: profileId,
                techniqueId: techniqueId,
                attempts: attempts,
                correctAttempts: correctAttempts,
                firstTryCorrect: firstTryCorrect,
                independentStreak: independentStreak,
                masteredEver: masteredEver,
                directionHintSuccesses: directionHintSuccesses,
                focusHintSuccesses: focusHintSuccesses,
                reasoningHintSuccesses: reasoningHintSuccesses,
                resultHintSuccesses: resultHintSuccesses,
                lastPracticedAtMs: lastPracticedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                required String techniqueId,
                required int attempts,
                required int correctAttempts,
                required int firstTryCorrect,
                required int independentStreak,
                Value<bool> masteredEver = const Value.absent(),
                required int directionHintSuccesses,
                required int focusHintSuccesses,
                required int reasoningHintSuccesses,
                required int resultHintSuccesses,
                Value<int?> lastPracticedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TechniqueProgressEntriesCompanion.insert(
                profileId: profileId,
                techniqueId: techniqueId,
                attempts: attempts,
                correctAttempts: correctAttempts,
                firstTryCorrect: firstTryCorrect,
                independentStreak: independentStreak,
                masteredEver: masteredEver,
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
typedef $$DailyLearningFocusesTableCreateCompanionBuilder =
    DailyLearningFocusesCompanion Function({
      Value<String> profileId,
      required String localDate,
      required String techniqueId,
      required String actionId,
      required String reasonId,
      required int estimatedMinutes,
      required String evidenceJson,
      Value<int> rowid,
    });
typedef $$DailyLearningFocusesTableUpdateCompanionBuilder =
    DailyLearningFocusesCompanion Function({
      Value<String> profileId,
      Value<String> localDate,
      Value<String> techniqueId,
      Value<String> actionId,
      Value<String> reasonId,
      Value<int> estimatedMinutes,
      Value<String> evidenceJson,
      Value<int> rowid,
    });

class $$DailyLearningFocusesTableFilterComposer
    extends Composer<_$GameDatabase, $DailyLearningFocusesTable> {
  $$DailyLearningFocusesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionId => $composableBuilder(
    column: $table.actionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonId => $composableBuilder(
    column: $table.reasonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evidenceJson => $composableBuilder(
    column: $table.evidenceJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyLearningFocusesTableOrderingComposer
    extends Composer<_$GameDatabase, $DailyLearningFocusesTable> {
  $$DailyLearningFocusesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionId => $composableBuilder(
    column: $table.actionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonId => $composableBuilder(
    column: $table.reasonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evidenceJson => $composableBuilder(
    column: $table.evidenceJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyLearningFocusesTableAnnotationComposer
    extends Composer<_$GameDatabase, $DailyLearningFocusesTable> {
  $$DailyLearningFocusesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionId =>
      $composableBuilder(column: $table.actionId, builder: (column) => column);

  GeneratedColumn<String> get reasonId =>
      $composableBuilder(column: $table.reasonId, builder: (column) => column);

  GeneratedColumn<int> get estimatedMinutes => $composableBuilder(
    column: $table.estimatedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get evidenceJson => $composableBuilder(
    column: $table.evidenceJson,
    builder: (column) => column,
  );
}

class $$DailyLearningFocusesTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $DailyLearningFocusesTable,
          DailyLearningFocusRow,
          $$DailyLearningFocusesTableFilterComposer,
          $$DailyLearningFocusesTableOrderingComposer,
          $$DailyLearningFocusesTableAnnotationComposer,
          $$DailyLearningFocusesTableCreateCompanionBuilder,
          $$DailyLearningFocusesTableUpdateCompanionBuilder,
          (
            DailyLearningFocusRow,
            BaseReferences<
              _$GameDatabase,
              $DailyLearningFocusesTable,
              DailyLearningFocusRow
            >,
          ),
          DailyLearningFocusRow,
          PrefetchHooks Function()
        > {
  $$DailyLearningFocusesTableTableManager(
    _$GameDatabase db,
    $DailyLearningFocusesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLearningFocusesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLearningFocusesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyLearningFocusesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<String> techniqueId = const Value.absent(),
                Value<String> actionId = const Value.absent(),
                Value<String> reasonId = const Value.absent(),
                Value<int> estimatedMinutes = const Value.absent(),
                Value<String> evidenceJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyLearningFocusesCompanion(
                profileId: profileId,
                localDate: localDate,
                techniqueId: techniqueId,
                actionId: actionId,
                reasonId: reasonId,
                estimatedMinutes: estimatedMinutes,
                evidenceJson: evidenceJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                required String localDate,
                required String techniqueId,
                required String actionId,
                required String reasonId,
                required int estimatedMinutes,
                required String evidenceJson,
                Value<int> rowid = const Value.absent(),
              }) => DailyLearningFocusesCompanion.insert(
                profileId: profileId,
                localDate: localDate,
                techniqueId: techniqueId,
                actionId: actionId,
                reasonId: reasonId,
                estimatedMinutes: estimatedMinutes,
                evidenceJson: evidenceJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyLearningFocusesTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $DailyLearningFocusesTable,
      DailyLearningFocusRow,
      $$DailyLearningFocusesTableFilterComposer,
      $$DailyLearningFocusesTableOrderingComposer,
      $$DailyLearningFocusesTableAnnotationComposer,
      $$DailyLearningFocusesTableCreateCompanionBuilder,
      $$DailyLearningFocusesTableUpdateCompanionBuilder,
      (
        DailyLearningFocusRow,
        BaseReferences<
          _$GameDatabase,
          $DailyLearningFocusesTable,
          DailyLearningFocusRow
        >,
      ),
      DailyLearningFocusRow,
      PrefetchHooks Function()
    >;
typedef $$ImportedPuzzlesTableCreateCompanionBuilder =
    ImportedPuzzlesCompanion Function({
      Value<String> profileId,
      required String puzzleId,
      required String initialBoard,
      required bool humanSolverFullySupported,
      required String requiredTechniquesJson,
      required int importedAtMs,
      Value<int> rowid,
    });
typedef $$ImportedPuzzlesTableUpdateCompanionBuilder =
    ImportedPuzzlesCompanion Function({
      Value<String> profileId,
      Value<String> puzzleId,
      Value<String> initialBoard,
      Value<bool> humanSolverFullySupported,
      Value<String> requiredTechniquesJson,
      Value<int> importedAtMs,
      Value<int> rowid,
    });

class $$ImportedPuzzlesTableFilterComposer
    extends Composer<_$GameDatabase, $ImportedPuzzlesTable> {
  $$ImportedPuzzlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get humanSolverFullySupported => $composableBuilder(
    column: $table.humanSolverFullySupported,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requiredTechniquesJson => $composableBuilder(
    column: $table.requiredTechniquesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedAtMs => $composableBuilder(
    column: $table.importedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportedPuzzlesTableOrderingComposer
    extends Composer<_$GameDatabase, $ImportedPuzzlesTable> {
  $$ImportedPuzzlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get humanSolverFullySupported => $composableBuilder(
    column: $table.humanSolverFullySupported,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requiredTechniquesJson => $composableBuilder(
    column: $table.requiredTechniquesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedAtMs => $composableBuilder(
    column: $table.importedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportedPuzzlesTableAnnotationComposer
    extends Composer<_$GameDatabase, $ImportedPuzzlesTable> {
  $$ImportedPuzzlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get puzzleId =>
      $composableBuilder(column: $table.puzzleId, builder: (column) => column);

  GeneratedColumn<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get humanSolverFullySupported => $composableBuilder(
    column: $table.humanSolverFullySupported,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requiredTechniquesJson => $composableBuilder(
    column: $table.requiredTechniquesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get importedAtMs => $composableBuilder(
    column: $table.importedAtMs,
    builder: (column) => column,
  );
}

class $$ImportedPuzzlesTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $ImportedPuzzlesTable,
          ImportedPuzzleRow,
          $$ImportedPuzzlesTableFilterComposer,
          $$ImportedPuzzlesTableOrderingComposer,
          $$ImportedPuzzlesTableAnnotationComposer,
          $$ImportedPuzzlesTableCreateCompanionBuilder,
          $$ImportedPuzzlesTableUpdateCompanionBuilder,
          (
            ImportedPuzzleRow,
            BaseReferences<
              _$GameDatabase,
              $ImportedPuzzlesTable,
              ImportedPuzzleRow
            >,
          ),
          ImportedPuzzleRow,
          PrefetchHooks Function()
        > {
  $$ImportedPuzzlesTableTableManager(
    _$GameDatabase db,
    $ImportedPuzzlesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportedPuzzlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportedPuzzlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportedPuzzlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<String> initialBoard = const Value.absent(),
                Value<bool> humanSolverFullySupported = const Value.absent(),
                Value<String> requiredTechniquesJson = const Value.absent(),
                Value<int> importedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportedPuzzlesCompanion(
                profileId: profileId,
                puzzleId: puzzleId,
                initialBoard: initialBoard,
                humanSolverFullySupported: humanSolverFullySupported,
                requiredTechniquesJson: requiredTechniquesJson,
                importedAtMs: importedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                required String puzzleId,
                required String initialBoard,
                required bool humanSolverFullySupported,
                required String requiredTechniquesJson,
                required int importedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => ImportedPuzzlesCompanion.insert(
                profileId: profileId,
                puzzleId: puzzleId,
                initialBoard: initialBoard,
                humanSolverFullySupported: humanSolverFullySupported,
                requiredTechniquesJson: requiredTechniquesJson,
                importedAtMs: importedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImportedPuzzlesTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $ImportedPuzzlesTable,
      ImportedPuzzleRow,
      $$ImportedPuzzlesTableFilterComposer,
      $$ImportedPuzzlesTableOrderingComposer,
      $$ImportedPuzzlesTableAnnotationComposer,
      $$ImportedPuzzlesTableCreateCompanionBuilder,
      $$ImportedPuzzlesTableUpdateCompanionBuilder,
      (
        ImportedPuzzleRow,
        BaseReferences<
          _$GameDatabase,
          $ImportedPuzzlesTable,
          ImportedPuzzleRow
        >,
      ),
      ImportedPuzzleRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$GameDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$GameDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$GameDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $SyncMetadataTable,
          SyncMetadataData,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<
              _$GameDatabase,
              $SyncMetadataTable,
              SyncMetadataData
            >,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$GameDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $SyncMetadataTable,
      SyncMetadataData,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<_$GameDatabase, $SyncMetadataTable, SyncMetadataData>,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxTableCreateCompanionBuilder =
    SyncOutboxCompanion Function({
      required String profileId,
      required String entityType,
      required String entityId,
      Value<int> revision,
      required int createdAtMs,
      Value<int> attemptCount,
      Value<int?> lastAttemptAtMs,
      Value<int> rowid,
    });
typedef $$SyncOutboxTableUpdateCompanionBuilder =
    SyncOutboxCompanion Function({
      Value<String> profileId,
      Value<String> entityType,
      Value<String> entityId,
      Value<int> revision,
      Value<int> createdAtMs,
      Value<int> attemptCount,
      Value<int?> lastAttemptAtMs,
      Value<int> rowid,
    });

class $$SyncOutboxTableFilterComposer
    extends Composer<_$GameDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastAttemptAtMs => $composableBuilder(
    column: $table.lastAttemptAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxTableOrderingComposer
    extends Composer<_$GameDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastAttemptAtMs => $composableBuilder(
    column: $table.lastAttemptAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxTableAnnotationComposer
    extends Composer<_$GameDatabase, $SyncOutboxTable> {
  $$SyncOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemptCount => $composableBuilder(
    column: $table.attemptCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lastAttemptAtMs => $composableBuilder(
    column: $table.lastAttemptAtMs,
    builder: (column) => column,
  );
}

class $$SyncOutboxTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $SyncOutboxTable,
          SyncOutboxData,
          $$SyncOutboxTableFilterComposer,
          $$SyncOutboxTableOrderingComposer,
          $$SyncOutboxTableAnnotationComposer,
          $$SyncOutboxTableCreateCompanionBuilder,
          $$SyncOutboxTableUpdateCompanionBuilder,
          (
            SyncOutboxData,
            BaseReferences<_$GameDatabase, $SyncOutboxTable, SyncOutboxData>,
          ),
          SyncOutboxData,
          PrefetchHooks Function()
        > {
  $$SyncOutboxTableTableManager(_$GameDatabase db, $SyncOutboxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> attemptCount = const Value.absent(),
                Value<int?> lastAttemptAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion(
                profileId: profileId,
                entityType: entityType,
                entityId: entityId,
                revision: revision,
                createdAtMs: createdAtMs,
                attemptCount: attemptCount,
                lastAttemptAtMs: lastAttemptAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                required String entityType,
                required String entityId,
                Value<int> revision = const Value.absent(),
                required int createdAtMs,
                Value<int> attemptCount = const Value.absent(),
                Value<int?> lastAttemptAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxCompanion.insert(
                profileId: profileId,
                entityType: entityType,
                entityId: entityId,
                revision: revision,
                createdAtMs: createdAtMs,
                attemptCount: attemptCount,
                lastAttemptAtMs: lastAttemptAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $SyncOutboxTable,
      SyncOutboxData,
      $$SyncOutboxTableFilterComposer,
      $$SyncOutboxTableOrderingComposer,
      $$SyncOutboxTableAnnotationComposer,
      $$SyncOutboxTableCreateCompanionBuilder,
      $$SyncOutboxTableUpdateCompanionBuilder,
      (
        SyncOutboxData,
        BaseReferences<_$GameDatabase, $SyncOutboxTable, SyncOutboxData>,
      ),
      SyncOutboxData,
      PrefetchHooks Function()
    >;
typedef $$TechniqueContributionsTableCreateCompanionBuilder =
    TechniqueContributionsCompanion Function({
      required String profileId,
      required String techniqueId,
      required String sourceId,
      required int attempts,
      required int correctAttempts,
      required int firstTryCorrect,
      required int independentStreak,
      required int bestIndependentStreak,
      required int directionHintSuccesses,
      required int focusHintSuccesses,
      required int reasoningHintSuccesses,
      required int resultHintSuccesses,
      Value<int?> lastPracticedAtMs,
      Value<int> rowid,
    });
typedef $$TechniqueContributionsTableUpdateCompanionBuilder =
    TechniqueContributionsCompanion Function({
      Value<String> profileId,
      Value<String> techniqueId,
      Value<String> sourceId,
      Value<int> attempts,
      Value<int> correctAttempts,
      Value<int> firstTryCorrect,
      Value<int> independentStreak,
      Value<int> bestIndependentStreak,
      Value<int> directionHintSuccesses,
      Value<int> focusHintSuccesses,
      Value<int> reasoningHintSuccesses,
      Value<int> resultHintSuccesses,
      Value<int?> lastPracticedAtMs,
      Value<int> rowid,
    });

class $$TechniqueContributionsTableFilterComposer
    extends Composer<_$GameDatabase, $TechniqueContributionsTable> {
  $$TechniqueContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
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

  ColumnFilters<int> get bestIndependentStreak => $composableBuilder(
    column: $table.bestIndependentStreak,
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

class $$TechniqueContributionsTableOrderingComposer
    extends Composer<_$GameDatabase, $TechniqueContributionsTable> {
  $$TechniqueContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
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

  ColumnOrderings<int> get bestIndependentStreak => $composableBuilder(
    column: $table.bestIndependentStreak,
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

class $$TechniqueContributionsTableAnnotationComposer
    extends Composer<_$GameDatabase, $TechniqueContributionsTable> {
  $$TechniqueContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get techniqueId => $composableBuilder(
    column: $table.techniqueId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

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

  GeneratedColumn<int> get bestIndependentStreak => $composableBuilder(
    column: $table.bestIndependentStreak,
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

class $$TechniqueContributionsTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $TechniqueContributionsTable,
          TechniqueContribution,
          $$TechniqueContributionsTableFilterComposer,
          $$TechniqueContributionsTableOrderingComposer,
          $$TechniqueContributionsTableAnnotationComposer,
          $$TechniqueContributionsTableCreateCompanionBuilder,
          $$TechniqueContributionsTableUpdateCompanionBuilder,
          (
            TechniqueContribution,
            BaseReferences<
              _$GameDatabase,
              $TechniqueContributionsTable,
              TechniqueContribution
            >,
          ),
          TechniqueContribution,
          PrefetchHooks Function()
        > {
  $$TechniqueContributionsTableTableManager(
    _$GameDatabase db,
    $TechniqueContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TechniqueContributionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TechniqueContributionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TechniqueContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> techniqueId = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> correctAttempts = const Value.absent(),
                Value<int> firstTryCorrect = const Value.absent(),
                Value<int> independentStreak = const Value.absent(),
                Value<int> bestIndependentStreak = const Value.absent(),
                Value<int> directionHintSuccesses = const Value.absent(),
                Value<int> focusHintSuccesses = const Value.absent(),
                Value<int> reasoningHintSuccesses = const Value.absent(),
                Value<int> resultHintSuccesses = const Value.absent(),
                Value<int?> lastPracticedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TechniqueContributionsCompanion(
                profileId: profileId,
                techniqueId: techniqueId,
                sourceId: sourceId,
                attempts: attempts,
                correctAttempts: correctAttempts,
                firstTryCorrect: firstTryCorrect,
                independentStreak: independentStreak,
                bestIndependentStreak: bestIndependentStreak,
                directionHintSuccesses: directionHintSuccesses,
                focusHintSuccesses: focusHintSuccesses,
                reasoningHintSuccesses: reasoningHintSuccesses,
                resultHintSuccesses: resultHintSuccesses,
                lastPracticedAtMs: lastPracticedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                required String techniqueId,
                required String sourceId,
                required int attempts,
                required int correctAttempts,
                required int firstTryCorrect,
                required int independentStreak,
                required int bestIndependentStreak,
                required int directionHintSuccesses,
                required int focusHintSuccesses,
                required int reasoningHintSuccesses,
                required int resultHintSuccesses,
                Value<int?> lastPracticedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TechniqueContributionsCompanion.insert(
                profileId: profileId,
                techniqueId: techniqueId,
                sourceId: sourceId,
                attempts: attempts,
                correctAttempts: correctAttempts,
                firstTryCorrect: firstTryCorrect,
                independentStreak: independentStreak,
                bestIndependentStreak: bestIndependentStreak,
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

typedef $$TechniqueContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $TechniqueContributionsTable,
      TechniqueContribution,
      $$TechniqueContributionsTableFilterComposer,
      $$TechniqueContributionsTableOrderingComposer,
      $$TechniqueContributionsTableAnnotationComposer,
      $$TechniqueContributionsTableCreateCompanionBuilder,
      $$TechniqueContributionsTableUpdateCompanionBuilder,
      (
        TechniqueContribution,
        BaseReferences<
          _$GameDatabase,
          $TechniqueContributionsTable,
          TechniqueContribution
        >,
      ),
      TechniqueContribution,
      PrefetchHooks Function()
    >;
typedef $$DailyCompletionsTableCreateCompanionBuilder =
    DailyCompletionsCompanion Function({
      required String profileId,
      required String challengeKey,
      required String puzzleId,
      required String gameId,
      required int completedAtMs,
      Value<int> rowid,
    });
typedef $$DailyCompletionsTableUpdateCompanionBuilder =
    DailyCompletionsCompanion Function({
      Value<String> profileId,
      Value<String> challengeKey,
      Value<String> puzzleId,
      Value<String> gameId,
      Value<int> completedAtMs,
      Value<int> rowid,
    });

class $$DailyCompletionsTableFilterComposer
    extends Composer<_$GameDatabase, $DailyCompletionsTable> {
  $$DailyCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get challengeKey => $composableBuilder(
    column: $table.challengeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedAtMs => $composableBuilder(
    column: $table.completedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCompletionsTableOrderingComposer
    extends Composer<_$GameDatabase, $DailyCompletionsTable> {
  $$DailyCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
    column: $table.profileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get challengeKey => $composableBuilder(
    column: $table.challengeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedAtMs => $composableBuilder(
    column: $table.completedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCompletionsTableAnnotationComposer
    extends Composer<_$GameDatabase, $DailyCompletionsTable> {
  $$DailyCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get challengeKey => $composableBuilder(
    column: $table.challengeKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get puzzleId =>
      $composableBuilder(column: $table.puzzleId, builder: (column) => column);

  GeneratedColumn<String> get gameId =>
      $composableBuilder(column: $table.gameId, builder: (column) => column);

  GeneratedColumn<int> get completedAtMs => $composableBuilder(
    column: $table.completedAtMs,
    builder: (column) => column,
  );
}

class $$DailyCompletionsTableTableManager
    extends
        RootTableManager<
          _$GameDatabase,
          $DailyCompletionsTable,
          DailyCompletion,
          $$DailyCompletionsTableFilterComposer,
          $$DailyCompletionsTableOrderingComposer,
          $$DailyCompletionsTableAnnotationComposer,
          $$DailyCompletionsTableCreateCompanionBuilder,
          $$DailyCompletionsTableUpdateCompanionBuilder,
          (
            DailyCompletion,
            BaseReferences<
              _$GameDatabase,
              $DailyCompletionsTable,
              DailyCompletion
            >,
          ),
          DailyCompletion,
          PrefetchHooks Function()
        > {
  $$DailyCompletionsTableTableManager(
    _$GameDatabase db,
    $DailyCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<String> challengeKey = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<int> completedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCompletionsCompanion(
                profileId: profileId,
                challengeKey: challengeKey,
                puzzleId: puzzleId,
                gameId: gameId,
                completedAtMs: completedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                required String challengeKey,
                required String puzzleId,
                required String gameId,
                required int completedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => DailyCompletionsCompanion.insert(
                profileId: profileId,
                challengeKey: challengeKey,
                puzzleId: puzzleId,
                gameId: gameId,
                completedAtMs: completedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$GameDatabase,
      $DailyCompletionsTable,
      DailyCompletion,
      $$DailyCompletionsTableFilterComposer,
      $$DailyCompletionsTableOrderingComposer,
      $$DailyCompletionsTableAnnotationComposer,
      $$DailyCompletionsTableCreateCompanionBuilder,
      $$DailyCompletionsTableUpdateCompanionBuilder,
      (
        DailyCompletion,
        BaseReferences<_$GameDatabase, $DailyCompletionsTable, DailyCompletion>,
      ),
      DailyCompletion,
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
  $$DailyLearningFocusesTableTableManager get dailyLearningFocuses =>
      $$DailyLearningFocusesTableTableManager(_db, _db.dailyLearningFocuses);
  $$ImportedPuzzlesTableTableManager get importedPuzzles =>
      $$ImportedPuzzlesTableTableManager(_db, _db.importedPuzzles);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
  $$SyncOutboxTableTableManager get syncOutbox =>
      $$SyncOutboxTableTableManager(_db, _db.syncOutbox);
  $$TechniqueContributionsTableTableManager get techniqueContributions =>
      $$TechniqueContributionsTableTableManager(
        _db,
        _db.techniqueContributions,
      );
  $$DailyCompletionsTableTableManager get dailyCompletions =>
      $$DailyCompletionsTableTableManager(_db, _db.dailyCompletions);
}
