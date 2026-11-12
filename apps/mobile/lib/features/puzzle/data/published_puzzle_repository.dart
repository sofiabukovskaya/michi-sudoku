import 'dart:async';
import 'dart:developer' as developer;

import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/puzzle/data/content_flags.dart';
import 'package:michi_mobile/features/puzzle/data/drift_content_cache.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/data/remote_content_source.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';

/// Combines an always-available bundled catalog with validated published data.
final class PublishedPuzzleRepository implements PuzzleRepository {
  PublishedPuzzleRepository({
    required this.bundled,
    required this.remote,
    required this.cache,
    required this.games,
    required this.flags,
  });

  final LocalPuzzleRepository bundled;
  final RemoteContentSource remote;
  final DriftContentCache cache;
  final GameRepository games;
  final ContentFlags flags;

  Future<void>? _refreshing;
  DateTime? _lastRefresh;

  Future<void> refresh({bool force = false}) {
    final active = _refreshing;
    if (active != null) return active;
    final last = _lastRefresh;
    if (!force &&
        last != null &&
        DateTime.now().difference(last) < const Duration(hours: 6)) {
      return Future<void>.value();
    }
    final result = _refresh();
    _refreshing = result;
    return result.whenComplete(() => _refreshing = null);
  }

  Future<void> _refresh() async {
    await flags.refresh();
    if (!flags.remoteContentEnabled) return;
    try {
      final release = await remote.latestRelease().timeout(
        const Duration(seconds: 3),
      );
      if (release == null) return;
      if (await cache.release(release.id) == null) {
        for (final id in release.puzzleIds) {
          final puzzle = await remote
              .puzzle(id)
              .timeout(const Duration(seconds: 3));
          if (puzzle == null || puzzle.contentVersion != release.version) {
            throw FormatException('Unusable published puzzle $id');
          }
          await cache.savePuzzle(puzzle, release.id);
        }
        await cache.saveRelease(release);
      }
      _lastRefresh = DateTime.now();
    } on Object catch (error, stack) {
      developer.log(
        'Published content refresh failed',
        name: 'michi.content',
        error: error,
        stackTrace: stack,
      );
    }
  }

  @override
  Future<PuzzleDefinition> getPuzzle(String id) async {
    final cached = await cache.puzzle(id);
    if (cached != null) return cached;
    final local = (await bundled.loader.load()).puzzleById(id);
    if (local != null) return local;
    if (flags.remoteContentEnabled) {
      final fetched = await remote
          .puzzle(id)
          .timeout(const Duration(seconds: 3));
      if (fetched != null) {
        await cache.savePuzzle(fetched, 'direct');
        return fetched;
      }
    }
    throw StateError('Unknown puzzle: $id');
  }

  @override
  Future<PuzzleDefinition> selectPuzzle({
    required PuzzleDifficulty difficulty,
  }) async {
    unawaited(refresh());
    final local = (await bundled.loader.load()).puzzlesByDifficulty(difficulty);
    final published = flags.remoteContentEnabled
        ? (await cache.activePuzzles()).where(
            (puzzle) => puzzle.difficulty == difficulty,
          )
        : const <PuzzleDefinition>[];
    final options = [...published, ...local];
    final activeId = (await games.loadActiveSummary())?.puzzleId;
    final recent = await games.recentCompletedPuzzleIds();
    final recentIds = recent.toSet();
    for (final puzzle in options) {
      if (puzzle.id != activeId && !recentIds.contains(puzzle.id)) {
        return puzzle;
      }
    }
    final available = options.where((puzzle) => puzzle.id != activeId).toList();
    final pool = available.isEmpty ? options : available;
    return (pool..sort((a, b) {
          final aRank = recent.indexOf(a.id);
          final bRank = recent.indexOf(b.id);
          final order = bRank.compareTo(aRank);
          return order == 0 ? a.id.compareTo(b.id) : order;
        }))
        .first;
  }

  @override
  Future<DailyPuzzle> getDailyPuzzle(LocalDate date) async {
    final existing = await cache.daily(date);
    if (existing != null) {
      final puzzle = await _puzzleFor(existing.assignment.puzzleId);
      if (puzzle != null) {
        if (!existing.locked) {
          await cache.saveDaily(
            existing.assignment,
            source: existing.source,
            lock: true,
          );
        }
        return DailyPuzzle(
          date: date,
          challengeKey: existing.assignment.challengeKey,
          puzzle: puzzle,
        );
      }
      if (existing.locked) {
        throw StateError(
          'Locked Daily puzzle is unavailable: ${existing.assignment.puzzleId}',
        );
      }
      await cache.discardUnusablePrefetch(date);
    }
    if (flags.remoteContentEnabled && flags.dailyRemoteEnabled) {
      try {
        final assignment = await remote
            .daily(date)
            .timeout(const Duration(seconds: 3));
        if (assignment != null) {
          final puzzle = await _puzzleFor(assignment.puzzleId);
          if (puzzle != null) {
            final saved = await cache.saveDaily(
              assignment,
              source: 'remotePublished',
              lock: true,
            );
            unawaited(_prefetch(date));
            return DailyPuzzle(
              date: date,
              challengeKey: saved.assignment.challengeKey,
              puzzle: await _puzzleFor(saved.assignment.puzzleId) ?? puzzle,
            );
          }
        }
      } on Object catch (error, stack) {
        developer.log(
          'Daily fetch failed',
          name: 'michi.daily',
          error: error,
          stackTrace: stack,
        );
      }
    }
    final fallback = await bundled.getDailyPuzzle(date);
    final saved = await cache.saveDaily(
      PublishedDailyAssignment(
        date: date,
        puzzleId: fallback.puzzle.id,
        challengeKey: fallback.challengeKey,
      ),
      source: 'bundledFallback',
      lock: true,
    );
    return DailyPuzzle(
      date: date,
      challengeKey: saved.assignment.challengeKey,
      puzzle: await _puzzleFor(saved.assignment.puzzleId) ?? fallback.puzzle,
    );
  }

  Future<PuzzleDefinition?> _puzzleFor(String id) async {
    final cached = await cache.puzzle(id);
    if (cached != null) return cached;
    final local = (await bundled.loader.load()).puzzleById(id);
    if (local != null) return local;
    try {
      final fetched = await remote
          .puzzle(id)
          .timeout(const Duration(seconds: 3));
      if (fetched != null) await cache.savePuzzle(fetched, 'daily');
      return fetched;
    } on Object {
      return null;
    }
  }

  Future<void> _prefetch(LocalDate date) async {
    for (var offset = 1; offset <= flags.dailyFutureCacheDays; offset++) {
      try {
        final future = LocalDate.fromDateTime(
          DateTime(date.year, date.month, date.day + offset),
        );
        if (await cache.daily(future) != null) continue;
        final assignment = await remote.daily(future);
        if (assignment == null ||
            await _puzzleFor(assignment.puzzleId) == null) {
          continue;
        }
        await cache.saveDaily(assignment, source: 'cachedRemote', lock: false);
      } on Object {
        return;
      }
    }
  }
}
