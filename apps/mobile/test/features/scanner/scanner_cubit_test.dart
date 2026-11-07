import 'dart:async';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/application/scanner_state.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  final unique = SudokuBoard.parse('''
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
  final invalid = unique.withValue(CellRef(row: 0, column: 1), 5);
  final impossible = SudokuBoard.parse('''
    123456780
    000000009
    000000000
    000000000
    000000000
    000000000
    000000000
    000000000
    000000000
  ''');
  final empty = SudokuBoard.fromValues(List<int>.filled(81, 0));

  ScannerCubit create(
    SudokuBoard board,
    _MemoryImports saved, {
    double confidence = 0.98,
  }) => ScannerCubit(
    imageSource: _ImageSource(),
    scanner: _Scanner(_result(board, confidence)),
    analyzer: const PuzzleAnalyzer(
      BacktrackingExactSolver(),
      DeterministicHumanSolver(),
    ),
    importedPuzzles: saved,
  );

  test(
    'given recognized clues, review edits and clear update an immutable board',
    () async {
      final cubit = create(unique, _MemoryImports(), confidence: 0.55);
      addTearDown(cubit.close);
      await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
      expect(cubit.state.phase, ScannerPhase.review);
      expect(cubit.state.review!.lowConfidenceCount, 81);
      cubit
        ..selectCell(0)
        ..editSelected(0);
      expect(cubit.state.review!.board.valueAt(CellRef.fromIndex(0)), 0);
      expect(unique.valueAt(CellRef.fromIndex(0)), 5);
      expect(cubit.state.review!.lowConfidenceCount, 80);
      cubit.editSelected(5);
      expect(cubit.state.review!.board, unique);
    },
  );

  test('given duplicate clues, confirmation remains in Review', () async {
    final saved = _MemoryImports();
    final cubit = create(invalid, saved);
    addTearDown(cubit.close);
    await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
    expect(
      cubit.state.review!.conflicts,
      containsAll([CellRef(row: 0, column: 0), CellRef(row: 0, column: 1)]),
    );
    await cubit.confirm();
    expect(cubit.state.phase, ScannerPhase.review);
    expect(cubit.state.review!.issue, ScannerReviewIssue.duplicateClues);
    expect(saved.items, isEmpty);
  });

  test(
    'given zero-candidate and multi-solution boards, import is rejected',
    () async {
      for (final (board, issue) in [
        (impossible, ScannerReviewIssue.noSolution),
        (empty, ScannerReviewIssue.multipleSolutions),
      ]) {
        final saved = _MemoryImports();
        final cubit = create(board, saved);
        await cubit.scanImage(
          ScanImage(bytes: [1], format: ScanImageFormat.png),
        );
        await cubit.confirm();
        expect(cubit.state.phase, ScannerPhase.review);
        expect(cubit.state.review!.issue, issue);
        expect(saved.items, isEmpty);
        await cubit.close();
      }
    },
  );

  test(
    'given a corrected unique puzzle, import keeps content identity',
    () async {
      final saved = _MemoryImports();
      final cubit = create(invalid, saved);
      addTearDown(cubit.close);
      await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
      cubit
        ..selectCell(1)
        ..editSelected(3);
      await cubit.confirm();
      expect(cubit.state.phase, ScannerPhase.imported);
      final puzzle = cubit.state.imported!;
      expect(puzzle.source, PuzzleSource.imported);
      expect(puzzle.initialBoard, unique);
      expect(puzzle.dailyEligible, isFalse);
      expect(
        puzzle.id,
        PuzzleDefinition.imported(
          board: unique,
          humanSolverFullySupported: true,
          requiredTechniques: const [],
        ).id,
      );
      expect(saved.items[puzzle.id], same(puzzle));
    },
  );

  test('validation isolate does not capture platform image source', () async {
    final port = RawReceivePort();
    addTearDown(port.close);
    final cubit = ScannerCubit(
      imageSource: _ImageSource(port),
      scanner: _Scanner(_result(unique, 0.9)),
      analyzer: const PuzzleAnalyzer(
        BacktrackingExactSolver(),
        DeterministicHumanSolver(),
      ),
      importedPuzzles: _MemoryImports(),
    );
    addTearDown(cubit.close);
    await cubit.scanImage(ScanImage(bytes: [1], format: ScanImageFormat.png));
    await cubit.confirm();
    expect(cubit.state.phase, ScannerPhase.imported);
  });

  test('rescan invalidates an in-flight scan result', () async {
    final source = _ImageSource();
    final scanner = _DeferredScanner();
    final cubit = ScannerCubit(
      imageSource: source,
      scanner: scanner,
      analyzer: const PuzzleAnalyzer(
        BacktrackingExactSolver(),
        DeterministicHumanSolver(),
      ),
      importedPuzzles: _MemoryImports(),
    );
    addTearDown(cubit.close);
    final pending = cubit.scanImage(
      ScanImage(bytes: [1], format: ScanImageFormat.png),
    );
    await Future<void>.delayed(Duration.zero);
    cubit.rescan();
    scanner.finish(_result(unique, 0.9));
    await pending;
    expect(cubit.state.phase, ScannerPhase.capture);
  });
}

SudokuScanResult _result(SudokuBoard board, double confidence) =>
    SudokuScanResult(
      cells: [
        for (var index = 0; index < 81; index++)
          RecognizedCell(
            row: index ~/ 9,
            column: index % 9,
            prediction: DigitPrediction(
              digit: board.values[index] == 0 ? null : board.values[index],
              confidence: confidence,
            ),
          ),
      ],
      geometry: GridGeometry([
        ImagePoint(0, 0),
        ImagePoint(9, 0),
        ImagePoint(9, 9),
        ImagePoint(0, 9),
      ]),
      overallConfidence: confidence,
    );

final class _ImageSource implements ScannerImageSource {
  _ImageSource([this.port]);

  final RawReceivePort? port;

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

final class _DeferredScanner implements SudokuScannerService {
  final _pending = Completer<SudokuScanResult>();
  void finish(SudokuScanResult result) => _pending.complete(result);
  @override
  Future<SudokuScanResult> scan(ScanImage image) => _pending.future;
}

final class _MemoryImports implements ImportedPuzzleRepository {
  final items = <String, PuzzleDefinition>{};
  @override
  Future<void> save(PuzzleDefinition puzzle) async {
    items[puzzle.id] = puzzle;
  }

  @override
  Future<PuzzleDefinition?> load(String id) async => items[id];
}
