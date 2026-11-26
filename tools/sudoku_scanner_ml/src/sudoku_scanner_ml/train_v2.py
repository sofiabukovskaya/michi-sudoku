"""Train michi-digit-v2 on CellNormalizer v2 tensors (see cells_v2.py).

Inputs are `data/v2/{split}.f32` written by the Dart CLI
`packages/sudoku_scanner/tool/normalize_cells.dart`, so training sees the
exact on-device preprocessing. Train / validation / test come from disjoint
sources (fonts, MNIST rows, Wicht images), so there is no leakage.
"""

import argparse
import json
from pathlib import Path

import numpy as np
import tensorflow as tf
import yaml


def load(data: Path, split: str):
    x = np.fromfile(data / f"{split}.f32", dtype=np.float32).reshape(-1, 32, 32, 1)
    y = np.load(data / f"{split}.labels.npy")
    s = np.load(data / f"{split}.sources.npy")
    return x, y, s


def build_model() -> tf.keras.Model:
    inputs = tf.keras.Input(shape=(32, 32, 1), name="cell")
    x = inputs
    for filters in (32, 64):
        x = tf.keras.layers.Conv2D(filters, 3, padding="same", use_bias=False)(x)
        x = tf.keras.layers.BatchNormalization()(x)
        x = tf.keras.layers.ReLU()(x)
        x = tf.keras.layers.Conv2D(filters, 3, padding="same", use_bias=False)(x)
        x = tf.keras.layers.BatchNormalization()(x)
        x = tf.keras.layers.ReLU()(x)
        x = tf.keras.layers.MaxPool2D()(x)
    x = tf.keras.layers.Conv2D(128, 3, padding="same", use_bias=False)(x)
    x = tf.keras.layers.BatchNormalization()(x)
    x = tf.keras.layers.ReLU()(x)
    x = tf.keras.layers.GlobalAveragePooling2D()(x)
    x = tf.keras.layers.Dropout(0.3)(x)
    x = tf.keras.layers.Dense(128, activation="relu")(x)
    x = tf.keras.layers.Dropout(0.2)(x)
    outputs = tf.keras.layers.Dense(10, activation="softmax", name="class")(x)
    return tf.keras.Model(inputs, outputs, name="michi_digit_v2")


_GEOMETRY = tf.keras.Sequential([
    tf.keras.layers.RandomRotation(0.03, fill_mode="constant"),
    tf.keras.layers.RandomZoom(0.08, fill_mode="constant"),
    tf.keras.layers.RandomTranslation(0.06, 0.06, fill_mode="constant"),
])


def augment(x, y):
    # Small geometric jitter the normalizer leaves (rotation/shear/scale)
    # plus stroke-weight changes; never flips (6/9 would swap).
    x = _GEOMETRY(x, training=True)
    n = tf.shape(x)[0]
    weight = tf.random.uniform((n, 1, 1, 1))
    bolder = tf.nn.max_pool2d(x, 2, 1, "SAME")
    thinner = -tf.nn.max_pool2d(-x, 2, 1, "SAME")
    x = tf.where(weight < 0.15, bolder, tf.where(weight > 0.9, thinner, x))
    x = x * tf.random.uniform((n, 1, 1, 1), 0.7, 1.0)
    return tf.clip_by_value(x, 0.0, 1.0), y


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data", type=Path, default=Path("data/v2"))
    parser.add_argument("--config", type=Path, default=Path("configs/v2.yaml"))
    parser.add_argument("--output", type=Path, default=Path("artifacts/v2"))
    args = parser.parse_args()
    config = yaml.safe_load(args.config.read_text(encoding="utf-8"))
    tf.keras.utils.set_random_seed(config["seed"])
    x_train, y_train, _ = load(args.data, "train")
    x_val, y_val, _ = load(args.data, "validation")
    counts = np.bincount(y_train, minlength=10)
    class_weight = {i: float(counts.sum() / (10 * c)) for i, c in enumerate(counts)}
    train = (
        tf.data.Dataset.from_tensor_slices((x_train, y_train))
        .shuffle(len(x_train), seed=config["seed"])
        .batch(config["batch_size"])
        .map(augment, num_parallel_calls=tf.data.AUTOTUNE)
        .prefetch(tf.data.AUTOTUNE)
    )
    val = tf.data.Dataset.from_tensor_slices((x_val, y_val)).batch(512)
    model = build_model()
    steps = config["epochs"] * int(np.ceil(len(x_train) / config["batch_size"]))
    model.compile(
        optimizer=tf.keras.optimizers.Adam(
            tf.keras.optimizers.schedules.CosineDecay(config["learning_rate"], steps)
        ),
        loss="sparse_categorical_crossentropy",
        metrics=["accuracy"],
    )
    args.output.mkdir(parents=True, exist_ok=True)
    history = model.fit(
        train,
        validation_data=val,
        epochs=config["epochs"],
        class_weight=class_weight,
        callbacks=[
            tf.keras.callbacks.ModelCheckpoint(
                str(args.output / "best.keras"),
                monitor="val_accuracy",
                save_best_only=True,
            ),
            tf.keras.callbacks.EarlyStopping(
                monitor="val_accuracy", patience=config["patience"],
                restore_best_weights=True,
            ),
        ],
        verbose=2,
    )
    (args.output / "history.json").write_text(
        json.dumps({k: [float(v) for v in vs] for k, vs in history.history.items()}),
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
