import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

import '../fixtures/synthetic_scan_images.dart';

/// A book page with two puzzles side by side, the right one slightly larger.
ScanImage _twoPuzzlePage() {
  final grid = img.decodeImage(Uint8List.fromList(syntheticGrid().bytes))!;
  final page = img.Image(width: 1400, height: 760);
  img.fill(page, color: img.ColorRgb8(250, 250, 250));
  img.compositeImage(
    page,
    img.copyResize(grid, width: 620),
    dstX: 20,
    dstY: 70,
  );
  img.compositeImage(page, img.copyResize(grid, width: 700), dstX: 680);
  return ScanImage(bytes: img.encodePng(page), format: ScanImageFormat.png);
}

final class _Empty implements DigitClassifier {
  @override
  Future<DigitPrediction> classify(ScanImage cellImage) async =>
      DigitPrediction(digit: null, confidence: 1);
}

double _centreX(GridGeometry grid) =>
    grid.corners.fold<double>(0, (sum, p) => sum + p.x) / 4;

void main() {
  const detector = LocalGridDetector();
  final scanner = LocalSudokuScannerService(
    detector: detector,
    corrector: const HomographyPerspectiveCorrector(),
    segmenter: const InsetCellSegmenter(),
    classifier: _Empty(),
  );

  test('every puzzle on a page is a candidate, largest first', () async {
    final grids = await detector.candidates(_twoPuzzlePage());
    expect(grids, hasLength(2));
    expect(_centreX(grids.first), greaterThan(700));
    expect(_centreX(grids.last), lessThan(700));
  });

  test('the puzzle inside the scanning frame wins over a larger one', () async {
    final result = await scanner.scan(
      _twoPuzzlePage(),
      focus: const ScanFocus(left: 0, top: 0, right: 0.47, bottom: 1),
    );
    expect(_centreX(result.geometry), lessThan(700));
  });

  test('two similar puzzles and no frame ask the player to choose', () async {
    final failure = await scanner
        .scan(_twoPuzzlePage())
        .then<ScanFailure?>(
          (_) => null,
          onError: (Object e) => e as ScanFailure,
        );
    expect(failure?.kind, ScanFailureKind.multipleGrids);
    expect(failure!.candidates, hasLength(2));
    expect(failure.image, isNotNull);

    final chosen = await scanner.scan(
      failure.image!,
      grid: failure.candidates.last,
    );
    expect(_centreX(chosen.geometry), lessThan(700));
    expect(chosen.cells, hasLength(81));
  });
}
