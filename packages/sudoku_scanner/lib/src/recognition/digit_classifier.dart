import '../model/digit_prediction.dart';
import '../model/scan_image.dart';

/// Generic OCR and TFLite adapters will share this contract.
abstract interface class DigitClassifier {
  Future<DigitPrediction> classify(ScanImage cellImage);
}
