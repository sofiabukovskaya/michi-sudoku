import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';

final class DailyPuzzle {
  const DailyPuzzle({
    required this.date,
    required this.challengeKey,
    required this.puzzle,
  });

  final LocalDate date;
  final String challengeKey;
  final PuzzleDefinition puzzle;
}
