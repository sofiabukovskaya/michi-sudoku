import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// A game in progress as widgets show it: a mini-board and progress only.
final class WidgetGame {
  WidgetGame({
    required SudokuBoard givens,
    required SudokuBoard current,
    required this.daily,
  }) : board = current.values.join(),
       givenMask = givens.values.map((v) => v == 0 ? '0' : '1').join(),
       total = givens.values.where((v) => v == 0).length,
       filled = [
         for (var i = 0; i < 81; i++)
           if (givens.values[i] == 0 && current.values[i] != 0) i,
       ].length;

  /// 81 digits, row by row; 0 is empty.
  final String board;

  /// 81 flags, row by row; 1 marks a printed given.
  final String givenMask;
  final int filled;
  final int total;
  final bool daily;

  Map<String, Object> toJson() => {
    'board': board,
    'givens': givenMask,
    'filled': filled,
    'total': total,
    'daily': daily,
  };
}

/// What the Home Screen and Lock Screen widgets show.
final class WidgetSnapshot {
  const WidgetSnapshot({
    required this.day,
    required this.difficulty,
    required this.dailyDone,
    required this.streak,
    required this.week,
    required this.game,
  });

  /// `yyyy-MM-dd` of today's Daily.
  final String day;
  final String? difficulty;
  final bool dailyDone;
  final int streak;

  /// Monday to Sunday: whether a puzzle was finished that day.
  final List<bool> week;
  final WidgetGame? game;

  String toJson() => jsonEncode({
    'day': day,
    'difficulty': difficulty,
    'dailyDone': dailyDone,
    'streak': streak,
    'week': week,
    'game': game?.toJson(),
  });
}

/// iOS widgets and the "game waiting" Live Activity. Silent elsewhere and
/// whenever the platform side is missing (tests, older systems).
abstract final class IosWidgets {
  static const _widgets = MethodChannel('michi/daily');
  static const _activity = MethodChannel('michi/activity');

  static bool get _enabled =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  static Future<void> publish(WidgetSnapshot snapshot) =>
      _call(_widgets, 'snapshot', snapshot.toJson());

  /// Shown on the Lock Screen and in the Dynamic Island while a game waits
  /// in the background.
  static Future<void> showGameWaiting(WidgetGame game, Duration elapsed) =>
      _call(
        _activity,
        'show',
        jsonEncode({...game.toJson(), 'elapsed': elapsed.inSeconds}),
      );

  static Future<void> endGameWaiting() => _call(_activity, 'end', null);

  static Future<void> _call(
    MethodChannel channel,
    String method,
    Object? arguments,
  ) async {
    if (!_enabled) return;
    try {
      await channel.invokeMethod<void>(method, arguments);
    } on MissingPluginException {
      // Widget extensions are optional in embedded and test runners.
    } on PlatformException catch (error) {
      developer.log('iOS widget update unavailable', error: error);
    }
  }
}
