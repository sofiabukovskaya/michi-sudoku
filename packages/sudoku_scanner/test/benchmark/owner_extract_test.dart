@Tags(['benchmark'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_scanner/src/image/scan_image_codec.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

/// Runs the shipped pipeline on every grid found in local owner photos and
/// writes the cell crops and predictions for labelling and evaluation.
///
/// Opt-in: `MICHI_OWNER=dir` (with `photos/*.jpg`); output in `dir/extract`.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final root = Platform.environment['MICHI_OWNER'];
  test(
    'extract owner photos',
    () async {
      final classifier = TFLiteDigitClassifier();
      addTearDown(classifier.close);
      const detector = LocalGridDetector();
      const corrector = HomographyPerspectiveCorrector();
      const segmenter = InsetCellSegmenter();
      final photos =
          Directory('$root/photos').listSync().whereType<File>().toList()
            ..sort((a, b) => a.path.compareTo(b.path));
      final summary = <Map<String, Object?>>[];
      for (final photo in photos) {
        final name = photo.uri.pathSegments.last.replaceAll('.jpg', '');
        final image = await ScanImageCodec.normalize(
          ScanImage(
            bytes: photo.readAsBytesSync(),
            format: ScanImageFormat.jpeg,
          ),
        );
        final grids = await detector.candidates(image);
        for (var g = 0; g < grids.length; g++) {
          final out = Directory('$root/extract/$name/g$g')
            ..createSync(recursive: true);
          final rectified = await corrector.correct(image, grids[g]);
          File('${out.path}/grid.png').writeAsBytesSync(rectified.bytes);
          final cells = await segmenter.segment(rectified);
          final predictions = <Map<String, Object?>>[];
          for (final cell in cells) {
            final index = cell.row * 9 + cell.column;
            File(
              '${out.path}/${index.toString().padLeft(2, '0')}.png',
            ).writeAsBytesSync(cell.image.bytes);
            final p = await classifier.classify(cell.image);
            predictions.add({
              'digit': p.digit ?? 0,
              'confidence': p.confidence,
            });
          }
          File('${out.path}/predictions.json').writeAsStringSync(
            jsonEncode({
              'corners': [
                for (final c in grids[g].corners) [c.x, c.y],
              ],
              'cells': predictions,
            }),
          );
          summary.add({
            'photo': name,
            'grid': g,
            'board': predictions.map((p) => p['digit']).join(),
          });
        }
      }
      File('$root/extract/summary.json').writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(summary),
      );
    },
    skip: root == null ? 'Set MICHI_OWNER to run' : false,
    timeout: const Timeout(Duration(minutes: 10)),
  );
}
