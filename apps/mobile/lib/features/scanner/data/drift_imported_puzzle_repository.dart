import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:michi_mobile/features/game/data/game_codec.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class DriftImportedPuzzleRepository implements ImportedPuzzleRepository {
  const DriftImportedPuzzleRepository(this.database);

  final GameDatabase database;

  @override
  Future<void> save(PuzzleDefinition puzzle) async {
    if (puzzle.source != PuzzleSource.imported) {
      throw ArgumentError.value(puzzle.source, 'source');
    }
    await database
        .into(database.importedPuzzles)
        .insert(
          ImportedPuzzlesCompanion.insert(
            puzzleId: puzzle.id,
            initialBoard: GameCodec.board(puzzle.initialBoard),
            humanSolverFullySupported: puzzle.humanSolverFullySupported,
            requiredTechniquesJson: jsonEncode([
              for (final technique in SudokuTechniqueOrder.supported)
                if (puzzle.requiredTechniques.contains(technique))
                  technique.name,
            ]),
            importedAtMs: DateTime.now().millisecondsSinceEpoch,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  @override
  Future<PuzzleDefinition?> load(String id) async {
    final row = await (database.select(
      database.importedPuzzles,
    )..where((table) => table.puzzleId.equals(id))).getSingleOrNull();
    if (row == null) return null;
    final names = (jsonDecode(row.requiredTechniquesJson) as List<dynamic>)
        .cast<String>();
    return PuzzleDefinition(
      id: row.puzzleId,
      initialBoard: GameCodec.parseBoard(row.initialBoard),
      difficulty: null,
      requiredTechniques: names.map(SudokuTechnique.values.byName),
      contentVersion: 1,
      dailyEligible: false,
      source: PuzzleSource.imported,
      humanSolverFullySupported: row.humanSolverFullySupported,
    );
  }
}
