import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/puzzle/data/remote_content_source.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class CachedDaily {
  const CachedDaily(this.assignment, this.source, {required this.locked});

  final PublishedDailyAssignment assignment;
  final String source;
  final bool locked;
}

/// Global, installation-wide published content; never keyed by account UID.
final class DriftContentCache {
  const DriftContentCache(this.database);

  final GameDatabase database;

  Future<PuzzleDefinition?> puzzle(String id) async {
    final row = await (database.select(
      database.remotePuzzles,
    )..where((table) => table.puzzleId.equals(id))).getSingleOrNull();
    if (row == null) return null;
    try {
      return PuzzleDefinition(
        id: row.puzzleId,
        initialBoard: SudokuBoard.parse(row.board),
        difficulty: PuzzleDifficulty.values.byName(row.difficulty),
        requiredTechniques:
            (jsonDecode(row.requiredTechniquesJson) as List<dynamic>)
                .cast<String>()
                .map(SudokuTechnique.values.byName),
        contentVersion: row.contentVersion,
        dailyEligible: row.dailyEligible,
        source: PuzzleSource.remote,
      );
    } on Object {
      return null;
    }
  }

  Future<void> savePuzzle(PuzzleDefinition puzzle, String releaseId) async {
    final prior = await this.puzzle(puzzle.id);
    if (prior != null &&
        (prior.initialBoard != puzzle.initialBoard ||
            prior.difficulty != puzzle.difficulty ||
            prior.contentVersion != puzzle.contentVersion ||
            prior.dailyEligible != puzzle.dailyEligible ||
            !prior.requiredTechniques.containsAll(puzzle.requiredTechniques) ||
            !puzzle.requiredTechniques.containsAll(prior.requiredTechniques))) {
      throw FormatException('Immutable remote puzzle conflict: ${puzzle.id}');
    }
    await database
        .into(database.remotePuzzles)
        .insertOnConflictUpdate(
          RemotePuzzlesCompanion.insert(
            puzzleId: puzzle.id,
            releaseId: releaseId,
            board: puzzle.initialBoard.values.join(),
            difficulty: puzzle.difficulty!.name,
            requiredTechniquesJson: jsonEncode(
              puzzle.requiredTechniques.map((item) => item.name).toList()
                ..sort(),
            ),
            contentVersion: puzzle.contentVersion,
            dailyEligible: puzzle.dailyEligible,
            fetchedAtMs: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  Future<PublishedRelease?> release(String id) async {
    final row = await (database.select(
      database.remoteContentReleases,
    )..where((table) => table.releaseId.equals(id))).getSingleOrNull();
    if (row == null || row.status != 'published') return null;
    return PublishedRelease(
      id: id,
      version: row.contentVersion,
      puzzleIds: (jsonDecode(row.puzzleIdsJson) as List<dynamic>)
          .cast<String>(),
    );
  }

  Future<void> saveRelease(PublishedRelease release) =>
      database.transaction(() async {
        await database
            .update(database.remoteContentReleases)
            .write(
              const RemoteContentReleasesCompanion(status: Value('retired')),
            );
        await database
            .into(database.remoteContentReleases)
            .insertOnConflictUpdate(
              RemoteContentReleasesCompanion.insert(
                releaseId: release.id,
                contentVersion: release.version,
                status: 'published',
                puzzleIdsJson: jsonEncode(release.puzzleIds),
                fetchedAtMs: DateTime.now().millisecondsSinceEpoch,
              ),
            );
      });

  Future<List<PuzzleDefinition>> activePuzzles() async {
    final releases = await (database.select(
      database.remoteContentReleases,
    )..where((table) => table.status.equals('published'))).get();
    if (releases.isEmpty) return [];
    releases.sort((a, b) {
      final version = b.contentVersion.compareTo(a.contentVersion);
      return version != 0 ? version : b.fetchedAtMs.compareTo(a.fetchedAtMs);
    });
    final ids = (jsonDecode(releases.first.puzzleIdsJson) as List<dynamic>)
        .cast<String>();
    final puzzles = await Future.wait(ids.map(puzzle));
    return puzzles.whereType<PuzzleDefinition>().toList();
  }

  Future<CachedDaily?> daily(LocalDate date) async {
    final row = await (database.select(
      database.dailyChallengeCache,
    )..where((table) => table.localDate.equals('$date'))).getSingleOrNull();
    if (row == null) return null;
    return CachedDaily(
      PublishedDailyAssignment(
        date: date,
        puzzleId: row.puzzleId,
        challengeKey: row.challengeKey,
      ),
      row.source,
      locked: row.locked,
    );
  }

  /// First assignment wins. Prefetched remote assignments may be locked later.
  Future<CachedDaily> saveDaily(
    PublishedDailyAssignment assignment, {
    required String source,
    required bool lock,
  }) async {
    await database
        .into(database.dailyChallengeCache)
        .insert(
          DailyChallengeCacheCompanion.insert(
            localDate: '${assignment.date}',
            challengeKey: assignment.challengeKey,
            puzzleId: assignment.puzzleId,
            source: source,
            locked: lock,
            fetchedAtMs: DateTime.now().millisecondsSinceEpoch,
          ),
          mode: InsertMode.insertOrIgnore,
        );
    if (lock) {
      await (database.update(database.dailyChallengeCache)
            ..where((table) => table.localDate.equals('${assignment.date}')))
          .write(const DailyChallengeCacheCompanion(locked: Value(true)));
    }
    return (await daily(assignment.date))!;
  }

  Future<void> discardUnusablePrefetch(LocalDate date) =>
      (database.delete(database.dailyChallengeCache)..where(
            (table) =>
                table.localDate.equals('$date') & table.locked.equals(false),
          ))
          .go();
}
