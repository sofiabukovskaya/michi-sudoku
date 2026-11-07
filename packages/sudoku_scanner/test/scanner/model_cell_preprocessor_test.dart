import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_scanner/src/recognition/model_cell_preprocessor.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  test('Python and Dart produce equivalent 32×32 grayscale tensors', () {
    const directory = 'test/fixtures/model_input';
    final cases =
        (jsonDecode(
                  File('$directory/cases.json').readAsStringSync(),
                )
                as List<dynamic>)
            .cast<Map<String, dynamic>>();
    const preprocessor = ModelCellPreprocessor();
    for (final entry in cases) {
      final image = ScanImage(
        bytes: File('$directory/${entry['image']}').readAsBytesSync(),
        format: ScanImageFormat.png,
      );
      final actual = preprocessor.normalize(image);
      final expected = ByteData.sublistView(
        File('$directory/${entry['tensor']}').readAsBytesSync(),
      ).buffer.asFloat32List();
      expect(actual, hasLength(1024));
      for (var index = 0; index < 1024; index++) {
        expect(
          (actual[index] - expected[index]).abs(),
          lessThan(0.00002),
          reason: '${entry['image']} pixel $index',
        );
      }
    }
  });

  test('invalid encoded cell is a recognition failure', () {
    const preprocessor = ModelCellPreprocessor();
    expect(
      () => preprocessor.normalize(
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
  });
}
