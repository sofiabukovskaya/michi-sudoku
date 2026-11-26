import 'dart:typed_data';

/// Model input contract v2, shared by the app and training.
///
/// Training data is produced by running this exact code (see
/// `tool/normalize_cells.dart`), so the model never sees a different
/// preprocessing from the one used on device.
///
/// Steps, on a cell crop given as 8-bit gray (0 black, 255 white):
/// 1. Resample to 48×48 (bilinear, pixel centres).
/// 2. Local paper level (9×9 max then mean) absorbs shadows and uneven
///    light; ink is darkness below it. Contrast is measured inside a 4 px
///    margin (grid remnants live at the edge). Below [minContrast] the cell
///    is empty: a blank page never becomes "ink" by stretching.
/// 3. Ink map = (darkness − noise floor) / max(99.5th-pct darkness, 36),
///    so faint pencil is lifted while paper texture stays near zero.
/// 4. Straight lines spanning 80% of a row or column are erased; strokes
///    hugging the border (line remnants) and specks are removed by connected
///    components; a digit touching the border is kept.
/// 5. Ink whose larger extent is under 30% of the cell is empty: pencil
///    candidate notes and specks are not entries (entries and givens are
///    larger). Spread-out notes in several corners are left to the model,
///    which is trained to call them empty.
/// 6. The remaining ink is scaled so its longer side is 22 px and placed in
///    a 32×32 frame by its centre of mass. Output: ink 1, paper 0.
abstract final class CellNormalizer {
  static const size = 32;
  static const _work = 48;
  static const minContrast = 16;
  static const _noiseFloor = 4;
  static const _inkThreshold = 0.25;
  static const _border = 4;
  static const _minimumInkPixels = 12;
  static const _target = 22;
  static const _minimumExtent = 14;

