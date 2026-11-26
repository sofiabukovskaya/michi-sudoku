import 'dart:convert';

import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:michi_mobile/features/game/domain/post_game_insight.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Personal bests per technique, kept on this device. Each finished game
/// counts once: its insight is remembered by game ID, so reopening the
/// completion screen shows the same line and never inflates a best.
final class InsightRecords {
  InsightRecords({SharedPreferencesAsync? preferences})
    : _preferences = preferences;

  static const _bestsKey = 'michi.insight.bests';
  static const _lastKey = 'michi.insight.last';

  SharedPreferencesAsync? _preferences;
  SharedPreferencesAsync get _store =>
      _preferences ??= SharedPreferencesAsync();

  Future<PostGameInsight> settle({
    required String gameId,
    required Iterable<MoveReasoningContext> placements,
    required int hints,
    required int mistakes,
  }) async {
    final list = placements.toList();
    try {
      final last = await _store.getString(_lastKey);
      if (last != null) {
        final decoded = jsonDecode(last);
        if (decoded is Map<String, dynamic> && decoded['game'] == gameId) {
          final kept = PostGameInsight.fromJson(decoded['insight']);
          if (kept != null) return kept;
        }
      }
      final bests = _decodeBests(await _store.getString(_bestsKey));
      final insight = PostGameInsight.of(
        placements: list,
        hints: hints,
        mistakes: mistakes,
        bests: bests,
      );
      for (final entry in PostGameInsight.aloneCounts(list).entries) {
        if (entry.value > (bests[entry.key] ?? 0)) {
          bests[entry.key] = entry.value;
        }
      }
      await _store.setString(
        _bestsKey,
        jsonEncode({for (final e in bests.entries) e.key.name: e.value}),
      );
      await _store.setString(
        _lastKey,
        jsonEncode({'game': gameId, 'insight': insight.toJson()}),
      );
      return insight;
    } on Object {
      // Storage is optional: the line still reflects this game.
      return PostGameInsight.of(
        placements: list,
        hints: hints,
        mistakes: mistakes,
        bests: const {},
      );
    }
  }

  static Map<SudokuTechnique, int> _decodeBests(String? source) {
    if (source == null) return {};
    try {
      final decoded = jsonDecode(source);
      if (decoded is! Map<String, dynamic>) return {};
      return {
        for (final entry in decoded.entries)
          if (SudokuTechnique.values.any((t) => t.name == entry.key) &&
              entry.value is int)
            SudokuTechnique.values.byName(entry.key): entry.value as int,
      };
    } on Object {
      return {};
    }
  }
}
