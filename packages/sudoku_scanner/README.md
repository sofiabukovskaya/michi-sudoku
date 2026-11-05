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

`TemplateDigitClassifier` is the **interim Phase 13 recognizer**. It detects
blanks and compares simple 5×7 ink patterns. Non-empty confidence is capped at
0.82. Print fonts, handwriting, blur, shadows, grid contact, and perspective
artifacts can cause wrong digits. The mobile Review screen must be used before
import. Confidence thresholds (below 0.70 needs review, 0.90 and above high)
are application presentation values, not calibrated probabilities.

The `image` package provides portable decoding, pixels, and encoding without a
native OpenCV dependency. EXIF orientation is baked before geometry work. The
pipeline bounds the longest input side to 1400 pixels and runs expensive stages
off the UI isolate. `DigitClassifier` remains replaceable by a Phase 14 TFLite
implementation without changing the scanner service or mobile Review flow.

Run `flutter test` and `flutter analyze` from this directory. Synthetic images
cover straight, perspective, thick-line, uneven-light, blank, segmentation,
and replaceable classification behavior. Validate varied real photos on devices
as the recognition corpus grows.
