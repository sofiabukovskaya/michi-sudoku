/// Null digit means that the image appears to contain an empty cell.
final class DigitPrediction {
  DigitPrediction({required this.digit, required this.confidence}) {
    final predictedDigit = digit;
    if (predictedDigit != null && (predictedDigit < 1 || predictedDigit > 9)) {
      throw RangeError.range(predictedDigit, 1, 9, 'digit');
    }
    if (!confidence.isFinite || confidence < 0 || confidence > 1) {
      throw RangeError.range(confidence, 0, 1, 'confidence');
    }
  }

  final int? digit;
  final double confidence;
}
