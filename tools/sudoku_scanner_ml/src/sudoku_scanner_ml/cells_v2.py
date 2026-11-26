"""Build v2 cell crops (gray, as the segmenter would cut them) for training.

Sources and splits (no leakage across splits):
- Printed synthetic digits: fonts Manrope (train), Lora (validation), Roboto
  (test), variable weights 300–800 (thin, regular, bold).
- Handwritten digits 1–9 from MNIST, rendered as pen or pencil with varying
  pressure, size, offset and slant: MNIST train rows 0–49,999 (train),
  50,000–59,999 (validation), MNIST test (test). MNIST writers of train and
  test are disjoint by construction of the dataset.
- Real printed cells from Wicht & Hennebert photos, split by source photo
  (official test photos are test only).
- printed-digits-dataset: train only (augmented copies of a small original).
- Empty cells: paper texture, shadows, specks, grid-line remnants, faintly
  erased marks and small pencil candidate notes (all labelled empty).

Output per split: `<split>.cells` (little-endian records of uint16 width,
uint16 height, gray bytes; 0 black, 255 white), `<split>.labels.npy` and
`<split>.sources.npy`. `tool/normalize_cells.dart` turns cells into tensors
with the production Dart normalizer.
"""

import argparse
import csv
import json
import random
import struct
from pathlib import Path

import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[4]
FONTS = {
    "manrope": ROOT / "packages/michi_design_system/assets/fonts/Manrope-wght.ttf",
    "lora": ROOT / "packages/michi_design_system/assets/fonts/Lora-wght.ttf",
    "roboto": ROOT / "tools/sudoku_scanner_ml/fonts/Roboto-wdth-wght.ttf",
}
FONT_SPLIT = {"train": "manrope", "validation": "lora", "test": "roboto"}
SOURCES = ["printed", "handwritten", "pencil", "wicht", "printed_dataset", "empty", "owner"]

# Owner photo pages (book puzzles), split by page so twins never cross splits.
OWNER_SPLIT = {
    "p01": "train", "p38": "train", "p39": "train", "p40": "train",
    "p41": "validation",
    "p46": "test", "p47": "test", "p51": "test",
}
# Grids whose detected corners cut a column: crops do not match labels.
OWNER_EXCLUDE = {"p39b/g1"}


def _paper(rng: random.Random, size: int) -> np.ndarray:
    tone = rng.uniform(185, 250)
    paper = np.full((size, size), tone, np.float32)
    # Uneven light / shadow: a linear gradient plus an occasional soft shadow.
    gx, gy = rng.uniform(-30, 30), rng.uniform(-30, 30)
    xs = np.linspace(-0.5, 0.5, size)
    paper += gx * xs[None, :] + gy * xs[:, None]
    if rng.random() < 0.3:
        cx, cy = rng.uniform(-0.3, 1.3) * size, rng.uniform(-0.3, 1.3) * size
        yy, xx = np.mgrid[0:size, 0:size]
        dist = np.sqrt((xx - cx) ** 2 + (yy - cy) ** 2) / size
        paper -= rng.uniform(15, 60) * np.clip(1 - dist, 0, 1)
    texture = np.random.default_rng(rng.getrandbits(32)).normal(
        0, rng.uniform(1, 7), (size, size)
    )
    return paper + texture


def _grid_remnants(cell: np.ndarray, rng: random.Random) -> None:
    size = cell.shape[0]
    for _ in range(rng.choice([0, 0, 1, 1, 2, 3])):
        tone = rng.uniform(20, 150)
        width = rng.choice([1, 1, 2, 3])
        edge = rng.choice(["l", "r", "t", "b"])
        offset = rng.randint(0, 3)
        tilt = rng.uniform(-2.5, 2.5)
        if edge in "lr":
            x0 = offset if edge == "l" else size - 1 - offset
            cv2.line(cell, (int(x0), 0), (int(x0 + tilt), size - 1), tone, width)
        else:
            y0 = offset if edge == "t" else size - 1 - offset
            cv2.line(cell, (0, int(y0)), (size - 1, int(y0 + tilt)), tone, width)


def _finish(cell: np.ndarray, rng: random.Random) -> np.ndarray:
    if rng.random() < 0.35:
        cell = cv2.GaussianBlur(cell, (3, 3), rng.uniform(0.3, 1.0))
    out = np.clip(cell, 0, 255).astype(np.uint8)
    if rng.random() < 0.3:
        ok, enc = cv2.imencode(".jpg", out, [cv2.IMWRITE_JPEG_QUALITY, rng.randint(55, 90)])
        if ok:
            out = cv2.imdecode(enc, cv2.IMREAD_GRAYSCALE)
    return out


def _paste_ink(cell: np.ndarray, alpha: np.ndarray, ink: float) -> None:
    """Darken `cell` toward `ink` by coverage `alpha` (0..1, same shape)."""
    cell[:] = cell * (1 - alpha) + ink * alpha


