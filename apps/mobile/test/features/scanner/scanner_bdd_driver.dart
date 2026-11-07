import 'package:camera/camera.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_cubit.dart';
import 'package:michi_mobile/features/game/data/drift_game_repository.dart';
import 'package:michi_mobile/features/game/data/game_database.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/application/scanner_state.dart';
import 'package:michi_mobile/features/scanner/data/drift_imported_puzzle_repository.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:michi_mobile/features/scanner/presentation/scanner_page.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

final _scenarios = Expando<_Scenario>();
final _cell = CellRef(row: 0, column: 0);
final _move = CellRef(row: 0, column: 2);
final _unique = SudokuBoard.parse('''
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

_Scenario _scenario(WidgetTester tester) => _scenarios[tester]!;

Future<void> openRecognizedReview(WidgetTester tester) async {
  final board = _unique.withValue(_cell, 1);
  final cubit = _createCubit(board, _MemoryImports());
  _scenarios[tester] = _Scenario(cubit);
  await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
  LocaleSettings.setLocaleSync(AppLocale.en);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: AppTheme.light,
        home: ScannerPage(cubit: cubit),
      ),
    ),
  );
  expect(cubit.state.phase, ScannerPhase.review);
  expect(cubit.state.review!.needsReview(_cell), isTrue);
}

Future<void> correctReviewClue(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('scan-cell-0')));
  await tester.pump();
  final digit = find.byKey(const ValueKey('scan-digit-5'));
  await tester.ensureVisible(digit);
  await tester.pumpAndSettle();
  await tester.tap(digit);
}

void expectCorrectedReview(WidgetTester tester) {
  final review = _scenario(tester).cubit.state.review!;
  expect(review.board.valueAt(_cell), 5);
  expect(review.needsReview(_cell), isFalse);
  expect(review.conflicts, isEmpty);
}

Future<void> openInvalidReview(WidgetTester tester) async {
  final board = _unique.withValue(CellRef(row: 0, column: 1), 5);
  final cubit = _createCubit(board, _MemoryImports());
  _scenarios[tester] = _Scenario(cubit);
  await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
  LocaleSettings.setLocaleSync(AppLocale.en);
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: AppTheme.light,
        home: ScannerPage(cubit: cubit),
      ),
    ),
  );
}

Future<void> confirmInvalidReview(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const ValueKey('scanner-confirm')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('scanner-confirm')));
}

void expectInvalidReview(WidgetTester tester) {
  final state = _scenario(tester).cubit.state;
  expect(state.phase, ScannerPhase.review);
  expect(state.review!.issue, ScannerReviewIssue.duplicateClues);
  expect(state.review!.conflicts, contains(_cell));
  expect(find.byKey(const ValueKey('scan-cell-0')), findsOneWidget);
}

Future<void> openUniqueImport(WidgetTester tester) async {
  final database = GameDatabase(NativeDatabase.memory());
  addTearDown(database.close);
  final imports = DriftImportedPuzzleRepository(database);
  final cubit = _createCubit(
    _unique.withValue(CellRef(row: 0, column: 1), 5),
    imports,
  );
  addTearDown(cubit.close);
  _scenarios[tester] = _Scenario(
    cubit,
    database: database,
    imported: imports,
  );
  await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
  cubit
    ..selectCell(1)
    ..editSelected(3);
  expect(cubit.state.review!.board, _unique);
}

Future<void> confirmUniqueImport(WidgetTester tester) async {
  await tester.runAsync(() => _scenario(tester).cubit.confirm());
  expect(_scenario(tester).cubit.state.phase, ScannerPhase.imported);
}

Future<void> expectImportedGame(WidgetTester tester) async {
  final scenario = _scenario(tester);
  final definition = scenario.cubit.state.imported!;
  expect(definition.source, PuzzleSource.imported);
  final games = DriftGameRepository(scenario.database!);
  scenario.games = games;
  final game = GameCubit(
    puzzle: definition.puzzle,
    exactSolver: const BacktrackingExactSolver(),
    humanSolver: const DeterministicHumanSolver(),
    coachEngine: const StructuredCoachEngine(),
    repository: games,
  );
  addTearDown(game.close);
  game
    ..selectCell(_cell)
    ..enterDigit(1);
  expect(game.state.board.valueAt(_cell), 5);
  game
    ..selectCell(_move)
    ..enterDigit(4)
    ..requestHint();
  expect(game.state.coach, isNotNull);
  await game.flushPersistence();
}

Future<void> expectRestoredImportedGame(WidgetTester tester) async {
  final scenario = _scenario(tester);
  final stored = (await scenario.games!.loadActiveGame())!;
  final definition = (await scenario.imported!.load(stored.puzzleId))!;
  expect(definition.initialBoard, _unique);
  final restored = GameCubit.restore(
    stored: stored,
    exactSolver: const BacktrackingExactSolver(),
    humanSolver: const DeterministicHumanSolver(),
    coachEngine: const StructuredCoachEngine(),
    repository: scenario.games,
  );
  addTearDown(restored.close);
  expect(restored.state.board.valueAt(_move), 4);
  expect(restored.state.puzzle.givens.valueAt(_cell), 5);
  restored
    ..resume()
    ..requestHint();
  expect(restored.state.coach, isNotNull);
}

ScannerCubit _createCubit(
  SudokuBoard board,
  ImportedPuzzleRepository imports,
) => ScannerCubit(
  imageSource: _ImageSource(),
  scanner: _Scanner(
    SudokuScanResult(
      cells: [
        for (var index = 0; index < 81; index++)
          RecognizedCell(
            row: index ~/ 9,
            column: index % 9,
            prediction: DigitPrediction(
              digit: board.values[index] == 0 ? null : board.values[index],
              confidence: index == 0 ? 0.5 : 0.95,
            ),
          ),
      ],
      geometry: GridGeometry([
        ImagePoint(0, 0),
        ImagePoint(9, 0),
        ImagePoint(9, 9),
        ImagePoint(0, 9),
      ]),
      overallConfidence: 0.94,
    ),
  ),
  analyzer: const PuzzleAnalyzer(
    BacktrackingExactSolver(),
    DeterministicHumanSolver(),
  ),
  importedPuzzles: imports,
);

final class _Scenario {
  _Scenario(this.cubit, {this.database, this.imported});
  final ScannerCubit cubit;
  final GameDatabase? database;
  final DriftImportedPuzzleRepository? imported;
  DriftGameRepository? games;
}

final class _ImageSource implements ScannerImageSource {
  @override
  CameraController? get controller => null;
  @override
  Future<CameraAccess> openCamera() async => CameraAccess.unavailable;
  @override
  Future<CameraAccess> requestCamera() async => CameraAccess.unavailable;
  @override
  Future<void> openSettings() async {}
  @override
  Future<ScanImage?> capture() async => null;
  @override
  Future<ScanImage?> selectPhoto() async => null;
  @override
  Future<void> closeCamera() async {}
}

final class _Scanner implements SudokuScannerService {
  const _Scanner(this.result);
  final SudokuScanResult result;
  @override
  Future<SudokuScanResult> scan(ScanImage image) async => result;
}

final class _MemoryImports implements ImportedPuzzleRepository {
  @override
  Future<void> save(PuzzleDefinition puzzle) async {}
  @override
  Future<PuzzleDefinition?> load(String id) async => null;
}
