import 'dart:io';

import 'package:sudoku_scanner/src/grid/local_grid_detector.dart';
import 'package:sudoku_scanner/src/image/scan_image_codec.dart';
import 'package:sudoku_scanner/src/model/scan_image.dart';

/// Report Phase 13 detector success separately from annotated OCR accuracy.
Future<void> main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln(
      'Expected Wicht repository and official split (train/test).',
    );
    exitCode = 64;
    return;
  }
  final [root, split] = arguments;
  if (split != 'train' && split != 'test') {
    throw ArgumentError.value(split, 'split');
  }
  final paths = await File('$root/datasets/v2_$split.desc').readAsLines();
  const detector = LocalGridDetector();
  var successes = 0;
  for (final relative in paths) {
    final image = await ScanImageCodec.normalize(
      ScanImage(
        bytes: await File('$root/$relative').readAsBytes(),
        format: ScanImageFormat.jpeg,
      ),
    );
    if (await detector.detect(image) != null) {
      successes++;
      stdout.writeln('found $relative');
    }
  }
  stdout.writeln('$successes/${paths.length} grids found');
}
