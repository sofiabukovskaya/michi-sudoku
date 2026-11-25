import 'grid_geometry.dart';
import 'scan_image.dart';

/// Scanner failures are semantic; the mobile app supplies localized wording.
enum ScanFailureKind {
  imageDecodeFailure,
  noGridFound,
  invalidGeometry,
  segmentationFailure,
  recognitionFailure,

  /// Several puzzles are equally plausible; the player picks one.
  multipleGrids,
}

final class ScanFailure implements Exception {
  const ScanFailure(this.kind, {this.image, this.candidates = const []});

  final ScanFailureKind kind;

  /// For [ScanFailureKind.multipleGrids]: the upright photo the candidates
  /// refer to, so the app can show them and scan the chosen one.
  final ScanImage? image;
  final List<GridGeometry> candidates;

  @override
  String toString() => 'ScanFailure(${kind.name})';
}
