# sudoku_scanner

Local still-image recognition for a Sudoku grid. This Flutter package owns the
image pipeline and stops at recognition. It has no Game, Coach, Firebase, camera
widget, or Sudoku-solving dependency.

```text
JPEG/PNG → EXIF orientation + resize → grid detection → homography (900×900)
         → 81 inset cell images → DigitClassifier → SudokuScanResult

Mobile Review → corrected SudokuBoard → constraints + ExactSolver
              → imported puzzle → existing Game / HumanSolver / Coach / Why
```

## Public contracts

- `ScanImage` carries encoded bytes; camera and `BuildContext` types stay in the
  mobile app.
- `GridDetector` returns an ordered `GridGeometry` or `null`. The local detector
  uses a luminance threshold, connected dark components, corner estimates, and
  interior line evidence. It never invents a quadrilateral when none is found.
- `PerspectiveCorrector` maps the detected quadrilateral to a 900×900 image by
  inverse homography.
- `CellSegmenter` finds the ten row and column grid lines after correction,
  then returns 81 row-major cells cropped 14% inside each detected boundary.
- `DigitClassifier` predicts empty or 1–9 with a confidence in 0…1.
- `SudokuScannerService` coordinates the stages and returns the predictions,
  geometry, and mean confidence. `ScanFailure` has structured failure kinds.

`TFLiteDigitClassifier` is the Phase 14 runtime recognizer. It loads the
versioned float32 model once, runs inference through an isolate worker, and
returns the existing `DigitPrediction` type. Its 32×32 grayscale input is
prepared by `ModelCellPreprocessor` with Python/Dart parity fixtures.
`TemplateDigitClassifier` remains available only for Phase 13 regression
comparison. Review is still mandatory: real-photo holdout errors include
high-confidence wrong digits. Current app thresholds are below 0.80 for a
review marker and 0.90 for high confidence, selected from validation data.
These categories are not a guarantee of correctness.

The `image` package provides portable decoding, pixels, and encoding without a
native OpenCV dependency. EXIF orientation is baked before geometry work. The
pipeline bounds the longest input side to 1400 pixels and runs expensive stages
off the UI isolate. The mobile app's Review and import flow is unchanged.

Run `flutter test` and `flutter analyze` from this directory. Synthetic images
cover straight, perspective, thick-line, uneven-light, blank, segmentation,
and replaceable classification behavior. Validate varied real photos on devices
as the recognition corpus grows.
