import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/data/demo_puzzle.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

const _exact = BacktrackingExactSolver();
const _human = DeterministicHumanSolver();
const _coach = StructuredCoachEngine();
final _empty = CellRef(row: 0, column: 2);
final _given = CellRef(row: 0, column: 0);

GameCubit _game([SudokuPuzzle? puzzle]) => GameCubit(
  puzzle: puzzle ?? DemoPuzzle.standard,
  exactSolver: _exact,
  humanSolver: _human,
  coachEngine: _coach,
);

final class _StuckHumanSolver implements HumanSolver {
  const _StuckHumanSolver();

  @override
  Deduction? findNextDeduction(HumanSolverState state) => null;

  @override
  Deduction? findDeductionForPlacement(
    HumanSolverState state,
    DigitPlacement target,
  ) => null;

  @override
  HumanSolveResult solveLogically(SudokuBoard board) =>
      throw UnimplementedError('The game only requests the next deduction.');
}

final class _FixedHumanSolver implements HumanSolver {
  const _FixedHumanSolver(this.deduction);

  final Deduction deduction;

  @override
  Deduction findNextDeduction(HumanSolverState state) => deduction;

  @override
  Deduction? findDeductionForPlacement(
    HumanSolverState state,
    DigitPlacement target,
  ) => deduction.placements.contains(target) ? deduction : null;

  @override
  HumanSolveResult solveLogically(SudokuBoard board) =>
      throw UnimplementedError('The game only requests the next deduction.');
}

