import 'dart:io';

import 'package:sudoku_scanner/src/grid/homography_perspective_corrector.dart';
import 'package:sudoku_scanner/src/grid/inset_cell_segmenter.dart';
import 'package:sudoku_scanner/src/model/grid_geometry.dart';
import 'package:sudoku_scanner/src/model/image_point.dart';
import 'package:sudoku_scanner/src/model/scan_image.dart';

/// Export Wicht V2 with its official train/test split and annotated outlines.
///
/// The official test split is only extracted, never used for training or
/// calibration. This measures classifier quality with ground-truth geometry;
/// end-to-end detector success must be reported separately.
/// Usage: dart run tool/extract_wicht_cells.dart `repository` `output`
Future<void> main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln('Expected Wicht repository path and output directory.');
    exitCode = 64;
    return;
  }
  final repository = Directory(arguments[0]);
  final output = Directory(arguments[1])..createSync(recursive: true);
  final outlines = <String, GridGeometry>{};
  final outlineLines = await File(
    '${repository.path}/outlines_sorted.csv',
  ).readAsLines();
  for (final line in outlineLines.skip(1)) {
    final fields = line.replaceAll('"', '').split(',');
    if (fields.length != 9) continue;
    final imageName = fields[0].split('/').last;
    final numbers = fields.skip(1).map(double.parse).toList();
    outlines[imageName] = GridGeometry([
      for (var point = 0; point < 4; point++)
        ImagePoint(numbers[point * 2], numbers[point * 2 + 1]),
    ]);
  }
  const corrector = HomographyPerspectiveCorrector();
  const segmenter = InsetCellSegmenter();
  final manifest = <String>[
    // Keep the interoperable CSV header as one literal line.
    // ignore: lines_longer_than_80_chars
    'sample_id,sample_path,label,source_image_id,source_type,font_id,split,notes,old_prediction,old_confidence',
  ];
  final failures = <String>[];
  for (final officialSplit in ['train', 'test']) {
    final description = File(
      '${repository.path}/datasets/v2_$officialSplit.desc',
    );
    final paths = (await description.readAsLines())
        .where((line) => line.trim().isNotEmpty)
        .toList();
    for (var photoIndex = 0; photoIndex < paths.length; photoIndex++) {
      final relativePath = paths[photoIndex].trim();
      final photo = File('${repository.path}/$relativePath');
      final photoId = photo.uri.pathSegments.last.replaceAll('.jpg', '');
      final geometry = outlines[photo.uri.pathSegments.last];
      if (geometry == null) {
        failures.add('$photoId: missing outline');
        continue;
      }
      final metadata = File(photo.path.replaceAll('.jpg', '.dat'));
      final datLines = await metadata.readAsLines();
      final labels = datLines
          .skip(2)
          .expand((line) => RegExp('[0-9]').allMatches(line).map((m) => m[0]!))
          .toList();
      if (labels.length != 81) {
        failures.add('$photoId: expected 81 ground-truth labels');
        continue;
      }
      try {
        final encoded = ScanImage(
          bytes: await photo.readAsBytes(),
          format: ScanImageFormat.jpeg,
        );
        final rectified = await corrector.correct(encoded, geometry);
        final cells = await segmenter.segment(rectified);
        if (cells.length != 81) throw StateError('Expected 81 cells');
        final split = officialSplit == 'test'
            ? 'test'
            : photoIndex % 5 == 0
            ? 'validation'
            : 'train';
        final cellDirectory = Directory('${output.path}/cells/$photoId')
          ..createSync(recursive: true);
        for (var index = 0; index < 81; index++) {
          final filename = index.toString().padLeft(2, '0');
          await File('${cellDirectory.path}/$filename.png').writeAsBytes(
            cells[index].image.bytes,
          );
          manifest.add(
            'wicht-$photoId-$index,cells/$photoId/$filename.png,'
            '${labels[index]},wicht-$photoId,printed_scan,,$split,'
            'official_v2_${officialSplit}_annotated_outline,,',
          );
        }
      } on Object catch (error) {
        failures.add('$photoId: $error');
      }
      if (photoIndex % 10 == 0) {
        stdout.writeln('$officialSplit $photoIndex/${paths.length}');
      }
    }
  }
  await File('${output.path}/manifest.csv').writeAsString(
    '${manifest.join('\n')}\n',
  );
  await File('${output.path}/failures.txt').writeAsString(
    '${failures.join('\n')}\n',
  );
  stdout.writeln(
    '${(manifest.length - 1) ~/ 81} boards, ${failures.length} failures',
  );
}
