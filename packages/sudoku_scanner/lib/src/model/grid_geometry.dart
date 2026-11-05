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
    var direction = 0.0;
    for (var i = 0; i < 4; i++) {
      final a = this.corners[i];
      final b = this.corners[(i + 1) % 4];
      final c = this.corners[(i + 2) % 4];
      final cross = (b.x - a.x) * (c.y - b.y) - (b.y - a.y) * (c.x - b.x);
      if (cross.abs() < 1e-6 || (direction != 0 && cross * direction < 0)) {
        throw ArgumentError.value(
          corners,
          'corners',
          'Expected a convex grid.',
        );
      }
      direction = cross;
    }
    if (direction < 0) {
      throw ArgumentError.value(corners, 'corners', 'Wrong corner order.');
    }
  }

  final List<ImagePoint> corners;

  ImagePoint get topLeft => corners[0];
  ImagePoint get topRight => corners[1];
  ImagePoint get bottomRight => corners[2];
  ImagePoint get bottomLeft => corners[3];
}
