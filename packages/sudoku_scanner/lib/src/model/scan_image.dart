/// Encoded image bytes, independent of camera and UI frameworks.
final class ScanImage {
  ScanImage({required List<int> bytes, required this.format})
    : bytes = List<int>.unmodifiable(bytes) {
    if (this.bytes.isEmpty) throw ArgumentError.value(bytes, 'bytes');
  }

  final List<int> bytes;
  final ScanImageFormat format;
}

enum ScanImageFormat { jpeg, png }
