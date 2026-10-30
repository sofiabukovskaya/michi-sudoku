import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/presentation/widgets/post_game_technique_feedback.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.en));

  testWidgets('completion shows required and Coach-assisted techniques', (
    tester,
  ) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(
          home: Scaffold(
            body: PostGameTechniqueFeedback(
              requiredTechniques: {
                SudokuTechnique.nakedSingle,
                SudokuTechnique.nakedPair,
              },
              techniqueHelp: {SudokuTechnique.nakedPair: 3},
            ),
          ),
        ),
      ),
    );
    expect(find.text('Techniques in this puzzle'), findsOneWidget);
    expect(find.byKey(const ValueKey('required-nakedSingle')), findsOneWidget);
    expect(find.byKey(const ValueKey('required-nakedPair')), findsOneWidget);
    expect(find.byKey(const ValueKey('helped-nakedPair')), findsOneWidget);
    expect(find.byKey(const ValueKey('helped-nakedSingle')), findsNothing);
  });

  testWidgets('completion without hints says MICHI did not help', (
    tester,
  ) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(
          home: Scaffold(
            body: PostGameTechniqueFeedback(
              requiredTechniques: {SudokuTechnique.hiddenSingle},
              techniqueHelp: {},
            ),
          ),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('required-hiddenSingle')), findsOneWidget);
    expect(find.text('No hints used'), findsOneWidget);
  });
}
