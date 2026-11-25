"""Board-level comparison on the official Wicht test photos (real, printed).

Each test photo is one board of 81 cells. Reports complete-board accuracy,
corrections per board (cells the player must fix in Review), cells a
confident model gets wrong, and per-photo distributions for v1 and v2.
"""

import argparse
import csv
import json
import sys
from pathlib import Path

import cv2
import numpy as np

from sudoku_scanner_ml.evaluate_v2 import batched, read_cells


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data", type=Path, default=Path("data/v2"))
    parser.add_argument("--manifest", type=Path, default=Path("data/wicht/manifest.csv"))
    parser.add_argument("--v1", type=Path, required=True)
    parser.add_argument("--v2", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    rows = [r for r in csv.DictReader(args.manifest.open(encoding="utf-8")) if r["split"] == "test"]
    y = np.load(args.data / "test.labels.npy")
    s = np.load(args.data / "test.sources.npy")
    index = np.where(s == 3)[0]
    if len(index) != len(rows):
        sys.exit(f"manifest rows {len(rows)} != wicht test cells {len(index)}")
    images = np.array([r["source_image_id"] for r in rows])
    cells = read_cells(args.data / "test.cells")
    x1 = np.stack([cv2.resize(cells[i], (32, 32)).astype(np.float32) / 255 for i in index])[..., None]
    x2 = np.fromfile(args.data / "test.f32", np.float32).reshape(-1, 32, 32, 1)[index]
    p1 = batched(args.v1, x1)
    p2 = batched(args.v2, x2)
    p2[x2.reshape(len(x2), -1).max(1) == 0] = np.eye(10, dtype=np.float32)[0]
    truth = y[index]
    out = {}
    for name, p in (("michi-digit-v1", p1), ("michi-digit-v2", p2)):
        pred, conf = p.argmax(1), p.max(1)
        boards = []
        for image in sorted(set(images)):
            m = images == image
            wrong = pred[m] != truth[m]
            boards.append({
                "image": image,
                "corrections": int(wrong.sum()),
                "confident_wrong": int((wrong & (conf[m] >= 0.9)).sum()),
                "flagged": int((conf[m] < 0.9).sum()),
            })
        c = np.array([b["corrections"] for b in boards])
        out[name] = {
            "boards": len(boards),
            "cell_accuracy": float((pred == truth).mean()),
            "complete_boards": int((c == 0).sum()),
            "boards_at_most_3_corrections": int((c <= 3).sum()),
            "mean_corrections": float(c.mean()),
            "median_corrections": float(np.median(c)),
            "mean_confident_wrong": float(np.mean([b["confident_wrong"] for b in boards])),
            "per_board": boards,
        }
    args.output.write_text(json.dumps(out, indent=2), encoding="utf-8")
    for name, r in out.items():
        print(name, {k: v for k, v in r.items() if k != "per_board"})


if __name__ == "__main__":
    main()
