import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../image/scan_image_codec.dart';
import '../model/grid_geometry.dart';
import '../model/image_point.dart';
import '../model/scan_image.dart';
import 'grid_detector.dart';

/// Finds the largest connected dark grid component after local thresholding.
/// It checks size, shape and repeated interior lines; a plain rectangle fails.
final class LocalGridDetector implements GridDetector {
  const LocalGridDetector();

  @override
  Future<GridGeometry?> detect(ScanImage image) =>
      Isolate.run(() => _detect(image));

  static GridGeometry? _detect(ScanImage source) {
    var bitmap = ScanImageCodec.decode(source);
    final originalWidth = bitmap.width;
    final scale =
        900 / (bitmap.width > bitmap.height ? bitmap.width : bitmap.height);
    if (scale < 1) {
      bitmap = img.copyResize(
        bitmap,
        width: (bitmap.width * scale).round(),
        height: (bitmap.height * scale).round(),
      );
    }
    final width = bitmap.width;
    final height = bitmap.height;
    if (width < 180 || height < 180) return null;
    final stride = width + 1;
    final sums = Int32List(stride * (height + 1));
    final gray = Uint8List(width * height);
    for (var y = 0; y < height; y++) {
      var line = 0;
      for (var x = 0; x < width; x++) {
        final p = bitmap.getPixel(x, y);
        final value =
            ((p.r.toInt() * 299 + p.g.toInt() * 587 + p.b.toInt() * 114) ~/
                    1000)
                .clamp(0, 255);
        gray[y * width + x] = value;
        line += value;
        sums[(y + 1) * stride + x + 1] = sums[y * stride + x + 1] + line;
      }
    }
    final dark = Uint8List(width * height);
    const radius = 10;
    for (var y = 0; y < height; y++) {
      final y0 = (y - radius).clamp(0, height - 1);
      final y1 = (y + radius + 1).clamp(1, height);
      for (var x = 0; x < width; x++) {
        final x0 = (x - radius).clamp(0, width - 1);
        final x1 = (x + radius + 1).clamp(1, width);
        final total =
            sums[y1 * stride + x1] -
            sums[y0 * stride + x1] -
            sums[y1 * stride + x0] +
            sums[y0 * stride + x0];
        final mean = total ~/ ((x1 - x0) * (y1 - y0));
        final value = gray[y * width + x];
        if (value < 115 || value < mean - 20) dark[y * width + x] = 1;
      }
    }

    final visited = Uint8List(dark.length);
    _Component? best;
    for (var start = 0; start < dark.length; start++) {
      if (dark[start] == 0 || visited[start] != 0) continue;
      final queue = <int>[start];
      visited[start] = 1;
      var head = 0;
      final component = _Component();
      while (head < queue.length) {
        final index = queue[head++];
        final x = index % width;
        final y = index ~/ width;
        component.add(x, y);
        void visit(int neighbor) {
          if (dark[neighbor] == 1 && visited[neighbor] == 0) {
            visited[neighbor] = 1;
            queue.add(neighbor);
          }
        }

        if (x > 0) visit(index - 1);
        if (x + 1 < width) visit(index + 1);
        if (y > 0) visit(index - width);
        if (y + 1 < height) visit(index + width);
      }
      final boxWidth = component.maxX - component.minX + 1;
      final boxHeight = component.maxY - component.minY + 1;
      final ratio = boxWidth / boxHeight;
      final density = component.count / (boxWidth * boxHeight);
      if (boxWidth < width * 0.28 ||
          boxHeight < height * 0.28 ||
          ratio < 0.55 ||
          ratio > 1.8 ||
          density < 0.025 ||
          density > 0.55) {
        continue;
      }
      if (best == null || component.count > best.count) best = component;
    }
    if (best == null) return null;
    final corners = best.corners;
    try {
      final geometry = GridGeometry(corners);
      if (_lineScore(dark, width, height, geometry) < 6) return null;
      final multiplier = originalWidth / width;
      return GridGeometry([
        for (final point in corners)
          ImagePoint(point.x * multiplier, point.y * multiplier),
      ]);
      // Detected image geometry is untrusted external input.
      // ignore: avoid_catching_errors
    } on ArgumentError {
      return null;
    }
  }

  static int _lineScore(
    Uint8List dark,
    int width,
    int height,
    GridGeometry geometry,
  ) {
    var score = 0;
    for (var axis = 0; axis < 2; axis++) {
      for (var line = 1; line < 9; line++) {
        var hits = 0;
        for (var sample = 1; sample < 20; sample++) {
          final u = axis == 0 ? sample / 20 : line / 9;
          final v = axis == 0 ? line / 9 : sample / 20;
          final x =
              (geometry.topLeft.x * (1 - u) * (1 - v) +
                      geometry.topRight.x * u * (1 - v) +
                      geometry.bottomRight.x * u * v +
                      geometry.bottomLeft.x * (1 - u) * v)
                  .round();
          final y =
              (geometry.topLeft.y * (1 - u) * (1 - v) +
                      geometry.topRight.y * u * (1 - v) +
                      geometry.bottomRight.y * u * v +
                      geometry.bottomLeft.y * (1 - u) * v)
                  .round();
          var found = false;
          for (var dy = -2; dy <= 2 && !found; dy++) {
            for (var dx = -2; dx <= 2; dx++) {
              final xx = x + dx;
              final yy = y + dy;
              if (xx >= 0 &&
                  yy >= 0 &&
                  xx < width &&
                  yy < height &&
                  dark[yy * width + xx] == 1) {
                found = true;
                break;
              }
            }
          }
          if (found) hits++;
        }
        if (hits >= 6) score++;
      }
    }
    return score;
  }
}

final class _Component {
  int count = 0;
  int minX = 1 << 30;
  int maxX = -1;
  int minY = 1 << 30;
  int maxY = -1;
  ImagePoint? topLeft;
  ImagePoint? topRight;
  ImagePoint? bottomRight;
  ImagePoint? bottomLeft;
  double minSum = double.infinity;
  double maxSum = -double.infinity;
  double minDiff = double.infinity;
  double maxDiff = -double.infinity;

  void add(int x, int y) {
    count++;
    if (x < minX) minX = x;
    if (x > maxX) maxX = x;
    if (y < minY) minY = y;
    if (y > maxY) maxY = y;
    final sum = (x + y).toDouble();
    final diff = (x - y).toDouble();
    if (sum < minSum) {
      minSum = sum;
      topLeft = ImagePoint(x.toDouble(), y.toDouble());
    }
    if (sum > maxSum) {
      maxSum = sum;
      bottomRight = ImagePoint(x.toDouble(), y.toDouble());
    }
    if (diff > maxDiff) {
      maxDiff = diff;
      topRight = ImagePoint(x.toDouble(), y.toDouble());
    }
    if (diff < minDiff) {
      minDiff = diff;
      bottomLeft = ImagePoint(x.toDouble(), y.toDouble());
    }
  }

  List<ImagePoint> get corners => [
    topLeft!,
    topRight!,
    bottomRight!,
    bottomLeft!,
  ];
}
