import '../model/scan_image.dart';
import '../model/scan_result.dart';

/// Orchestrates recognition only; Sudoku validation belongs to the app/engine.
abstract interface class SudokuScannerService {
  Future<SudokuScanResult> scan(ScanImage image);
}
