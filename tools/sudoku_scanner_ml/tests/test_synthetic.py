import random

import numpy as np

from sudoku_scanner_ml.synthetic import FONTS, render_cell


def test_seeded_augmentation_is_reproducible_and_digit_differs_from_blank():
    blank = render_cell(0, FONTS["manrope"], random.Random(7))
    digit = render_cell(5, FONTS["manrope"], random.Random(7))
    again = render_cell(5, FONTS["manrope"], random.Random(7))
    assert np.array_equal(digit, again)
    assert blank.shape == (72, 72, 3)
    assert np.count_nonzero(digit < 100) > np.count_nonzero(blank < 100)
