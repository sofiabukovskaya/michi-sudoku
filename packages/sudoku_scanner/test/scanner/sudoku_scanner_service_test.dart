import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  final geometry = GridGeometry([
    ImagePoint(0, 0),
    ImagePoint(1, 0),
    ImagePoint(1, 1),
    ImagePoint(0, 1),
  ]);

  test(
    'scanner contract preserves 81 recognized cells and confidence',
    () async {
      final result = SudokuScanResult(
        cells: [
          for (var row = 0; row < 9; row++)
            for (var column = 0; column < 9; column++)
              RecognizedCell(
                row: row,
                column: column,
                prediction: DigitPrediction(
                  digit: row == 0 && column == 0 ? 5 : null,
                  confidence: 0.9,
                ),
              ),
        ],
        geometry: geometry,
        overallConfidence: 0.9,
      );
      final SudokuScannerService scanner = _StubScanner(result);
      final scanned = await scanner.scan(
        ScanImage(bytes: [1], format: ScanImageFormat.jpeg),
      );
      expect(scanned.cells, hasLength(81));
      expect(scanned.cells.first.prediction.digit, 5);
      expect(scanned.cells[1].prediction.digit, isNull);
      expect(scanned.overallConfidence, 0.9);
      expect(scanned.cells.clear, throwsUnsupportedError);
    },
  );

  test('rejects incomplete scans and invalid confidence', () {
    expect(
      () => SudokuScanResult(
        cells: [],
        geometry: geometry,
        overallConfidence: 0.9,
      ),
      throwsArgumentError,
    );
    expect(
      () => DigitPrediction(digit: 1, confidence: 1.2),
      throwsRangeError,
    );
  });
}

final class _StubScanner implements SudokuScannerService {
  const _StubScanner(this.result);

  final SudokuScanResult result;

  @override
  Future<SudokuScanResult> scan(ScanImage image) async => result;
}
