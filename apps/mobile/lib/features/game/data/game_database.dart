import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'game_database.g.dart';

class ActiveGames extends Table {
  IntColumn get slot => integer()();
  TextColumn get gameId => text()();
  TextColumn get puzzleId => text()();
  TextColumn get dailyChallengeKey => text().nullable()();
  TextColumn get initialBoard => text()();
  TextColumn get currentBoard => text()();
  TextColumn get notesJson => text()();
  TextColumn get undoJson => text()();
  TextColumn get reasoningJson => text().withDefault(const Constant('{}'))();
  IntColumn get mistakes => integer()();
  IntColumn get elapsedMs => integer()();
  IntColumn get runningSinceMs => integer().nullable()();
  IntColumn get startedAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isPaused => boolean()();
  IntColumn get hintsRequested => integer()();
  IntColumn get highestHintLevelUsed => integer()();
  TextColumn get techniqueHelpJson =>
      text().withDefault(const Constant('{}'))();
  IntColumn get correctEditableCells => integer()();
  IntColumn get editableCells => integer()();

  @override
  Set<Column> get primaryKey => {slot};
}

@DataClassName('CompletedGameRow')
class CompletedGames extends Table {
  TextColumn get gameId => text()();
  TextColumn get puzzleId => text()();
  TextColumn get dailyChallengeKey => text().nullable()();
  TextColumn get initialBoard => text()();
  TextColumn get completedBoard => text()();
  IntColumn get startedAtMs => integer()();
  IntColumn get completedAtMs => integer()();
  IntColumn get elapsedMs => integer()();
  IntColumn get mistakes => integer()();
  IntColumn get hintsRequested => integer()();
  IntColumn get highestHintLevelUsed => integer()();
  TextColumn get techniqueHelpJson =>
      text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {gameId};
}

@DataClassName('TechniqueProgressRow')
class TechniqueProgressEntries extends Table {
  TextColumn get techniqueId => text()();
  IntColumn get attempts => integer()();
  IntColumn get correctAttempts => integer()();
  IntColumn get firstTryCorrect => integer()();
  IntColumn get independentStreak => integer()();
  IntColumn get directionHintSuccesses => integer()();
  IntColumn get focusHintSuccesses => integer()();
  IntColumn get reasoningHintSuccesses => integer()();
  IntColumn get resultHintSuccesses => integer()();
  IntColumn get lastPracticedAtMs => integer().nullable()();

  @override
  Set<Column> get primaryKey => {techniqueId};
}

@DataClassName('DailyLearningFocusRow')
class DailyLearningFocuses extends Table {
  TextColumn get localDate => text()();
  TextColumn get techniqueId => text()();
  TextColumn get actionId => text()();
  TextColumn get reasonId => text()();
  IntColumn get estimatedMinutes => integer()();
  TextColumn get evidenceJson => text()();

  @override
  Set<Column> get primaryKey => {localDate};
}

@DriftDatabase(
  tables: [
    ActiveGames,
    CompletedGames,
    TechniqueProgressEntries,
    DailyLearningFocuses,
  ],
)
final class GameDatabase extends _$GameDatabase {
  GameDatabase(super.e);

  factory GameDatabase.open() =>
      GameDatabase(driftDatabase(name: 'michi_games'));

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from == 1 && to >= 2) {
        await migrator.addColumn(activeGames, activeGames.dailyChallengeKey);
        await migrator.addColumn(
          completedGames,
          completedGames.dailyChallengeKey,
        );
      }
      if (from <= 2 && to >= 3) {
        await migrator.addColumn(activeGames, activeGames.techniqueHelpJson);
        await migrator.addColumn(
          completedGames,
          completedGames.techniqueHelpJson,
        );
        await migrator.createTable(techniqueProgressEntries);
      }
      if (from <= 3 && to >= 4) {
        await migrator.addColumn(activeGames, activeGames.reasoningJson);
      }
      if (from <= 4 && to >= 5) {
        await migrator.createTable(dailyLearningFocuses);
      }
    },
  );
}
