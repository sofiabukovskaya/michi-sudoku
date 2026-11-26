import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/review/domain/review_policy.dart';

void main() {
  final now = DateTime(2026, 12, 25, 12);
  bool allows({
    Set<ReviewMoment> moments = const {ReviewMoment.cleanPuzzle},
    int completed = 5,
    int activeDays = 3,
    Duration age = const Duration(days: 2),
    String version = '1.4',
    Iterable<({DateTime at, String version})> requests = const [],
    bool usedSettings = false,
  }) => ReviewPolicy.allows(
    moments: moments,
    completedPuzzles: completed,
    activeDays: activeDays,
    installedAt: now.subtract(age),
    now: now,
    version: version,
    requests: requests,
    usedSettings: usedSettings,
  );

  test('each happy moment can qualify, but a neutral event cannot', () {
    for (final moment in ReviewMoment.values) {
      expect(allows(moments: {moment}), isTrue, reason: moment.name);
    }
    expect(allows(moments: {}), isFalse);
    expect(ReviewPolicy.cleanPuzzle(mistakes: 0, highestHintLevel: 0), isTrue);
    expect(ReviewPolicy.cleanPuzzle(mistakes: 0, highestHintLevel: 1), isTrue);
    expect(ReviewPolicy.cleanPuzzle(mistakes: 0, highestHintLevel: 2), isFalse);
    expect(ReviewPolicy.cleanPuzzle(mistakes: 1, highestHintLevel: 0), isFalse);
  });

  test(
    'requires five puzzles, three active days and two days since install',
    () {
      expect(allows(completed: 4), isFalse);
      expect(allows(activeDays: 2), isFalse);
      expect(allows(age: const Duration(hours: 47, minutes: 59)), isFalse);
      expect(allows(), isTrue);
    },
  );

  test(
    'blocks used Settings, unknown versions and any previously used version',
    () {
      expect(allows(usedSettings: true), isFalse);
      expect(allows(version: ''), isFalse);
      expect(
        allows(requests: [(at: DateTime(2025, 6), version: '1.4')]),
        isFalse,
      );
    },
  );

  test('enforces the 60-day interval and three attempts per calendar year', () {
    expect(
      allows(
        requests: [
          (at: now.subtract(const Duration(days: 59)), version: '1.3'),
        ],
      ),
      isFalse,
    );
    expect(
      allows(
        requests: [
          (at: now.subtract(const Duration(days: 60)), version: '1.3'),
        ],
      ),
      isTrue,
    );
    final history = [
      (at: DateTime(2026, 1, 2), version: '1.1'),
      (at: DateTime(2026, 4, 2), version: '1.2'),
      (at: DateTime(2026, 8, 2), version: '1.3'),
    ];
    expect(allows(requests: history.take(2)), isTrue);
    expect(allows(requests: history), isFalse);
    history[0] = (at: DateTime(2025, 12, 31), version: '1.1');
    expect(allows(requests: history), isTrue);
  });
}
