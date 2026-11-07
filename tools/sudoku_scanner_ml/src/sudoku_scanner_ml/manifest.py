"""Dataset manifest validation and group-aware split assignment."""

import csv
import json
from collections import Counter, defaultdict
from pathlib import Path

import cv2

FIELDS = (
    "sample_id",
    "sample_path",
    "label",
    "source_image_id",
    "source_type",
    "font_id",
    "split",
    "notes",
    "old_prediction",
    "old_confidence",
)
SPLITS = {"train", "validation", "test"}
SOURCES = {
    "synthetic",
    "printed_scan",
    "digital_screenshot",
    "hard_example",
    "supplemental_printed",
}


def read_manifest(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as stream:
        reader = csv.DictReader(stream)
        if not set(FIELDS).issubset(reader.fieldnames or []):
            raise ValueError(f"Manifest columns must include {FIELDS}")
        return list(reader)


def write_manifest(path: Path, rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=FIELDS, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)


def validate_manifest(path: Path) -> dict:
    rows = read_manifest(path)
    seen: set[str] = set()
    groups: dict[str, set[str]] = defaultdict(set)
    counts: Counter[str] = Counter()
    for row in rows:
        sample_id = row["sample_id"]
        if not sample_id or sample_id in seen:
            raise ValueError(f"Duplicate or empty sample ID: {sample_id}")
        seen.add(sample_id)
        if row["label"] not in {str(i) for i in range(10)}:
            raise ValueError(f"Invalid label for {sample_id}")
        if row["split"] not in SPLITS or row["source_type"] not in SOURCES:
            raise ValueError(f"Invalid split/source for {sample_id}")
        if not row["source_image_id"]:
            raise ValueError(f"Missing source group for {sample_id}")
        groups[row["source_image_id"]].add(row["split"])
        image_path = (path.parent / row["sample_path"]).resolve()
        if not image_path.is_file():
            raise ValueError(f"Missing sample file: {image_path}")
        image = cv2.imread(str(image_path), cv2.IMREAD_COLOR)
        if image is None or min(image.shape[:2]) < 12:
            raise ValueError(f"Corrupt or undersized image: {image_path}")
        counts[f"{row['split']}:{row['label']}"] += 1
    for group, splits in groups.items():
        if len(splits) != 1:
            raise ValueError(f"Source-group split leakage: {group} -> {splits}")
    return {"samples": len(rows), "groups": len(groups), "counts": dict(counts)}


def main() -> None:
    import argparse

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    args = parser.parse_args()
    print(json.dumps(validate_manifest(args.manifest), indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
