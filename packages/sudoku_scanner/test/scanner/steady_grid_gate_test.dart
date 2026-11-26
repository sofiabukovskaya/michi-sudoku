import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:sudoku_scanner/sudoku_scanner.dart';

import '../fixtures/synthetic_scan_images.dart';

GridGeometry _square(double x, double y, double side) => GridGeometry([
  ImagePoint(x, y),
  ImagePoint(x + side, y),
  ImagePoint(x + side, y + side),
  ImagePoint(x, y + side),
]);

void main() {
  test('a framed puzzle becomes steady after three still frames', () {
    final gate = SteadyGridGate();
    expect(gate.add(_square(20, 20, 250), 300), LiveGridState.found);
    expect(gate.add(_square(22, 21, 250), 300), LiveGridState.found);
    expect(gate.add(_square(21, 22, 250), 300), LiveGridState.steady);
  });

  test('movement restarts the count', () {
    final gate = SteadyGridGate()
      ..add(_square(20, 20, 250), 300)
      ..add(_square(20, 20, 250), 300);
    expect(gate.add(_square(60, 20, 250), 300), LiveGridState.found);
    expect(gate.add(_square(60, 20, 250), 300), LiveGridState.found);
    expect(gate.add(_square(60, 20, 250), 300), LiveGridState.steady);
  });

  test('nothing or a small grid far away is searching', () {
    final gate = SteadyGridGate();
    expect(gate.add(null, 300), LiveGridState.searching);
    expect(gate.add(_square(0, 0, 60), 300), LiveGridState.searching);
  });

  test('live gray frames find the grid without encoding', () {
    final image = img.decodeImage(Uint8List.fromList(syntheticGrid().bytes))!;
    final small = img.copyResize(image, width: 300);
    final gray = Uint8List(small.width * small.height);
    for (var y = 0; y < small.height; y++) {
      for (var x = 0; x < small.width; x++) {
        gray[y * small.width + x] = small.getPixel(x, y).r.toInt();
      }
    }
    final grids = LocalGridDetector.candidatesInGray(
      gray,
      small.width,
      small.height,
    );
    expect(grids, isNotEmpty);
    expect(grids.first.topLeft.x, closeTo(33, 6));
  });
}
