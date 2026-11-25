/// Null digit means that the image appears to contain an empty cell.
final class DigitPrediction {
  DigitPrediction({
    required this.digit,
    required this.confidence,
    this.alternative,
  }) {
    final predictedDigit = digit;
    if (predictedDigit != null && (predictedDigit < 1 || predictedDigit > 9)) {
      throw RangeError.range(predictedDigit, 1, 9, 'digit');
    }
    if (!confidence.isFinite || confidence < 0 || confidence > 1) {
      throw RangeError.range(confidence, 0, 1, 'confidence');
    }
    final second = alternative;
    if (second != null && (second < 1 || second > 9 || second == digit)) {
      throw RangeError.range(second, 1, 9, 'alternative');
    }
  }

  final int? digit;
  final double confidence;

  /// The model's second choice (1–9), offered to the player when the cell is
  /// unsure; it is never applied without the player's tap.
  final int? alternative;
}
