import 'dart:developer' as developer;

import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Reads existing local aggregates. It never analyzes a Sudoku board.
final class LearningProfileProvider {
  const LearningProfileProvider(this.progress, this.games, this.puzzles);

  final TechniqueProgressRepository progress;
  final GameRepository games;
  final PuzzleRepository puzzles;

  Future<LearningProfileSnapshot> load(LocalDate date) async {
    final techniqueProgress = await progress.loadAll();
    List<CompletedGame> completed;
    try {
      completed = await games.loadRecentCompletedGames(
        limit: 10,
        normalOnly: true,
      );
    } on Object catch (error, stackTrace) {
      developer.log(
        'Game history unavailable for learning focus',
        name: 'michi.recommendation',
        error: error,
        stackTrace: stackTrace,
      );
      completed = const [];
    }
    final recent = <GameLearningEvidence>[];
    for (final game in completed) {
      var required = <SudokuTechnique>{};
      try {
        required = (await puzzles.getPuzzle(game.puzzleId)).requiredTechniques;
      } on Object {
        // A retired catalog ID still contributes its recorded Coach evidence.
      }
      recent.add(
        GameLearningEvidence(
          gameId: game.gameId,
          techniqueHelp: game.techniqueHelp,
          requiredTechniques: required,
        ),
      );
    }
    return LearningProfileSnapshot(
      date: date,
      techniqueProgress: techniqueProgress,
      recentNormalGames: recent,
    );
  }
}
