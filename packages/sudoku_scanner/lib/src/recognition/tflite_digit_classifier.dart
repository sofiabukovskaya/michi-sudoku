import 'dart:async';
import 'dart:developer' as developer;

import 'package:tflite_flutter/tflite_flutter.dart';

import '../model/digit_prediction.dart';
import '../model/scan_failure.dart';
import '../model/scan_image.dart';
import 'digit_classifier.dart';
import 'model_cell_preprocessor.dart';

/// On-device ten-class classifier. One interpreter serves the whole scan.
final class TFLiteDigitClassifier implements DigitClassifier {
  TFLiteDigitClassifier({
    this.assetPath =
        'packages/sudoku_scanner/assets/models/michi_digit_v1.tflite',
  });

  final String assetPath;
  final ModelCellPreprocessor _preprocessor = const ModelCellPreprocessor();
  Interpreter? _interpreter;
  IsolateInterpreter? _worker;
  Future<void>? _loading;
  bool _closed = false;

  Future<void> _load() => _loading ??= _loadOnce();

  Future<void> _loadOnce() async {
    if (_closed) throw StateError('Classifier is closed.');
    Interpreter? loadingInterpreter;
    try {
      final interpreter = await Interpreter.fromAsset(assetPath);
      loadingInterpreter = interpreter;
      final input = interpreter.getInputTensor(0);
      final output = interpreter.getOutputTensor(0);
      if (input.shape.join(',') != '1,32,32,1' ||
          output.shape.join(',') != '1,10' ||
          input.type != TensorType.float32 ||
          output.type != TensorType.float32) {
        throw const ScanFailure(ScanFailureKind.recognitionFailure);
      }
      final worker = await IsolateInterpreter.create(
        address: interpreter.address,
      );
      _interpreter = interpreter;
      _worker = worker;
      loadingInterpreter = null;
    } on ScanFailure {
      loadingInterpreter?.close();
      rethrow;
    } on Object catch (error, stack) {
      loadingInterpreter?.close();
      developer.log(
        'Could not load TFLite digit model',
        name: 'michi.scanner',
        error: error,
        stackTrace: stack,
      );
      throw const ScanFailure(ScanFailureKind.recognitionFailure);
    }
  }

  @override
  Future<DigitPrediction> classify(ScanImage cellImage) async {
    if (_closed) throw StateError('Classifier is closed.');
    final normalized = _preprocessor.normalize(cellImage);
    await _load();
    final input = [
      [
        for (var y = 0; y < ModelCellPreprocessor.size; y++)
          [
            for (var x = 0; x < ModelCellPreprocessor.size; x++)
              [normalized[y * ModelCellPreprocessor.size + x]],
          ],
      ],
    ];
    final output = [List<double>.filled(10, 0)];
    try {
      await _worker!.run(input, output);
      var best = 0;
      for (var index = 1; index < 10; index++) {
        if (output[0][index] > output[0][best]) best = index;
      }
      final confidence = output[0][best];
      if (!confidence.isFinite || confidence < 0 || confidence > 1) {
        throw const ScanFailure(ScanFailureKind.recognitionFailure);
      }
      return DigitPrediction(
        digit: best == 0 ? null : best,
        confidence: confidence,
      );
    } on ScanFailure {
      rethrow;
    } on Object {
      throw const ScanFailure(ScanFailureKind.recognitionFailure);
    }
  }

  /// Release the worker before its native interpreter.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    try {
      await _loading;
    } on Object {
      // A failed load has already closed its partial interpreter.
    }
    await _worker?.close();
    _interpreter?.close();
    _worker = null;
    _interpreter = null;
  }
}
