# Scanner v2: recognition pipeline and results

Date: 2026-11-25. Recognition stays fully on device; Review stays mandatory
and editable; recognized digits are never replaced by solver answers; the
confidence thresholds (0.90 / 0.80) are unchanged from v1.

## Root causes of the misreads (owner's iPhone screenshots)

| # | Cause | Effect |
|---|---|---|
| 1 | Grid detector used an absolute "darker than 115" mask | Grids next to a dark table, shadow or page edge merged with it; corners jumped to the photo corners and every cell was cut wrongly. 25 of 40 real test photos affected. |
| 2 | Cell segmenter used an absolute "darker than 140" mask | On dim photos the whole page counted as ink, so each line snapped to the start of its search window: crops shifted by up to half a cell (digits cut in half → `?`, wrong digits like 8→6). |
| 3 | Detector chose the largest grid anywhere in the photo | On a book page with several puzzles, the framed one was ignored. |
| 4 | Model v1 trained on printed synthetic digits only, raw gray input | Handwriting 38%, pencil 30% accuracy; shadows and contrast changed the input directly. |

## Changes

**Pipeline (`packages/sudoku_scanner`)**
- `LocalGridDetector`: local-contrast mask first (absolute mask only as the
  fallback), returns every plausible grid via `candidates()`, and can search
  only a region.
- `ScanFocus` + `LocalSudokuScannerService`: the camera frame is searched
  first (with an 8% margin); a clearly dominant grid wins; two similar grids
  raise `ScanFailureKind.multipleGrids` with the candidates, and the player
  picks one. Nothing is guessed.
- `InsetCellSegmenter`: local-contrast line mask, peak-prominence test, ties
  resolved toward the expected line, band-local lines for gently curved
  pages, 8% inset (was 14%) so off-centre handwriting is kept.
- `CellNormalizer` (new, the model input contract v2): local paper level
  (absorbs shadows), contrast measured away from the cell edge, erasure of
  straight grid-line remnants, speck and remnant removal, small notes
  treated as empty, digit scaled and centred by centre of mass. Training
  tensors are produced by this same Dart code (`tool/normalize_cells.dart`),
  so training and the device cannot drift apart.
- `TFLiteDigitClassifier` uses `michi_digit_v2.tflite`. A cell with no ink
  after normalization is empty without calling the model.
- `RecognizedCell.image`: each cell keeps its photo crop for Review.

**Model v2 (`tools/sudoku_scanner_ml`)**: `cells_v2.py`, `train_v2.py`,
`evaluate_v2.py`, `evaluate_boards_v2.py`, `configs/v2.yaml`.
- Data (train 95,113 / validation 20,334 / test 20,993 cells): printed
  synthetic digits with variable weights (train Manrope, validation Lora,
  test Roboto), MNIST handwriting rendered as pen and as faint pencil (train
  rows 0–49,999, validation 50,000–59,999, test = MNIST test set), empty cells
  with paper texture, shadows, specks, erased smudges and small pencil notes,
  the Wicht V2 real photos (official train/test split, validation = every
  fifth train photo) and the printed-digits dataset (train only). No source
  image, font or writer row is shared between splits.
- CNN: 2×(conv-conv-pool) 32/64 + conv 128, batch norm, global average
  pooling, dropout; class weights; augmentation (rotation, zoom, shift, stroke
  weight, ink strength; no flips). 633 KB float32 TFLite (v1: 869 KB).

## Results

### End to end on real photos (40 official Wicht V2 test photos, full pipeline)

| | v1 (shipped) | v2 |
|---|---:|---:|
| Grid found | 40/40 | 40/40 |
| Corners within 6 px of the annotation | 15/40 | 31/40 |
| Complete boards (0 corrections) | 7 | **24** |
| Boards needing ≤ 3 corrections | 10 | **28** |
| Corrections per board, median | 35 | **0** |
| Corrections per board, mean | 28.8 | **10.7** |
| Confidently wrong cells (≥ 0.90), all boards | 457 | 238 |

Most of the remaining corrections come from the 9 photos whose detected
corners are still off (grid touching dense text or the photo border). The
confidently wrong cells are concentrated on those same boards.

### Same photos with annotated corners (recognition only)

| | v1 + old segmenter | v1 + new segmenter | v2 + new segmenter |
|---|---:|---:|---:|
| Cell accuracy | 92.2% | 96.0% | **97.4%** |
| Digit cells read correctly | 79.0% | 89.4% | **93.9%** |
| Empty cells read as empty | 99.5% | 99.7% | 99.4% |
| Complete boards | 13 | 16 | **30** |
| Corrections per board, mean | 6.3 | 3.2 | **2.1** |
| Confidently wrong per board | 0.53 | 0.20 | 0.25 |

