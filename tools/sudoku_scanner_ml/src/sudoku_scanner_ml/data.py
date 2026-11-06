"""Load manifest-backed labeled cells into fixed-size tensors."""

from pathlib import Path

import numpy as np

from .manifest import read_manifest, validate_manifest
from .preprocess import normalize_cell


def load_split(manifest: Path, split: str) -> tuple[np.ndarray, np.ndarray, list[dict]]:
    validate_manifest(manifest)
    rows = [row for row in read_manifest(manifest) if row["split"] == split]
    if not rows:
        raise ValueError(f"No {split} samples in {manifest}")
    images = np.stack(
        [normalize_cell(manifest.parent / row["sample_path"]) for row in rows]
    )
    labels = np.array([int(row["label"]) for row in rows], dtype=np.int64)
    return images, labels, rows
