# sudoku_scanner

Replaceable contracts for later camera and image import. The package does not
contain UI screens, Firebase, OCR, OpenCV, or a model yet.

```text
Computer vision   → locate the grid
Digit classifier  → recognize empty / 1…9 with confidence
Sudoku engine     → validate the user-confirmed board
Human solver      → find the next logical move
Coach             → structure an explanation
Flutter app       → display the result
```

`ScanImage` is encoded image data, independent of `CameraImage` and
`BuildContext`. `SudokuScannerService` returns 81 recognized cells and grid
geometry. Future generic OCR and TFLite classifiers can implement the same
`DigitClassifier` contract. Scanning ends at recognition; the app handles review
and conversion to `SudokuBoard`.

Run `flutter test` from this directory.
