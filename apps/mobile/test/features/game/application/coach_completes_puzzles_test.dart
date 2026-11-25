import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// "I'm stuck, help me" must always move forward: following Coach alone,
/// including candidate eliminations, solves every bundled hard puzzle.
void main() {
  final catalog =
      jsonDecode(File('assets/puzzles/classic_v1.json').readAsStringSync())
          as Map<String, Object?>;
  final hard = [
    for (final entry
        in (catalog['puzzles']! as List).cast<Map<String, Object?>>())
      if (entry['difficulty'] == 'advanced' || entry['difficulty'] == 'expert')
        (entry['id']! as String, entry['board']! as String),
  ];

  for (final (id, board) in hard) {
    test('Coach alone completes $id', () async {
      final cubit = GameCubit(
        puzzle: SudokuPuzzle(id: id, givens: SudokuBoard.parse(board)),
        exactSolver: const BacktrackingExactSolver(),
        humanSolver: const DeterministicHumanSolver(),
        coachEngine: const StructuredCoachEngine(),
      );
      addTearDown(cubit.close);
      for (var step = 0; step < 600; step++) {
        if (cubit.state.status == GameStatus.completed) break;
        cubit.requestHint();
        expect(
          cubit.state.hintUnavailable,
          isNull,
          reason: '$id stalled after $step Coach actions',
        );
        while (cubit.state.coach!.hint.level != CoachHintLevel.result) {
          cubit.requestNextHint();
        }
        cubit.applyCoachResult();
      }
      expect(cubit.state.status, GameStatus.completed);
    });
  }
}
