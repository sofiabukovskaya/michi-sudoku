import 'grid_geometry.dart';

/// The scanning frame the player aimed with, as fractions (0–1) of the
/// upright photo. Detection looks there first, so a neighbouring puzzle on
/// the same page is not chosen just because it is larger.
final class ScanFocus {
  const ScanFocus({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  }) : assert(
         0 <= left && left < right && right <= 1,
         'Horizontal bounds must be within 0–1.',
       ),
       assert(
         0 <= top && top < bottom && bottom <= 1,
         'Vertical bounds must be within 0–1.',
       );

  final double left;
  final double top;
  final double right;
  final double bottom;

  /// The same frame grown by [fraction] of its size on each side, clamped
  /// to the photo: a grid drawn right up to the frame stays whole.
  ScanFocus expand(double fraction) {
    final dx = (right - left) * fraction;
    final dy = (bottom - top) * fraction;
    return ScanFocus(
      left: (left - dx).clamp(0, 1),
      top: (top - dy).clamp(0, 1),
      right: (right + dx).clamp(0, 1),
      bottom: (bottom + dy).clamp(0, 1),
    );
  }

  /// Whether a grid's centre lies inside the frame of a photo of the given
  /// pixel size.
  bool containsCentreOf(GridGeometry grid, int width, int height) {
    var x = 0.0;
    var y = 0.0;
    for (final corner in grid.corners) {
      x += corner.x / 4;
      y += corner.y / 4;
    }
    return x >= left * width &&
        x <= right * width &&
        y >= top * height &&
        y <= bottom * height;
  }
}
