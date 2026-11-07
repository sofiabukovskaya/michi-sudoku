import 'dart:isolate';

import '../image/scan_image_codec.dart';
import '../model/digit_prediction.dart';
import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import 'digit_classifier.dart';

/// Interim local recognizer. It detects blanks and compares ink with simple
/// 5×7 digit templates. Non-empty confidence is deliberately capped at 0.82;
/// printed fonts, handwriting, and camera artifacts still require Review.
final class TemplateDigitClassifier implements DigitClassifier {
  const TemplateDigitClassifier();

  @override
  Future<DigitPrediction> classify(ScanImage cellImage) =>
      Isolate.run(() => _classify(cellImage));

  static DigitPrediction _classify(ScanImage encoded) {
    final image = ScanImageCodec.decode(encoded);
    if (image.width < 12 || image.height < 12) {
      throw const ScanFailure(ScanFailureKind.recognitionFailure);
    }
    var count = 0;
    var minX = image.width;
    var minY = image.height;
    var maxX = -1;
    var maxY = -1;
    final ink = List<bool>.filled(image.width * image.height, false);
    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final p = image.getPixel(x, y);
        final dark = (p.r.toInt() + p.g.toInt() + p.b.toInt()) ~/ 3 < 145;
        if (!dark) continue;
        ink[y * image.width + x] = true;
        count++;
        if (x < minX) minX = x;
        if (x > maxX) maxX = x;
        if (y < minY) minY = y;
        if (y > maxY) maxY = y;
      }
    }
    final fraction = count / (image.width * image.height);
    if (fraction < 0.012) {
      return DigitPrediction(digit: null, confidence: 0.98);
    }
    if (fraction > 0.55 || maxX - minX < 2 || maxY - minY < 3) {
      return DigitPrediction(digit: null, confidence: 0.22);
    }
    final pattern = <bool>[];
    for (var gy = 0; gy < 7; gy++) {
      for (var gx = 0; gx < 5; gx++) {
        final x0 = minX + ((maxX - minX + 1) * gx / 5).floor();
        final x1 = minX + ((maxX - minX + 1) * (gx + 1) / 5).ceil();
        final y0 = minY + ((maxY - minY + 1) * gy / 7).floor();
        final y1 = minY + ((maxY - minY + 1) * (gy + 1) / 7).ceil();
        var pixels = 0;
        var dark = 0;
        for (var y = y0; y < y1 && y < image.height; y++) {
          for (var x = x0; x < x1 && x < image.width; x++) {
            pixels++;
            if (ink[y * image.width + x]) dark++;
          }
        }
        pattern.add(pixels > 0 && dark / pixels > 0.27);
      }
    }
    var digit = 1;
    var errors = 36;
    for (final entry in _templates.entries) {
      var mismatch = 0;
      for (var i = 0; i < 35; i++) {
        if (pattern[i] != (entry.value[i] == '1')) mismatch++;
      }
      if (mismatch < errors) {
        errors = mismatch;
        digit = entry.key;
      }
    }
    if (errors > 15) return DigitPrediction(digit: null, confidence: 0.24);
    return DigitPrediction(
      digit: digit,
      confidence: (0.82 - errors * 0.035).clamp(0.20, 0.82),
    );
  }

  static const _templates = <int, String>{
    1: '00100011000010000100001000010001110',
    2: '01110100010000100010001000100011111',
    3: '11110000010000101110000010000111110',
    4: '00010001100101010010111110001000010',
    5: '11111100001000011110000010000111110',
    6: '01110100001000011110100011000101110',
    7: '11111000010001000100010000100001000',
    8: '01110100011000101110100011000101110',
    9: '01110100011000101111000010000101110',
  };
}