  static Float32List normalizeGray(Uint8List gray, int width, int height) {
    if (width < 8 || height < 8 || gray.length != width * height) {
      throw ArgumentError('A cell must be at least 8×8 gray pixels.');
    }
    final work = _resample(
      Float32List.fromList([for (final v in gray) v.toDouble()]),
      width,
      height,
      _work,
      _work,
    );
    // Local paper level: a 9×9 maximum, then a 9×9 mean. Shadows and uneven
    // light are part of the paper, so only strokes darker than their own
    // surroundings count as ink.
    final paper = _boxMean(_boxMax(work, 4), 4);
    final darkness = Float32List(work.length);
    for (var i = 0; i < work.length; i++) {
      final d = paper[i] - work[i];
      darkness[i] = d < 0 ? 0 : d;
    }
    // Contrast is measured away from the cell edge, where grid-line
    // remnants would otherwise set the scale and wash out faint pencil.
    final sorted = Float32List.fromList([
      for (var y = _border; y < _work - _border; y++)
        for (var x = _border; x < _work - _border; x++) darkness[y * _work + x],
    ])..sort();
    final contrast = sorted[((sorted.length - 1) * 0.995).round()];
    final output = Float32List(size * size);
    if (contrast < minContrast) return output;

    final scale = contrast > 36 ? contrast : 36.0;
    final map = Float32List(_work * _work);
    for (var i = 0; i < map.length; i++) {
      final v = (darkness[i] - _noiseFloor) / scale;
      map[i] = v < 0 ? 0 : (v > 1 ? 1 : v);
    }
    // Straight grid lines spanning most of a row or column are never digit
    // strokes (a digit stays within ~80% of the cell): erase them wherever
    // segmentation left them, including through the middle.
    for (var y = 0; y < _work; y++) {
      var count = 0;
      for (var x = 0; x < _work; x++) {
        if (map[y * _work + x] >= _inkThreshold) count++;
      }
      if (count >= _work * 0.8) {
        for (var x = 0; x < _work; x++) {
          map[y * _work + x] = 0;
        }
      }
    }
    for (var x = 0; x < _work; x++) {
      var count = 0;
      for (var y = 0; y < _work; y++) {
        if (map[y * _work + x] >= _inkThreshold) count++;
      }
      if (count >= _work * 0.8) {
        for (var y = 0; y < _work; y++) {
          map[y * _work + x] = 0;
        }
      }
    }

    // Connected components of confident ink (4-connected).
    final labels = Int32List(map.length)..fillRange(0, map.length, -1);
    final kept = Uint8List(map.length);
    var keptCount = 0;
    var next = 0;
    final queue = <int>[];
    for (var start = 0; start < map.length; start++) {
      if (map[start] < _inkThreshold || labels[start] >= 0) continue;
      queue
        ..clear()
        ..add(start);
      labels[start] = next;
      var head = 0;
      var area = 0;
      var nearBorder = 0;
      var minX = _work;
      var minY = _work;
      var maxX = -1;
      var maxY = -1;
      while (head < queue.length) {
        final index = queue[head++];
        final x = index % _work;
        final y = index ~/ _work;
        area++;
        if (x < _border ||
            y < _border ||
            x >= _work - _border ||
            y >= _work - _border) {
          nearBorder++;
        }
        if (x < minX) minX = x;
        if (x > maxX) maxX = x;
        if (y < minY) minY = y;
        if (y > maxY) maxY = y;
        void visit(int n) {
          if (map[n] >= _inkThreshold && labels[n] < 0) {
            labels[n] = next;
            queue.add(n);
          }
        }

        if (x > 0) visit(index - 1);
        if (x + 1 < _work) visit(index + 1);
        if (y > 0) visit(index - _work);
        if (y + 1 < _work) visit(index + _work);
      }
      final boxW = maxX - minX + 1;
      final boxH = maxY - minY + 1;
      final thinLine = (boxW <= 3 && boxH >= 16) || (boxH <= 3 && boxW >= 16);
      final remnant = nearBorder * 2 >= area || (thinLine && nearBorder > 0);
      if (area >= 6 && !remnant) {
        for (final index in queue) {
          kept[index] = 1;
        }
        keptCount += area;
      }
      next++;
    }
    if (keptCount < _minimumInkPixels) return output;

    // Soft ink stays only around kept strokes (one-pixel halo for antialias).
    final soft = Float32List(map.length);
    var minX = _work;
    var minY = _work;
    var maxX = -1;
    var maxY = -1;
    for (var y = 0; y < _work; y++) {
      for (var x = 0; x < _work; x++) {
        var near = false;
        for (var dy = -1; dy <= 1 && !near; dy++) {
          for (var dx = -1; dx <= 1; dx++) {
            final xx = x + dx;
            final yy = y + dy;
            if (xx >= 0 &&
                yy >= 0 &&
                xx < _work &&
                yy < _work &&
                kept[yy * _work + xx] == 1) {
              near = true;
              break;
            }
          }
        }
        if (!near) continue;
        final index = y * _work + x;
        soft[index] = map[index];
        if (kept[index] == 1) {
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }
    final boxW = maxX - minX + 1;
    final boxH = maxY - minY + 1;
    if ((boxW > boxH ? boxW : boxH) < _minimumExtent) return output;
    final crop = Float32List(boxW * boxH);
    for (var y = 0; y < boxH; y++) {
      for (var x = 0; x < boxW; x++) {
        crop[y * boxW + x] = soft[(minY + y) * _work + minX + x];
      }
    }
    final factor = _target / (boxW > boxH ? boxW : boxH);
    final targetW = (boxW * factor).round().clamp(1, _target);
    final targetH = (boxH * factor).round().clamp(1, _target);
    final scaled = _resample(crop, boxW, boxH, targetW, targetH);

    var mass = 0.0;

    var sumX = 0.0;

    var sumY = 0.0;
    for (var y = 0; y < targetH; y++) {
      for (var x = 0; x < targetW; x++) {
        final v = scaled[y * targetW + x];
        mass += v;
        sumX += v * (x + 0.5);
        sumY += v * (y + 0.5);
      }
    }
    final centerX = mass > 0 ? sumX / mass : targetW / 2;
    final centerY = mass > 0 ? sumY / mass : targetH / 2;
    final offsetX = (size / 2 - centerX).round().clamp(0, size - targetW);
    final offsetY = (size / 2 - centerY).round().clamp(0, size - targetH);
    for (var y = 0; y < targetH; y++) {
      for (var x = 0; x < targetW; x++) {
        output[(offsetY + y) * size + offsetX + x] = scaled[y * targetW + x];
      }
    }
    return output;
  }

  static Float32List _boxMax(Float32List source, int radius) {
    final out = Float32List(source.length);
    for (var y = 0; y < _work; y++) {
      for (var x = 0; x < _work; x++) {
        var best = 0.0;
        for (var dy = -radius; dy <= radius; dy++) {
          final yy = (y + dy).clamp(0, _work - 1);
          for (var dx = -radius; dx <= radius; dx++) {
            final v = source[yy * _work + (x + dx).clamp(0, _work - 1)];
            if (v > best) best = v;
          }
        }
        out[y * _work + x] = best;
      }
    }
    return out;
  }

  static Float32List _boxMean(Float32List source, int radius) {
    final out = Float32List(source.length);
    final span = (2 * radius + 1) * (2 * radius + 1);
    for (var y = 0; y < _work; y++) {
      for (var x = 0; x < _work; x++) {
        var sum = 0.0;
        for (var dy = -radius; dy <= radius; dy++) {
          final yy = (y + dy).clamp(0, _work - 1);
          for (var dx = -radius; dx <= radius; dx++) {
            sum += source[yy * _work + (x + dx).clamp(0, _work - 1)];
          }
        }
        out[y * _work + x] = sum / span;
      }
    }
    return out;
  }

  /// Bilinear resample with pixel-centre alignment.
  static Float32List _resample(
    Float32List source,
    int width,
    int height,
    int outWidth,
    int outHeight,
  ) {
    final out = Float32List(outWidth * outHeight);
    for (var y = 0; y < outHeight; y++) {
      final sy = ((y + 0.5) * height / outHeight - 0.5).clamp(
        0.0,
        (height - 1).toDouble(),
      );
      final y0 = sy.floor();
      final y1 = y0 + 1 < height ? y0 + 1 : height - 1;
      final wy = sy - y0;
      for (var x = 0; x < outWidth; x++) {
        final sx = ((x + 0.5) * width / outWidth - 0.5).clamp(
          0.0,
          (width - 1).toDouble(),
        );
        final x0 = sx.floor();
        final x1 = x0 + 1 < width ? x0 + 1 : width - 1;
        final wx = sx - x0;
        final top =
            source[y0 * width + x0] * (1 - wx) + source[y0 * width + x1] * wx;
        final bottom =
            source[y1 * width + x0] * (1 - wx) + source[y1 * width + x1] * wx;
        out[y * outWidth + x] = top * (1 - wy) + bottom * wy;
      }
    }
    return out;
  }
}
