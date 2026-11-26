import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Which technique stamps the player has already seen land, on this device.
/// A technique mastered since the last visit gets its stamp moment once.
final class NotebookStamps {
  NotebookStamps({SharedPreferencesAsync? preferences})
    : _preferences = preferences;

  static const _key = 'michi.notebook.stamped';

  SharedPreferencesAsync? _preferences;
  SharedPreferencesAsync get _store =>
      _preferences ??= SharedPreferencesAsync();

  Future<Set<SudokuTechnique>> seen() async {
    try {
      final names = await _store.getStringList(_key) ?? const <String>[];
      return {
        for (final name in names)
          for (final technique in SudokuTechnique.values)
            if (technique.name == name) technique,
      };
    } on Object {
      return {};
    }
  }

  Future<void> markSeen(Iterable<SudokuTechnique> techniques) async {
    try {
      await _store.setStringList(_key, [
        for (final technique in techniques) technique.name,
      ]);
    } on Object {
      // At worst a stamp moment plays again next time.
    }
  }
}
