import 'dart:convert';

import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Compact, deterministic storage format. Board strings contain 81 digits;
/// notes map zero-based cell indexes to nine-bit CandidateMask values.
abstract final class GameCodec {
  static String board(SudokuBoard value) => value.values.join();

  static SudokuBoard parseBoard(String value) => SudokuBoard.parse(value);

  static String notes(Map<CellRef, CandidateMask> value) {
    final cells = value.keys.toList()
      ..sort((left, right) => left.index.compareTo(right.index));
    return jsonEncode({
      for (final cell in cells) '${cell.index}': value[cell]!.bits,
    });
  }

  static Map<CellRef, CandidateMask> parseNotes(
    String value,
    SudokuBoard board,
  ) {
    final decoded = jsonDecode(value);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected a notes object.');
    }
    final result = <CellRef, CandidateMask>{};
    for (final entry in decoded.entries) {
      final index = int.tryParse(entry.key);
      if (index == null || index < 0 || index > 80 || entry.value is! int) {
        throw const FormatException('Invalid note cell or mask.');
      }
      final cell = CellRef.fromIndex(index);
      if (board.isFilled(cell)) {
        throw const FormatException('Notes cannot belong to a filled cell.');
      }
      final mask = CandidateMask(entry.value as int);
      if (mask.isEmpty) {
        throw const FormatException('Empty note masks are not stored.');
      }
      result[cell] = mask;
    }
    return result;
  }

  static String history(List<StoredGameSnapshot> snapshots) => jsonEncode([
    for (final snapshot in snapshots)
      {
        'board': board(snapshot.board),
        'notes': notes(snapshot.notes),
        'why': reasoning(snapshot.reasoning),
      },
  ]);

  static String reasoning(Map<CellRef, MoveReasoningContext> value) {
    final cells = value.keys.toList()
      ..sort((left, right) => left.index.compareTo(right.index));
    return jsonEncode({
      for (final cell in cells)
        '${cell.index}': {
          'board': board(value[cell]!.preMoveBoard),
          'digit': value[cell]!.digit,
          'technique': value[cell]!.technique.name,
          'source': value[cell]!.source.name,
        },
    });
  }

  static Map<CellRef, MoveReasoningContext> parseReasoning(
    String raw,
    SudokuBoard currentBoard,
  ) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic> || decoded.length > 81) {
      throw const FormatException('Invalid Why context.');
    }
    final result = <CellRef, MoveReasoningContext>{};
    for (final entry in decoded.entries) {
      final index = int.tryParse(entry.key);
      final value = entry.value;
      if (index == null ||
          index < 0 ||
          index > 80 ||
          value is! Map<String, dynamic>) {
        throw const FormatException('Invalid Why cell.');
      }
      final cell = CellRef.fromIndex(index);
      final source = value['board'];
      final digit = value['digit'];
      final technique = value['technique'];
      final origin = value['source'];
      if (source is! String ||
          digit is! int ||
          digit < 1 ||
          digit > 9 ||
          technique is! String ||
          origin is! String ||
          currentBoard.valueAt(cell) != digit) {
        throw const FormatException('Invalid Why placement.');
      }
      final preMoveBoard = parseBoard(source);
      if (preMoveBoard.isFilled(cell)) {
        throw const FormatException('Why target must be empty before move.');
      }
      if (!SudokuTechnique.values.any((item) => item.name == technique) ||
          !MoveReasoningSource.values.any((item) => item.name == origin)) {
        throw const FormatException('Unknown Why metadata.');
      }
      result[cell] = MoveReasoningContext(
        preMoveBoard: preMoveBoard,
        cell: cell,
        digit: digit,
        technique: SudokuTechnique.values.byName(technique),
        source: MoveReasoningSource.values.byName(origin),
      );
    }
    return Map<CellRef, MoveReasoningContext>.unmodifiable(result);
  }

  /// Why is optional educational metadata. A damaged record must not make an
  /// otherwise usable saved game disappear.
  static Map<CellRef, MoveReasoningContext> parseReasoningOrEmpty(
    String raw,
    SudokuBoard board,
  ) {
    try {
      return parseReasoning(raw, board);
    } on FormatException {
      return const {};
    }
  }

  static String techniqueHelp(Map<SudokuTechnique, int> value) {
    for (final level in value.values) {
      if (level < 1 || level > 4) {
        throw const FormatException('Invalid Coach level.');
      }
    }
    return jsonEncode({
      for (final technique in SudokuTechnique.values)
        if (value.containsKey(technique)) technique.name: value[technique],
    });
  }

  static Map<SudokuTechnique, int> parseTechniqueHelp(String value) {
    final decoded = jsonDecode(value);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid technique help record.');
    }
    final result = <SudokuTechnique, int>{};
    for (final entry in decoded.entries) {
      final technique = SudokuTechnique.values.byName(entry.key);
      final level = entry.value;
      if (level is! int || level < 1 || level > 4) {
        throw const FormatException('Invalid Coach level.');
      }
      result[technique] = level;
    }
    return Map<SudokuTechnique, int>.unmodifiable(result);
  }

  static List<StoredGameSnapshot> parseHistory(String value) {
    final decoded = jsonDecode(value);
    if (decoded is! List<dynamic> || decoded.length > 100) {
      throw const FormatException('Invalid undo history.');
    }
    return [
      for (final entry in decoded)
        if (entry case {
          'board': final String source,
          'notes': final String raw,
        })
          StoredGameSnapshot(
            board: parseBoard(source),
            notes: parseNotes(raw, parseBoard(source)),
            reasoning: parseReasoningOrEmpty(
              entry is Map<String, dynamic> && entry['why'] is String
                  ? entry['why'] as String
                  : '{}',
              parseBoard(source),
            ),
          )
        else
          throw const FormatException('Invalid undo snapshot.'),
    ];
  }

  static void validate(StoredGame game) {
    if (game.gameId.isEmpty || game.puzzleId.isEmpty) {
      throw const FormatException('Missing game identity.');
    }
    if (game.mistakes < 0 ||
        game.elapsedBeforeRun.isNegative ||
        game.hintsRequested < 0 ||
        game.highestHintLevelUsed < 0 ||
        game.highestHintLevelUsed > 4 ||
        game.editableCells != game.initialBoard.emptyCellCount ||
        game.correctEditableCells < 0 ||
        game.correctEditableCells > game.editableCells ||
        game.undoHistory.length > 100 ||
        game.isPaused != (game.runningSince == null)) {
      throw const FormatException('Incoherent stored game state.');
    }
    _checkGivens(game.initialBoard, game.currentBoard);
    for (final snapshot in game.undoHistory) {
      _checkGivens(game.initialBoard, snapshot.board);
    }
    parseNotes(notes(game.notes), game.currentBoard);
    parseReasoning(reasoning(game.reasoning), game.currentBoard);
    for (final snapshot in game.undoHistory) {
      parseReasoning(reasoning(snapshot.reasoning), snapshot.board);
    }
    techniqueHelp(game.techniqueHelp);
  }

  static void _checkGivens(SudokuBoard givens, SudokuBoard board) {
    for (var index = 0; index < 81; index++) {
      final cell = CellRef.fromIndex(index);
      if (givens.isFilled(cell) &&
          givens.valueAt(cell) != board.valueAt(cell)) {
        throw const FormatException('A given cell was changed.');
      }
    }
  }
}
