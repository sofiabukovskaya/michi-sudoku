import '../model/grid_geometry.dart';
import '../model/scan_image.dart';

abstract interface class PerspectiveCorrector {
  Future<ScanImage> correct(ScanImage image, GridGeometry geometry);
}
