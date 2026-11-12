import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/puzzle/data/content_flags.dart';
import 'package:michi_mobile/features/puzzle/data/drift_content_cache.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_catalog_loader.dart';
import 'package:michi_mobile/features/puzzle/data/local_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/data/published_puzzle_repository.dart';
import 'package:michi_mobile/features/puzzle/data/remote_content_source.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _Source implements RemoteContentSource {
  PublishedRelease? release;
  final Map<String, PuzzleDefinition> puzzles = {};
  final Map<LocalDate, PublishedDailyAssignment> assignments = {};
  bool offline = false;
  int puzzleFetches = 0;

  @override
  Future<PublishedRelease?> latestRelease() async {
    if (offline) throw StateError('offline');
    return release;
  }

  @override
  Future<PuzzleDefinition?> puzzle(String id) async {
    if (offline) throw StateError('offline');
    puzzleFetches++;
    return puzzles[id];
  }

  @override
  Future<PublishedDailyAssignment?> daily(LocalDate date) async {
    if (offline) throw StateError('offline');
    return assignments[date];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GameDatabase database;
  late DriftGameRepository games;
  late DriftContentCache cache;
  late _Source source;
  late ContentFlags flags;
  late PublishedPuzzleRepository repository;
  late LocalPuzzleCatalogLoader loader;

  setUp(() {
    database = GameDatabase(NativeDatabase.memory());
    cache = DriftContentCache(database);
    source = _Source();
    flags = ContentFlags.offline();
    loader = LocalPuzzleCatalogLoader();
    games = DriftGameRepository(database);
    repository = PublishedPuzzleRepository(
      bundled: LocalPuzzleRepository(loader, games),
      remote: source,
      cache: cache,
      games: games,
      flags: flags,
    );
  });
  tearDown(() async => database.close());

  Future<PuzzleDefinition> remotePuzzle() async {
    final base = (await loader.load()).puzzles.first;
    return PuzzleDefinition(
      id: 'remote_easy_1',
      initialBoard: base.initialBoard,
      difficulty: base.difficulty,
      requiredTechniques: base.requiredTechniques,
      contentVersion: 3,
      dailyEligible: true,
      source: PuzzleSource.remote,
    );
  }

  test(
    'published release is cached once and New Puzzle uses shared rotation',
    () async {
      final puzzle = await remotePuzzle();
      source.puzzles[puzzle.id] = puzzle;
      source.release = PublishedRelease(
        id: 'remote_v3',
        version: 3,
        puzzleIds: [puzzle.id],
      );
      await repository.refresh();
      expect((await cache.activePuzzles()).single.id, puzzle.id);
      expect(
        (await repository.selectPuzzle(difficulty: PuzzleDifficulty.easy)).id,
        puzzle.id,
      );
      source.offline = true;
      expect((await repository.getPuzzle(puzzle.id)).id, puzzle.id);
      expect(source.puzzleFetches, 1);
    },
  );

  test(
    'offline first Daily fallback remains locked after remote recovers',
    () async {
      final date = LocalDate(2026, 11, 11);
      source.offline = true;
      final fallback = await repository.getDailyPuzzle(date);
      expect((await cache.daily(date))?.source, 'bundledFallback');
      source.offline = false;
      final puzzle = await remotePuzzle();
      source.puzzles[puzzle.id] = puzzle;
      source.assignments[date] = PublishedDailyAssignment(
        date: date,
        puzzleId: puzzle.id,
        challengeKey: '$date|published:${puzzle.id}',
      );
      final same = await repository.getDailyPuzzle(date);
      expect(same.challengeKey, fallback.challengeKey);
      expect(same.puzzle.id, fallback.puzzle.id);
      expect((await cache.daily(date))?.locked, isTrue);
    },
  );

  test(
    'cached remote Daily stays playable offline and keeps challenge identity',
    () async {
      final date = LocalDate(2026, 11, 11);
      final puzzle = await remotePuzzle();
      source.puzzles[puzzle.id] = puzzle;
      source.assignments[date] = PublishedDailyAssignment(
        date: date,
        puzzleId: puzzle.id,
        challengeKey: '$date|published:${puzzle.id}',
      );
      final first = await repository.getDailyPuzzle(date);
      source.offline = true;
      final second = await repository.getDailyPuzzle(date);
      expect(second.challengeKey, first.challengeKey);
      expect(second.puzzle.id, puzzle.id);
      expect((await cache.daily(date))?.locked, isTrue);
    },
  );

  test('remote content kill switches preserve bundled play', () async {
    flags
      ..remoteContentEnabled = false
      ..dailyRemoteEnabled = false;
    final selected = await repository.selectPuzzle(
      difficulty: PuzzleDifficulty.easy,
    );
    expect(selected.source, PuzzleSource.catalog);
    final daily = await repository.getDailyPuzzle(LocalDate(2026, 11, 11));
    expect(daily.puzzle.source, PuzzleSource.catalog);
  });

  test(
    'malformed published entry does not activate a partial release',
    () async {
      final puzzle = await remotePuzzle();
      source.puzzles[puzzle.id] = puzzle;
      source.release = PublishedRelease(
        id: 'remote_v3',
        version: 3,
        puzzleIds: [puzzle.id, 'malformed'],
      );
      await repository.refresh();
      expect(await cache.activePuzzles(), isEmpty);
      expect(
        (await repository.selectPuzzle(
          difficulty: PuzzleDifficulty.easy,
        )).source,
        PuzzleSource.catalog,
      );
    },
  );

  test('repetition avoidance spans published and bundled puzzles', () async {
    final puzzle = await remotePuzzle();
    source.puzzles[puzzle.id] = puzzle;
    source.release = PublishedRelease(
      id: 'remote_v3',
      version: 3,
      puzzleIds: [puzzle.id],
    );
    await repository.refresh();
    final now = DateTime.utc(2026, 11, 11);
    await games.saveActiveGame(
      StoredGame(
        gameId: 'active-remote',
        puzzleId: puzzle.id,
        initialBoard: puzzle.initialBoard,
        currentBoard: puzzle.initialBoard,
        notes: const {},
        undoHistory: const [],
        mistakes: 0,
        elapsedBeforeRun: Duration.zero,
        runningSince: null,
        startedAt: now,
        updatedAt: now,
        isPaused: true,
        hintsRequested: 0,
        highestHintLevelUsed: 0,
        correctEditableCells: 0,
        editableCells: puzzle.initialBoard.emptyCellCount,
      ),
    );
    expect(
      (await repository.selectPuzzle(difficulty: PuzzleDifficulty.easy)).source,
      PuzzleSource.catalog,
    );
  });

  test('tomorrow has an independent remote assignment', () async {
    final today = LocalDate(2026, 11, 11);
    final tomorrow = LocalDate(2026, 11, 12);
    final puzzle = await remotePuzzle();
    source.puzzles[puzzle.id] = puzzle;
    source.assignments[today] = PublishedDailyAssignment(
      date: today,
      puzzleId: puzzle.id,
      challengeKey: '$today|published:${puzzle.id}',
    );
    source.assignments[tomorrow] = PublishedDailyAssignment(
      date: tomorrow,
      puzzleId: puzzle.id,
      challengeKey: '$tomorrow|published:${puzzle.id}',
    );
    final first = await repository.getDailyPuzzle(today);
    final second = await repository.getDailyPuzzle(tomorrow);
    expect(first.challengeKey, isNot(second.challengeKey));
    expect((await cache.daily(tomorrow))?.locked, isTrue);
  });

  test(
    'cached puzzle ID cannot be silently replaced with another board',
    () async {
      final puzzle = await remotePuzzle();
      await cache.savePuzzle(puzzle, 'remote_v3');
      final changed = PuzzleDefinition(
        id: puzzle.id,
        initialBoard: puzzle.initialBoard.withValue(
          CellRef(row: 0, column: 0),
          0,
        ),
        difficulty: puzzle.difficulty,
        requiredTechniques: puzzle.requiredTechniques,
        contentVersion: puzzle.contentVersion,
        dailyEligible: puzzle.dailyEligible,
        source: PuzzleSource.remote,
      );
      await expectLater(
        cache.savePuzzle(changed, 'remote_v4'),
        throwsFormatException,
      );
      expect(
        (await cache.puzzle(puzzle.id))?.initialBoard,
        puzzle.initialBoard,
      );
    },
  );
}
