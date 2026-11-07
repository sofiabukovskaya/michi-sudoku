import numpy as np

from sudoku_scanner_ml.model import build_model


def test_small_cnn_has_ten_probabilities_and_mobile_sized_input():
    model = build_model()
    assert model.input_shape == (None, 32, 32, 1)
    assert model.output_shape == (None, 10)
    assert model.count_params() < 300_000
    output = model(np.ones((1, 32, 32, 1), dtype=np.float32)).numpy()
    assert np.isclose(output.sum(), 1)
