// Developer-only candidate generation. Never used by the mobile runtime.
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:sudoku_engine/sudoku_engine.dart';

const solved = '''
534678912
672195348
198342567
859761423
426853791
713924856
961537284
287419635
345286179
''';

void main() {
  const exact = BacktrackingExactSolver();
  const human = DeterministicHumanSolver();
  final random = Random(20261026);
  final output = <Map<String, Object>>[];
  var easy = 0;
  var medium = 0;
  for (
    var attempt = 0;
    attempt < 1500 && (easy < 12 || medium < 8);
    attempt++
  ) {
    final transformed = _transform(SudokuBoard.parse(solved), random);
    var board = transformed;
    final order = List<int>.generate(81, (index) => index)..shuffle(random);
    SudokuBoard? mediumBoard;
    SudokuBoard? easyBoard;
    for (final index in order) {
      final candidate = board.withValue(CellRef.fromIndex(index), 0);
      if (exact.countSolutions(candidate) != 1) continue;
      final trace = human.solveLogically(candidate);
      if (trace.status != HumanSolveStatus.solved) continue;
      board = candidate;
      final techniques = trace.deductions.map((step) => step.technique).toSet();
      if (techniques.contains(SudokuTechnique.nakedPair) ||
          techniques.contains(SudokuTechnique.pointingPair)) {
        mediumBoard = board;
      } else if (board.filledCellCount <= 35) {
        easyBoard = board;
      }
    }
    SudokuBoard? chosen;
    String difficulty;
    if (medium < 8 && mediumBoard != null) {
      chosen = mediumBoard;
      difficulty = 'medium';
      medium++;
    } else if (easy < 12 && easyBoard != null) {
      chosen = easyBoard;
      difficulty = 'easy';
      easy++;
    } else {
      continue;
    }
    final trace = human.solveLogically(chosen);
    final techniques = trace.deductions.map((step) => step.technique).toSet();
    final serial = (difficulty == 'easy' ? easy : medium).toString().padLeft(
      4,
      '0',
    );
    final id = 'classic_${difficulty}_$serial';
    output.add({
      'id': id,
      'board': chosen.values.join(),
      'difficulty': difficulty,
      'requiredTechniques': [
        for (final technique in SudokuTechnique.values)
          if (techniques.contains(technique)) technique.name,
      ],
      'dailyEligible': true,
    });
    stdout.writeln(
      '$id clues=${chosen.filledCellCount} techniques=$techniques',
    );
  }
  stdout.writeln(jsonEncode({'version': 1, 'puzzles': output}));
}

SudokuBoard _transform(SudokuBoard board, Random random) {
  final digits = List<int>.generate(9, (index) => index + 1)..shuffle(random);
  final rowBands = [0, 1, 2]..shuffle(random);
  final colStacks = [0, 1, 2]..shuffle(random);
  final rows = <int>[];
  final cols = <int>[];
  for (final band in rowBands) {
    final within = [0, 1, 2]..shuffle(random);
    rows.addAll(within.map((index) => band * 3 + index));
  }
  for (final stack in colStacks) {
    final within = [0, 1, 2]..shuffle(random);
    cols.addAll(within.map((index) => stack * 3 + index));
  }
  return SudokuBoard.fromValues([
    for (var row = 0; row < 9; row++)
      for (var col = 0; col < 9; col++)
        digits[board.valueAtPosition(rows[row], cols[col]) - 1],
  ]);
}
