import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('bundled production pack is valid and fully coachable', () async {
    final catalog = await LocalPuzzleCatalogLoader().load();
    expect(catalog.version, 3);
    expect(
      catalog.puzzles.map((puzzle) => puzzle.id).toSet(),
      hasLength(catalog.puzzles.length),
    );
    expect(
      catalog.puzzles.map((puzzle) => puzzle.initialBoard).toSet(),
      hasLength(catalog.puzzles.length),
      reason: 'every puzzle is a different board',
    );
    // The original launch pack keeps its IDs, so saved games still match.
    expect(catalog.puzzleById('classic_easy_0001'), isNotNull);
    expect(catalog.puzzleById('classic_expert_0003'), isNotNull);
    for (final difficulty in PuzzleDifficulty.values) {
      expect(
        catalog.puzzlesByDifficulty(difficulty).length,
        greaterThanOrEqualTo(
          difficulty == PuzzleDifficulty.expert ? 100 : 500,
        ),
        reason: difficulty.name,
      );
    }
    expect(
      catalog.dailyEligible.every(
        (puzzle) => puzzle.difficulty != PuzzleDifficulty.expert,
      ),
      isTrue,
    );

    const analyzer = PuzzleAnalyzer(
      BacktrackingExactSolver(),
      DeterministicHumanSolver(),
    );
    for (final puzzle in catalog.puzzles) {
      final analysis = analyzer.analyze(puzzle.initialBoard);
      expect(analysis.isProductionReady, isTrue, reason: puzzle.id);
      expect(
        analysis.requiredTechniques,
        puzzle.requiredTechniques,
        reason: puzzle.id,
      );
      expect(analysis.difficulty, puzzle.difficulty, reason: puzzle.id);
      expect(
        analysis.humanResult!.status,
        HumanSolveStatus.solved,
        reason: puzzle.id,
      );
      expect(catalog.puzzleById(puzzle.id), same(puzzle));
    }
  });

  test('catalog rejects malformed schema and IDs', () {
    expect(() => LocalPuzzleCatalogLoader.parse('{}'), throwsFormatException);
    final board = List.filled(81, '0').join();
    final entry =
        '{"id":"a","board":"$board","difficulty":"easy",'
        '"requiredTechniques":["nakedSingle"],"dailyEligible":true}';
    expect(
      () => LocalPuzzleCatalogLoader.parse(
        '{"version":1,"puzzles":[$entry,$entry]}',
      ),
      throwsFormatException,
    );
    final invalidTechnique = entry.replaceFirst('nakedSingle', 'fake');
    expect(
      () => LocalPuzzleCatalogLoader.parse(
        '{"version":1,"puzzles":[$invalidTechnique]}',
      ),
      throwsFormatException,
    );
  });
}
