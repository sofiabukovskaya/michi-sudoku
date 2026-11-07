import 'dart:io';

import 'package:sudoku_scanner/src/grid/homography_perspective_corrector.dart';
import 'package:sudoku_scanner/src/grid/inset_cell_segmenter.dart';
import 'package:sudoku_scanner/src/grid/local_grid_detector.dart';
import 'package:sudoku_scanner/src/image/scan_image_codec.dart';
import 'package:sudoku_scanner/src/model/scan_image.dart';

/// Export actual Phase 13 cell crops for Python dataset preparation.
///
/// Usage: dart run tool/extract_labeled_cells.dart photo.png out
///   `board-labels` `source-id` `source-type` `split`
Future<void> main(List<String> arguments) async {
  if (arguments.length != 6) {
    stderr.writeln(
      'Expected photo, output directory, 81 labels, source ID, '
      'source type, and split.',
    );
    exitCode = 64;
    return;
  }
  final [inputPath, outputPath, labels, sourceId, sourceType, split] =
      arguments;
  if (!RegExp(r'^[0-9]{81}$').hasMatch(labels) ||
      !{
        'synthetic',
        'printed_scan',
        'digital_screenshot',
        'hard_example',
      }.contains(
        sourceType,
      ) ||
      !{'train', 'validation', 'test'}.contains(split) ||
      !RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(sourceId)) {
    throw ArgumentError('Invalid labels, source ID, source type, or split.');
  }
  final bytes = await File(inputPath).readAsBytes();
  final format = bytes.length > 2 && bytes[0] == 0xff && bytes[1] == 0xd8
      ? ScanImageFormat.jpeg
      : ScanImageFormat.png;
  final image = await ScanImageCodec.normalize(
    ScanImage(bytes: bytes, format: format),
  );
  const detector = LocalGridDetector();
  const corrector = HomographyPerspectiveCorrector();
  const segmenter = InsetCellSegmenter();
  final geometry = await detector.detect(image);
  if (geometry == null) throw StateError('No grid found in $inputPath');
  final rectified = await corrector.correct(image, geometry);
  final cells = await segmenter.segment(rectified);
  if (cells.length != 81) throw StateError('Expected 81 cell crops.');
  final output = Directory(outputPath)..createSync(recursive: true);
  final cellDirectory = Directory('${output.path}/cells')
    ..createSync(recursive: true);
  final lines = <String>[
    // Keep the interoperable CSV header as one literal line.
    // ignore: lines_longer_than_80_chars
    'sample_id,sample_path,label,source_image_id,source_type,font_id,split,notes,old_prediction,old_confidence',
  ];
  for (var index = 0; index < 81; index++) {
    final filename = '${sourceId}_${index.toString().padLeft(2, '0')}.png';
    await File(
      '${cellDirectory.path}/$filename',
    ).writeAsBytes(cells[index].image.bytes);
    lines.add(
      '$sourceId-$index,cells/$filename,${labels[index]},$sourceId,'
      '$sourceType,,$split,,,',
    );
  }
  await File('${output.path}/manifest.csv').writeAsString(
    '${lines.join('\n')}\n',
  );
  stdout.writeln('${output.path}/manifest.csv');
}
