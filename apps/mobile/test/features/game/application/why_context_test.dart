import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/why_selection.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/game/domain/move_reasoning_context.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  const exact = BacktrackingExactSolver();
  const human = DeterministicHumanSolver();
  const coach = StructuredCoachEngine();
  final first = CellRef(row: 0, column: 0);
  final second = CellRef(row: 0, column: 1);
  final solution = exact.solve(DemoPuzzle.standard.givens)!;
  final puzzle = SudokuPuzzle(
    id: 'why-two-away',
    givens: solution.withValue(first, 0).withValue(second, 0),
  );

  GameCubit game({DriftGameRepository? repository}) => GameCubit(
    puzzle: puzzle,
    exactSolver: exact,
    humanSolver: human,
    coachEngine: coach,
    repository: repository,
  );

  test('captures a supported correct move, not wrong entries or notes', () {
    final cubit = game();
    addTearDown(cubit.close);
    cubit
      ..selectCell(first)
      ..toggleNotesMode()
      ..enterDigit(2);
    expect(cubit.state.reasoning, isEmpty);
    cubit
      ..toggleNotesMode()
      ..enterDigit(1);
    expect(cubit.whyForCell(first).availability, WhyAvailability.wrong);
    expect(cubit.state.reasoning, isEmpty);
    cubit.enterDigit(5);
    final record = cubit.state.reasoning[first]!;
    expect(record.preMoveBoard.isEmpty(first), isTrue);
    expect(record.preMoveBoard.isEmpty(second), isTrue);
    expect(record.digit, 5);
    expect(record.source, MoveReasoningSource.manual);
    expect(cubit.whyForCell(first).plan!.target, DigitPlacement(first, 5));
    expect(cubit.whyForCell(second).availability, WhyAvailability.empty);
    expect(
      cubit.whyForCell(CellRef(row: 0, column: 2)).availability,
      WhyAvailability.given,
    );
  });

  test(
    'erase, replace and undo keep the Why record with its board snapshot',
    () {
      final cubit = game();
      addTearDown(cubit.close);
      cubit
        ..selectCell(first)
        ..enterDigit(5);
      expect(cubit.whyForCell(first).availability, WhyAvailability.available);
      cubit.erase();
      expect(cubit.state.reasoning[first], isNull);
      cubit.undo();
      expect(cubit.whyForCell(first).availability, WhyAvailability.available);
      cubit.enterDigit(1);
      expect(cubit.state.reasoning[first], isNull);
      cubit.undo();
      expect(cubit.whyForCell(first).availability, WhyAvailability.available);
    },
  );

  test('a correct move without a direct supported proof stays unavailable', () {
    final cubit = GameCubit(
      puzzle: DemoPuzzle.standard,
      exactSolver: exact,
      humanSolver: human,
      coachEngine: coach,
    );
    addTearDown(cubit.close);
    final preState = HumanSolverState.initial(cubit.state.board);
    final target = Iterable<CellRef>.generate(81, CellRef.fromIndex).firstWhere(
      (cell) =>
          cubit.state.board.isEmpty(cell) &&
          human.findDeductionForPlacement(
                preState,
                DigitPlacement(cell, cubit.state.solution.valueAt(cell)),
              ) ==
              null,
    );
    cubit
      ..selectCell(target)
      ..enterDigit(cubit.state.solution.valueAt(target));
    expect(cubit.state.reasoning[target], isNull);
    expect(
      cubit.whyForCell(target).availability,
      WhyAvailability.unsupported,
    );
  });

  test('Coach Result reuses the actual placement deduction', () {
    final cubit = game();
    addTearDown(cubit.close);
    cubit.requestHint();
    final deduction = cubit.state.coach!.deduction;
    expect(deduction.placements, hasLength(1));
    for (var index = 1; index < 4; index++) {
      cubit.requestNextHint();
    }
    cubit.applyCoachResult();
    final move = deduction.placements.single;
    expect(cubit.state.reasoning[move.cell]?.source, MoveReasoningSource.coach);
    expect(cubit.whyForCell(move.cell).plan?.technique, deduction.technique);
  });

  test(
    'Why survives Drift restore',
    () async {
      final database = GameDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final repository = DriftGameRepository(database);
      final original = game(repository: repository);
      // Persistence must finish before the Cubit is closed.
      // ignore: cascade_invocations
      original
        ..selectCell(first)
        ..enterDigit(5);
      await original.flushPersistence();
      await original.close();
      final saved = (await repository.loadActiveGame())!;
      expect(saved.reasoning[first]?.digit, 5);
      final restored = GameCubit.restore(
        stored: saved,
        exactSolver: exact,
        humanSolver: human,
        coachEngine: coach,
        repository: repository,
      );
      addTearDown(restored.close);
      expect(
        restored.whyForCell(first).availability,
        WhyAvailability.available,
      );
      expect(restored.whyForCell(first).plan!.target.digit, 5);
    },
  );
}
