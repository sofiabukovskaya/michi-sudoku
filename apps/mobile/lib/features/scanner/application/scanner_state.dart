import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

enum ScannerPhase { capture, processing, review, validating, failure, imported }

enum ScannerReviewIssue {
  duplicateClues,
  noSolution,
  multipleSolutions,
  validation,
  storage,
}

final class ScannerReviewData {
  ScannerReviewData({
    required this.result,
    required this.board,
    required Set<CellRef> edited,
    required Set<CellRef> conflicts,
    this.selectedIndex,
    this.issue,
  }) : edited = Set.unmodifiable(edited),
       conflicts = Set.unmodifiable(conflicts);

  final SudokuScanResult result;
  final SudokuBoard board;
  final Set<CellRef> edited;
  final Set<CellRef> conflicts;
  final int? selectedIndex;
  final ScannerReviewIssue? issue;

  static const double highConfidence = 0.90;
  static const double lowConfidence = 0.80;

  bool needsReview(CellRef cell) =>
      !edited.contains(cell) &&
      result.cells[cell.index].prediction.confidence < lowConfidence;

  int get lowConfidenceCount => [
    for (var index = 0; index < 81; index++)
      if (needsReview(CellRef.fromIndex(index))) index,
  ].length;
}

final class ScannerState {
  const ScannerState._({
    required this.phase,
    required this.cameraAccess,
    this.review,
    this.failure,
    this.imported,
  });

  factory ScannerState.capture(CameraAccess access) => ScannerState._(
    phase: ScannerPhase.capture,
    cameraAccess: access,
  );

  factory ScannerState.processing(CameraAccess access) => ScannerState._(
    phase: ScannerPhase.processing,
    cameraAccess: access,
  );

  factory ScannerState.review(CameraAccess access, ScannerReviewData review) =>
      ScannerState._(
        phase: ScannerPhase.review,
        cameraAccess: access,
        review: review,
      );

  factory ScannerState.validating(
    CameraAccess access,
    ScannerReviewData review,
  ) => ScannerState._(
    phase: ScannerPhase.validating,
    cameraAccess: access,
    review: review,
  );

  factory ScannerState.failure(CameraAccess access, ScanFailureKind failure) =>
      ScannerState._(
        phase: ScannerPhase.failure,
        cameraAccess: access,
        failure: failure,
      );

  factory ScannerState.imported(
    CameraAccess access,
    ScannerReviewData review,
    PuzzleDefinition puzzle,
  ) => ScannerState._(
    phase: ScannerPhase.imported,
    cameraAccess: access,
    review: review,
    imported: puzzle,
  );

  final ScannerPhase phase;
  final CameraAccess cameraAccess;
  final ScannerReviewData? review;
  final ScanFailureKind? failure;
  final PuzzleDefinition? imported;
}
