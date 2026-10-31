import 'dart:convert';
import 'dart:io';

import 'package:sudoku_engine/sudoku_engine.dart';

Future<void> main(List<String> args) async {
  const human = DeterministicHumanSolver();
  const exact = BacktrackingExactSolver();
  for (final source in args) {
    final board = SudokuBoard.parse(source);
    final result = human.solveLogically(board);
    final techniques = result.deductions.map((step) => step.technique).toSet();
    stdout.writeln(jsonEncode({
      'board': board.values.join(),
      'status': result.status.name,
      'unique': exact.hasUniqueSolution(board),
      'requiredTechniques': [
        for (final technique in SudokuTechniqueOrder.supported)
          if (techniques.contains(technique)) technique.name,
      ],
    }));
  }
}
