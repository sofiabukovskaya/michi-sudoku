enum ReviewMoment { cleanPuzzle, personalBest, techniqueMastery, dailyStreak }

abstract final class ReviewPolicy {
  static bool allows({
    required Set<ReviewMoment> moments,
    required int completedPuzzles,
    required int activeDays,
    required DateTime installedAt,
    required DateTime now,
    required String version,
    required Iterable<({DateTime at, String version})> requests,
    required bool usedSettings,
  }) {
    if (moments.isEmpty ||
        completedPuzzles < 5 ||
        activeDays < 3 ||
        now.difference(installedAt) < const Duration(days: 2) ||
        usedSettings ||
        version.trim().isEmpty) {
      return false;
    }
    var thisYear = 0;
    for (final request in requests) {
      if (request.version == version ||
          now.difference(request.at) < const Duration(days: 60)) {
        return false;
      }
      if (request.at.toLocal().year == now.toLocal().year) thisYear++;
    }
    return thisYear < 3;
  }

  static bool cleanPuzzle({
    required int mistakes,
    required int highestHintLevel,
  }) => mistakes == 0 && highestHintLevel <= 1;
}
