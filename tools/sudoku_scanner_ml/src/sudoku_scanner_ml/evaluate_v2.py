"""Compare michi-digit-v1 and v2 on the held-out v2 test split, per source.

v1 receives its own contract (mean gray / 255, bilinear 32×32); v2 receives
the CellNormalizer tensors, with the on-device blank short-circuit.
"""

import argparse
import json
import struct
from pathlib import Path

import cv2
import numpy as np
import tensorflow as tf

SOURCES = ["printed", "handwritten", "pencil", "wicht", "printed_dataset", "empty"]


def read_cells(path: Path):
    raw = path.read_bytes()
    out, offset = [], 0
    while offset < len(raw):
        w, h = struct.unpack_from("<HH", raw, offset)
        offset += 4
        out.append(np.frombuffer(raw, np.uint8, w * h, offset).reshape(h, w))
        offset += w * h
    return out


def run(model: Path, x: np.ndarray) -> np.ndarray:
    interpreter = tf.lite.Interpreter(model_path=str(model))
    interpreter.resize_tensor_input(0, [len(x), 32, 32, 1])
    interpreter.allocate_tensors()
    interpreter.set_tensor(interpreter.get_input_details()[0]["index"], x)
    interpreter.invoke()
    return interpreter.get_tensor(interpreter.get_output_details()[0]["index"])


def batched(model: Path, x: np.ndarray) -> np.ndarray:
    return np.concatenate([run(model, x[i : i + 2048]) for i in range(0, len(x), 2048)])


def report(name, probs, y, s, high):
    pred = probs.argmax(1)
    conf = probs.max(1)
    result = {"model": name, "overall": float((pred == y).mean())}
    for i, source in enumerate(SOURCES):
        m = s == i
        if m.any():
            result[source] = float((pred[m] == y[m]).mean())
    result["digit_cells"] = float((pred[y > 0] == y[y > 0]).mean())
    result["empty_cells"] = float((pred[y == 0] == 0).mean())
    wrong = pred != y
    result["high_confidence_errors"] = int((wrong & (conf >= high)).sum())
    result["high_confidence_error_rate"] = float((wrong & (conf >= high)).mean())
    result["below_review_threshold"] = float((conf < high).mean())
    cm = np.zeros((10, 10), int)
    np.add.at(cm, (y, pred), 1)
    result["confusion"] = cm.tolist()
    return result


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data", type=Path, default=Path("data/v2"))
    parser.add_argument("--split", default="test")
    parser.add_argument("--v1", type=Path, required=True)
    parser.add_argument("--v2", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    y = np.load(args.data / f"{args.split}.labels.npy")
    s = np.load(args.data / f"{args.split}.sources.npy")
    cells = read_cells(args.data / f"{args.split}.cells")
    x1 = np.stack([
        cv2.resize(c, (32, 32), interpolation=cv2.INTER_LINEAR).astype(np.float32) / 255
        for c in cells
    ])[..., None]
    x2 = np.fromfile(args.data / f"{args.split}.f32", np.float32).reshape(-1, 32, 32, 1)
    p1 = batched(args.v1, x1)
    p2 = batched(args.v2, x2)
    blank = x2.reshape(len(x2), -1).max(1) == 0
    p2[blank] = np.eye(10, dtype=np.float32)[0]
    results = [report("michi-digit-v1", p1, y, s, 0.9), report("michi-digit-v2", p2, y, s, 0.9)]
    args.output.write_text(json.dumps(results, indent=2), encoding="utf-8")
    for r in results:
        print({k: (round(v, 4) if isinstance(v, float) else v) for k, v in r.items() if k != "confusion"})
    print("v2 confusion (rows=truth empty,1..9):")
    for row in results[1]["confusion"]:
        print(" ".join(f"{v:5d}" for v in row))


if __name__ == "__main__":
    main()