### Held-out test cells (20,993), per source

| Source | v1 | v2 |
|---|---:|---:|
| Printed (unseen font) | 99.7% | 100.0% |
| Handwritten pen (unseen writers) | 37.7% | **98.4%** |
| Faint pencil (unseen writers) | 30.1% | **97.1%** |
| Real photos (Wicht test) | 96.0% | **97.4%** |
| Empty with shadows, specks, notes | 99.3% | 97.7% |
| Overall | 70.8% | **98.3%** |
| Confidently wrong (≥ 0.90) | 10.8% | **0.5%** |
| Sent to Review (< 0.90) | 27.5% | 3.7% |

The full confusion matrix is in `cell_metrics_test.json`. The commonest v2
errors are faint digits read as empty, and 4↔9 and 1↔7 in handwriting.
Per-board data: `wicht_board_metrics.json`, `wicht_end_to_end.json`,
`wicht_end_to_end_baseline_v1.json`.

## Model v3: the owner's own book pages (2026-11-25, second pass)

The owner's iPhone retest showed what the public data missed: her 9 (round
loop, straight tail) was read as 4, her crossed 7 as 4, her 5 as 3, and her
looped 2 was unstable. Printed digits were fine.

- **Data:** 14 iPhone photos of solved puzzles in the owner's books
  (`data/owner`, git-ignored, local only). Labels need no hand-typing. The
  confidently read printed givens define each puzzle, and its unique
  solution labels every cell. Two photos of the same page gave identical
  labels. One grid whose detected corner cut a column was excluded.
  Split by page, so a page and its twin photo never cross splits:
  - Train: book 1 page 1, pages 38, 39, 40 (648 cells)
  - Validation: page 41 (81 cells)
  - Test: pages 46, 47, 51 (324 cells), never trained on
- **Training:** about 5 minutes of fine-tuning from v2, with the owner's
  cells oversampled and all v2 data kept. Half of the synthetic handwritten
  7s get a continental crossbar.
- **Review:** an unsure cell offers the model's second reading
  ("Maybe 9?"). It is applied only by a tap.

| Owner held-out pages (full pipeline, 4 boards) | v2 | **v3** |
|---|---:|---:|
| Corrections per board, mean | 10.75 | **1.25** |
| Boards with nothing to fix | 0 | 1 |
| Owner cells read correctly | 86.1% | **98.8%** |
| Confidently wrong cells | 4 | 1 |

General data (held-out test cells): overall 98.1% → 97.8%, printed 100% →
100%, handwritten pen 98.2% → 98.1%, pencil 97.1% → 96.9%, empty 97.8% →
96.0%. Wicht real photos end to end: 24/40 complete boards for both, mean
corrections 10.7 → 11.1.

## Not yet measured / remaining limitations

- **Owner photos are one writer and three books.** v3 is tuned to the
  owner's handwriting; other people's handwriting is covered only by the
  general data above.
- **Empty cells on owner pages are not measured.** Every owner page was
  solved, so the box-line "1" seen on an unsolved page in the iPhone
  retest has no labelled test yet.
- **Whole-page photos confuse detection.** On two of 14 photos the real
  grids were missed, and some candidates were page edges or half grids from
  the facing page. The camera frame avoids this in the normal flow.
- Curved book pages are handled only within the segmenter's band-local
  lines. There is no full dewarping, so a strongly curved spine side can still
  misalign the outer cells.
- 9 of 40 real photos still have off corners when the grid touches dense
  text or the photo edge.
- A sideways photo without EXIF orientation is read rotated (one Wicht
  photo). Camera captures carry EXIF, so this mainly affects imported
  images.
- The frame-to-photo mapping assumes the photo has the preview's aspect
  ratio. A small mismatch is absorbed by the 8% search margin and the
  whole-photo fallback. It is not yet verified on device.

## Reproduce

```bash
cd tools/sudoku_scanner_ml
.venv/bin/python -I -m sudoku_scanner_ml.cells_v2
# normalize with the Dart contract (compile tool/normalize_cells.dart first)
# train:   train_v2.py; export: export.py --config configs/v2.yaml
# metrics: evaluate_v2.py, evaluate_boards_v2.py
cd ../../packages/sudoku_scanner
MICHI_WICHT=<wicht repo> MICHI_BENCH_OUT=out.json flutter test --tags benchmark test/benchmark
```
