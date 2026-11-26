import '../model/grid_geometry.dart';

/// What live framing sees right now.
enum LiveGridState {
  /// No puzzle large enough inside the frame.
  searching,

  /// A puzzle is framed but still moving.
  found,

  /// The same puzzle has held still long enough to take the photo.
  steady,
}

/// Decides when a live camera preview is ready for an automatic photo: a
/// grid fills enough of the frame and its corners stay put for
/// [requiredFrames] consecutive analysed frames. Pure logic, no timing.
final class SteadyGridGate {
  SteadyGridGate({
    this.requiredFrames = 3,
    this.tolerance = 0.03,
    this.minimumSize = 0.45,
  });

  /// Consecutive still frames needed (about ¾ s at four frames a second).
  final int requiredFrames;

  /// Largest corner movement between frames, as a fraction of the frame.
  final double tolerance;

  /// Smallest grid side, as a fraction of the frame side.
  final double minimumSize;

  GridGeometry? _last;
  int _still = 0;

  /// Adds one analysed frame. [grid] is in the frame's pixel coordinates and
  /// [frameSide] is the frame's side length in the same pixels.
  LiveGridState add(GridGeometry? grid, double frameSide) {
    if (grid == null || _side(grid) < frameSide * minimumSize) {
      reset();
      return LiveGridState.searching;
    }
    final last = _last;
    _last = grid;
    if (last != null && _moved(last, grid) <= frameSide * tolerance) {
      _still++;
    } else {
      _still = 1;
    }
    return _still >= requiredFrames
        ? LiveGridState.steady
        : LiveGridState.found;
  }

  void reset() {
    _last = null;
    _still = 0;
  }

  static double _side(GridGeometry grid) {
    final c = grid.corners;
    double length(int a, int b) {
      final dx = c[a].x - c[b].x;
      final dy = c[a].y - c[b].y;
      return dx.abs() > dy.abs() ? dx.abs() : dy.abs();
    }

    final sides = [length(0, 1), length(1, 2), length(2, 3), length(3, 0)];
    return sides.reduce((a, b) => a < b ? a : b);
  }

  static double _moved(GridGeometry a, GridGeometry b) {
    var most = 0.0;
    for (var i = 0; i < 4; i++) {
      final dx = (a.corners[i].x - b.corners[i].x).abs();
      final dy = (a.corners[i].y - b.corners[i].y).abs();
      final d = dx > dy ? dx : dy;
      if (d > most) most = d;
    }
    return most;
  }
}
