import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';

final class PublishedRelease {
  PublishedRelease({
    required this.id,
    required this.version,
    required Iterable<String> puzzleIds,
  }) : puzzleIds = List<String>.unmodifiable(puzzleIds);

  final String id;
  final int version;
  final List<String> puzzleIds;
}

final class PublishedDailyAssignment {
  const PublishedDailyAssignment({
    required this.date,
    required this.puzzleId,
    required this.challengeKey,
  });

  final LocalDate date;
  final String puzzleId;
  final String challengeKey;
}

/// Transport-neutral boundary. Firestore documents never reach app features.
abstract interface class RemoteContentSource {
  Future<PublishedRelease?> latestRelease();

  Future<PuzzleDefinition?> puzzle(String id);

  Future<PublishedDailyAssignment?> daily(LocalDate date);
}
