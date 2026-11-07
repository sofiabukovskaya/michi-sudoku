# MICHI digit classifier v1 — internal model card

**Purpose:** On-device perception of printed Sudoku cell crops. Output classes
are `0=empty, 1…9=digit`; the scanner still requires human Review and the
Sudoku engine independently validates the confirmed board.

**Version/artifact:** `michi-digit-v1`, trained 2026-11-05 with
`tools/sudoku_scanner_ml/configs/base.yaml`; float32 TFLite at
`packages/sudoku_scanner/assets/models/michi_digit_v1.tflite`, 869,100 bytes,
SHA-256 `8c8b94aa89e9457c68ae5166eb144879f3d5efd4ad7befbabdf850153e86aa93`.

**Input:** Actual Phase 13 inset cell crop, RGB mean luminance, pixel-center
bilinear resize to 32×32×1, normalized to `[0,1]`; black 0, white 1. The
model expects grid lines suppressed by the existing segmenter.

**Architecture:** Three small convolution blocks (16/32/48 channels), pooling
after the first two, flatten, 64-unit dense layer, dropout 0.15, ten-way
softmax. 215,994 parameters. Adam/cross-entropy, seed 14013, early stopping.

**Data:** 21,000 synthetic cells across Manrope/Lora/Roboto font-disjoint
splits; 159 Wicht V2 training-pool photos yielding 12,879 real cells with
source-photo-aware train/validation division; 6,299 supplemental printed
cells used only for optimization. Official Wicht V2 test remains 40 separate
photos (3,240 cells). Upstream raw datasets are not committed. Reproduction
requires the pinned upstream commits documented in the ML README.

**Evaluation:** Synthetic held-out Roboto 99.96% cell accuracy; Wicht real
validation 96.49%, 2.84 corrections/board; Wicht official holdout 92.10%,
6.40 corrections/board. The unchanged Phase 13 generated photo improved from
7 to 2 corrections. Exact board recognition on Wicht holdout was 13/40.
Wicht evaluation uses provided grid outlines, not full automatic detection.

**Confidence:** Validation-derived high 0.90, low/review 0.80. The real
holdout contained 22 wrong predictions above 0.90, so confidence is a Review
aid, not a calibrated probability or an auto-accept signal.

**Supported/unsupported:** Designed for printed Sudoku and clean rendered
digits. Purpose-created digital artwork passed, but photographs of screens
were not separately measured. Handwriting, pencil marks, severe glare,
occlusion, and arbitrary typography are unsupported. The model does not solve
Sudoku, infer missing clues, or correct a board using ExactSolver.

**Privacy/licensing:** Inference remains local. Wicht/Hennebert photos are
CC BY 4.0; the supplemental printed-digit source is MIT (Kshitij Dhama,
2021); bundled Roboto test font is SIL OFL. Links, commits, and citation are
in the ML README. User photos are not uploaded or used for training.
