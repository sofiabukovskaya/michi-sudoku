import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

enum PostGameInsightKind {
  /// More placements with one technique, found alone, than ever before.
  personalBest,

  /// The most advanced technique the player found without the Coach.
  foundAlone,

  /// No hints and no mistakes.
  cleanSolve,

  /// How many digits the player placed by their own logic.
  ownLogic,
}

/// One honest line about the finished game, built only from what the game
/// recorded: each placement's technique and whether the Coach showed it.
final class PostGameInsight {
  const PostGameInsight(this.kind, {this.technique, this.count = 0});

  final PostGameInsightKind kind;
  final SudokuTechnique? technique;
  final int count;

  /// The insight for a finished game. [bests] holds the player's previous
  /// best count per technique found alone (missing means none yet).
  // A static factory keeps the const constructor for stored insights.
  // ignore: prefer_constructors_over_static_methods
  static PostGameInsight of({
    required Iterable<MoveReasoningContext> placements,
    required int hints,
    required int mistakes,
    required Map<SudokuTechnique, int> bests,
  }) {
    final alone = <SudokuTechnique, int>{};
    var ownLogic = 0;
    for (final placement in placements) {
      if (placement.source != MoveReasoningSource.manual) continue;
      ownLogic++;
      alone.update(placement.technique, (n) => n + 1, ifAbsent: () => 1);
    }
    // Singles are every game's bread and butter; insights name the rest.
    final advanced =
        alone.entries
            .where(
              (e) => SudokuTechniqueOrder.rank(e.key) >= 2,
            )
            .toList()
          ..sort(
            (a, b) => SudokuTechniqueOrder.rank(
              b.key,
            ).compareTo(SudokuTechniqueOrder.rank(a.key)),
          );
    for (final entry in advanced) {
      if (entry.value > (bests[entry.key] ?? 0)) {
        return PostGameInsight(
          PostGameInsightKind.personalBest,
          technique: entry.key,
          count: entry.value,
        );
      }
    }
    if (advanced.isNotEmpty) {
      return PostGameInsight(
        PostGameInsightKind.foundAlone,
        technique: advanced.first.key,
        count: advanced.first.value,
      );
    }
    if (hints == 0 && mistakes == 0) {
      return const PostGameInsight(PostGameInsightKind.cleanSolve);
    }
    return PostGameInsight(PostGameInsightKind.ownLogic, count: ownLogic);
  }

  /// Every technique count found alone in this game, for updating bests.
  static Map<SudokuTechnique, int> aloneCounts(
    Iterable<MoveReasoningContext> placements,
  ) {
    final counts = <SudokuTechnique, int>{};
    for (final placement in placements) {
      if (placement.source == MoveReasoningSource.manual) {
        counts.update(placement.technique, (n) => n + 1, ifAbsent: () => 1);
      }
    }
    return counts;
  }

  Map<String, Object?> toJson() => {
    'kind': kind.name,
    'technique': technique?.name,
    'count': count,
  };

  static PostGameInsight? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    try {
      final technique = json['technique'] as String?;
      return PostGameInsight(
        PostGameInsightKind.values.byName(json['kind'] as String),
        technique: technique == null
            ? null
            : SudokuTechnique.values.byName(technique),
        count: json['count'] as int,
      );
    } on Object {
      return null;
    }
  }
}
