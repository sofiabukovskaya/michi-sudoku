import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/features/game/application/game_preparation.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Replaces the background-isolate preparation with the same synchronous
/// checks, keeping widget tests inside fake async time.
Future<void> useInlineGamePreparation() async {
  if (getIt.isRegistered<GamePreparation>()) {
    await getIt.unregister<GamePreparation>();
  }
  getIt.registerSingleton<GamePreparation>(
    GamePreparation.inline(const BacktrackingExactSolver()),
  );
}