void main() {
  group('GameCubit', () {
    test('initializes a unique offline puzzle and caches its solution', () {
      final cubit = _game();
      addTearDown(cubit.close);
      expect(cubit.state.board, DemoPuzzle.standard.givens);
      expect(cubit.state.solution.isComplete, isTrue);
      expect(cubit.state.status, GameStatus.playing);
      expect(cubit.state.notes, isEmpty);
      expect(cubit.state.mistakes, 0);
    });

    test('rejects invalid or non-unique content', () {
      expect(
        () => _game(SudokuPuzzle(id: 'empty', givens: SudokuBoard.empty())),
        throwsStateError,
      );
    });

    blocTest<GameCubit, GameState>(
      'selects editable and given cells without changing board values',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_empty)
        ..selectCell(_given),
      verify: (cubit) {
        expect(cubit.state.selectedCell, _given);
        expect(cubit.state.board, DemoPuzzle.standard.givens);
      },
    );

    blocTest<GameCubit, GameState>(
      'ignores digit and erase intents on a given cell',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_given)
        ..enterDigit(9)
        ..erase(),
      verify: (cubit) {
        expect(cubit.state.board.valueAt(_given), 5);
        expect(cubit.state.history, isEmpty);
      },
    );

    blocTest<GameCubit, GameState>(
      'places and replaces player digits as immutable atomic actions',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_empty)
        ..enterDigit(4)
        ..enterDigit(1),
      verify: (cubit) {
        expect(cubit.state.board.valueAt(_empty), 1);
        expect(cubit.state.puzzle.givens.valueAt(_empty), 0);
        expect(cubit.state.history, hasLength(2));
        expect(cubit.state.mistakes, 1);
        expect(cubit.state.isWrong(_empty), isTrue);
      },
    );

    blocTest<GameCubit, GameState>(
      'counts a wrong entry, keeps it visible, and supports erase',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_empty)
        ..enterDigit(1)
        ..erase(),
      verify: (cubit) {
        expect(cubit.state.board.isEmpty(_empty), isTrue);
        expect(cubit.state.mistakes, 1);
        expect(cubit.state.isWrong(_empty), isFalse);
      },
    );

    test('wrong entries do not reduce the keypad remaining count', () {
      final cubit = _game();
      addTearDown(cubit.close);
      final before = cubit.state.remainingCount(1);
      cubit
        ..selectCell(_empty)
        ..enterDigit(1);
      expect(cubit.state.isWrong(_empty), isTrue);
      expect(cubit.state.remainingCount(1), before);
    });

    blocTest<GameCubit, GameState>(
      'toggles notes only in empty editable cells',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_empty)
        ..toggleNotesMode()
        ..enterDigit(2)
        ..enterDigit(7)
        ..enterDigit(7),
      verify: (cubit) {
        expect(cubit.state.notesMode, isTrue);
        expect(cubit.state.board.isEmpty(_empty), isTrue);
        expect(cubit.state.notes[_empty]!.digits, [2]);
        expect(cubit.state.history, hasLength(3));
      },
    );

    blocTest<GameCubit, GameState>(
      'removes a correct placement from peer notes only',
      build: _game,
      act: (cubit) {
        final peer = CellRef(row: 0, column: 3);
        final unrelated = CellRef(row: 4, column: 4);
        cubit
          ..toggleNotesMode()
          ..selectCell(peer)
          ..enterDigit(4)
          ..selectCell(unrelated)
          ..enterDigit(4)
          ..toggleNotesMode()
          ..selectCell(_empty)
          ..enterDigit(4);
      },
      verify: (cubit) {
        expect(cubit.state.notes[CellRef(row: 0, column: 3)], isNull);
        expect(
          cubit.state.notes[CellRef(row: 4, column: 4)]!.contains(4),
          isTrue,
        );
      },
    );

    blocTest<GameCubit, GameState>(
      'undoes digit placement, note changes, and erase snapshots',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_empty)
        ..toggleNotesMode()
        ..enterDigit(2)
        ..undo()
        ..toggleNotesMode()
        ..enterDigit(4)
        ..erase()
        ..undo(),
      verify: (cubit) {
        expect(cubit.state.notes, isEmpty);
        expect(cubit.state.board.valueAt(_empty), 4);
        expect(cubit.state.history, hasLength(1));
      },
    );

    blocTest<GameCubit, GameState>(
      'blocks coaching while a wrong digit remains',
      build: _game,
      act: (cubit) => cubit
        ..selectCell(_empty)
        ..enterDigit(1)
        ..requestHint(),
      verify: (cubit) {
        expect(cubit.state.coach, isNull);
        expect(cubit.state.hintUnavailable, HintUnavailableReason.wrongEntry);
      },
    );

    test('reports a stuck HumanSolver without using the exact solution', () {
      final cubit = GameCubit(
        puzzle: DemoPuzzle.standard,
        exactSolver: _exact,
        humanSolver: const _StuckHumanSolver(),
        coachEngine: _coach,
      );
      addTearDown(cubit.close);
      cubit.requestHint();
      expect(cubit.state.coach, isNull);
      expect(
        cubit.state.hintUnavailable,
        HintUnavailableReason.unsupportedStep,
      );
    });

    blocTest<GameCubit, GameState>(
      'anchors all four hint levels to one real deduction',
      build: _game,
      act: (cubit) => cubit
        ..requestHint()
        ..requestNextHint()
        ..requestNextHint()
        ..requestNextHint()
        ..requestNextHint(),
      verify: (cubit) {
        final session = cubit.state.coach!;
        expect(session.hintIndex, 3);
        expect(
          session.plan.hints.map((hint) => hint.level),
          CoachHintLevel.values,
        );
        expect(session.hint.revealedPlacements, session.deduction.placements);
        expect(
          session.hint.revealedEliminations,
          session.deduction.eliminations,
        );
      },
    );

    blocTest<GameCubit, GameState>(
      'keeps a plan through note changes but invalidates it on board changes',
      build: _game,
      act: (cubit) => cubit
        ..requestHint()
        ..selectCell(_empty)
        ..toggleNotesMode()
        ..enterDigit(2)
        ..toggleNotesMode()
        ..enterDigit(4),
      verify: (cubit) {
        expect(cubit.state.coach, isNull);
        expect(cubit.state.board.valueAt(_empty), 4);
      },
    );

    test(
      'manual notes remain separate from engine evidence and keep the plan',
      () {
        final cubit = _game();
        addTearDown(cubit.close);
        cubit.requestHint();
        final deduction = cubit.state.coach!.deduction;
        cubit
          ..selectCell(_empty)
          ..toggleNotesMode()
          ..enterDigit(9);
        expect(cubit.state.notes[_empty]!.contains(9), isTrue);
        expect(cubit.state.coach!.deduction, deduction);
        cubit.undo();
        expect(cubit.state.coach!.deduction, deduction);
      },
    );

    test('undoing a board change invalidates a newly requested plan', () {
      final cubit = _game();
      addTearDown(cubit.close);
      cubit
        ..selectCell(_empty)
        ..enterDigit(4)
        ..requestHint();
      expect(cubit.state.coach, isNotNull);
      cubit.undo();
      expect(cubit.state.coach, isNull);
    });

    test('does not apply a result until the explicit action', () {
      final cubit = _game();
      addTearDown(cubit.close);
      cubit.requestHint();
      final before = cubit.state.board;
      for (var index = 0; index < 3; index++) {
        cubit.requestNextHint();
      }
      expect(cubit.state.board, before);
      final placements = cubit.state.coach!.hint.revealedPlacements;
      if (placements.isNotEmpty) {
        cubit.applyCoachResult();
        expect(
          cubit.state.board.valueAt(placements.single.cell),
          placements.single.digit,
        );
      }
    });

    test('an elimination result leaves board and manual notes unchanged', () {
      final first = CellRef(row: 0, column: 2);
      final second = CellRef(row: 0, column: 3);
      final target = CellRef(row: 0, column: 5);
      final mask = CandidateMask.fromDigits(const [1, 2]);
      final deduction = Deduction(
        technique: SudokuTechnique.nakedPair,
        focusCells: [first, second],
        evidence: [
          UnitEvidence(SudokuUnit.row(0)),
          CandidateSetEvidence(first, mask),
          CandidateSetEvidence(second, mask),
        ],
        eliminations: [CandidateElimination(target, 1)],
        placements: const [],
      );
      final cubit = GameCubit(
        puzzle: DemoPuzzle.standard,
        exactSolver: _exact,
        humanSolver: _FixedHumanSolver(deduction),
        coachEngine: _coach,
      );
      addTearDown(cubit.close);
      cubit
        ..selectCell(target)
        ..toggleNotesMode()
        ..enterDigit(1)
        ..requestHint();
      final boardBefore = cubit.state.board;
      final notesBefore = cubit.state.notes;
      for (var index = 0; index < 3; index++) {
        cubit.requestNextHint();
      }
      expect(
        cubit.state.coach!.hint.revealedEliminations,
        deduction.eliminations,
      );
      cubit.applyCoachResult();
      expect(cubit.state.board, boardBefore);
      expect(cubit.state.notes, notesBefore);
    });

    blocTest<GameCubit, GameState>(
      'completes a board when the final correct digit is entered',
      build: () {
        final solved = SudokuBoard.parse('''
          534678912
          672195348
          198342567
          859761423
          426853791
          713924856
          961537284
          287419635
          345286179
        ''');
        return _game(
          SudokuPuzzle(
            id: 'last-cell',
            givens: solved.withValue(CellRef(row: 0, column: 0), 0),
          ),
        );
      },
      act: (cubit) => cubit
        ..selectCell(CellRef(row: 0, column: 0))
        ..enterDigit(5),
      verify: (cubit) {
        expect(cubit.state.status, GameStatus.completed);
        expect(cubit.state.board, cubit.state.solution);
      },
    );
  });
}
