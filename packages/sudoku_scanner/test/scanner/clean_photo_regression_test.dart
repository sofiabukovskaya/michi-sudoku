import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

import '../../tool/generate_manual_fixture.dart';

void main() {
  test(
    'clean perspective photo keeps blanks empty and most clues readable',
    () async {
      final image = ScanImage(
        bytes: img.encodePng(makeManualSudokuPhoto()),
        format: ScanImageFormat.png,
      );
      const scanner = LocalSudokuScannerService(
        detector: LocalGridDetector(),
        corrector: HomographyPerspectiveCorrector(),
        segmenter: InsetCellSegmenter(),
        classifier: TemplateDigitClassifier(),
      );
      final result = await scanner.scan(image);
      const expected =
          '530070000600195000098000060800060003400803001'
          '700020006060000280000419005000080079';
      final predicted = [
        for (final cell in result.cells) cell.prediction.digit ?? 0,
      ];
      var correctClues = 0;
      for (var index = 0; index < 81; index++) {
        final given = int.parse(expected[index]);
        if (given == 0) {
          expect(predicted[index], 0, reason: 'blank cell $index');
        } else if (predicted[index] == given) {
          correctClues++;
        }
      }
      expect(correctClues, greaterThanOrEqualTo(20));
      expect(result.cells, hasLength(81));
    },
  );
}
