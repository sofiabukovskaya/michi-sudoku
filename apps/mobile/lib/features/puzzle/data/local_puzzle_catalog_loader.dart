import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_catalog.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Decodes the reviewable, versioned asset once per loader lifetime.
final class LocalPuzzleCatalogLoader {
  LocalPuzzleCatalogLoader({AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  static const assetPath = 'assets/puzzles/classic_v1.json';
  final AssetBundle _bundle;
  late final Future<PuzzleCatalog> _catalog = _load();

  Future<PuzzleCatalog> load() => _catalog;

  Future<PuzzleCatalog> _load() async {
    try {
      return parse(await _bundle.loadString(assetPath));
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Cannot load bundled puzzle catalog: $error');
    }
  }

  static PuzzleCatalog parse(String source) {
    try {
      final root = jsonDecode(source);
      if (root is! Map<String, dynamic> ||
          root['version'] is! int ||
          root['puzzles'] is! List<dynamic>) {
        throw const FormatException('Invalid puzzle catalog schema.');
      }
      final version = root['version'] as int;
      final puzzles = <PuzzleDefinition>[];
      for (final value in root['puzzles'] as List<dynamic>) {
        if (value is! Map<String, dynamic> ||
            value['id'] is! String ||
            value['board'] is! String ||
            value['difficulty'] is! String ||
            value['requiredTechniques'] is! List<dynamic> ||
            value['dailyEligible'] is! bool) {
          throw const FormatException('Invalid puzzle entry schema.');
        }
        final techniques = <SudokuTechnique>{};
        for (final technique in value['requiredTechniques'] as List<dynamic>) {
          if (technique is! String) {
            throw const FormatException('Invalid technique identifier.');
          }
          techniques.add(SudokuTechnique.values.byName(technique));
        }
        puzzles.add(
          PuzzleDefinition(
            id: value['id'] as String,
            initialBoard: SudokuBoard.parse(value['board'] as String),
            difficulty: PuzzleDifficulty.values.byName(
              value['difficulty'] as String,
            ),
            requiredTechniques: techniques,
            contentVersion: version,
            dailyEligible: value['dailyEligible'] as bool,
          ),
        );
      }
      return PuzzleCatalog(version: version, puzzles: puzzles);
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Malformed puzzle catalog: $error');
    }
  }
}
