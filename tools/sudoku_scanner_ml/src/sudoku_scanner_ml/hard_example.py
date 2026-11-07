"""Add a corrected local cell to a new training manifest version."""

import argparse
import shutil
from pathlib import Path

from .manifest import read_manifest, write_manifest


def add_hard_example(
    manifest: Path,
    image: Path,
    source_id: str,
    cell_index: int,
    label: int,
    old_prediction: int,
    old_confidence: float,
) -> Path:
    if not 0 <= cell_index < 81 or not 0 <= label <= 9 or not 0 <= old_prediction <= 9:
        raise ValueError("Cell index or class is outside its valid range")
    if not 0 <= old_confidence <= 1:
        raise ValueError("Confidence must be in [0, 1]")
    rows = read_manifest(manifest) if manifest.exists() else []
    if any(
        row["source_image_id"] == source_id and row["split"] == "test" for row in rows
    ):
        raise ValueError("Cannot move an existing test group into training")
    sample_id = f"hard-{source_id}-{cell_index:02d}"
    if any(row["sample_id"] == sample_id for row in rows):
        raise ValueError(f"Duplicate sample ID: {sample_id}")
    relative = Path("cells") / f"{sample_id}.png"
    destination = manifest.parent / relative
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(image, destination)
    rows.append(
        {
            "sample_id": sample_id,
            "sample_path": str(relative),
            "label": str(label),
            "source_image_id": source_id,
            "source_type": "hard_example",
            "font_id": "",
            "split": "train",
            "notes": "human-corrected recognition error",
            "old_prediction": str(old_prediction),
            "old_confidence": str(old_confidence),
        }
    )
    write_manifest(manifest, rows)
    return manifest


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--image", type=Path, required=True)
    parser.add_argument("--source-id", required=True)
    parser.add_argument("--cell-index", type=int, required=True)
    parser.add_argument("--label", type=int, required=True)
    parser.add_argument("--old-prediction", type=int, required=True)
    parser.add_argument("--old-confidence", type=float, required=True)
    args = parser.parse_args()
    print(
        add_hard_example(
            args.manifest,
            args.image,
            args.source_id,
            args.cell_index,
            args.label,
            args.old_prediction,
            args.old_confidence,
        )
    )


if __name__ == "__main__":
    main()
