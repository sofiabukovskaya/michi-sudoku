import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The four answers on "How well do you know Sudoku?".
enum PlayerLevel { beginner, basics, regular, challenge }

/// Device-level first-run state. A guest who finished onboarding returns to
/// Home; signing out never sends an experienced player through it again.
class OnboardingStore {
  OnboardingStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences;

  static const _completedKey = 'michi.onboarding.completed';
  static const _levelKey = 'michi.onboarding.level';

  SharedPreferencesAsync? _preferences;
  SharedPreferencesAsync get _store =>
      _preferences ??= SharedPreferencesAsync();

  /// Missing storage reads as "not completed", which shows Welcome: safe.
  Future<bool> isCompleted() async {
    try {
      return await _store.getBool(_completedKey) ?? false;
    } on Object {
      return false;
    }
  }

  Future<PlayerLevel?> level() async {
    try {
      final index = await _store.getInt(_levelKey);
      return index == null || index < 0 || index >= PlayerLevel.values.length
          ? null
          : PlayerLevel.values[index];
    } on Object {
      return null;
    }
  }

  Future<void> complete({PlayerLevel? level}) async {
    try {
      await _store.setBool(_completedKey, true);
      if (level != null) await _store.setInt(_levelKey, level.index);
    } on Object {
      // First-run state is a convenience; never block entering the app.
    }
  }

  /// The catalog difficulty that matches the player's own description.
  static PuzzleDifficulty suggestedDifficulty(PlayerLevel? level) =>
      switch (level) {
        PlayerLevel.beginner ||
        PlayerLevel.basics ||
        null => PuzzleDifficulty.easy,
        PlayerLevel.regular => PuzzleDifficulty.medium,
        PlayerLevel.challenge => PuzzleDifficulty.advanced,
      };
}
