import 'dart:convert';

import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';

/// Offline selection. Editorial order is the deterministic normal rotation.
final class LocalPuzzleRepository implements PuzzleRepository {
  const LocalPuzzleRepository(this.loader, this.games);

  final LocalPuzzleCatalogLoader loader;
  final GameRepository games;

  @override
  Future<PuzzleDefinition> getPuzzle(String id) async {
    final puzzle = (await loader.load()).puzzleById(id);
    if (puzzle == null) throw StateError('Unknown puzzle: $id');
    return puzzle;
  }

  @override
  Future<PuzzleDefinition> selectPuzzle({
    required PuzzleDifficulty difficulty,
  }) async {
    final options =
        (await loader.load()).puzzlesByDifficulty(difficulty).toList()
          ..sort((a, b) => a.id.compareTo(b.id));
    if (options.isEmpty) {
      throw StateError('No ${difficulty.name} puzzles in bundled catalog.');
    }
    final activeId = (await games.loadActiveSummary())?.puzzleId;
    final recent = await games.recentCompletedPuzzleIds();
    final recentIds = recent.toSet();
    for (final puzzle in options) {
      if (puzzle.id != activeId && !recentIds.contains(puzzle.id)) {
        return puzzle;
      }
    }
    // Exhausted: prefer a non-active puzzle least recently completed.
    final available = options.where((puzzle) => puzzle.id != activeId).toList();
    final pool = (available.isEmpty ? options : available)
      ..sort((a, b) {
        final aRecency = recent.indexOf(a.id);
        final bRecency = recent.indexOf(b.id);
        final aRank = aRecency < 0 ? 1 << 30 : aRecency;
        final bRank = bRecency < 0 ? 1 << 30 : bRecency;
        final order = bRank.compareTo(aRank);
        return order == 0 ? a.id.compareTo(b.id) : order;
      });
    return pool.first;
  }

  @override
  Future<DailyPuzzle> getDailyPuzzle(LocalDate date) async {
    final catalog = await loader.load();
    final eligible = catalog.dailyEligible.toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    if (eligible.isEmpty) {
      throw StateError('Bundled catalog has no Daily puzzles.');
    }
    final key = '$date|catalog-v${catalog.version}';
    return DailyPuzzle(
      date: date,
      challengeKey: key,
      puzzle: eligible[stableHash(key) % eligible.length],
    );
  }

  /// FNV-1a over UTF-8, constrained to unsigned 32-bit arithmetic.
  static int stableHash(String value) {
    var hash = 0x811c9dc5;
    for (final byte in utf8.encode(value)) {
      hash = ((hash ^ byte) * 0x01000193) & 0xffffffff;
    }
    return hash;
  }
}