def printed_cell(label: int, font_path: Path, rng: random.Random) -> np.ndarray:
    size = rng.randint(64, 96)
    cell = _paper(rng, size)
    if label:
        font = ImageFont.truetype(str(font_path), int(size * rng.uniform(0.5, 0.78)))
        try:
            font.set_variation_by_axes([rng.choice([300, 400, 500, 700, 800])])
        except OSError:
            pass
        mask = Image.new("L", (size, size), 0)
        ImageDraw.Draw(mask).text(
            (
                size / 2 + rng.uniform(-0.08, 0.08) * size,
                size / 2 + rng.uniform(-0.08, 0.08) * size,
            ),
            str(label),
            fill=255,
            font=font,
            anchor="mm",
        )
        alpha = np.asarray(mask, np.float32) / 255
        _paste_ink(cell, alpha, rng.uniform(5, 95))
    _grid_remnants(cell, rng)
    return _finish(cell, rng)


def _mnist_alpha(digit: np.ndarray, size: int, rng: random.Random) -> np.ndarray:
    glyph = digit.astype(np.float32) / 255
    # Stroke width varies with pen and pressure.
    k = rng.choice([-1, 0, 0, 1])
    if k > 0:
        glyph = cv2.dilate(glyph, np.ones((2, 2), np.uint8))
    elif k < 0:
        glyph = cv2.erode(glyph, np.ones((2, 2), np.uint8))
    shear = rng.uniform(-0.25, 0.25)
    angle = rng.uniform(-12, 12)
    matrix = cv2.getRotationMatrix2D((14, 14), angle, 1.0)
    matrix[0, 1] += shear
    glyph = cv2.warpAffine(glyph, matrix, (28, 28))
    height = int(size * rng.uniform(0.42, 0.85))
    glyph = cv2.resize(glyph, (height, height), interpolation=cv2.INTER_LINEAR)
    alpha = np.zeros((size, size), np.float32)
    slack = size - height
    # Handwriting is often off-centre in the cell.
    ox = int(np.clip(slack / 2 + rng.uniform(-0.35, 0.35) * slack, 0, slack))
    oy = int(np.clip(slack / 2 + rng.uniform(-0.35, 0.35) * slack, 0, slack))
    alpha[oy : oy + height, ox : ox + height] = glyph
    return np.clip(alpha, 0, 1)


def crossed_seven(glyph: np.ndarray) -> np.ndarray:
    """Continental 7: a short bar across the stem at mid height."""
    ys, xs = np.nonzero(glyph > 80)
    if len(ys) == 0:
        return glyph
    top, bottom = ys.min(), ys.max()
    y = int(top + 0.55 * (bottom - top))
    row = np.nonzero(glyph[y] > 80)[0]
    centre = int(row.mean()) if len(row) else int(xs.mean())
    half = max(3, int(0.25 * (xs.max() - xs.min() + 1)))
    out = glyph.copy()
    cv2.line(out, (centre - half, y), (centre + half, y), 255, 2)
    return out


def handwritten_cell(digit: np.ndarray, rng: random.Random, pencil: bool) -> np.ndarray:
    size = rng.randint(64, 96)
    cell = _paper(rng, size)
    alpha = _mnist_alpha(digit, size, rng)
    if pencil:
        # Graphite: lighter, grainy, pressure varies along the stroke.
        grain = np.random.default_rng(rng.getrandbits(32)).uniform(0.6, 1.0, alpha.shape)
        alpha = alpha * grain * rng.uniform(0.6, 1.0)
        ink = rng.uniform(55, 140)
    else:
        ink = rng.uniform(10, 90)
    _paste_ink(cell, alpha, ink)
    _grid_remnants(cell, rng)
    return _finish(cell, rng)


