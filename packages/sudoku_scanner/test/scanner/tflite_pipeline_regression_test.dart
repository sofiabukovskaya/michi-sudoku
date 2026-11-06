import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

import '../../tool/generate_manual_fixture.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('unchanged Phase 13 photo needs fewer than seven corrections', () async {
    final classifier = TFLiteDigitClassifier();
    addTearDown(classifier.close);
    final scanner = LocalSudokuScannerService(
      detector: const LocalGridDetector(),
      corrector: const HomographyPerspectiveCorrector(),
      segmenter: const InsetCellSegmenter(),
      classifier: classifier,
    );
    final result = await scanner.scan(
      ScanImage(
        bytes: img.encodePng(makeManualSudokuPhoto()),
        format: ScanImageFormat.png,
      ),
    );
    const truth =
        '530070000600195000098000060800060003400803001'
        '700020006060000280000419005000080079';
    final correctedCells = [
      for (var index = 0; index < 81; index++)
        if ((result.cells[index].prediction.digit ?? 0) !=
            int.parse(truth[index]))
          index,
    ];
    expect(correctedCells, hasLength(2));
    expect(result.cells, hasLength(81));
  });
}
