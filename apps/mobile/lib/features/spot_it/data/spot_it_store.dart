import 'package:shared_preferences/shared_preferences.dart';

/// Days on which a "Spot it" was solved, kept on this device. They count
/// toward the Daily streak, so a busy day does not break it.
final class SpotItStore {
  SpotItStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences;

  static const _key = 'michi.spotIt.days';
  static const _kept = 120;

  SharedPreferencesAsync? _preferences;
  SharedPreferencesAsync get _store =>
      _preferences ??= SharedPreferencesAsync();

  static String _day(DateTime value) {
    final local = value.toLocal();
    return '${local.year.toString().padLeft(4, '0')}-'
        '${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')}';
  }

  /// Local midnight of every solved day, newest first.
  Future<List<DateTime>> days() async {
    try {
      final stored = await _store.getStringList(_key) ?? const <String>[];
      return [for (final day in stored) ?DateTime.tryParse(day)];
    } on Object {
      return const [];
    }
  }

  Future<bool> isDone(DateTime now) async =>
      (await days()).any((day) => _day(day) == _day(now));

  Future<void> markDone(DateTime now) async {
    try {
      final stored = await _store.getStringList(_key) ?? const <String>[];
      final today = _day(now);
      if (stored.contains(today)) return;
      await _store.setStringList(_key, [today, ...stored].take(_kept).toList());
    } on Object {
      // A lost mark only affects the streak, never the puzzle.
    }
  }
}
