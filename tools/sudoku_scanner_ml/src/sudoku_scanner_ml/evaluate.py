"""Evaluate cell, confidence, and board correction metrics."""

import argparse
import json
from collections import defaultdict
from pathlib import Path

import numpy as np
import tensorflow as tf

from .data import load_split


def predict(model_path: Path, images: np.ndarray) -> np.ndarray:
    if model_path.suffix == ".tflite":
        interpreter = tf.lite.Interpreter(model_path=str(model_path), num_threads=2)
        interpreter.allocate_tensors()
        input_index = interpreter.get_input_details()[0]["index"]
        output_index = interpreter.get_output_details()[0]["index"]
        results = np.empty((len(images), 10), dtype=np.float32)
        for index, image in enumerate(images):
            interpreter.set_tensor(input_index, image[None, ...])
            interpreter.invoke()
            results[index] = interpreter.get_tensor(output_index)[0]
        return results
    model = tf.keras.models.load_model(model_path)
    return model.predict(images, batch_size=128, verbose=0)


def metrics(y_true: np.ndarray, probabilities: np.ndarray, rows: list[dict]) -> dict:
    predictions = probabilities.argmax(axis=1)
    confidence = probabilities.max(axis=1)
    matrix = np.zeros((10, 10), dtype=np.int64)
    for actual, predicted in zip(y_true, predictions, strict=True):
        matrix[actual, predicted] += 1
    per_class = {}
    for label in range(10):
        tp = int(matrix[label, label])
        per_class[str(label)] = {
            "samples": int(matrix[label].sum()),
            "precision": tp / max(1, int(matrix[:, label].sum())),
            "recall": tp / max(1, int(matrix[label].sum())),
        }
    by_board: dict[str, list[int]] = defaultdict(list)
    for index, row in enumerate(rows):
        if row["source_type"] != "synthetic":
            by_board[row["source_image_id"]].append(index)
    boards = {}
    for board_id, indexes in by_board.items():
        actual = y_true[indexes]
        predicted = predictions[indexes]
        boards[board_id] = {
            "cells": len(indexes),
            "recognized_clues": int(np.count_nonzero(predicted)),
            "correct_recognized_clues": int(
                np.count_nonzero((predicted == actual) & (actual != 0))
            ),
            "false_digits": int(np.count_nonzero((predicted != 0) & (actual == 0))),
            "missed_digits": int(np.count_nonzero((predicted == 0) & (actual != 0))),
            "wrong_digits": int(
                np.count_nonzero(
                    (predicted != actual) & (predicted != 0) & (actual != 0)
                )
            ),
            "manual_corrections": int(np.count_nonzero(predicted != actual)),
            "exact_board": bool(np.array_equal(predicted, actual))
            if len(indexes) == 81
            else None,
        }
    high_errors = {}
    for threshold in [0.70, 0.80, 0.90, 0.95, 0.98, 0.99, 0.995]:
        mask = confidence >= threshold
        high_errors[str(threshold)] = {
            "count": int(mask.sum()),
            "wrong": int(np.count_nonzero(mask & (predictions != y_true))),
        }
    return {
        "samples": len(y_true),
        "accuracy": float(np.mean(predictions == y_true)),
        "per_class": per_class,
        "confusion_matrix": matrix.tolist(),
        "confidence_bins": high_errors,
        "boards": boards,
    }


def evaluate(model_path: Path, manifest: Path, split: str, output: Path) -> dict:
    images, labels, rows = load_split(manifest, split)
    report = metrics(labels, predict(model_path, images), rows)
    report.update({"model": str(model_path), "manifest": str(manifest), "split": split})
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2), encoding="utf-8")
    return report


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument(
        "--split", choices=("train", "validation", "test"), required=True
    )
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    report = evaluate(args.model, args.manifest, args.split, args.output)
    print(
        json.dumps(
            {
                key: report[key]
                for key in ("accuracy", "per_class", "confidence_bins", "boards")
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
