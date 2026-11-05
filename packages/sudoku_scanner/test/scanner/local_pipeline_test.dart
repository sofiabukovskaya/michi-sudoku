import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

import '../fixtures/synthetic_scan_images.dart';

void main() {
  const detector = LocalGridDetector();
  const corrector = HomographyPerspectiveCorrector();
  const segmenter = InsetCellSegmenter();

  test('clean printed grid has ordered deterministic corners', () async {
    final image = syntheticGrid();
    final first = await detector.detect(image);
    final second = await detector.detect(image);
    expect(first, isNotNull);
    expect(first!.corners, second!.corners);
    expect(first.topLeft.x, lessThan(first.topRight.x));
    expect(first.topLeft.y, lessThan(first.bottomLeft.y));
    expect(first.bottomRight.x, greaterThan(first.bottomLeft.x));
  });

  test('mild perspective and uneven lighting still locate grid', () async {
    final found = await detector.detect(
      syntheticGrid(perspective: true, unevenLight: true, thick: true),
    );
    expect(found, isNotNull);
    expect(found!.topLeft.x, closeTo(85, 35));
    expect(found.bottomRight.y, closeTo(640, 35));
  });

  test('no Sudoku does not produce fake geometry', () async {
    expect(await detector.detect(syntheticBlank()), isNull);
  });

  test(
    'homography rectifies to 900 square and 81 ordered inset cells',
    () async {
      final source = syntheticGrid(perspective: true);
      final geometry = (await detector.detect(source))!;
      final normalized = await corrector.correct(source, geometry);
      final bitmap = img.decodeImage(Uint8List.fromList(normalized.bytes))!;
      expect(bitmap.width, 900);
      expect(bitmap.height, 900);
      final cells = await segmenter.segment(normalized);
      expect(cells, hasLength(81));
      expect(cells.first.row, 0);
      expect(cells.first.column, 0);
      expect(cells.last.row, 8);
      expect(cells.last.column, 8);
      final first = img.decodeImage(
        Uint8List.fromList(cells.first.image.bytes),
      )!;
      expect(first.width, inInclusiveRange(60, 90));
      expect(first.height, inInclusiveRange(60, 90));
    },
  );

  test('invalid geometry is rejected', () {
    expect(
      () => GridGeometry([
        ImagePoint(0, 0),
        ImagePoint(1, 1),
        ImagePoint(1, 0),
        ImagePoint(0, 1),
      ]),
      throwsArgumentError,
    );
  });

  test(
    'real geometry and segmentation feed replaceable recognition in order',
    () async {
      final classifier = _IndexedClassifier();
      final service = LocalSudokuScannerService(
        detector: detector,
        corrector: corrector,
        segmenter: segmenter,
        classifier: classifier,
      );
      final result = await service.scan(syntheticGrid(perspective: true));
      expect(result.cells, hasLength(81));
      expect(classifier.calls, 81);
      expect(result.cells[0].prediction.digit, 1);
      expect(result.cells[8].prediction.digit, 9);
      expect(result.cells[9].prediction.digit, 1);
      expect(result.overallConfidence, closeTo(0.75, 0.0001));
      expect(result.geometry.topLeft.x, lessThan(result.geometry.topRight.x));
    },
  );
}

final class _IndexedClassifier implements DigitClassifier {
  int calls = 0;

  @override
  Future<DigitPrediction> classify(ScanImage cellImage) async {
    expect(cellImage.bytes, isNotEmpty);
    return DigitPrediction(digit: calls++ % 9 + 1, confidence: 0.75);
  }
}
