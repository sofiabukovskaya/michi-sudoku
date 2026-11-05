import 'dart:developer' as developer;

import '../grid/cell_segmenter.dart';
import '../grid/grid_detector.dart';
import '../grid/perspective_corrector.dart';
import '../image/scan_image_codec.dart';
import '../model/recognized_cell.dart';
import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import '../model/scan_result.dart';
import '../recognition/digit_classifier.dart';
import 'sudoku_scanner_service.dart';

/// Pipeline composition. Phase 14 replaces only [DigitClassifier].
final class LocalSudokuScannerService implements SudokuScannerService {
  const LocalSudokuScannerService({
    required this.detector,
    required this.corrector,
    required this.segmenter,
    required this.classifier,
  });

  final GridDetector detector;
  final PerspectiveCorrector corrector;
  final CellSegmenter segmenter;
  final DigitClassifier classifier;

  @override
  Future<SudokuScanResult> scan(ScanImage image) async {
    final stopwatch = Stopwatch()..start();
    final normalized = await ScanImageCodec.normalize(image);
    _log('decode', stopwatch);
    final geometry = await detector.detect(normalized);
    _log('grid', stopwatch);
    if (geometry == null) throw const ScanFailure(ScanFailureKind.noGridFound);
    final corrected = await corrector.correct(normalized, geometry);
    _log('perspective', stopwatch);
    final cells = await segmenter.segment(corrected);
    _log('segmentation', stopwatch);
    if (cells.length != 81) {
      throw const ScanFailure(ScanFailureKind.segmentationFailure);
    }
    final recognized = <RecognizedCell>[];
    for (var index = 0; index < 81; index++) {
      final cell = cells[index];
      if (cell.row * 9 + cell.column != index) {
        throw const ScanFailure(ScanFailureKind.segmentationFailure);
      }
      try {
        recognized.add(
          RecognizedCell(
            row: cell.row,
            column: cell.column,
            prediction: await classifier.classify(cell.image),
          ),
        );
      } on ScanFailure {
        rethrow;
      } on Object {
        throw const ScanFailure(ScanFailureKind.recognitionFailure);
      }
    }
    _log('recognition', stopwatch);
    final confidence =
        recognized.fold<double>(
          0,
          (sum, cell) => sum + cell.prediction.confidence,
        ) /
        81;
    return SudokuScanResult(
      cells: recognized,
      geometry: geometry,
      overallConfidence: confidence,
    );
  }

  void _log(String stage, Stopwatch stopwatch) {
    developer.log(
      '$stage: ${stopwatch.elapsedMilliseconds} ms',
      name: 'michi.scanner',
    );
    stopwatch.reset();
  }
}
