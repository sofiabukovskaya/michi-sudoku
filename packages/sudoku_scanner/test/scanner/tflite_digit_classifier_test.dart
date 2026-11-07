import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'versioned TFLite asset classifies blank and printed digit cells',
    () async {
      final classifier = TFLiteDigitClassifier();
      addTearDown(classifier.close);
      ScanImage fixture(int index) => ScanImage(
        bytes: File(
          'test/fixtures/model_input/cell_${index.toString().padLeft(2, '0')}.png',
        ).readAsBytesSync(),
        format: ScanImageFormat.png,
      );

      final cases =
          (jsonDecode(
                    File(
                      'test/fixtures/model_input/cases.json',
                    ).readAsStringSync(),
                  )
                  as List<dynamic>)
              .cast<Map<String, dynamic>>();
      for (final entry in cases) {
        final image = ScanImage(
          bytes: File(
            'test/fixtures/model_input/${entry['image']}',
          ).readAsBytesSync(),
          format: ScanImageFormat.png,
        );
        final prediction = await classifier.classify(image);
        final expectedClass = entry['prediction'] as int;
        expect(prediction.digit, expectedClass == 0 ? null : expectedClass);
        expect(
          prediction.confidence,
          closeTo(entry['confidence'] as double, 0.02),
        );
      }
      final blank = await classifier.classify(fixture(2));
      final five = await classifier.classify(fixture(0));
      expect(blank.digit, isNull);
      expect(five.digit, 5);
      expect(blank.confidence, inInclusiveRange(0, 1));
      expect(five.confidence, inInclusiveRange(0, 1));

      // The production service calls the same classifier 81 times per board.
      for (var index = 0; index < 81; index++) {
        final prediction = await classifier.classify(fixture(index % 3));
        expect(prediction.confidence, inInclusiveRange(0, 1));
      }
      await classifier.close();
      expect(() => classifier.classify(fixture(2)), throwsStateError);
    },
  );

  test(
    'malformed encoded input remains a structured recognition failure',
    () async {
      final classifier = TFLiteDigitClassifier();
      addTearDown(classifier.close);
      expect(
        () => classifier.classify(
          ScanImage(bytes: [1, 2, 3], format: ScanImageFormat.png),
        ),
        throwsA(
          isA<ScanFailure>().having(
            (failure) => failure.kind,
            'kind',
            ScanFailureKind.recognitionFailure,
          ),
        ),
      );
    },
  );
}
