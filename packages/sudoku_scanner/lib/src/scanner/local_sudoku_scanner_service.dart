import 'dart:developer' as developer;

import '../grid/cell_segmenter.dart';
import '../grid/grid_detector.dart';
import '../grid/perspective_corrector.dart';
import '../image/scan_image_codec.dart';
import '../model/grid_geometry.dart';
import '../model/recognized_cell.dart';
import '../model/scan_failure.dart';
import '../model/scan_focus.dart';
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
  Future<SudokuScanResult> scan(
    ScanImage image, {
    ScanFocus? focus,
    GridGeometry? grid,
  }) async {
    final stopwatch = Stopwatch()..start();
    // A chosen grid refers to the already upright image of the failure.
    final normalized = grid == null
        ? await ScanImageCodec.normalize(image)
        : image;
    _log('decode', stopwatch);
    final geometry = grid ?? await _selectGrid(normalized, focus);
    _log('grid', stopwatch);
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
            image: cell.image,
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

  /// The frame decides first: the search is limited to it (with a margin),
  /// and only if nothing is there does the whole photo count. Two similar
  /// grids with no frame preference are the player's choice, never a guess.
  Future<GridGeometry> _selectGrid(ScanImage image, ScanFocus? focus) async {
    if (focus != null) {
      final framed = await detector.candidates(
        image,
        region: focus.expand(0.08),
      );
      if (framed.length == 1) return framed.first;
      if (framed.length > 1) return _decide(image, framed);
    }
    final all = await detector.candidates(image);
    if (all.isEmpty) throw const ScanFailure(ScanFailureKind.noGridFound);
    return _decide(image, all);
  }

  GridGeometry _decide(ScanImage image, List<GridGeometry> grids) {
    if (grids.length == 1) return grids.first;
    final first = _area(grids[0]);
    final second = _area(grids[1]);
    // A clearly dominant grid is the one being photographed.
    if (second < first * 0.5) return grids.first;
    throw ScanFailure(
      ScanFailureKind.multipleGrids,
      image: image,
      candidates: [
        for (final grid in grids)
          if (_area(grid) >= first * 0.5) grid,
      ],
    );
  }

  static double _area(GridGeometry grid) {
    var sum = 0.0;
    for (var i = 0; i < 4; i++) {
      final a = grid.corners[i];
      final b = grid.corners[(i + 1) % 4];
      sum += a.x * b.y - b.x * a.y;
    }
    return sum.abs() / 2;
  }

  void _log(String stage, Stopwatch stopwatch) {
    developer.log(
      '$stage: ${stopwatch.elapsedMilliseconds} ms',
      name: 'michi.scanner',
    );
    stopwatch.reset();
  }
}
