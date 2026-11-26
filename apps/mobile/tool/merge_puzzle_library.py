"""Append a generated library to the bundled catalog.

Usage: python3 tool/merge_puzzle_library.py PARTS_GLOB OUT_VERSION

Keeps every existing puzzle (same IDs, so saved games and history still
match), drops generated boards that duplicate an existing one, numbers new
puzzles after the last ID of each difficulty and bumps the catalog version.
"""

import glob
import json
import sys

CATALOG = "assets/puzzles/classic_v1.json"


def main() -> None:
    pattern, version = sys.argv[1], int(sys.argv[2])
    catalog = json.load(open(CATALOG, encoding="utf-8"))
    puzzles = catalog["puzzles"]
    seen = {p["board"] for p in puzzles}
    serial = {}
    for p in puzzles:
        difficulty, number = p["id"].rsplit("_", 2)[1:]
        serial[difficulty] = max(serial.get(difficulty, 0), int(number))
    added = {}
    for path in sorted(glob.glob(pattern)):
        for line in open(path, encoding="utf-8"):
            entry = json.loads(line)
            if entry["board"] in seen:
                continue
            seen.add(entry["board"])
            d = entry["difficulty"]
            serial[d] = serial.get(d, 0) + 1
            puzzles.append({"id": f"classic_{d}_{serial[d]:04d}", **entry})
            added[d] = added.get(d, 0) + 1
    catalog["version"] = version
    order = ["easy", "medium", "advanced", "expert"]
    puzzles.sort(key=lambda p: (order.index(p["difficulty"]), p["id"]))
    lines = ",\n".join("  " + json.dumps(p, separators=(",", ":")) for p in puzzles)
    with open(CATALOG, "w", encoding="utf-8") as handle:
        handle.write('{\n  "version": %d,\n  "puzzles": [\n%s\n  ]\n}\n' % (version, lines))
    print("added", added, "total", len(puzzles))


if __name__ == "__main__":
    main()
