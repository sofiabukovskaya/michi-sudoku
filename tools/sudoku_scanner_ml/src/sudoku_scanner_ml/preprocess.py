"""Model input contract shared with Dart's ModelCellPreprocessor.

The scanner already crops 14% inside detected grid lines. This step decodes
that PNG, computes RGB mean intensity (black=0, white=1), and bilinearly
resizes to 32×32. No adaptive threshold or cell-specific recentering occurs.
"""

from pathlib import Path

import cv2
import numpy as np

INPUT_SIZE = 32


def normalize_cell(path_or_bytes: Path | bytes | np.ndarray) -> np.ndarray:
    """Return a (32, 32, 1) float32 tensor with values in [0, 1]."""
    if isinstance(path_or_bytes, np.ndarray):
        bgr = path_or_bytes
    else:
        encoded = (
            np.frombuffer(path_or_bytes, dtype=np.uint8)
            if isinstance(path_or_bytes, bytes)
            else np.fromfile(path_or_bytes, dtype=np.uint8)
        )
        bgr = cv2.imdecode(encoded, cv2.IMREAD_COLOR)
    if bgr is None or bgr.ndim != 3 or bgr.shape[2] < 3:
        raise ValueError("Cell image must decode to RGB pixels")
    height, width = bgr.shape[:2]
    if height < 12 or width < 12:
        raise ValueError("Cell image is smaller than 12×12")
    gray = bgr[:, :, :3].astype(np.float32).mean(axis=2)
    out = np.empty((INPUT_SIZE, INPUT_SIZE, 1), dtype=np.float32)
    for y in range(INPUT_SIZE):
        source_y = min(max((y + 0.5) * height / INPUT_SIZE - 0.5, 0), height - 1)
        y0 = int(source_y)
        y1 = min(y0 + 1, height - 1)
        wy = source_y - y0
        for x in range(INPUT_SIZE):
            source_x = min(max((x + 0.5) * width / INPUT_SIZE - 0.5, 0), width - 1)
            x0 = int(source_x)
            x1 = min(x0 + 1, width - 1)
            wx = source_x - x0
            top = gray[y0, x0] * (1 - wx) + gray[y0, x1] * wx
            bottom = gray[y1, x0] * (1 - wx) + gray[y1, x1] * wx
            out[y, x, 0] = (top * (1 - wy) + bottom * wy) / 255.0
    return out
