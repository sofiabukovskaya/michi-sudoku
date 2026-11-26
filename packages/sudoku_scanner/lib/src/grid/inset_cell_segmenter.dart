import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../image/scan_image_codec.dart';
import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import 'cell_segmenter.dart';

/// Locates grid strokes on the rectified image, then crops inside each cell.
///
/// Lines are located per band (each row band finds its own column lines and
/// each column band its own row lines), so a gently curved book page whose
/// lines drift after rectification is still followed cell by cell. The small
/// inset keeps off-centre handwriting; the cell normalizer removes any line
/// remnants that remain.
final class InsetCellSegmenter implements CellSegmenter {
  const InsetCellSegmenter({this.insetFraction = 0.08})
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
    final size = grid.width;
    // Strokes are darker than their own neighbourhood. An absolute threshold
    // fails on dim photos, where the whole page is "dark" and every position
    // would score alike.
    final gray = Uint8List(size * size);
    final stride = size + 1;
    final sums = Int32List(stride * (size + 1));
    for (var y = 0; y < size; y++) {
      var line = 0;
      for (var x = 0; x < size; x++) {
        final pixel = grid.getPixel(x, y);
        final value =
            (pixel.r.toInt() + pixel.g.toInt() + pixel.b.toInt()) ~/ 3;
        gray[y * size + x] = value;
        line += value;
        sums[(y + 1) * stride + x + 1] = sums[y * stride + x + 1] + line;
      }
    }
    final radius = (size / 60).round().clamp(4, 24);
    final dark = Uint8List(size * size);
    for (var y = 0; y < size; y++) {
      final y0 = (y - radius).clamp(0, size - 1);
      final y1 = (y + radius + 1).clamp(1, size);
      for (var x = 0; x < size; x++) {
        final x0 = (x - radius).clamp(0, size - 1);
        final x1 = (x + radius + 1).clamp(1, size);
        final mean =
            (sums[y1 * stride + x1] -
                sums[y0 * stride + x1] -
                sums[y1 * stride + x0] +
                sums[y0 * stride + x0]) /
            ((x1 - x0) * (y1 - y0));
        if (gray[y * size + x] < mean - 10) dark[y * size + x] = 1;
      }
    }
    List<int> scores({required bool rows, int from = 0, int? to}) {
      final end = to ?? size;
      final result = List<int>.filled(size, 0);
      for (var a = from; a < end; a++) {
        for (var b = 0; b < size; b++) {
          // rows: score per y over x in [from,to); columns: per x over y.
          if (rows) {
            if (dark[b * size + a] == 1) result[b]++;
          } else {
            if (dark[a * size + b] == 1) result[b]++;
          }
        }
      }
      return result;
    }

    final globalRows = _linePositions(scores(rows: true), size);
    final globalColumns = _linePositions(scores(rows: false), size);
    // Band-local lines follow curvature; weak evidence keeps the global line.
    final columnsByRow = [
      for (var row = 0; row < 9; row++)
        _linePositions(
          scores(rows: false, from: globalRows[row], to: globalRows[row + 1]),
          globalRows[row + 1] - globalRows[row],
          fallback: globalColumns,
        ),
    ];
    final rowsByColumn = [
      for (var column = 0; column < 9; column++)
        _linePositions(
          scores(
            rows: true,
            from: globalColumns[column],
            to: globalColumns[column + 1],
          ),
          globalColumns[column + 1] - globalColumns[column],
          fallback: globalRows,
        ),
    ];
    return [
      for (var row = 0; row < 9; row++)
        for (var column = 0; column < 9; column++)
          () {
            final columns = columnsByRow[row];
            final rows = rowsByColumn[column];
            final left = columns[column];
            final right = columns[column + 1];
            final top = rows[row];
            final bottom = rows[row + 1];
            final crop = img.copyCrop(
              grid,
              x: left + ((right - left) * insetFraction).round(),
              y: top + ((bottom - top) * insetFraction).round(),
              width: _cropLength(right - left),
              height: _cropLength(bottom - top),
            );
            return ScanCellImage(
              row: row,
              column: column,
              image: ScanImage(
                bytes: img.encodePng(crop),
                format: ScanImageFormat.png,
              ),
            );
          }(),
    ];
  }

  int _cropLength(int distance) =>
      distance - 2 * (distance * insetFraction).round();

  /// Nine evenly expected lines; each snaps to the strongest stroke nearby
  /// when the stroke is clear (relative to [span], the length scanned).
  /// Otherwise it keeps [fallback] (or the geometric position).
  List<int> _linePositions(
    List<int> scores,
    int span, {
    List<int>? fallback,
  }) {
    final length = scores.length;
    final cell = length / 9;
    final lines = <int>[0];
    for (var index = 1; index < 9; index++) {
      final expected = fallback?[index] ?? (index * cell).round();
      final start = (expected - cell * 0.4).round().clamp(0, length - 1);
      final end = (expected + cell * 0.4).round().clamp(0, length - 1);
      var strongest = start;
      for (var position = start + 1; position <= end; position++) {
        // Ties prefer the position closest to the expected line.
        if (scores[position] > scores[strongest] ||
            (scores[position] == scores[strongest] &&
                (position - expected).abs() < (strongest - expected).abs())) {
          strongest = position;
        }
      }
      final window = scores.sublist(start, end + 1)..sort();
      final baseline = window[window.length ~/ 2];
      // The homography already guarantees nine near-equal cells. A line is
      // trusted only when it stands out from its window; otherwise keep the
      // expected line.
      var position =
          scores[strongest] - baseline < span * 0.3 ||
              strongest - lines.last < cell * 0.5
          ? expected
          : strongest;
      if (position - lines.last < cell * 0.5) {
        if (fallback == null) {
          throw const ScanFailure(ScanFailureKind.segmentationFailure);
        }
        position = fallback[index];
      }
      lines.add(position);
    }
    lines.add(length - 1);
    if (lines.last - lines[8] < cell * 0.5) {
      if (fallback == null) {
        throw const ScanFailure(ScanFailureKind.segmentationFailure);
      }
      return fallback;
    }
    return lines;
  }
}
