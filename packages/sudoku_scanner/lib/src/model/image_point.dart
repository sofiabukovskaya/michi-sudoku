final class ImagePoint {
  ImagePoint(this.x, this.y) {
    if (!x.isFinite || !y.isFinite) {
      throw ArgumentError('Image coordinates must be finite.');
    }
  }

  final double x;
  final double y;
}
