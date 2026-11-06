"""Check Keras and exported TFLite predictions on the same local cells."""

import argparse
import json
from pathlib import Path

import numpy as np

from .data import load_split
from .evaluate import predict


def compare(
    keras_model: Path, tflite_model: Path, manifest: Path, split: str, limit: int = 256
) -> dict:
    images, _, _ = load_split(manifest, split)
    images = images[:limit]
    keras_probabilities = predict(keras_model, images)
    tflite_probabilities = predict(tflite_model, images)
    report = {
        "cells": len(images),
        "class_mismatches": int(
            np.count_nonzero(
                keras_probabilities.argmax(axis=1)
                != tflite_probabilities.argmax(axis=1)
            )
        ),
        "max_probability_delta": float(
            np.max(np.abs(keras_probabilities - tflite_probabilities))
        ),
    }
    if report["class_mismatches"] or report["max_probability_delta"] > 0.02:
        raise ValueError(f"Keras/TFLite parity failed: {report}")
    return report


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--keras", type=Path, required=True)
    parser.add_argument("--tflite", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--split", default="validation")
    parser.add_argument("--limit", type=int, default=256)
    args = parser.parse_args()
    print(
        json.dumps(
            compare(args.keras, args.tflite, args.manifest, args.split, args.limit),
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
