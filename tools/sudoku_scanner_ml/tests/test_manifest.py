from pathlib import Path

import cv2
import numpy as np
import pytest

from sudoku_scanner_ml.manifest import validate_manifest, write_manifest


def _row(sample_id: str, split: str, group: str = "photo-1") -> dict[str, str]:
    return {
        "sample_id": sample_id,
        "sample_path": f"{sample_id}.png",
        "label": "0",
        "source_image_id": group,
        "source_type": "printed_scan",
        "font_id": "",
        "split": split,
    }


def _image(path: Path) -> None:
    cv2.imwrite(str(path), np.full((20, 20, 3), 255, dtype=np.uint8))


def test_group_aware_manifest_accepts_distinct_photo_groups(tmp_path: Path):
    _image(tmp_path / "one.png")
    _image(tmp_path / "two.png")
    manifest = tmp_path / "manifest.csv"
    write_manifest(manifest, [_row("one", "train"), _row("two", "test", "photo-2")])
    assert validate_manifest(manifest)["groups"] == 2


def test_same_photo_cannot_leak_across_splits(tmp_path: Path):
    _image(tmp_path / "one.png")
    _image(tmp_path / "two.png")
    manifest = tmp_path / "manifest.csv"
    write_manifest(manifest, [_row("one", "train"), _row("two", "test")])
    with pytest.raises(ValueError, match="split leakage"):
        validate_manifest(manifest)


@pytest.mark.parametrize("problem", ["duplicate", "label", "missing", "corrupt"])
def test_manifest_rejects_bad_data(tmp_path: Path, problem: str):
    _image(tmp_path / "one.png")
    row = _row("one", "train")
    rows = [row]
    if problem == "duplicate":
        rows.append(row.copy())
    elif problem == "label":
        row["label"] = "10"
    elif problem == "missing":
        row["sample_path"] = "missing.png"
    else:
        (tmp_path / "one.png").write_bytes(b"not png")
    manifest = tmp_path / "manifest.csv"
    write_manifest(manifest, rows)
    with pytest.raises(ValueError):
        validate_manifest(manifest)
