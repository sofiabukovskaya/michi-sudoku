# Phase 14 scanner ML evaluation

Model: `michi-digit-v1`, float32 TFLite, 32×32×1 input, ten classes (empty,
1–9), 215,994 parameters, 869,100-byte artifact. Training used Python 3.11.18,
TensorFlow 2.21.0, OpenCV 4.10.0.84, seed 14013, Adam at 0.001, batch 128,
inverse-square-root class weighting, early stopping and best validation
checkpointing. Best checkpoint was epoch 15 of 20 run epochs. Keras to TFLite
parity on 256 validation cells had zero class changes and maximum probability
delta `3.58e-7`.

## Data and split discipline

| Source | Train | Validation | Final test | Role |
|---|---:|---:|---:|---|
| Purpose-created synthetic cells | 7,000 | 7,000 | 7,000 | Manrope train, Lora validation, OFL Roboto test |
| Wicht V2 real photos | 10,287 cells / 127 photos | 2,592 / 32 photos | 3,240 / 40 photos | Official 160/40 image split; one training image lacks outline |
| Printed-digits supplemental | 6,299 | 0 | 0 | Training only; upstream polarity inverted |

Total optimization data: 23,586 cells. Validation includes 9,592 cells.
All cells from one Wicht photo remain in one split. The 40 official test
photos were not used for training, checkpoint selection, or confidence
threshold selection. The dataset's annotated quadrilaterals drive the Wicht
OCR crop benchmark, followed by MICHI's 900×900 correction and cell segmenter.
Thus the Wicht cell metrics isolate classification; they are **not** an
end-to-end grid-detection score. One train photo (`image103`) lacks a supplied
outline and is recorded as excluded. The Phase 13 detector found 146/160
Wicht training grids independently. This is a separate scanner limitation.

Synthetic augmentation varies size, offset, rotation, paper tone, contrast,
blur, edge fragments, JPEG compression, and noise. Empty cells receive the
same paper/lighting variations. Model input is mean RGB luminance, bilinearly
resized at pixel centers to 32×32 and divided by 255. Phase 13 segmentation
already suppresses cell borders with a 14% inset; no second thresholding or
centering step is applied. Four frozen real scanner crops verify Python/Dart
pixel parity.

## Results

| Set | Cells | Cell accuracy | Corrections per board | Exact boards |
|---|---:|---:|---:|---:|
| Synthetic validation, held-out Lora | 7,000 | 99.84% | — | — |
| Synthetic test, held-out Roboto | 7,000 | 99.96% | — | — |
| Wicht real-photo validation | 2,592 | 96.49% | 2.84 mean | 17/32 |
| Wicht official real-photo holdout | 3,240 | **92.10%** | **6.40 mean, 2.5 median** | **13/40** |
| Unchanged Phase 13 generated photo | 81 | 97.53% | **2** | 0/1 |

The Phase 13 template recognizer needed **7** corrections on that exact photo;
the new model needs **2**. Five additional purpose-created board styles
(clean print, alternate font, digital screenshot, uneven light, low resolution)
were detected, segmented, and classified with 0 corrections each. They are
sanity fixtures, not real-camera accuracy evidence. Full machine-readable
confusion matrices, per-board results, and class metrics are in
`tools/sudoku_scanner_ml/reports/`.

Wicht official holdout per-class precision / recall:

| Class | Precision | Recall |
|---|---:|---:|
| Empty | 0.984 | 0.995 |
| 1 | 0.937 | 0.806 |
| 2 | 0.937 | 0.748 |
| 3 | 0.733 | 0.780 |
| 4 | 0.870 | 0.806 |
| 5 | 0.840 | 0.787 |
| 6 | 0.830 | 0.752 |
| 7 | 0.898 | 0.776 |
| 8 | 0.552 | 0.837 |
| 9 | 0.907 | 0.784 |

The largest holdout confusions are 6→8 and 3→8 (15 each), 2→8 (14), 5→8
(13), and 7→8 (12). Some photos are much harder: the worst board required
30 corrections. The 40-board total was 256 corrections, including 10 false
digits, 34 missed digits, and 212 wrong non-empty digits.

## Confidence and product interpretation

Validation selected `0.90` as the high-confidence boundary and `0.80` as the
low-confidence Review marker boundary. On Wicht validation, 0/2,375
predictions at or above 0.90 were wrong. **On the untouched Wicht holdout,
22/2,835 at or above 0.90 were wrong.** Confidence is therefore not reliably
calibrated across real-photo styles. The app never auto-imports a scan: every
board goes through editable Review, then Sudoku constraint and ExactSolver
uniqueness checks. These checks flag inconsistency but do not rewrite OCR or
guarantee that all mistaken clues are noticed. Raw confidence is not shown as
an accuracy percentage.

The holdout result was recorded without tuning v1 against it. Future model
work should add more independently sourced real-photo groups and establish a
new untouched holdout before claiming better generalization. The existing
Wicht test set must not be silently repurposed for training.

## Runtime measurement

On this Apple Silicon development Mac, a warmed Python TFLite interpreter
with two CPU threads took about **4.2 ms for 81 inference calls** (mean of
ten full-board runs). This excludes image decode, Dart input conversion,
isolate communication, grid detection, and segmentation; it is not an
on-device phone latency claim. The scanner logs each pipeline stage for
development. A physical-device end-to-end timing is still needed.

## Simulator review check

On 2026-11-06, the iPhone 16 / iOS 18.3 simulator imported the unchanged
Phase 13 generated photo from Photos. Review exposed two wrong recognized
digits (r3c3 and r5c4, both read as 3 instead of 8), highlighted their
constraint conflicts, accepted both edits, and opened the resulting puzzle in
Game as an imported Sudoku. The new-puzzle sheet was made scrollable after
this check revealed that its Scan Sudoku action was clipped on the simulator.
This verifies the photo-picker and editable Review path with a generated
image; it does not verify physical camera permission or capture.

## Limits

The Wicht benchmark uses provided grid outlines, and the current detector
still misses some real photos. Pencil marks, handwritten digits, severe glare,
occlusion, stylized type, and live camera frames were not evaluated. The
digital board result is generated artwork, not a photographed screen.
Physical-device camera permission, capture, cleanup, and inference timing
remain outstanding. The selected float32 model was preferred over untested
quantization; there is no claim of quantized performance.

Sources: [Wicht V2](https://github.com/wichtounet/sudoku_dataset) (CC BY 4.0),
[printed-digits-dataset](https://github.com/kaydee0502/printed-digits-dataset)
(MIT), and the bundled Roboto OFL notice in the ML tooling directory.
