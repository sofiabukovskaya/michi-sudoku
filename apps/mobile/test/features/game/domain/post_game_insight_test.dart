import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:michi_mobile/features/game/domain/post_game_insight.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

MoveReasoningContext _move(
  SudokuTechnique technique, {
  MoveReasoningSource source = MoveReasoningSource.manual,
  int index = 0,
}) => MoveReasoningContext(
  preMoveBoard: SudokuBoard.fromValues(List<int>.filled(81, 0)),
  cell: CellRef.fromIndex(index),
  digit: 1,
  technique: technique,
  source: source,
);

void main() {
  test('a technique found alone more often than ever is a personal best', () {
    final insight = PostGameInsight.of(
      placements: [
        _move(SudokuTechnique.nakedPair),
        _move(SudokuTechnique.nakedPair),
        _move(SudokuTechnique.nakedPair),
        _move(SudokuTechnique.hiddenSingle),
      ],
      hints: 1,
      mistakes: 0,
      bests: {SudokuTechnique.nakedPair: 2},
    );
    expect(insight.kind, PostGameInsightKind.personalBest);
    expect(insight.technique, SudokuTechnique.nakedPair);
    expect(insight.count, 3);
  });

  test('without a best, the most advanced technique found alone is named', () {
    final insight = PostGameInsight.of(
      placements: [
        _move(SudokuTechnique.nakedPair),
        _move(SudokuTechnique.xWing),
      ],
      hints: 0,
      mistakes: 0,
      bests: {SudokuTechnique.nakedPair: 5, SudokuTechnique.xWing: 3},
    );
    expect(insight.kind, PostGameInsightKind.foundAlone);
    expect(insight.technique, SudokuTechnique.xWing);
  });

  test('Coach-shown placements never count as found alone', () {
    final insight = PostGameInsight.of(
      placements: [
        _move(SudokuTechnique.xWing, source: MoveReasoningSource.coach),
        _move(SudokuTechnique.nakedSingle),
      ],
      hints: 2,
      mistakes: 1,
      bests: const {},
    );
    expect(insight.kind, PostGameInsightKind.ownLogic);
    expect(insight.count, 1);
  });

  test('only singles, no hints and no mistakes is a clean solve', () {
    final insight = PostGameInsight.of(
      placements: [_move(SudokuTechnique.hiddenSingle)],
      hints: 0,
      mistakes: 0,
      bests: const {},
    );
    expect(insight.kind, PostGameInsightKind.cleanSolve);
  });

  test('an insight survives storage unchanged', () {
    const insight = PostGameInsight(
      PostGameInsightKind.personalBest,
      technique: SudokuTechnique.pointingPair,
      count: 4,
    );
    final restored = PostGameInsight.fromJson(insight.toJson())!;
    expect(restored.kind, insight.kind);
    expect(restored.technique, insight.technique);
    expect(restored.count, 4);
  });
}
