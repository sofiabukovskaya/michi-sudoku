import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';

abstract interface class PuzzleRepository {
  Future<PuzzleDefinition> getPuzzle(String id);

  Future<PuzzleDefinition> selectPuzzle({
    required PuzzleDifficulty difficulty,
  });

  Future<DailyPuzzle> getDailyPuzzle(LocalDate date);
}
