import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/src/image/scan_image_codec.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

void main() {
  test('JPEG EXIF rotation is baked before grid processing', () async {
    final bitmap = img.Image(width: 240, height: 180);
    img.fill(bitmap, color: img.ColorRgb8(245, 245, 245));
    img.fillRect(
      bitmap,
      x1: 0,
      y1: 0,
      x2: 39,
      y2: 39,
      color: img.ColorRgb8(15, 15, 15),
    );
    bitmap.exif.imageIfd.orientation = 6;
    final source = ScanImage(
      bytes: img.encodeJpg(bitmap),
      format: ScanImageFormat.jpeg,
    );

    final normalized = await ScanImageCodec.normalize(source);
    final decoded = img.decodeImage(Uint8List.fromList(normalized.bytes))!;
    expect(decoded.width, 180);
    expect(decoded.height, 240);
    expect(decoded.exif.imageIfd.orientation, isNull);
    final cornerValues = [
      decoded.getPixel(10, 10).r.toInt(),
      decoded.getPixel(169, 10).r.toInt(),
      decoded.getPixel(10, 229).r.toInt(),
      decoded.getPixel(169, 229).r.toInt(),
    ];
    expect(cornerValues.where((value) => value < 80), hasLength(1));
  });
}
