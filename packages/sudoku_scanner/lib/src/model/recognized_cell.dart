import 'digit_prediction.dart';

final class RecognizedCell {
  RecognizedCell({
    required this.row,
    required this.column,
    required this.prediction,
  }) {
    if (row < 0 || row > 8 || column < 0 || column > 8) {
      throw RangeError('Cell coordinates must be between 0 and 8.');
    }
  }

  final int row;
  final int column;
  final DigitPrediction prediction;
}
