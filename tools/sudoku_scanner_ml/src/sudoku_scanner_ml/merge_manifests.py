"""Merge local source manifests without copying large image datasets."""

import argparse
from pathlib import Path

from .manifest import read_manifest, write_manifest


def merge(inputs: list[Path], output: Path, include_test: bool = False) -> Path:
    rows = []
    for manifest in inputs:
        for row in read_manifest(manifest):
            if row["split"] == "test" and not include_test:
                continue
            row["sample_path"] = str((manifest.parent / row["sample_path"]).resolve())
            rows.append(row)
    write_manifest(output, rows)
    return output


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--inputs", nargs="+", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--include-test", action="store_true")
    args = parser.parse_args()
    print(merge(args.inputs, args.output, args.include_test))


if __name__ == "__main__":
    main()
