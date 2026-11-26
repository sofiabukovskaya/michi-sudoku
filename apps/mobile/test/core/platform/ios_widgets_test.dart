import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/platform/ios_widgets.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  test('widget game counts only the player cells and marks givens', () {
    final givens = SudokuBoard.parse('''
      530070000
      600195000
      098000060
      800060003
      400803001
      700020006
      060000280
      000419005
      000080079
    ''');
    final current = givens
        .withValue(CellRef(row: 0, column: 2), 4)
        .withValue(CellRef(row: 0, column: 3), 6);
    final game = WidgetGame(givens: givens, current: current, daily: true);
    expect(game.total, 51);
    expect(game.filled, 2);
    expect(game.board, hasLength(81));
    expect(game.givenMask.substring(0, 4), '1100');

    final json = jsonDecode(
      WidgetSnapshot(
        day: '2026-11-25',
        difficulty: 'medium',
        dailyDone: false,
        streak: 3,
        week: const [true, false, false, false, false, false, false],
        game: game,
      ).toJson(),
    ) as Map<String, dynamic>;
    expect(json['streak'], 3);
    expect((json['game'] as Map)['filled'], 2);
  });
}
