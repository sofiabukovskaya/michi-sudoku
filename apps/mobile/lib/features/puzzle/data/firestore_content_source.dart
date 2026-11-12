import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/features/puzzle/data/remote_content_source.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class FirestoreContentSource implements RemoteContentSource {
  const FirestoreContentSource(this.runtime);

  final FirebaseRuntime runtime;

  Future<FirebaseFirestore?> get _store async =>
      await runtime.ready ? runtime.firestore : null;

  @override
  Future<PublishedRelease?> latestRelease() async {
    final store = await _store;
    if (store == null) return null;
    final rows = await store
        .collection('contentReleases')
        .where('status', isEqualTo: 'published')
        .orderBy('publishedAt', descending: true)
        .limit(1)
        .get();
    if (rows.docs.isEmpty) return null;
    final row = rows.docs.single;
    final data = row.data();
    final ids = data['puzzleIds'];
    if (data['contentVersion'] is! int ||
        ids is! List<dynamic> ||
        ids.isEmpty ||
        ids.any((id) => id is! String || id.isEmpty)) {
      return null;
    }
    return PublishedRelease(
      id: row.id,
      version: data['contentVersion'] as int,
      puzzleIds: ids.cast<String>(),
    );
  }

  @override
  Future<PuzzleDefinition?> puzzle(String id) async {
    final store = await _store;
    if (store == null) return null;
    final row = await store.collection('puzzles').doc(id).get();
    final data = row.data();
    if (data == null || data['status'] != 'published') return null;
    try {
      final board = data['board'];
      final difficulty = data['difficulty'];
      final version = data['contentVersion'];
      final techniques = data['requiredTechniques'];
      final eligible = data['dailyEligible'];
      if (board is! String ||
          difficulty is! String ||
          version is! int ||
          techniques is! List<dynamic> ||
          eligible is! bool ||
          techniques.any((item) => item is! String)) {
        return null;
      }
      final puzzle = PuzzleDefinition(
        id: row.id,
        initialBoard: SudokuBoard.parse(board),
        difficulty: PuzzleDifficulty.values.byName(difficulty),
        requiredTechniques: techniques.cast<String>().map(
          SudokuTechnique.values.byName,
        ),
        contentVersion: version,
        dailyEligible: eligible,
        source: PuzzleSource.remote,
      );
      return SudokuConstraints.validate(puzzle.initialBoard).isValid
          ? puzzle
          : null;
    } on Object {
      return null;
    }
  }

  @override
  Future<PublishedDailyAssignment?> daily(LocalDate date) async {
    final store = await _store;
    if (store == null) return null;
    final row = await store.collection('dailyChallenges').doc('$date').get();
    final data = row.data();
    if (data == null || data['status'] != 'published') return null;
    final puzzleId = data['puzzleId'];
    final challengeKey = data['challengeKey'];
    if (puzzleId is! String ||
        puzzleId.isEmpty ||
        challengeKey is! String ||
        challengeKey.isEmpty) {
      return null;
    }
    return PublishedDailyAssignment(
      date: date,
      puzzleId: puzzleId,
      challengeKey: challengeKey,
    );
  }
}
