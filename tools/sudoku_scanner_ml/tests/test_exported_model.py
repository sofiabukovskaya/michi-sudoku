from pathlib import Path

import numpy as np

from sudoku_scanner_ml.evaluate import predict
from sudoku_scanner_ml.preprocess import normalize_cell

ROOT = Path(__file__).resolve().parents[3]
MODEL = ROOT / "packages/sudoku_scanner/assets/models/michi_digit_v1.tflite"
FIXTURES = ROOT / "packages/sudoku_scanner/test/fixtures/model_input"


def test_committed_model_smoke_on_empty_and_printed_digit():
    images = np.stack(
        [
            normalize_cell(FIXTURES / "cell_02.png"),
            normalize_cell(FIXTURES / "cell_00.png"),
        ]
    )
    probabilities = predict(MODEL, images)
    assert probabilities.shape == (2, 10)
    assert np.array_equal(probabilities.argmax(axis=1), [0, 5])
    assert np.allclose(probabilities.sum(axis=1), 1, atol=1e-4)
