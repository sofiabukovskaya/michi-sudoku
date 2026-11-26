import 'dart:async';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

/// Watches the live preview for a puzzle held still inside the scanning
/// frame. It reads only the brightness plane, about four frames a second,
/// downscaled to ~300 px and limited to the frame, in a background isolate.
/// Nothing is stored; frames are dropped while one is being analysed.
final class LiveGridWatcher {
  LiveGridWatcher({required this.onSteady});

  /// Called once when the framed puzzle has held still.
  final VoidCallback onSteady;

  final ValueNotifier<LiveGridState> state = ValueNotifier(
    LiveGridState.searching,
  );

  static const _interval = Duration(milliseconds: 250);
  static const _side = 300;

  final _gate = SteadyGridGate();
  CameraController? _controller;
  ScanFocus? _focus;
  bool _busy = false;
  bool _fired = false;
  DateTime _last = DateTime.fromMillisecondsSinceEpoch(0);

  /// [focus] is the frame in portrait photo fractions.
  Future<void> start(CameraController controller, ScanFocus focus) async {
    if (identical(_controller, controller) &&
        controller.value.isStreamingImages) {
      return;
    }
    _controller = controller;
    _focus = focus;
    _fired = false;
    _gate.reset();
    try {
      await controller.startImageStream(_onFrame);
    } on Object {
      // Live framing is a convenience; the shutter button still works.
      _controller = null;
    }
  }

  Future<void> stop() async {
    final controller = _controller;
    _controller = null;
    _gate.reset();
    state.value = LiveGridState.searching;
    if (controller == null) return;
    try {
      if (controller.value.isInitialized &&
          controller.value.isStreamingImages) {
        await controller.stopImageStream();
      }
    } on Object {
      // Already stopped or disposed with the camera.
    }
  }

  void dispose() {
    unawaited(stop());
    state.dispose();
  }

  void _onFrame(CameraImage image) {
    final now = DateTime.now();
    if (_busy || _fired || now.difference(_last) < _interval) return;
    final focus = _focus;
    if (focus == null || image.planes.isEmpty) return;
    _busy = true;
    _last = now;
    final plane = image.planes.first;
    final width = image.width;
    final height = image.height;
    // Sensor frames arrive in landscape; the portrait frame turns with them.
    // The frame is centred, so swapping the axes is enough.
    final landscape = width > height;
    final region = landscape
        ? ScanFocus(
            left: focus.top,
            top: focus.left,
            right: focus.bottom,
            bottom: focus.right,
          )
        : focus;
    final bytes = Uint8List.fromList(plane.bytes);
    final stride = plane.bytesPerRow;
    unawaited(
      Isolate.run(() => _analyse(bytes, stride, width, height, region))
          .then((found) {
            if (_controller == null || _fired) return;
            final next = _gate.add(found, _side.toDouble());
            if (state.value != next) state.value = next;
            if (next == LiveGridState.steady) {
              _fired = true;
              onSteady();
            }
          })
          .catchError((Object _) {})
          .whenComplete(() => _busy = false),
    );
  }

  /// Crops the frame region from the luma plane and samples it down to
  /// about [_side] px, then looks for the largest grid.
  static GridGeometry? _analyse(
    Uint8List luma,
    int stride,
    int width,
    int height,
    ScanFocus region,
  ) {
    final x0 = (region.left * width).floor();
    final y0 = (region.top * height).floor();
    final w = ((region.right - region.left) * width).floor();
    final h = ((region.bottom - region.top) * height).floor();
    final longest = w > h ? w : h;
    final step = longest / _side;
    final outW = (w / step).floor();
    final outH = (h / step).floor();
    final gray = Uint8List(outW * outH);
    for (var y = 0; y < outH; y++) {
      final sy = y0 + (y * step).floor();
      for (var x = 0; x < outW; x++) {
        final sx = x0 + (x * step).floor();
        gray[y * outW + x] = luma[sy * stride + sx];
      }
    }
    final grids = LocalGridDetector.candidatesInGray(gray, outW, outH);
    return grids.isEmpty ? null : grids.first;
  }
}
