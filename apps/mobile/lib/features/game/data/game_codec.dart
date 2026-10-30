import 'dart:convert';

import 'package:michi_mobile/features/game/domain/game_repository.dart';
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
      {'board': board(snapshot.board), 'notes': notes(snapshot.notes)},
  ]);

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
