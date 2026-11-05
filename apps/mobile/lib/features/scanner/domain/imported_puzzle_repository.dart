import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';

abstract interface class ImportedPuzzleRepository {
  Future<void> save(PuzzleDefinition puzzle);

  Future<PuzzleDefinition?> load(String id);
}
