/// Scanner failures are semantic; the mobile app supplies localized wording.
enum ScanFailureKind {
  imageDecodeFailure,
  noGridFound,
  invalidGeometry,
  segmentationFailure,
  recognitionFailure,
}

final class ScanFailure implements Exception {
  const ScanFailure(this.kind);

  final ScanFailureKind kind;

  @override
  String toString() => 'ScanFailure(${kind.name})';
}
