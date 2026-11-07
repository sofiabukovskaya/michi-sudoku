import 'package:meta/meta.dart';

@immutable
final class ImagePoint {
  ImagePoint(this.x, this.y) {
    if (!x.isFinite || !y.isFinite) {
      throw ArgumentError('Image coordinates must be finite.');
    }
  }

  final double x;
  final double y;

  @override
  bool operator ==(Object other) =>
      other is ImagePoint && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}
