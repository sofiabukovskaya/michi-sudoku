import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

abstract interface class TechniqueProgressRepository {
  Future<TechniqueProgress> load(SudokuTechnique technique);

  Future<Map<SudokuTechnique, TechniqueProgress>> loadAll();

  /// Persists one submitted answer atomically and returns the new aggregate.
  Future<TechniqueProgress> recordCheck({
    required SudokuTechnique technique,
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  });
}
