import '../model/grid_geometry.dart';
import '../model/scan_image.dart';

abstract interface class GridDetector {
  Future<GridGeometry?> detect(ScanImage image);
}
