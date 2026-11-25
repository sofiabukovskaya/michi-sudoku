import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

const _human = DeterministicHumanSolver();
const _coach = StructuredCoachEngine();
const _exact = BacktrackingExactSolver();

final class _Clock implements GameClock {
  DateTime current = DateTime.utc(2026, 11, 25, 9);
  Duration ticks = Duration.zero;

  @override
  DateTime now() => current;

  @override
  Duration monotonic() => ticks;
}

SudokuPuzzle _advanced() {
  final catalog =
      jsonDecode(File('assets/puzzles/classic_v1.json').readAsStringSync())
          as Map<String, Object?>;
  final entry = (catalog['puzzles']! as List)
      .cast<Map<String, Object?>>()
      .firstWhere((item) => item['id'] == 'classic_advanced_0001');
  return SudokuPuzzle(
    id: entry['id']! as String,
    givens: SudokuBoard.parse(entry['board']! as String),
  );
}

void _toResult(GameCubit cubit) {
  cubit.requestHint();
  while (cubit.state.coach!.hint.level != CoachHintLevel.result) {
    cubit.requestNextHint();
  }
}

/// Follows Coach until it offers a removal step, then returns that step.
CoachHint _advanceToFirstElimination(GameCubit cubit) {
  for (var step = 0; step < 200; step++) {
    _toResult(cubit);
    final hint = cubit.state.coach!.hint;
    if (hint.revealedEliminations.isNotEmpty) return hint;
    cubit.applyCoachResult();
  }
  fail('No elimination step in the fixture puzzle.');
}

void main() {
  test('an accepted removal is not repeated and never edits notes', () {
    final cubit = GameCubit(
      puzzle: _advanced(),
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
    );
    addTearDown(cubit.close);
    final step = _advanceToFirstElimination(cubit);
    final notes = cubit.state.notes;
    cubit.applyCoachResult();
    expect(cubit.state.notes, notes);
    expect(
      cubit.state.provenEliminations.map((item) => item.removal).toSet(),
      step.revealedEliminations.toSet(),
    );
    _toResult(cubit);
    expect(
      cubit.state.coach!.hint.revealedEliminations,
      isNot(step.revealedEliminations),
    );
  });

  test('entering a correct digit keeps proofs; erase and undo drop them', () {
    final cubit = GameCubit(
      puzzle: _advanced(),
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
    );
    addTearDown(cubit.close);
    _advanceToFirstElimination(cubit);
    cubit.applyCoachResult();
    final proofs = cubit.state.provenEliminations;
    expect(proofs, isNotEmpty);

    // A new correct digit only adds information: proofs still hold.
    final basis = proofs.first.basis;
    final empty = Iterable<CellRef>.generate(81, CellRef.fromIndex).firstWhere(
      (cell) =>
          cubit.state.board.isEmpty(cell) &&
          proofs.every((item) => item.removal.cell != cell),
    );
    cubit
      ..selectCell(empty)
      ..enterDigit(cubit.state.solution.valueAt(empty));
    expect(cubit.state.provenEliminations, proofs);

    // Undoing that digit returns to the proof position: still valid.
    cubit.undo();
    expect(cubit.state.provenEliminations, proofs);

    // Erasing a digit the proof relied on drops it.
    final relied = Iterable<CellRef>.generate(81, CellRef.fromIndex).firstWhere(
      (cell) => basis.isFilled(cell) && !cubit.state.isGiven(cell),
    );
    cubit
      ..selectCell(relied)
      ..erase();
    expect(cubit.state.provenEliminations, isEmpty);
    cubit.undo();
    // Undo restores the digit but not a proof that was invalidated.
    expect(cubit.state.provenEliminations, isEmpty);
  });

  test('pencil notes never feed or clear the proven removals', () {
    final cubit = GameCubit(
      puzzle: _advanced(),
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
    );
    addTearDown(cubit.close);
    _advanceToFirstElimination(cubit);
    cubit.applyCoachResult();
    final proofs = cubit.state.provenEliminations;
    final cell = proofs.first.removal.cell;
    cubit
      ..selectCell(cell)
      ..toggleNotesMode()
      ..enterDigit(proofs.first.removal.digit);
    expect(cubit.state.notes[cell]?.contains(proofs.first.removal.digit), true);
    expect(cubit.state.provenEliminations, proofs);
  });

  test('proofs survive pause, termination and restore', () async {
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftGameRepository(database);
    final clock = _Clock();
    final cubit = GameCubit(
      puzzle: _advanced(),
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
      repository: repository,
      clock: clock,
    );
    final step = _advanceToFirstElimination(cubit);
    cubit.applyCoachResult();
    final proofs = cubit.state.provenEliminations;
    await cubit.onAppBackground();
    await cubit.close();

    final stored = await repository.loadActiveGame();
    expect(stored!.provenEliminations, proofs);
    final restored = GameCubit.restore(
      stored: stored,
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
      repository: repository,
      clock: clock,
    );
    addTearDown(restored.close);
    expect(restored.state.isPaused, isTrue);
    expect(restored.state.provenEliminations, proofs);
    restored.resume();
    _toResult(restored);
    expect(
      restored.state.coach!.hint.revealedEliminations,
      isNot(step.revealedEliminations),
    );
  });

  test('timer does not count time the app was terminated', () async {
    final database = GameDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftGameRepository(database);
    final clock = _Clock();
    final cubit = GameCubit(
      puzzle: _advanced(),
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
      repository: repository,
      clock: clock,
    );
    // Five minutes of play, last saved by a move, then the process dies.
    clock
      ..ticks += const Duration(minutes: 5)
      ..current = clock.current.add(const Duration(minutes: 5));
    final cell = Iterable<CellRef>.generate(
      81,
      CellRef.fromIndex,
    ).firstWhere(cubit.state.board.isEmpty);
    cubit
      ..selectCell(cell)
      ..enterDigit(cubit.state.solution.valueAt(cell));
    await cubit.flushPersistence();
    await cubit.close();
    clock.current = clock.current.add(const Duration(hours: 12));

    final restored = GameCubit.restore(
      stored: (await repository.loadActiveGame())!,
      exactSolver: _exact,
      humanSolver: _human,
      coachEngine: _coach,
      repository: repository,
      clock: clock,
    );
    addTearDown(restored.close);
    expect(restored.state.isPaused, isTrue);
    expect(restored.elapsed, const Duration(minutes: 5));
    // Paused time never counts.
    clock
      ..ticks += const Duration(hours: 1)
      ..current = clock.current.add(const Duration(hours: 1));
    expect(restored.elapsed, const Duration(minutes: 5));
    expect(restored.state.status, GameStatus.playing);
  });
}
