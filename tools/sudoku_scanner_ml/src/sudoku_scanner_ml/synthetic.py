"""Generate purpose-created printed Sudoku cell crops with fixed seeds."""

import argparse
import random
from pathlib import Path

import cv2
import numpy as np
import yaml
from PIL import Image, ImageDraw, ImageFont

from .manifest import write_manifest

ROOT = Path(__file__).resolve().parents[4]
FONTS = {
    "manrope": ROOT / "packages/michi_design_system/assets/fonts/Manrope-wght.ttf",
    "lora": ROOT / "packages/michi_design_system/assets/fonts/Lora-wght.ttf",
    "roboto": ROOT / "tools/sudoku_scanner_ml/fonts/Roboto-wdth-wght.ttf",
}


def render_cell(label: int, font_path: Path, rng: random.Random) -> np.ndarray:
    """Return a 72×72 BGR cell resembling Phase 13's inset crop."""
    tone = rng.randint(207, 255)
    image = np.full((72, 72, 3), tone, dtype=np.uint8)
    horizontal = rng.uniform(-15, 12)
    vertical = rng.uniform(-12, 10)
    gradient = np.linspace(horizontal, -horizontal, 72)[None, :, None]
    image = np.clip(image.astype(np.float32) + gradient + vertical, 0, 255).astype(
        np.uint8
    )
    if label:
        canvas = Image.fromarray(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
        font = ImageFont.truetype(str(font_path), rng.randint(37, 56))
        draw = ImageDraw.Draw(canvas)
        ink = rng.randint(14, 90)
        draw.text(
            (36 + rng.randint(-6, 6), 35 + rng.randint(-6, 6)),
            str(label),
            fill=(ink, ink, ink),
            font=font,
            anchor="mm",
            stroke_width=0,
        )
        image = cv2.cvtColor(np.array(canvas), cv2.COLOR_RGB2BGR)
    # Border fragments are possible even after the Phase 13 inset.
    if rng.random() < 0.18:
        edge = rng.choice([0, 1, 70, 71])
        if rng.random() < 0.5:
            cv2.line(image, (edge, 0), (edge, 71), (rng.randint(100, 190),) * 3)
        else:
            cv2.line(image, (0, edge), (71, edge), (rng.randint(100, 190),) * 3)
    angle = rng.uniform(-5, 5)
    shift_x, shift_y = rng.uniform(-2, 2), rng.uniform(-2, 2)
    matrix = cv2.getRotationMatrix2D((35.5, 35.5), angle, 1.0)
    matrix[:, 2] += [shift_x, shift_y]
    image = cv2.warpAffine(
        image, matrix, (72, 72), flags=cv2.INTER_LINEAR, borderValue=(tone,) * 3
    )
    if rng.random() < 0.32:
        image = cv2.GaussianBlur(image, (3, 3), rng.uniform(0.25, 0.9))
    noise = np.random.default_rng(rng.getrandbits(32)).normal(
        0, rng.uniform(0, 6), image.shape
    )
    return np.clip(image.astype(np.float32) + noise, 0, 255).astype(np.uint8)


def generate(
    config_path: Path, output_dir: Path, samples_per_class: int | None
) -> Path:
    config = yaml.safe_load(config_path.read_text(encoding="utf-8"))
    amount = samples_per_class or config["synthetic_samples_per_class_per_font"]
    rng = random.Random(config["seed"])
    output_dir.mkdir(parents=True, exist_ok=True)
    rows = []
    for split, font_names in config["font_split"].items():
        for font_name in font_names:
            font_path = FONTS[font_name]
            if not font_path.is_file():
                raise FileNotFoundError(f"Font {font_name} is missing: {font_path}")
            for label in range(10):
                for number in range(amount):
                    image = render_cell(label, font_path, rng)
                    sample_id = f"{font_name}-{label}-{number:05d}"
                    extension = ".jpg" if number % 5 == 0 else ".png"
                    relative = Path("cells") / f"{sample_id}{extension}"
                    path = output_dir / relative
                    path.parent.mkdir(exist_ok=True)
                    cv2.imwrite(str(path), image, [cv2.IMWRITE_JPEG_QUALITY, 72])
                    rows.append(
                        {
                            "sample_id": sample_id,
                            "sample_path": str(relative),
                            "label": str(label),
                            "source_image_id": f"{font_name}-style-{number // 50}",
                            "source_type": "synthetic",
                            "font_id": font_name,
                            "split": split,
                            "notes": "purpose-created printed cell",
                        }
                    )
    manifest = output_dir / "manifest.csv"
    write_manifest(manifest, rows)
    return manifest


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--samples-per-class", type=int)
    args = parser.parse_args()
    print(generate(args.config, args.output, args.samples_per_class))


if __name__ == "__main__":
    main()
