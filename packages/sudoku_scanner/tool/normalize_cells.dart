import 'dart:io';
import 'dart:typed_data';

import 'package:sudoku_scanner/src/recognition/cell_normalizer.dart';

/// Runs training/evaluation cells through the production [CellNormalizer].
///
/// Input: little-endian records `[uint16 width][uint16 height][w*h gray]`.
/// Output: one float32 32×32 tensor per record, in order.
/// Usage: dart run tool/normalize_cells.dart `input.cells` `output.f32`
void main(List<String> arguments) {
  if (arguments.length != 2) {
    stderr.writeln('Usage: normalize_cells.dart <input.cells> <output.f32>');
    exitCode = 64;
    return;
  }
  final input = File(arguments[0]).readAsBytesSync();
  final data = ByteData.sublistView(input);
  final sink = File(arguments[1]).openSync(mode: FileMode.write);
  var offset = 0;
  var count = 0;
  while (offset < input.length) {
    final width = data.getUint16(offset, Endian.little);
    final height = data.getUint16(offset + 2, Endian.little);
    offset += 4;
    final gray = Uint8List.sublistView(input, offset, offset + width * height);
    offset += width * height;
    final tensor = CellNormalizer.normalizeGray(gray, width, height);
    sink.writeFromSync(tensor.buffer.asUint8List());
    count++;
  }
  sink.closeSync();
  stdout.writeln('normalized $count cells');
}
