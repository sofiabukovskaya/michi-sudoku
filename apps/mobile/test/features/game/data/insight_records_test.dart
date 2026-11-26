import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/data/insight_records.dart';
import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:michi_mobile/features/game/domain/post_game_insight.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

List<MoveReasoningContext> _pairs(int count) => [
  for (var i = 0; i < count; i++)
    MoveReasoningContext(
      preMoveBoard: SudokuBoard.fromValues(List<int>.filled(81, 0)),
      cell: CellRef.fromIndex(i),
      digit: 1,
      technique: SudokuTechnique.nakedPair,
      source: MoveReasoningSource.manual,
    ),
];

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('a game counts once; the next game compares with its best', () async {
    final records = InsightRecords();
    final first = await records.settle(
      gameId: 'a',
      placements: _pairs(2),
      hints: 0,
      mistakes: 0,
    );
    expect(first.kind, PostGameInsightKind.personalBest);

    // Reopening the same game shows the same line.
    final again = await records.settle(
      gameId: 'a',
      placements: _pairs(2),
      hints: 0,
      mistakes: 0,
    );
    expect(again.kind, PostGameInsightKind.personalBest);
    expect(again.count, 2);

    // Equal to the best is not a new best.
    final second = await records.settle(
      gameId: 'b',
      placements: _pairs(2),
      hints: 0,
      mistakes: 0,
    );
    expect(second.kind, PostGameInsightKind.foundAlone);

    final third = await records.settle(
      gameId: 'c',
      placements: _pairs(3),
      hints: 0,
      mistakes: 0,
    );
    expect(third.kind, PostGameInsightKind.personalBest);
    expect(third.count, 3);
  });
}
