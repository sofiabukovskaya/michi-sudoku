import 'dart:io';

import 'package:image/image.dart' as img;

/// Generates local simulator Photos fixtures; never bundled with the app.
void main(List<String> arguments) {
  final directory = Directory(
    arguments.isEmpty ? Directory.systemTemp.path : arguments.first,
  )..createSync(recursive: true);
  final blank = img.Image(width: 720, height: 720);
  img.fill(blank, color: img.ColorRgb8(250, 250, 250));
  File(
    '${directory.path}/michi_no_grid.png',
  ).writeAsBytesSync(img.encodePng(blank));

  final imagePath = '${directory.path}/michi_sudoku_photo.png';
  File(imagePath).writeAsBytesSync(img.encodePng(makeManualSudokuPhoto()));
  stdout.writeln(imagePath);
}

/// A perspective printed puzzle for repeatable scanner and simulator checks.
img.Image makeManualSudokuPhoto() {
  final bitmap = img.Image(width: 720, height: 720);
  for (var y = 0; y < 720; y++) {
    for (var x = 0; x < 720; x++) {
      final brightness = 245 - x ~/ 18 - y ~/ 25;
      bitmap.setPixelRgb(x, y, brightness, brightness, brightness);
    }
  }
  const corners = [(85, 110), (620, 65), (655, 640), (60, 660)];
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
    img.drawLine(
      bitmap,
      x1: leftX,
      y1: leftY,
      x2: rightX,
      y2: rightY,
      color: img.ColorRgb8(25, 28, 30),
      thickness: line % 3 == 0 ? 5 : 3,
    );
    img.drawLine(
      bitmap,
      x1: topX,
      y1: topY,
      x2: bottomX,
      y2: bottomY,
      color: img.ColorRgb8(25, 28, 30),
      thickness: line % 3 == 0 ? 5 : 3,
    );
  }
  const rows = [
    '530070000',
    '600195000',
    '098000060',
    '800060003',
    '400803001',
    '700020006',
    '060000280',
    '000419005',
    '000080079',
  ];
  // Place print-like digits near the grid's cell centers. Perspective is mild.
  for (var row = 0; row < 9; row++) {
    for (var column = 0; column < 9; column++) {
      final value = rows[row][column];
      if (value == '0') continue;
      final u = (column + 0.5) / 9;
      final v = (row + 0.5) / 9;
      final x =
          (85 * (1 - u) * (1 - v) +
                  620 * u * (1 - v) +
                  655 * u * v +
                  60 * (1 - u) * v)
              .round();
      final y =
          (110 * (1 - u) * (1 - v) +
                  65 * u * (1 - v) +
                  640 * u * v +
                  660 * (1 - u) * v)
              .round();
      img.drawString(
        bitmap,
        value,
        font: img.arial48,
        x: x - 15,
        y: y - 25,
        color: img.ColorRgb8(35, 37, 37),
      );
    }
  }
  return bitmap;
}
