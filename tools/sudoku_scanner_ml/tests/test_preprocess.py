import cv2
import numpy as np
import pytest

from sudoku_scanner_ml.preprocess import normalize_cell


def test_blank_and_digit_polarity_and_shape():
    blank = np.full((72, 72, 3), 245, dtype=np.uint8)
    digit = blank.copy()
    cv2.putText(digit, "7", (22, 54), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (20, 20, 20), 3)
    empty_input = normalize_cell(blank)
    digit_input = normalize_cell(digit)
    assert empty_input.shape == (32, 32, 1)
    assert empty_input.dtype == np.float32
    assert np.allclose(empty_input, 245 / 255)
    assert digit_input.min() < 0.2
    assert digit_input.mean() < empty_input.mean()


def test_encoding_and_resize_are_deterministic():
    image = np.arange(72 * 72 * 3, dtype=np.uint8).reshape(72, 72, 3)
    encoded = cv2.imencode(".png", image)[1].tobytes()
    assert np.array_equal(normalize_cell(encoded), normalize_cell(image))


def test_small_or_corrupt_input_is_rejected():
    with pytest.raises(ValueError, match="12×12"):
        normalize_cell(np.zeros((11, 30, 3), dtype=np.uint8))
    with pytest.raises(ValueError, match="decode"):
        normalize_cell(b"not an image")
