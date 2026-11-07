"""Prepare the approved printed-digits dataset as training-only cell crops.

The upstream 28×28 assets use white ink on black. MICHI's camera crops use the
opposite polarity, so this conversion inverts and resizes them. Upstream images
are augmented from a small original set and are never used for evaluation.
"""

import argparse
from pathlib import Path

import cv2

from .manifest import write_manifest


def prepare(source: Path, output: Path) -> Path:
    rows = []
    cell_dir = output / "cells"
    cell_dir.mkdir(parents=True, exist_ok=True)
    for label in range(10):
        for path in sorted((source / "assets" / str(label)).iterdir()):
            if path.suffix.lower() not in {".png", ".jpg", ".jpeg"}:
                continue
            image = cv2.imread(str(path), cv2.IMREAD_GRAYSCALE)
            if image is None or min(image.shape) < 12:
                raise ValueError(f"Bad supplemental image: {path}")
            normalized = cv2.resize(
                255 - image, (72, 72), interpolation=cv2.INTER_LINEAR
            )
            sample_id = f"printed-{label}-{path.stem}"
            relative = Path("cells") / f"{sample_id}.png"
            cv2.imwrite(str(output / relative), normalized)
            rows.append(
                {
                    "sample_id": sample_id,
                    "sample_path": str(relative),
                    "label": str(label),
                    "source_image_id": sample_id,
                    "source_type": "supplemental_printed",
                    "font_id": "upstream_unknown",
                    "split": "train",
                    "notes": "polarity_inverted_from_upstream_28px",
                }
            )
    manifest = output / "manifest.csv"
    write_manifest(manifest, rows)
    return manifest


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    print(prepare(args.source, args.output))


if __name__ == "__main__":
    main()
