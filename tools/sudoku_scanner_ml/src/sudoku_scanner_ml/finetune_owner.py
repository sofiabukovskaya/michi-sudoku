"""Fine-tune michi-digit-v2 with real owner cells (book photos).

Starts from the v2 checkpoint and keeps all v2 data, so general accuracy is
kept while owner cells (oversampled) teach real handwriting on real paper.
Selection uses owner validation pages only; owner test pages are never seen.
"""

import argparse
import json
from pathlib import Path

import numpy as np
import tensorflow as tf

from sudoku_scanner_ml.train_v2 import augment, load

OWNER = 6


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data", type=Path, default=Path("data/v2"))
    parser.add_argument("--start", type=Path, default=Path("artifacts/v2/best.keras"))
    parser.add_argument("--output", type=Path, default=Path("artifacts/v3"))
    parser.add_argument("--epochs", type=int, default=4)
    parser.add_argument("--oversample", type=int, default=30)
    args = parser.parse_args()
    tf.keras.utils.set_random_seed(20261126)
    x, y, s = load(args.data, "train")
    owner = s == OWNER
    x = np.concatenate([x] + [x[owner]] * args.oversample)
    y = np.concatenate([y] + [y[owner]] * args.oversample)
    xv, yv, sv = load(args.data, "validation")
    train = (
        tf.data.Dataset.from_tensor_slices((x, y))
        .shuffle(len(x), seed=1)
        .batch(256)
        .map(augment, num_parallel_calls=tf.data.AUTOTUNE)
        .prefetch(tf.data.AUTOTUNE)
    )
    model = tf.keras.models.load_model(args.start)
    model.compile(
        optimizer=tf.keras.optimizers.Adam(3e-4),
        loss="sparse_categorical_crossentropy",
        metrics=["accuracy"],
    )
    args.output.mkdir(parents=True, exist_ok=True)
    history = []
    best = -1.0
    for epoch in range(args.epochs):
        model.fit(train, epochs=1, verbose=2)
        pred = model.predict(xv, batch_size=1024, verbose=0).argmax(1)
        general = float((pred == yv).mean())
        own = float((pred[sv == OWNER] == yv[sv == OWNER]).mean())
        score = own + general
        history.append({"epoch": epoch + 1, "validation": general, "owner_validation": own})
        print(history[-1], flush=True)
        if score > best:
            best = score
            model.save(args.output / "best.keras")
    (args.output / "history.json").write_text(json.dumps(history), encoding="utf-8")


if __name__ == "__main__":
    main()
