@Tags(['benchmark'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

/// End-to-end benchmark on the official Wicht V2 test photos (real phone
/// photos of printed newspaper puzzles), through the shipped pipeline:
/// detection, perspective, segmentation and the TFLite model.
///
/// Opt-in: `MICHI_WICHT=repo MICHI_BENCH_OUT=out.json`
///   flutter test --tags benchmark test/benchmark
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final root = Platform.environment['MICHI_WICHT'];
  test(
    'Wicht V2 test photos end to end',
    () async {
      final classifier = TFLiteDigitClassifier();
      addTearDown(classifier.close);
      final scanner = LocalSudokuScannerService(
        detector: const LocalGridDetector(),
        corrector: const HomographyPerspectiveCorrector(),
        segmenter: const InsetCellSegmenter(),
        classifier: classifier,
      );
      final boards = <Map<String, Object?>>[];
      final paths = File(
        '$root/datasets/v2_test.desc',
      ).readAsLinesSync().where((l) => l.trim().isNotEmpty);
      for (final relative in paths) {
        final photo = File('$root/${relative.trim()}');
        final name = photo.uri.pathSegments.last;
        final truth = File(photo.path.replaceAll('.jpg', '.dat'))
            .readAsLinesSync()
            .skip(2)
            .expand((l) => RegExp('[0-9]').allMatches(l).map((m) => m[0]!))
            .map(int.parse)
            .toList();
        final entry = <String, Object?>{'image': name};
        try {
          final result = await scanner.scan(
            ScanImage(
              bytes: photo.readAsBytesSync(),
              format: ScanImageFormat.jpeg,
            ),
          );
          var corrections = 0;
          var confidentWrong = 0;
          var flagged = 0;
          for (var i = 0; i < 81; i++) {
            final p = result.cells[i].prediction;
            final wrong = (p.digit ?? 0) != truth[i];
            if (wrong) corrections++;
            if (wrong && p.confidence >= 0.9) confidentWrong++;
            if (p.confidence < 0.8) flagged++;
          }
          entry
            ..['found'] = true
            ..['corrections'] = corrections
            ..['confidentWrong'] = confidentWrong
            ..['flagged'] = flagged;
        } on ScanFailure catch (failure) {
          entry
            ..['found'] = false
            ..['failure'] = failure.kind.name;
        }
        boards.add(entry);
      }
      final found = boards.where((b) => b['found'] == true).toList();
      final corrections = [for (final b in found) b['corrections']! as int]
        ..sort();
      final summary = {
        'photos': boards.length,
        'gridFound': found.length,
        'complete': corrections.where((c) => c == 0).length,
        'atMost3': corrections.where((c) => c <= 3).length,
        'meanCorrections': corrections.isEmpty
            ? null
            : corrections.reduce((a, b) => a + b) / corrections.length,
        'medianCorrections': corrections.isEmpty
            ? null
            : corrections[corrections.length ~/ 2],
        'confidentWrongTotal': found.fold<int>(
          0,
          (s, b) => s + (b['confidentWrong']! as int),
        ),
        'boards': boards,
      };
      File(Platform.environment['MICHI_BENCH_OUT']!).writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(summary),
      );
      // A benchmark reports its numbers on the console.
      // ignore: avoid_print
      print({...summary}..remove('boards'));
    },
    skip: root == null ? 'Set MICHI_WICHT to run' : false,
    timeout: const Timeout(Duration(minutes: 10)),
  );
}
