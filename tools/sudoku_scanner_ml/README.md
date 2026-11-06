# MICHI scanner ML tooling

Python 3.11 training and evaluation for the local, ten-class printed Sudoku
classifier. The Flutter app ships only `michi_digit_v1.tflite` and its metadata;
it does not run Python, OpenCV, TensorFlow training, or remote inference.

## Sources and attribution

- [Wicht and Hennebert Sudoku Dataset V2](https://github.com/wichtounet/sudoku_dataset),
  repository commit `0db6de036b80b4e8e4574abe6e15026331bd5c2c`. Photos and
  dataset are CC BY 4.0. The official `v2_train.desc` (160 images) is split by
  source photo into 127 training and 32 validation images after one image
  without an outline is excluded. The official `v2_test.desc` contains 40
  images and is kept out of training, checkpoint selection, and threshold
  selection. The citation requested by the dataset authors is Wicht and
  Hennebert, *Camera-based Sudoku recognition with deep belief network*,
  SoCPaR 2014, pp. 83–88.
- [Printed Numerical Digits Image Dataset](https://github.com/kaydee0502/printed-digits-dataset),
  repository commit `bdaa0000821c849a38fe8a9d27bde2bfe15414f1`, MIT license,
  copyright 2021 Kshitij Dhama. Its 6,299 available 28×28 assets are
  polarity-inverted and used only as supplemental training data. They are
  augmented variants of a much smaller original collection, so they never
  form an evaluation split.
- Purpose-created synthetic crops use the existing MICHI Manrope and Lora
  font assets. The held-out Roboto font and its SIL OFL license are in `fonts/`.
  No third-party raw photo or cell dataset is committed to this repository.

The optional Hugging Face and KU Leuven sources named in the brief were not
needed for v1. Adding them requires inspecting their annotations and grouping
before changing the dataset version.

## Input contract

The existing Dart scanner detects and rectifies a grid to 900×900, finds the
ten row and column lines, and crops 14% inside each cell. `DigitClassifier`
receives each encoded crop. Both `preprocess.py` and Dart's
`ModelCellPreprocessor` decode RGB, average its three channels, bilinearly
resize at pixel centers to 32×32, and divide by 255. Black is 0, white is 1.
There is no extra thresholding or recentering after segmentation. Four frozen
cells and float tensors in the scanner test fixtures verify pixel parity.

## Reproduce

Install [uv](https://docs.astral.sh/uv/) and run from this directory:

```sh
uv sync --locked --python 3.11
uv run ruff format --check src tests
uv run ruff check src tests
uv run pytest -q
```

Clone the two upstream repositories into `data/upstream/` at the commits above.
This directory and all generated data are ignored by Git. Then:

```sh
uv run python -m sudoku_scanner_ml.synthetic --config configs/base.yaml --output data/synthetic
uv run python -m sudoku_scanner_ml.prepare_printed --source data/upstream/printed-digits-dataset --output data/printed
cd ../../packages/sudoku_scanner
dart run tool/extract_wicht_cells.dart ../../tools/sudoku_scanner_ml/data/upstream/sudoku_dataset ../../tools/sudoku_scanner_ml/data/wicht
cd ../../tools/sudoku_scanner_ml
uv run python -m sudoku_scanner_ml.merge_manifests --inputs data/synthetic/manifest.csv data/wicht/manifest.csv data/printed/manifest.csv --output data/combined/manifest.csv
uv run python -m sudoku_scanner_ml.manifest data/combined/manifest.csv
uv run python -m sudoku_scanner_ml.contact_sheet --manifest data/combined/manifest.csv --split train --output artifacts/train_contact_sheet.png
uv run python -m sudoku_scanner_ml.train --config configs/base.yaml --manifest data/combined/manifest.csv --output artifacts/v1
uv run python -m sudoku_scanner_ml.export --checkpoint artifacts/v1/best.keras --output ../../packages/sudoku_scanner/assets/models/michi_digit_v1.tflite --version michi-digit-v1 --config configs/base.yaml
```

Evaluate synthetic validation, Wicht validation, and the official Wicht test
separately with `python -m sudoku_scanner_ml.evaluate --model ... --manifest
... --split ... --output ...`. The machine-readable v1 reports are in
`reports/`. `compare_export` checks Keras/TFLite parity. The Wicht extractor
uses the dataset's annotated outlines and MICHI's perspective/segmentation
code, so those metrics isolate digit recognition. Run
`tool/benchmark_grid_detector.dart` separately for end-to-end grid detection.

The official 40-image test set has been evaluated **once** for v1. Do not tune
this artifact using its failures and then report that split as untouched. A
new model version trained on test-discovered examples needs a new untouched
holdout set. Use `hard_example.py` to add user-corrected, approved training
cells to a new dataset version with their prior prediction and confidence.

## Flutter tests

`tflite_flutter` 0.12.1 includes the macOS native library but expects it in
the Flutter SDK test resource directory. On a macOS development machine, run
`scripts/prepare_flutter_test_runtime.sh <Flutter SDK root> <Dart pub cache
root>` once before `flutter test`. Android and iOS apps bundle their native
libraries through the plugin. The classifier loads one interpreter, uses its
isolate worker for the 81 cells, and closes both resources together.

The model is float32 (no quantization); see the [evaluation report](../../docs/phase14_scanner_ml_evaluation.md)
and [model card](../../docs/phase14_digit_model_card.md) for measured quality
and limits. The existing Review and Sudoku validation remain required.
