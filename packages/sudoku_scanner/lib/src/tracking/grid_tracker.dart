import '../model/grid_geometry.dart';
import '../model/scan_image.dart';

/// Reserved for live camera tracking after still-image scanning exists.
abstract interface class GridTracker {
  Future<GridGeometry?> track(ScanImage frame);
}
