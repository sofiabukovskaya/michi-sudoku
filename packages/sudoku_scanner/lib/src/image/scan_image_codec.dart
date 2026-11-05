import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../model/scan_failure.dart';
import '../model/scan_image.dart';

abstract final class ScanImageCodec {
  static img.Image decode(ScanImage source) {
    final decoded = img.decodeImage(Uint8List.fromList(source.bytes));
    if (decoded == null) {
      throw const ScanFailure(ScanFailureKind.imageDecodeFailure);
    }
    return img.bakeOrientation(decoded);
  }

  /// Bakes EXIF orientation and bounds processing cost before geometry work.
  static Future<ScanImage> normalize(ScanImage source) => Isolate.run(() {
    var bitmap = decode(source);
    final longest = bitmap.width > bitmap.height ? bitmap.width : bitmap.height;
    if (longest > 1400) {
      final ratio = 1400 / longest;
      bitmap = img.copyResize(
        bitmap,
        width: (bitmap.width * ratio).round(),
        height: (bitmap.height * ratio).round(),
      );
    }
    return ScanImage(bytes: img.encodePng(bitmap), format: ScanImageFormat.png);
  });
}
