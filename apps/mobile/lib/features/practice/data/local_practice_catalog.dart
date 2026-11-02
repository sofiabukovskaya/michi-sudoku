import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:michi_mobile/features/practice/domain/technique_practice_scenario.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class LocalPracticeCatalog {
  LocalPracticeCatalog({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  static const assetPath = 'assets/practice/practice_v1.json';
  final AssetBundle _bundle;
  late final Future<List<TechniquePracticeScenario>> _scenarios = _load();

  Future<List<TechniquePracticeScenario>> load() => _scenarios;

  Future<List<TechniquePracticeScenario>> forTechnique(
    SudokuTechnique technique,
  ) async => List<TechniquePracticeScenario>.unmodifiable(
    (await load()).where((scenario) => scenario.technique == technique),
  );

  Future<List<TechniquePracticeScenario>> _load() async {
    try {
      return parse(await _bundle.loadString(assetPath));
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Cannot load practice catalog: $error');
    }
  }

  static List<TechniquePracticeScenario> parse(String source) {
    try {
      final root = jsonDecode(source);
      if (root is! Map<String, dynamic> ||
          root['version'] is! int ||
          root['scenarios'] is! List<dynamic>) {
        throw const FormatException('Invalid practice catalog schema.');
      }
      final version = root['version'] as int;
      if (version < 1) throw const FormatException('Invalid catalog version.');
      final scenarios = <TechniquePracticeScenario>[];
      final ids = <String>{};
      for (final raw in root['scenarios'] as List<dynamic>) {
        if (raw is! Map<String, dynamic> ||
            raw['id'] is! String ||
            raw['board'] is! String ||
            raw['technique'] is! String ||
            !ids.add(raw['id'] as String)) {
          throw const FormatException('Invalid practice scenario.');
        }
        final technique = SudokuTechnique.values.byName(
          raw['technique'] as String,
        );
        scenarios.add(
          TechniquePracticeScenario(
            id: raw['id'] as String,
            technique: technique,
            board: SudokuBoard.parse(raw['board'] as String),
            contentVersion: version,
            candidateOverrides: {
              for (final entry
                  in (raw['candidateOverrides'] as Map<String, dynamic>? ??
                          const <String, dynamic>{})
                      .entries)
                int.parse(entry.key): entry.value as int,
            },
          ),
        );
      }
      if (scenarios.isEmpty) throw const FormatException('Empty catalog.');
      return List<TechniquePracticeScenario>.unmodifiable(scenarios);
    } on FormatException {
      rethrow;
    } on Object catch (error) {
      throw FormatException('Malformed practice catalog: $error');
    }
  }
}
