"""Freeze a few scanner crop tensors for Python/Dart preprocessing parity."""

import argparse
import json
import shutil
from pathlib import Path

import numpy as np

from .manifest import read_manifest
from .preprocess import normalize_cell


def create(manifest: Path, output: Path, model: Path | None = None) -> None:
    rows = read_manifest(manifest)
    if len(rows) != 81:
        raise ValueError("Parity fixture source must contain one complete board")
    output.mkdir(parents=True, exist_ok=True)
    cases = []
    tensors = []
    for index in (0, 1, 2, 40):
        source = manifest.parent / rows[index]["sample_path"]
        stem = f"cell_{index:02d}"
        shutil.copy2(source, output / f"{stem}.png")
        tensor = normalize_cell(source)
        (output / f"{stem}.f32").write_bytes(tensor.tobytes())
        tensors.append(tensor)
        cases.append(
            {
                "image": f"{stem}.png",
                "tensor": f"{stem}.f32",
                "label": int(rows[index]["label"]),
            }
        )
    if model is not None:
        from .evaluate import predict

        for case, probabilities in zip(
            cases, predict(model, np.stack(tensors)), strict=True
        ):
            case["prediction"] = int(probabilities.argmax())
            case["confidence"] = float(probabilities.max())
    (output / "cases.json").write_text(json.dumps(cases, indent=2), encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--model", type=Path)
    args = parser.parse_args()
    create(args.manifest, args.output, args.model)


if __name__ == "__main__":
    main()