def empty_cell(rng: random.Random, notes: list[np.ndarray]) -> np.ndarray:
    size = rng.randint(64, 96)
    cell = _paper(rng, size)
    kind = rng.random()
    if kind < 0.25 and notes:
        # Pencil candidate notes: small digits near corners.
        for _ in range(rng.randint(1, 4)):
            small = int(size * rng.uniform(0.14, 0.26))
            glyph = cv2.resize(rng.choice(notes).astype(np.float32) / 255, (small, small))
            x = rng.choice([rng.randint(1, size // 4), rng.randint(size // 2, size - small - 1)])
            y = rng.choice([rng.randint(1, size // 4), rng.randint(size // 2, size - small - 1)])
            region = cell[y : y + small, x : x + small]
            _paste_ink(region, glyph * rng.uniform(0.4, 0.9), rng.uniform(60, 140))
    elif kind < 0.40:
        # Faintly erased entry: a light smudge.
        cv2.ellipse(
            cell,
            (size // 2 + rng.randint(-8, 8), size // 2 + rng.randint(-8, 8)),
            (rng.randint(8, size // 3), rng.randint(8, size // 3)),
            rng.uniform(0, 180), 0, 360,
            float(cell.mean() - rng.uniform(3, 12)), -1,
        )
    elif kind < 0.55:
        for _ in range(rng.randint(1, 6)):
            cv2.circle(
                cell,
                (rng.randint(0, size - 1), rng.randint(0, size - 1)),
                rng.randint(0, 1),
                rng.uniform(40, 150),
                -1,
            )
    _grid_remnants(cell, rng)
    return _finish(cell, rng)


def _write(path: Path, cells: list[np.ndarray]) -> None:
    with path.open("wb") as handle:
        for cell in cells:
            height, width = cell.shape
            handle.write(struct.pack("<HH", width, height))
            handle.write(np.ascontiguousarray(cell, np.uint8).tobytes())


def build(data: Path, output: Path, seed: int, printed_per_class: int) -> None:
    rng = random.Random(seed)
    output.mkdir(parents=True, exist_ok=True)
    with np.load(data / "upstream/mnist.npz") as mnist:
        mnist_sets = {
            "train": (mnist["x_train"][:50000], mnist["y_train"][:50000]),
            "validation": (mnist["x_train"][50000:], mnist["y_train"][50000:]),
            "test": (mnist["x_test"], mnist["y_test"]),
        }
    splits: dict[str, tuple[list, list, list]] = {s: ([], [], []) for s in FONT_SPLIT}

    def add(split: str, cell: np.ndarray, label: int, source: str) -> None:
        splits[split][0].append(cell)
        splits[split][1].append(label)
        splits[split][2].append(SOURCES.index(source))

    for split, font in FONT_SPLIT.items():
        amount = printed_per_class if split == "train" else printed_per_class // 4
        for label in range(1, 10):
            for _ in range(amount):
                add(split, printed_cell(label, FONTS[font], rng), label, "printed")
        images, labels = mnist_sets[split]
        notes = [images[i] for i in range(0, len(images), 7) if labels[i] != 0]
        for image, label in zip(images, labels):
            if label == 0:
                continue
            pencil = rng.random() < 0.5
            if label == 7 and rng.random() < 0.5:
                image = crossed_seven(image)
            add(split, handwritten_cell(image, rng, pencil), int(label),
                "pencil" if pencil else "handwritten")
        empties = len(images) // 4 if split == "train" else len(images) // 3
        for _ in range(empties):
            add(split, empty_cell(rng, notes), 0, "empty")

    wicht = data / "wicht/manifest.csv"
    if wicht.is_file():
        with wicht.open(encoding="utf-8") as handle:
            for row in csv.DictReader(handle):
                gray = cv2.imread(str(wicht.parent / row["sample_path"]), cv2.IMREAD_GRAYSCALE)
                if gray is None:
                    continue
                add(row["split"], gray, int(row["label"]), "wicht")
    printed = data / "upstream/printed-digits-dataset"
    for path in sorted((printed / "assets").rglob("*")):
        label_text = path.parent.name
        if path.suffix.lower() not in {".png", ".jpg", ".jpeg"}:
            continue
        if label_text not in {str(d) for d in range(1, 10)}:
            continue
        gray = cv2.imread(str(path), cv2.IMREAD_GRAYSCALE)
        if gray is None:
            continue
        if gray.mean() < 128:  # stored white-on-black
            gray = 255 - gray
        # Crop around the digit so it fills a cell like a printed given
        # (about 55-70% of the cell height), not a speck on a large page.
        ys, xs = np.nonzero(gray < 160)
        if len(ys) < 8:
            continue
        cy, cx = (ys.min() + ys.max()) / 2, (xs.min() + xs.max()) / 2
        half = (ys.max() - ys.min() + 1) / (2 * rng.uniform(0.55, 0.7))
        y0, y1 = int(round(cy - half)), int(round(cy + half))
        x0, x1 = int(round(cx - half)), int(round(cx + half))
        pad = max(0, -y0, -x0, y1 - gray.shape[0], x1 - gray.shape[1])
        gray = cv2.copyMakeBorder(gray, pad, pad, pad, pad, cv2.BORDER_REPLICATE)
        gray = gray[y0 + pad : y1 + pad, x0 + pad : x1 + pad]
        add("train", gray, int(label_text), "printed_dataset")

    owner = data / "owner/extract"
    for labels_file in sorted(owner.glob("*/g*/labels.json")):
        grid = labels_file.parent
        key = f"{grid.parent.name}/{grid.name}"
        split = OWNER_SPLIT.get(grid.parent.name[:3])
        if split is None or key in OWNER_EXCLUDE:
            continue
        for index, label in enumerate(json.loads(labels_file.read_text())):
            gray = cv2.imread(str(grid / f"{index:02d}.png"), cv2.IMREAD_GRAYSCALE)
            if gray is not None:
                add(split, gray, int(label), "owner")

    for split, (cells, labels, sources) in splits.items():
        _write(output / f"{split}.cells", cells)
        np.save(output / f"{split}.labels.npy", np.asarray(labels, np.int64))
        np.save(output / f"{split}.sources.npy", np.asarray(sources, np.int64))
        counts = np.bincount(np.asarray(labels), minlength=10).tolist()
        print(split, len(labels), "per class", counts)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data", type=Path, default=Path("data"))
    parser.add_argument("--output", type=Path, default=Path("data/v2"))
    parser.add_argument("--seed", type=int, default=20261125)
    parser.add_argument("--printed-per-class", type=int, default=2400)
    args = parser.parse_args()
    build(args.data, args.output, args.seed, args.printed_per_class)


if __name__ == "__main__":
    main()
