import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_preparation.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  test('prepares a unique solution and reuses the same pending work', () async {
    final preparation = GamePreparation(const BacktrackingExactSolver());
    final board = DemoPuzzle.standard.givens;
    final first = preparation.prepare(board);
    expect(identical(first, preparation.prepare(board)), isTrue);
    final result = await first;
    expect(result.solution.isComplete, isTrue);
    expect(SudokuConstraints.validate(result.solution).isValid, isTrue);
    expect(result.solutionFor(board), result.solution);
    expect(
      () => result.solutionFor(board.withValue(CellRef.fromIndex(0), 0)),
      throwsArgumentError,
    );
    expect(await preparation.prepare(board), same(result));
  });

  test(
    'rejects contradictory and ambiguous boards without blocking callers',
    () async {
      final preparation = GamePreparation(const BacktrackingExactSolver());
      final duplicate = DemoPuzzle.standard.givens.withValue(
        CellRef.fromIndex(1),
        5,
      );
      await expectLater(preparation.prepare(duplicate), throwsStateError);
      await expectLater(
        preparation.prepare(SudokuBoard.fromValues(List.filled(81, 0))),
        throwsStateError,
      );
      // A failure on another board must not poison a subsequent valid request.
      final result = await preparation.prepare(DemoPuzzle.standard.givens);
      expect(result.solution.isComplete, isTrue);
    },
  );

  test('inline preparation applies the same checks synchronously', () async {
    final preparation = GamePreparation.inline(const BacktrackingExactSolver());
    final board = DemoPuzzle.standard.givens;
    final result = await preparation.prepare(board);
    expect(result.solutionFor(board).isComplete, isTrue);
    await expectLater(
      preparation.prepare(SudokuBoard.fromValues(List.filled(81, 0))),
      throwsStateError,
    );
  });
}
