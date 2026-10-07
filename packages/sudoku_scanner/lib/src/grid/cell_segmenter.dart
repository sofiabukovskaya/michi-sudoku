import '../model/scan_image.dart';

final class ScanCellImage {
  ScanCellImage({
    required this.row,
    required this.column,
    required this.image,
  }) {
    if (row < 0 || row > 8 || column < 0 || column > 8) {
      throw RangeError('Cell coordinates must be between 0 and 8.');
    }
  }

  final int row;
  final int column;
  final ScanImage image;
}

abstract interface class CellSegmenter {
  Future<List<ScanCellImage>> segment(ScanImage correctedGrid);
}
