import 'dart:isolate';

import 'package:image/image.dart' as img;

import '../image/scan_image_codec.dart';
import '../model/grid_geometry.dart';
import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import 'perspective_corrector.dart';

/// Maps the detected quadrilateral to a fixed 900×900 square with a homography.
final class HomographyPerspectiveCorrector implements PerspectiveCorrector {
  const HomographyPerspectiveCorrector();

  static const int boardSize = 900;

  @override
  Future<ScanImage> correct(ScanImage image, GridGeometry geometry) =>
      Isolate.run(() => _correct(image, geometry));

  static ScanImage _correct(ScanImage image, GridGeometry geometry) {
    final source = ScanImageCodec.decode(image);
    final points = geometry.corners;
    for (final point in points) {
      if (point.x < 0 ||
          point.y < 0 ||
          point.x >= source.width ||
          point.y >= source.height) {
        throw const ScanFailure(ScanFailureKind.invalidGeometry);
      }
    }
    final h = _homography([
      (0.0, 0.0, points[0].x, points[0].y),
      (899.0, 0.0, points[1].x, points[1].y),
      (899.0, 899.0, points[2].x, points[2].y),
      (0.0, 899.0, points[3].x, points[3].y),
    ]);
    final output = img.Image(width: boardSize, height: boardSize);
    for (var y = 0; y < boardSize; y++) {
      for (var x = 0; x < boardSize; x++) {
        final divisor = h[6] * x + h[7] * y + 1;
        final sx = (h[0] * x + h[1] * y + h[2]) / divisor;
        final sy = (h[3] * x + h[4] * y + h[5]) / divisor;
        output.setPixel(
          x,
          y,
          source.getPixelInterpolate(
            sx.clamp(0, source.width - 1).toDouble(),
            sy.clamp(0, source.height - 1).toDouble(),
          ),
        );
      }
    }
    return ScanImage(bytes: img.encodePng(output), format: ScanImageFormat.png);
  }

  static List<double> _homography(
    List<(double, double, double, double)> correspondences,
  ) {
    final matrix = <List<double>>[];
    for (final (u, v, x, y) in correspondences) {
      matrix
        ..add([u, v, 1, 0, 0, 0, -u * x, -v * x, x])
        ..add([0, 0, 0, u, v, 1, -u * y, -v * y, y]);
    }
    for (var column = 0; column < 8; column++) {
      var pivot = column;
      for (var row = column + 1; row < 8; row++) {
        if (matrix[row][column].abs() > matrix[pivot][column].abs()) {
          pivot = row;
        }
      }
      if (matrix[pivot][column].abs() < 1e-9) {
        throw const ScanFailure(ScanFailureKind.invalidGeometry);
      }
      final swap = matrix[column];
      matrix[column] = matrix[pivot];
      matrix[pivot] = swap;
      final denominator = matrix[column][column];
      for (var k = column; k <= 8; k++) {
        matrix[column][k] /= denominator;
      }
      for (var row = 0; row < 8; row++) {
        if (row == column) continue;
        final factor = matrix[row][column];
        for (var k = column; k <= 8; k++) {
          matrix[row][k] -= factor * matrix[column][k];
        }
      }
    }
    return [for (final row in matrix) row[8]];
  }
}
