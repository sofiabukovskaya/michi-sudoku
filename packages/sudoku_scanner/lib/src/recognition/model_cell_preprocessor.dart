import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import 'cell_normalizer.dart';

/// Model input contract v2: decodes a cell crop to gray (mean RGB) and runs
/// [CellNormalizer], the same code that produced the training tensors.
final class ModelCellPreprocessor {
  const ModelCellPreprocessor();

  static const int size = CellNormalizer.size;

  Float32List normalize(ScanImage encoded) {
    final image = img.decodeImage(Uint8List.fromList(encoded.bytes));
    if (image == null || image.width < 12 || image.height < 12) {
      throw const ScanFailure(ScanFailureKind.recognitionFailure);
    }
    final gray = Uint8List(image.width * image.height);
    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        gray[y * image.width + x] =
            ((pixel.r.toInt() + pixel.g.toInt() + pixel.b.toInt()) / 3).round();
      }
    }
    return CellNormalizer.normalizeGray(gray, image.width, image.height);
  }

  /// No ink survived normalization: the cell is empty without asking the
  /// model (paper, shadows, specks and small notes).
  static bool isBlank(Float32List normalized) {
    for (final v in normalized) {
      if (v > 0) return false;
    }
    return true;
  }
}
