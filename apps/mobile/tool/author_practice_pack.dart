import 'dart:convert';
import 'dart:io';

import 'package:sudoku_engine/sudoku_engine.dart';

/// Offline authoring tool. Runtime code reads the checked-in JSON.
void main() {
  final source =
      jsonDecode(
            File('assets/puzzles/classic_v1.json').readAsStringSync(),
          )
          as Map<String, dynamic>;
  const solver = DeterministicHumanSolver();
  const coach = StructuredCoachEngine();
  final selected = <SudokuTechnique, List<Map<String, Object>>>{
    for (final technique in [
      SudokuTechnique.nakedSingle,
      SudokuTechnique.hiddenSingle,
      SudokuTechnique.nakedPair,
      SudokuTechnique.pointingPair,
    ])
      technique: [],
  };
  final seen = <String>{};
  for (final entry in source['puzzles'] as List<dynamic>) {
    final puzzle = entry as Map<String, dynamic>;
    var state = HumanSolverState.initial(
      SudokuBoard.parse(puzzle['board'] as String),
    );
    while (!state.isSolved && !state.hasContradiction) {
      final next = solver.findNextDeduction(state);
      if (next == null) break;
      final fresh = HumanSolverState.initial(state.board);
      final candidate = solver.findNextDeduction(fresh);
      final technique = candidate?.technique;
      if (technique != null &&
          selected.containsKey(technique) &&
          seen.add(state.board.values.join())) {
        try {
          final plan = coach.createPlan(candidate!);
          if (plan.length == 4 &&
              (candidate.placements.isNotEmpty ||
                  candidate.eliminations.isNotEmpty)) {
            selected[technique]!.add({
              'sourceId': puzzle['id'] as String,
              'technique': technique.name,
              'board': state.board.values.join(),
            });
          }
        } on Object {
          // Incomplete candidate states cannot be published.
        }
      }
      state = state.apply(next);
    }
  }
  for (final item in selected.entries) {
    stdout.writeln('${item.key.name}: ${item.value.length}');
  }
  final published = <Map<String, Object>>[];
  for (final technique in selected.keys) {
    final candidates = selected[technique]!;
    final sources = <String>{};
    final chosen = <Map<String, Object>>[];
    for (final candidate in candidates) {
      if (sources.add(candidate['sourceId']! as String)) chosen.add(candidate);
      if (chosen.length == 5) break;
    }
    for (final candidate in candidates) {
      if (chosen.length == 5) break;
      if (!chosen.contains(candidate)) chosen.add(candidate);
    }
    if (technique == SudokuTechnique.pointingPair && chosen.isNotEmpty) {
      final base = chosen.first['board']! as String;
      for (var variant = 1; variant < 5; variant++) {
        final board = _transform(base, variant);
        final deduction = solver.findNextDeduction(
          HumanSolverState.initial(SudokuBoard.parse(board)),
        );
        if (deduction?.technique != technique) {
          throw StateError('Pointing Pair variant $variant is invalid.');
        }
        coach.createPlan(deduction!);
        chosen.add({'technique': technique.name, 'board': board});
      }
    }
    for (var index = 0; index < chosen.length; index++) {
      published.add({
        'id':
            'practice_${technique.name}_'
            '${(index + 1).toString().padLeft(2, '0')}',
        'technique': technique.name,
        'board': chosen[index]['board']!,
      });
    }
  }
  final content = {
    'version': 1,
    'scenarios': published,
  };
  File('assets/practice/practice_v1.json')
    ..createSync(recursive: true)
    ..writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(content)}\n',
    );
}

String _transform(String source, int variant) {
  final output = List<String>.filled(81, '0');
  for (var row = 0; row < 9; row++) {
    for (var column = 0; column < 9; column++) {
      final (targetRow, targetColumn) = switch (variant) {
        1 => (column, 8 - row),
        2 => (8 - row, 8 - column),
        3 => (8 - column, row),
        _ => (column, row),
      };
      final digit = int.parse(source[row * 9 + column]);
      output[targetRow * 9 + targetColumn] = digit == 0
          ? '0'
          : '${(digit + variant - 1) % 9 + 1}';
    }
  }
  return output.join();
}
