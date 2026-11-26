import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/scheduler.dart';

/// Opt-in profiling aid: `--dart-define=MICHI_FRAME_STATS=true`.
///
/// Every five seconds with rendered frames it logs UI (build) and raster
/// percentiles, frames over the 120 Hz and 60 Hz budgets, and resident
/// memory. Nothing is logged for windows without frames, which makes
/// unintended background animation visible. Compiled out otherwise.
const bool _enabled = bool.fromEnvironment('MICHI_FRAME_STATS');

final List<FrameTiming> _window = [];

double? get _refreshRate =>
    PlatformDispatcher.instance.displays.firstOrNull?.refreshRate;

void installFrameStats() {
  if (!_enabled) return;
  SchedulerBinding.instance.addTimingsCallback(_window.addAll);
  Timer.periodic(const Duration(seconds: 5), (_) => _report());
}

void _report() {
  if (_window.isEmpty) return;
  final build = [for (final f in _window) f.buildDuration.inMicroseconds]
    ..sort();
  final raster = [for (final f in _window) f.rasterDuration.inMicroseconds]
    ..sort();
  final total = [for (final f in _window) f.totalSpan.inMicroseconds]..sort();
  int pct(List<int> values, double p) =>
      values[((values.length - 1) * p).round()];
  String ms(int micros) => (micros / 1000).toStringAsFixed(1);
  final over120 = _window
      .where(
        (f) =>
            f.buildDuration.inMicroseconds > 8333 ||
            f.rasterDuration.inMicroseconds > 8333,
      )
      .length;
  final over60 = _window
      .where(
        (f) =>
            f.buildDuration.inMicroseconds > 16667 ||
            f.rasterDuration.inMicroseconds > 16667,
      )
      .length;
  final line =
      'MICHI_FRAMES n=${_window.length} '
      'ui p50=${ms(pct(build, .5))} p95=${ms(pct(build, .95))} '
      'p99=${ms(pct(build, .99))} '
      'raster p50=${ms(pct(raster, .5))} p95=${ms(pct(raster, .95))} '
      'p99=${ms(pct(raster, .99))} '
      'total p99=${ms(pct(total, .99))} '
      'over8.3ms=$over120 over16.7ms=$over60 '
      'rssMB=${(ProcessInfo.currentRss / 1048576).toStringAsFixed(0)} '
      'refresh=$_refreshRate';
  developer.log(line, name: 'michi.frames');
  // Profile builds strip developer.log from device logs; print is the only
  // channel `flutter run --profile` shows. Opt-in diagnostics only.
  // ignore: avoid_print
  print(line);
  _window.clear();
}
