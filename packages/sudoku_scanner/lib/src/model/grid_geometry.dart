import 'image_point.dart';

/// Four corners in top-left, top-right, bottom-right, bottom-left order.
final class GridGeometry {
  GridGeometry(List<ImagePoint> corners)
    : corners = List<ImagePoint>.unmodifiable(corners) {
    if (this.corners.length != 4) {
      throw ArgumentError.value(
        corners.length,
        'corners.length',
        'Expected 4.',
      );
    }
  }

  final List<ImagePoint> corners;
}
