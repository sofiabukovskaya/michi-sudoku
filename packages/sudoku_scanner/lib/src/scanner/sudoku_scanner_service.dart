import '../model/grid_geometry.dart';
import '../model/scan_focus.dart';
import '../model/scan_image.dart';
import '../model/scan_result.dart';

/// Orchestrates recognition only; Sudoku validation belongs to the app/engine.
abstract interface class SudokuScannerService {
  /// [focus] is the frame the player aimed with. [grid] scans a grid the
  /// player chose after a `multipleGrids` scan failure; it refers
  /// to that failure's image.
  Future<SudokuScanResult> scan(
    ScanImage image, {
    ScanFocus? focus,
    GridGeometry? grid,
  });
}
