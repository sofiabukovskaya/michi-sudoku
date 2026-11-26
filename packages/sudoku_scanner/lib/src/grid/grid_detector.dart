import '../model/grid_geometry.dart';
import '../model/scan_focus.dart';
import '../model/scan_image.dart';

abstract interface class GridDetector {
  /// The most plausible grid, or null.
  Future<GridGeometry?> detect(ScanImage image);

  /// Every plausible grid, largest first, in the photo's own coordinates.
  /// With [region], only that part of the photo is searched.
  Future<List<GridGeometry>> candidates(ScanImage image, {ScanFocus? region});
}
