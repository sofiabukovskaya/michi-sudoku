import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/profile/local_profile_scope.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/review/data/review_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'only a saved seventh Daily can request a review, once per version',
    () async {
      final original = SharedPreferencesAsyncPlatform.instance;
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      addTearDown(() => SharedPreferencesAsyncPlatform.instance = original);
      final database = GameDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final profile = LocalProfileScope();
      addTearDown(profile.dispose);
      final games = DriftGameRepository(database, profile);
      final service = ReviewService(database, profile);
      final today = DateTime.now();
      PackageInfo.setMockInitialValues(
        appName: 'MICHI',
        packageName: 'test.michi',
        version: '1.7',
        buildNumber: '1',
        buildSignature: '',
        installTime: today.subtract(const Duration(days: 20)),
      );
      final requests = <String>[];
      const channel = MethodChannel('dev.britannio.in_app_review');
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      addTearDown(() => messenger.setMockMethodCallHandler(channel, null));
      messenger.setMockMethodCallHandler(channel, (call) async {
        requests.add(call.method);
        return call.method == 'isAvailable' ? true : null;
      });
      final initial = DemoPuzzle.standard.givens;
      final solution = const BacktrackingExactSolver().solve(initial)!;
      Future<void> saveDay(int offset) async {
        final date = DateTime(today.year, today.month, today.day - offset, 12);
        await games.completeGame(
          CompletedGame(
            gameId: 'daily-$offset',
            puzzleId: 'puzzle-$offset',
            dailyChallengeKey: 'challenge-$offset',
            initialBoard: initial,
            completedBoard: solution,
            startedAt: date,
            completedAt: date,
            elapsed: const Duration(minutes: 2),
            mistakes: 1,
            hintsRequested: 1,
            highestHintLevelUsed: 2,
          ),
        );
      }

      for (var offset = 1; offset <= 6; offset++) {
        await saveDay(offset);
      }
      await service.consider(
        moments: {},
        completedDailyId: 'daily-0',
        isVisible: () => true,
      );
      expect(requests, isEmpty);
      await saveDay(0);
      await service.consider(
        moments: {},
        completedDailyId: 'daily-0',
        isVisible: () => false,
      );
      expect(requests, isEmpty);
      await service.consider(
        moments: {},
        completedDailyId: 'daily-0',
        isVisible: () => true,
      );
      expect(requests, ['isAvailable', 'requestReview']);
      await ReviewService(database, profile).consider(
        moments: {},
        completedDailyId: 'daily-0',
        isVisible: () => true,
      );
      expect(requests, ['isAvailable', 'requestReview']);
      expect(
        await SharedPreferencesAsync().getStringList('michi.review.requests'),
        hasLength(1),
      );
    },
  );
}
