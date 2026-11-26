// Developer-only puzzle library generation. Never used by the mobile runtime.
//
// Run: dart run tool/generate_puzzle_library.dart OUTPUT.json [workers] [scale]
//
// Every puzzle comes from its own random solution grid, has exactly one
// solution and is fully solvable with MICHI's supported techniques. Its
// difficulty is assigned by `PuzzleAnalyzer`, the same rule the app uses.
// Generation is deterministic for a given worker count (fixed seeds).
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Puzzles wanted per difficulty, and the clue range that suits it.
const Map<PuzzleDifficulty, (int, int, int)> targets = {
  PuzzleDifficulty.easy: (800, 30, 38),
  PuzzleDifficulty.medium: (800, 26, 32),
  PuzzleDifficulty.advanced: (800, 24, 30),
  PuzzleDifficulty.expert: (300, 22, 30),
};

const analyzer = PuzzleAnalyzer(
  BacktrackingExactSolver(),
  DeterministicHumanSolver(),
);

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln('Usage: generate_puzzle_library.dart OUTPUT [workers]');
    exitCode = 64;
    return;
  }
  final workers = args.length > 1 ? int.parse(args[1]) : 8;
  // Optional third argument scales every target (e.g. 0.01 for a dry run).
  // Or exact counts "easy,medium,advanced,expert" to top up an earlier run.
  final counts = args.length > 2 && args[2].contains(',')
      ? args[2].split(',').map(int.parse).toList()
      : null;
  final scale = args.length > 2 && counts == null ? double.parse(args[2]) : 1.0;
  int wanted(PuzzleDifficulty d) =>
      counts?[d.index] ?? (targets[d]!.$1 * scale).ceil();
  final quotas = {
    for (final d in PuzzleDifficulty.values) d: (wanted(d) / workers).ceil(),
  };
  final stopwatch = Stopwatch()..start();
  final batches = await Future.wait([
    for (var worker = 0; worker < workers; worker++)
      Isolate.run(
        () => _work(20261126 + worker * 7919, quotas, '${args[0]}.part$worker'),
      ),
  ]);
  final byDifficulty = <PuzzleDifficulty, List<Map<String, Object>>>{};
  final seen = <String>{};
  for (final batch in batches) {
    for (final entry in batch) {
      final difficulty = PuzzleDifficulty.values.byName(
        entry['difficulty']! as String,
      );
      final list = byDifficulty.putIfAbsent(difficulty, () => []);
      if (list.length < wanted(difficulty) &&
          seen.add(entry['board']! as String)) {
        list.add(entry);
      }
    }
  }
  final output = [
    for (final difficulty in PuzzleDifficulty.values)
      ...byDifficulty[difficulty] ?? const <Map<String, Object>>[],
  ];
  File(args[0]).writeAsStringSync(jsonEncode(output));
  stdout.writeln(
    'Generated ${output.length} puzzles in '
    '${stopwatch.elapsed.inSeconds} s: '
    '${{for (final e in byDifficulty.entries) e.key.name: e.value.length}}',
  );
}

/// Each worker also appends its puzzles to [partPath] (one JSON per line),
/// so a long run can be stopped and merged without losing work.
List<Map<String, Object>> _work(
  int seed,
  Map<PuzzleDifficulty, int> quotas,
  String partPath,
) {
  final part = File(partPath).openSync(mode: FileMode.write);
  final clock = Stopwatch()..start();
  final random = Random(seed);
  final made = {for (final d in PuzzleDifficulty.values) d: 0};
  final result = <Map<String, Object>>[];
  var grids = 0;
  while (made.entries.any((e) => e.value < quotas[e.key]!) && grids < 2000000) {
    grids++;
    final snapshots = _carve(_solvedGrid(random), random);
    // Serve the difficulty that is furthest behind its quota.
    final needed =
        PuzzleDifficulty.values.where((d) => made[d]! < quotas[d]!).toList()
          ..sort(
            (a, b) => (made[a]! / quotas[a]!).compareTo(made[b]! / quotas[b]!),
          );
    for (final difficulty in needed) {
      final (_, low, high) = targets[difficulty]!;
      final fitting = snapshots
          .where(
            (s) =>
                s.$2 == difficulty &&
                s.$1.filledCellCount >= low &&
                s.$1.filledCellCount <= high,
          )
          .toList();
      if (fitting.isEmpty) continue;
      final board = fitting[random.nextInt(fitting.length)].$1;
      final analysis = analyzer.analyze(board);
      if (!analysis.isProductionReady || analysis.difficulty != difficulty) {
        continue;
      }
      result.add({
        'board': board.values.join(),
        'difficulty': difficulty.name,
        'requiredTechniques': [
          for (final t in SudokuTechnique.values)
            if (analysis.requiredTechniques.contains(t)) t.name,
        ],
        'dailyEligible': difficulty != PuzzleDifficulty.expert,
      });
      made[difficulty] = made[difficulty]! + 1;
      part
        ..writeStringSync('${jsonEncode(result.last)}\n')
        ..flushSync();
      if (result.length % 25 == 0) {
        stderr.writeln(
          '[$partPath] ${clock.elapsed.inSeconds}s grids=$grids '
          '${{for (final e in made.entries) e.key.name: e.value}}',
        );
      }
      break;
    }
  }
  part.closeSync();
  return result;
}

/// Removes clues in random order while the puzzle stays unique and
/// solvable with supported techniques; returns every accepted state with
/// its difficulty.
List<(SudokuBoard, PuzzleDifficulty)> _carve(
  SudokuBoard solved,
  Random random,
) {
  const exact = BacktrackingExactSolver();
  var board = solved;
  final states = <(SudokuBoard, PuzzleDifficulty)>[];
  final order = List<int>.generate(81, (i) => i)..shuffle(random);
  for (final index in order) {
    final candidate = board.withValue(CellRef.fromIndex(index), 0);
    if (candidate.filledCellCount > 40) {
      // Very full boards are easy; only uniqueness needs checking (cheap).
      if (exact.countSolutions(candidate) == 1) board = candidate;
      continue;
    }
    if (candidate.filledCellCount < 22) break;
    final analysis = analyzer.analyze(candidate);
    final difficulty = analysis.difficulty;
    if (!analysis.isProductionReady || difficulty == null) continue;
    board = candidate;
    states.add((board, difficulty));
  }
  return states;
}

/// A random complete grid by randomized backtracking.
SudokuBoard _solvedGrid(Random random) {
  final cells = List<int>.filled(81, 0);
  bool fill(int index) {
    if (index == 81) return true;
    final row = index ~/ 9;
    final column = index % 9;
    final digits = List<int>.generate(9, (d) => d + 1)..shuffle(random);
    for (final digit in digits) {
      var ok = true;
      for (var k = 0; k < 9 && ok; k++) {
        if (cells[row * 9 + k] == digit || cells[k * 9 + column] == digit) {
          ok = false;
        }
      }
      final boxRow = row - row % 3;
      final boxColumn = column - column % 3;
      for (var r = 0; r < 3 && ok; r++) {
        for (var c = 0; c < 3 && ok; c++) {
          if (cells[(boxRow + r) * 9 + boxColumn + c] == digit) ok = false;
        }
      }
      if (!ok) continue;
      cells[index] = digit;
      if (fill(index + 1)) return true;
      cells[index] = 0;
    }
    return false;
  }

  fill(0);
  return SudokuBoard.fromValues(cells);
}
