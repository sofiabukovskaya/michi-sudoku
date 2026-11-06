"""Create reproducible board-style images for scanner manual checks."""

import argparse
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFont

from .synthetic import FONTS

BOARD = (
    "530070000600195000098000060800060003400803001700020006060000280000419005000080079"
)


def generate(output: Path) -> None:
    output.mkdir(parents=True, exist_ok=True)
    styles = {
        "clean_printed": ("roboto", (248, 245, 237), (32, 33, 34), 700),
        "alternate_typography": ("lora", (251, 249, 244), (39, 39, 40), 700),
        "digital_screenshot": ("manrope", (255, 255, 255), (49, 70, 87), 700),
        "uneven_light": ("roboto", (247, 241, 229), (30, 31, 32), 700),
        "low_resolution": ("roboto", (247, 247, 245), (35, 35, 35), 420),
    }
    for name, (font_name, paper, ink, extent) in styles.items():
        margin = extent // 10
        side = extent - 2 * margin
        image = Image.new("RGB", (extent, extent), paper)
        draw = ImageDraw.Draw(image)
        for line in range(10):
            position = margin + line * side / 9
            weight = 4 if line % 3 == 0 else 2
            draw.line(
                (position, margin, position, extent - margin), fill=ink, width=weight
            )
            draw.line(
                (margin, position, extent - margin, position), fill=ink, width=weight
            )
        font = ImageFont.truetype(str(FONTS[font_name]), round(side / 9 * 0.65))
        for index, label in enumerate(BOARD):
            if label == "0":
                continue
            row, column = divmod(index, 9)
            x = margin + (column + 0.5) * side / 9
            y = margin + (row + 0.5) * side / 9
            draw.text((x, y), label, fill=ink, font=font, anchor="mm")
        if name == "uneven_light":
            pixels = np.array(image).astype(np.float32)
            shade = np.linspace(0, 36, extent)[:, None, None]
            pixels = np.clip(pixels - shade, 0, 255).astype(np.uint8)
            image = Image.fromarray(pixels)
        image.save(output / f"{name}.png")
        (output / f"{name}.txt").write_text(BOARD, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    generate(args.output)


if __name__ == "__main__":
    main()
