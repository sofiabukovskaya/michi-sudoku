"""Render labeled post-preprocessing samples for dataset quality review."""

import argparse
import random
from collections import defaultdict
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw

from .manifest import read_manifest
from .preprocess import normalize_cell


def create_sheet(manifest: Path, output: Path, split: str, seed: int = 14013) -> None:
    grouped: dict[int, list[dict]] = defaultdict(list)
    for row in read_manifest(manifest):
        if row["split"] == split:
            grouped[int(row["label"])].append(row)
    rng = random.Random(seed)
    sheet = Image.new("RGB", (10 * 100, 10 * 120), "#eee")
    draw = ImageDraw.Draw(sheet)
    for label in range(10):
        if len(grouped[label]) < 10:
            raise ValueError(f"Class {label} has fewer than 10 {split} samples")
        for column, row in enumerate(rng.sample(grouped[label], 10)):
            values = normalize_cell(manifest.parent / row["sample_path"])
            preview = Image.fromarray((values[:, :, 0] * 255).astype(np.uint8))
            preview = preview.resize((96, 96), Image.Resampling.NEAREST)
            sheet.paste(preview.convert("RGB"), (column * 100 + 2, label * 120 + 2))
            draw.text((column * 100 + 2, label * 120 + 100), str(label), fill="black")
    output.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(output)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--split", required=True)
    args = parser.parse_args()
    create_sheet(args.manifest, args.output, args.split)


if __name__ == "__main__":
    main()
