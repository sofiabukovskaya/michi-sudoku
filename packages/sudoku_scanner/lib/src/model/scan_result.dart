import 'grid_geometry.dart';
import 'recognized_cell.dart';

/// Raw recognition output; the app must confirm and validate it later.
final class SudokuScanResult {
  SudokuScanResult({
    required List<RecognizedCell> cells,
    required this.geometry,
    required this.overallConfidence,
  }) : cells = List<RecognizedCell>.unmodifiable(cells) {
    if (this.cells.length != 81 ||
        this.cells.map((cell) => cell.row * 9 + cell.column).toSet().length !=
            81) {
      throw ArgumentError.value(cells, 'cells', 'Expected 81 unique cells.');
    }
    if (!overallConfidence.isFinite ||
        overallConfidence < 0 ||
        overallConfidence > 1) {
      throw RangeError.range(overallConfidence, 0, 1, 'overallConfidence');
    }
  }

  final List<RecognizedCell> cells;
  final GridGeometry geometry;
  final double overallConfidence;
}
