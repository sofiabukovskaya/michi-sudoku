import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';

final class PuzzleCatalog {
  PuzzleCatalog({
    required this.version,
    required Iterable<PuzzleDefinition> puzzles,
  }) : puzzles = List<PuzzleDefinition>.unmodifiable(puzzles) {
    if (version < 1 || this.puzzles.isEmpty) {
      throw const FormatException('Catalog needs a version and puzzles.');
    }
    final ids = this.puzzles.map((puzzle) => puzzle.id).toSet();
    if (ids.length != this.puzzles.length ||
        this.puzzles.any((puzzle) => puzzle.contentVersion != version)) {
      throw const FormatException('Duplicate IDs or conflicting versions.');
    }
  }

  final int version;
  final List<PuzzleDefinition> puzzles;

  PuzzleDefinition? puzzleById(String id) =>
      puzzles.where((puzzle) => puzzle.id == id).firstOrNull;

  List<PuzzleDefinition> puzzlesByDifficulty(PuzzleDifficulty difficulty) =>
      List<PuzzleDefinition>.unmodifiable(
        puzzles.where((puzzle) => puzzle.difficulty == difficulty),
      );

  List<PuzzleDefinition> get dailyEligible =>
      List<PuzzleDefinition>.unmodifiable(
        puzzles.where((puzzle) => puzzle.dailyEligible),
      );
}
