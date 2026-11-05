import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  const classifier = TemplateDigitClassifier();

  test(
    'blank inset cell is recognized as empty with bounded confidence',
    () async {
      final image = img.Image(width: 84, height: 84);
      img.fill(image, color: img.ColorRgb8(250, 250, 250));
      final prediction = await classifier.classify(
        ScanImage(bytes: img.encodePng(image), format: ScanImageFormat.png),
      );
      expect(prediction.digit, isNull);
      expect(prediction.confidence, inInclusiveRange(0, 1));
      expect(prediction.confidence, greaterThan(0.9));
    },
  );

  test(
    'interim template recognition returns a real digit and cautious score',
    () async {
      final image = img.Image(width: 84, height: 84);
      img.fill(image, color: img.ColorRgb8(250, 250, 250));
      const eight = '01110100011000101110100011000101110';
      for (var y = 0; y < 7; y++) {
        for (var x = 0; x < 5; x++) {
          if (eight[y * 5 + x] == '1') {
            img.fillRect(
              image,
              x1: 17 + x * 10,
              y1: 7 + y * 10,
              x2: 25 + x * 10,
              y2: 15 + y * 10,
              color: img.ColorRgb8(20, 20, 20),
            );
          }
        }
      }
      final prediction = await classifier.classify(
        ScanImage(bytes: img.encodePng(image), format: ScanImageFormat.png),
      );
      expect(prediction.digit, 8);
      expect(prediction.confidence, inInclusiveRange(0.2, 0.82));
    },
  );
}
