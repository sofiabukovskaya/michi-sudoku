import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Run with `flutter pub run tool/validate_content_release.dart SOURCE OUTPUT`.
Future<void> main(List<String> args) async {
  if (args.length != 2) {
    stderr.writeln('Usage: validate_content_release.dart SOURCE OUTPUT');
    exitCode = 64;
    return;
  }
  final source = jsonDecode(await File(args[0]).readAsString());
  if (source is! Map<String, dynamic> ||
      source['releaseId'] is! String ||
      source['contentVersion'] is! int ||
      source['puzzles'] is! List<dynamic>) {
    throw const FormatException('Invalid release source.');
  }
  final releaseId = source['releaseId'] as String;
  final version = source['contentVersion'] as int;
  if (!RegExp(r'^[a-z0-9_-]+$').hasMatch(releaseId) || version < 1) {
    throw const FormatException('Invalid release identity.');
  }
  const analyzer = PuzzleAnalyzer(
    BacktrackingExactSolver(),
    DeterministicHumanSolver(),
  );
  final ids = <String>{};
  final validated = <Map<String, Object>>[];
  for (final value in source['puzzles'] as List<dynamic>) {
    if (value is! Map<String, dynamic> ||
        value['id'] is! String ||
        value['board'] is! String ||
        value['difficulty'] is! String ||
        value['requiredTechniques'] is! List<dynamic> ||
        value['dailyEligible'] is! bool) {
      throw const FormatException('Invalid puzzle source entry.');
    }
    final id = value['id'] as String;
    if (!ids.add(id) || !RegExp(r'^[a-z0-9_]+$').hasMatch(id)) {
      throw FormatException('Duplicate or invalid puzzle ID: $id');
    }
    final board = SudokuBoard.parse(value['board'] as String);
    final declared = (value['requiredTechniques'] as List<dynamic>)
        .cast<String>()
        .map(SudokuTechnique.values.byName)
        .toSet();
    final analysis = analyzer.analyze(board);
    if (!analysis.isProductionReady ||
        analysis.difficulty?.name != value['difficulty'] ||
        !analysis.requiredTechniques.containsAll(declared) ||
        !declared.containsAll(analysis.requiredTechniques)) {
      throw FormatException(
        'Puzzle $id failed Dart validation: '
        'ready=${analysis.isProductionReady}, '
        'expected=${analysis.difficulty?.name}, '
        'techniques=${analysis.requiredTechniques.map((e) => e.name).toList()}',
      );
    }
    validated.add({
      'id': id,
      'board': board.values.join(),
      'difficulty': (value['difficulty'] as String),
      'requiredTechniques': declared.map((e) => e.name).toList()..sort(),
      'dailyEligible': value['dailyEligible'] as bool,
    });
  }
  if (validated.isEmpty) throw const FormatException('Empty release.');
  validated.sort((a, b) => (a['id']! as String).compareTo(b['id']! as String));
  final payload = <String, Object>{
    'schemaVersion': 1,
    'releaseId': releaseId,
    'contentVersion': version,
    'puzzles': validated,
  };
  final canonical = jsonEncode(payload);
  final artifact = {
    ...payload,
    'sha256': sha256.convert(utf8.encode(canonical)).toString(),
  };
  final output = File(args[1]);
  await output.parent.create(recursive: true);
  await output.writeAsString(
    '${const JsonEncoder.withIndent('  ').convert(artifact)}\n',
  );
  stdout.writeln('Validated ${validated.length} puzzles → ${output.path}');
}
