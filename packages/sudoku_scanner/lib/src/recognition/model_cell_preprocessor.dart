import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../model/scan_failure.dart';
import '../model/scan_image.dart';

/// Exact 32×32 float input contract used by the Python training pipeline.
///
/// The segmenter has already cropped inside the four grid lines. Pixel values
/// are mean RGB intensity / 255 (black 0, white 1). The resize uses pixel-centre
/// bilinear sampling; no adaptive threshold or recentering is applied here.
final class ModelCellPreprocessor {
  const ModelCellPreprocessor();

  static const size = 32;

  Float32List normalize(ScanImage encoded) {
    final image = img.decodeImage(Uint8List.fromList(encoded.bytes));
    if (image == null || image.width < 12 || image.height < 12) {
      throw const ScanFailure(ScanFailureKind.recognitionFailure);
    }
    final output = Float32List(size * size);
    for (var y = 0; y < size; y++) {
      final sourceY = ((y + 0.5) * image.height / size - 0.5).clamp(
        0.0,
        (image.height - 1).toDouble(),
      );
      final y0 = sourceY.floor();
      final y1 = (y0 + 1).clamp(0, image.height - 1);
      final wy = sourceY - y0;
      for (var x = 0; x < size; x++) {
        final sourceX = ((x + 0.5) * image.width / size - 0.5).clamp(
          0.0,
          (image.width - 1).toDouble(),
        );
        final x0 = sourceX.floor();
        final x1 = (x0 + 1).clamp(0, image.width - 1);
        final wx = sourceX - x0;
        final top =
            _gray(image.getPixel(x0, y0)) * (1 - wx) +
            _gray(image.getPixel(x1, y0)) * wx;
        final bottom =
            _gray(image.getPixel(x0, y1)) * (1 - wx) +
            _gray(image.getPixel(x1, y1)) * wx;
        output[y * size + x] = (top * (1 - wy) + bottom * wy) / 255;
      }
    }
    return output;
  }

  double _gray(img.Pixel pixel) =>
      (pixel.r.toInt() + pixel.g.toInt() + pixel.b.toInt()) / 3;
}
