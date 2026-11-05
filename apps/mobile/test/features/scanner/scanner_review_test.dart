import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:michi_mobile/features/scanner/presentation/scanner_page.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(430, 932),
  ]) {
    testWidgets('Review remains usable at ${size.width}×${size.height}', (
      tester,
    ) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = size;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      LocaleSettings.setLocaleSync(AppLocale.en);
      final cubit = _cubit();
      await cubit.scanImage(
        ScanImage(bytes: [1], format: ScanImageFormat.png),
      );
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            theme: AppTheme.light,
            home: ScannerPage(cubit: cubit),
          ),
        ),
      );
      await tester.pump();
      expect(find.byKey(const ValueKey('scan-cell-0')), findsOneWidget);
      expect(find.byKey(const ValueKey('scan-cell-80')), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byKey(const ValueKey('scan-cell-0')));
      await tester.pump();
      await tester.ensureVisible(find.byKey(const ValueKey('scan-clear')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('scan-clear')));
      expect(cubit.state.review!.board.valueAt(CellRef.fromIndex(0)), 0);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Review exposes conflict and confidence through cell semantics', (
    tester,
  ) async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    final cubit = _cubit(conflict: true);
    await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: ScannerPage(cubit: cubit),
        ),
      ),
    );
    final semantics = tester.getSemantics(
      find.byKey(const ValueKey('scan-cell-0')),
    );
    expect(semantics.label.toLowerCase(), contains('needs review'));
    expect(semantics.label.toLowerCase(), contains('conflicting clue'));
    expect(find.byKey(const ValueKey('scanner-confirm')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

ScannerCubit _cubit({bool conflict = false}) {
  final board = SudokuBoard.parse('''
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
  final recognized = conflict
      ? board.withValue(CellRef(row: 0, column: 1), 5)
      : board;
  return ScannerCubit(
    imageSource: _ImageSource(),
    scanner: _Scanner(
      SudokuScanResult(
        cells: [
          for (var index = 0; index < 81; index++)
            RecognizedCell(
              row: index ~/ 9,
              column: index % 9,
              prediction: DigitPrediction(
                digit: recognized.values[index] == 0
                    ? null
                    : recognized.values[index],
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
    importedPuzzles: _Imports(),
  );
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

final class _Imports implements ImportedPuzzleRepository {
  @override
  Future<void> save(PuzzleDefinition puzzle) async {}
  @override
  Future<PuzzleDefinition?> load(String id) async => null;
}
