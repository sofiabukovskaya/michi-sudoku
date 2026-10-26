import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'game_database.g.dart';

class ActiveGames extends Table {
  IntColumn get slot => integer()();
  TextColumn get gameId => text()();
  TextColumn get puzzleId => text()();
  TextColumn get initialBoard => text()();
  TextColumn get currentBoard => text()();
  TextColumn get notesJson => text()();
  TextColumn get undoJson => text()();
  IntColumn get mistakes => integer()();
  IntColumn get elapsedMs => integer()();
  IntColumn get runningSinceMs => integer().nullable()();
  IntColumn get startedAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isPaused => boolean()();
  IntColumn get hintsRequested => integer()();
  IntColumn get highestHintLevelUsed => integer()();
  IntColumn get correctEditableCells => integer()();
  IntColumn get editableCells => integer()();

  @override
  Set<Column> get primaryKey => {slot};
}

@DataClassName('CompletedGameRow')
class CompletedGames extends Table {
  TextColumn get gameId => text()();
  TextColumn get puzzleId => text()();
  TextColumn get initialBoard => text()();
  TextColumn get completedBoard => text()();
  IntColumn get startedAtMs => integer()();
  IntColumn get completedAtMs => integer()();
  IntColumn get elapsedMs => integer()();
  IntColumn get mistakes => integer()();
  IntColumn get hintsRequested => integer()();
  IntColumn get highestHintLevelUsed => integer()();

  @override
  Set<Column> get primaryKey => {gameId};
}

@DriftDatabase(tables: [ActiveGames, CompletedGames])
final class GameDatabase extends _$GameDatabase {
  GameDatabase(super.e);

  factory GameDatabase.open() =>
      GameDatabase(driftDatabase(name: 'michi_games'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    // Future schema versions get explicit, non-destructive steps here.
    onUpgrade: (migrator, from, to) async {
      throw StateError('No migration registered from $from to $to.');
    },
  );
}
