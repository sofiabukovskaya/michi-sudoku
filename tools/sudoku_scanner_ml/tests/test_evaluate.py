import numpy as np

from sudoku_scanner_ml.evaluate import metrics


def test_board_metrics_count_false_missed_and_wrong_digits():
    actual = np.array([0, 5, 6, 7], dtype=np.int64)
    probabilities = np.zeros((4, 10), dtype=np.float32)
    probabilities[0, 2] = 1  # false digit
    probabilities[1, 0] = 1  # missed digit
    probabilities[2, 8] = 1  # wrong digit
    probabilities[3, 7] = 1  # correct clue
    rows = [{"source_type": "printed_scan", "source_image_id": "board-1"}] * 4
    board = metrics(actual, probabilities, rows)["boards"]["board-1"]
    assert board["false_digits"] == 1
    assert board["missed_digits"] == 1
    assert board["wrong_digits"] == 1
    assert board["manual_corrections"] == 3
