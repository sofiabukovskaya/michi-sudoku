import json
from pathlib import Path

import numpy as np

from sudoku_scanner_ml.evaluate import predict

ROOT = Path(__file__).resolve().parents[3]
MODEL = ROOT / "packages/sudoku_scanner/assets/models/michi_digit_v3.tflite"
FIXTURES = ROOT / "packages/sudoku_scanner/test/fixtures/model_input"


def test_shipped_model_matches_dart_fixtures():
    """Tensors come from the Dart CellNormalizer; labels are ground truth."""
    cases = json.loads((FIXTURES / "cases.json").read_text(encoding="utf-8"))
    tensors = np.stack(
        [
            np.fromfile(FIXTURES / case["tensor"], np.float32).reshape(32, 32, 1)
            for case in cases
        ]
    )
    probabilities = predict(MODEL, tensors)
    assert probabilities.shape == (len(cases), 10)
    assert np.allclose(probabilities.sum(axis=1), 1, atol=1e-4)
    for case, row in zip(cases, probabilities):
        blank = not np.any(
            np.fromfile(FIXTURES / case["tensor"], np.float32)
        )
        predicted = 0 if blank else int(row.argmax())
        assert predicted == case["label"], case["image"]
