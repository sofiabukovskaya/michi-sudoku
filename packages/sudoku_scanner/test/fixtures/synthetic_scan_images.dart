import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

/// Original test art, drawn from lines rather than a third-party screenshot.
ScanImage syntheticGrid({
  bool perspective = false,
  bool thick = false,
  bool unevenLight = false,
}) {
  final image = img.Image(width: 720, height: 720);
  for (var y = 0; y < 720; y++) {
    for (var x = 0; x < 720; x++) {
      final brightness = unevenLight ? (245 - x ~/ 18 - y ~/ 25) : 250;
      image.setPixelRgb(x, y, brightness, brightness, brightness);
    }
  }
  final corners = perspective
      ? [(85, 110), (620, 65), (655, 640), (60, 660)]
      : [(80, 80), (640, 80), (640, 640), (80, 640)];
  for (var line = 0; line < 10; line++) {
    final t = line / 9;
    final leftX = (corners[0].$1 * (1 - t) + corners[3].$1 * t).round();
    final leftY = (corners[0].$2 * (1 - t) + corners[3].$2 * t).round();
    final rightX = (corners[1].$1 * (1 - t) + corners[2].$1 * t).round();
    final rightY = (corners[1].$2 * (1 - t) + corners[2].$2 * t).round();
    final topX = (corners[0].$1 * (1 - t) + corners[1].$1 * t).round();
    final topY = (corners[0].$2 * (1 - t) + corners[1].$2 * t).round();
    final bottomX = (corners[3].$1 * (1 - t) + corners[2].$1 * t).round();
    final bottomY = (corners[3].$2 * (1 - t) + corners[2].$2 * t).round();
    final width = line % 3 == 0 ? (thick ? 8 : 5) : (thick ? 5 : 3);
    img.drawLine(
      image,
      x1: leftX,
      y1: leftY,
      x2: rightX,
      y2: rightY,
      color: img.ColorRgb8(25, 28, 30),
      thickness: width,
    );
    img.drawLine(
      image,
      x1: topX,
      y1: topY,
      x2: bottomX,
      y2: bottomY,
      color: img.ColorRgb8(25, 28, 30),
      thickness: width,
    );
  }
  return ScanImage(bytes: img.encodePng(image), format: ScanImageFormat.png);
}

ScanImage syntheticBlank() {
  final image = img.Image(width: 720, height: 720);
  img.fill(image, color: img.ColorRgb8(250, 250, 250));
  return ScanImage(bytes: img.encodePng(image), format: ScanImageFormat.png);
}
