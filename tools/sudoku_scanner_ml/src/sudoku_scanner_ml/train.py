"""Train MICHI's small CNN from a validated manifest."""

import argparse
import json
from pathlib import Path

import numpy as np
import tensorflow as tf
import yaml

from .data import load_split
from .model import build_model


def train(config_path: Path, manifest: Path, output: Path) -> Path:
    config = yaml.safe_load(config_path.read_text(encoding="utf-8"))
    seed = int(config["seed"])
    np.random.seed(seed)
    tf.keras.utils.set_random_seed(seed)
    tf.config.experimental.enable_op_determinism()
    x_train, y_train, _ = load_split(manifest, "train")
    x_val, y_val, _ = load_split(manifest, "validation")
    class_counts = np.bincount(y_train, minlength=10)
    if np.any(class_counts == 0):
        raise ValueError("Training data must include empty and digits 1–9")
    weights = 1 / np.sqrt(class_counts[y_train])
    weights /= weights.mean()
    output.mkdir(parents=True, exist_ok=True)
    model = build_model(config["input_size"])
    model.compile(
        optimizer=tf.keras.optimizers.Adam(config["learning_rate"]),
        loss="sparse_categorical_crossentropy",
        metrics=["accuracy"],
    )
    best = output / "best.keras"
    history = model.fit(
        x_train,
        y_train,
        sample_weight=weights,
        validation_data=(x_val, y_val),
        batch_size=config["batch_size"],
        epochs=config["epochs"],
        shuffle=True,
        callbacks=[
            tf.keras.callbacks.ModelCheckpoint(
                best, monitor="val_accuracy", mode="max", save_best_only=True
            ),
            tf.keras.callbacks.EarlyStopping(
                monitor="val_accuracy",
                mode="max",
                patience=config["patience"],
                min_delta=config["minimum_delta"],
                restore_best_weights=True,
            ),
            tf.keras.callbacks.ReduceLROnPlateau(
                monitor="val_loss", factor=0.5, patience=2, min_lr=1e-5
            ),
        ],
        verbose=2,
    )
    (output / "history.json").write_text(
        json.dumps(
            {
                key: [float(v) for v in values]
                for key, values in history.history.items()
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    (output / "training_config.yaml").write_text(
        config_path.read_text(encoding="utf-8"), encoding="utf-8"
    )
    (output / "parameters.txt").write_text(str(model.count_params()), encoding="utf-8")
    return best


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    print(train(args.config, args.manifest, args.output))


if __name__ == "__main__":
    main()
