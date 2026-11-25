import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/onboarding/data/onboarding_store.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    final original = SharedPreferencesAsyncPlatform.instance;
    addTearDown(() => SharedPreferencesAsyncPlatform.instance = original);
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('first run is not completed until onboarding finishes', () async {
    final store = OnboardingStore();
    expect(await store.isCompleted(), isFalse);
    expect(await store.level(), isNull);
    await store.complete(level: PlayerLevel.challenge);
    expect(await store.isCompleted(), isTrue);
    expect(await store.level(), PlayerLevel.challenge);
  });

  test('the chosen level maps to an honest default difficulty', () {
    expect(OnboardingStore.suggestedDifficulty(null), PuzzleDifficulty.easy);
    expect(
      OnboardingStore.suggestedDifficulty(PlayerLevel.regular),
      PuzzleDifficulty.medium,
    );
    expect(
      OnboardingStore.suggestedDifficulty(PlayerLevel.challenge),
      PuzzleDifficulty.advanced,
    );
  });
}
