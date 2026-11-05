import 'dart:isolate';

import 'package:image/image.dart' as img;

import '../image/scan_image_codec.dart';
import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import 'cell_segmenter.dart';

/// Locates grid strokes on the rectified image, then crops inside each cell.
/// The inset suppresses line remnants without cutting centered printed digits.
final class InsetCellSegmenter implements CellSegmenter {
  const InsetCellSegmenter({this.insetFraction = 0.14})
    : assert(
        insetFraction >= 0 && insetFraction < 0.25,
        'Cell inset must be from 0 up to 25%.',
      );

  final double insetFraction;

  @override
  Future<List<ScanCellImage>> segment(ScanImage correctedGrid) =>
      Isolate.run(() => _segment(correctedGrid));

  List<ScanCellImage> _segment(ScanImage encoded) {
    final grid = ScanImageCodec.decode(encoded);
    if (grid.width != grid.height || grid.width % 9 != 0) {
      throw const ScanFailure(ScanFailureKind.segmentationFailure);
    }
    final rowScores = List<int>.filled(grid.height, 0);
    final columnScores = List<int>.filled(grid.width, 0);
    for (var y = 0; y < grid.height; y++) {
      for (var x = 0; x < grid.width; x++) {
        final pixel = grid.getPixel(x, y);
        if ((pixel.r.toInt() + pixel.g.toInt() + pixel.b.toInt()) ~/ 3 < 140) {
          rowScores[y]++;
          columnScores[x]++;
        }
      }
    }
    final rows = _linePositions(rowScores);
    final columns = _linePositions(columnScores);
    return [
      for (var row = 0; row < 9; row++)
        for (var column = 0; column < 9; column++)
          ScanCellImage(
            row: row,
            column: column,
            image: ScanImage(
              bytes: img.encodePng(
                img.copyCrop(
                  grid,
                  x:
                      columns[column] +
                      ((columns[column + 1] - columns[column]) * insetFraction)
                          .round(),
                  y:
                      rows[row] +
                      ((rows[row + 1] - rows[row]) * insetFraction).round(),
                  width: _cropLength(
                    columns[column + 1] - columns[column],
                  ),
                  height: _cropLength(rows[row + 1] - rows[row]),
                ),
              ),
              format: ScanImageFormat.png,
            ),
          ),
    ];
  }

  int _cropLength(int distance) =>
      distance - 2 * (distance * insetFraction).round();

  List<int> _linePositions(List<int> scores) {
    final length = scores.length;
    final cell = length / 9;
    final lines = <int>[0];
    for (var index = 1; index < 9; index++) {
      final expected = index * cell;
      final start = (expected - cell * 0.4).round().clamp(0, length - 1);
      final end = (expected + cell * 0.4).round().clamp(0, length - 1);
      var strongest = start;
      for (var position = start + 1; position <= end; position++) {
        if (scores[position] > scores[strongest]) strongest = position;
      }
      if (scores[strongest] < length * 0.35 ||
          strongest - lines.last < cell * 0.5) {
        throw const ScanFailure(ScanFailureKind.segmentationFailure);
      }
      lines.add(strongest);
    }
    lines.add(length - 1);
    if (lines.last - lines[8] < cell * 0.5) {
      throw const ScanFailure(ScanFailureKind.segmentationFailure);
    }
    return lines;
  }
}
