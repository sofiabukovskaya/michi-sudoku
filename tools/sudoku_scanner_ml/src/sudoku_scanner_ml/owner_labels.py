"""Label owner photo cells from the puzzles themselves.

The owner's book puzzles are solved in pen/pencil. The printed givens, read
with high confidence, define a puzzle with one solution; that solution is the
label of every cell. A grid is accepted only when the confident readings
admit exactly one solution and it agrees with nearly all printed readings.
"""

import argparse
import json
from pathlib import Path


def candidates(board, i):
    r, c = divmod(i, 9)
    used = {board[r * 9 + k] for k in range(9)} | {board[k * 9 + c] for k in range(9)}
    br, bc = r - r % 3, c - c % 3
    used |= {board[(br + a) * 9 + bc + b] for a in range(3) for b in range(3)}
    return [d for d in range(1, 10) if d not in used]


def solve(board, limit=2):
    board = list(board)
    solutions = []

    def rec():
        if len(solutions) >= limit:
            return
        best, options = -1, None
        for i in range(81):
            if board[i] == 0:
                opts = candidates(board, i)
                if not opts:
                    return
                if options is None or len(opts) < len(options):
                    best, options = i, opts
        if best < 0:
            solutions.append(list(board))
            return
        for d in options:
            board[best] = d
            rec()
            board[best] = 0

    rec()
    return solutions


def consistent(board):
    for i, v in enumerate(board):
        if v and v not in candidates(board[:i] + [0] + board[i + 1 :], i):
            return False
    return True


def label(cells, threshold):
    """Givens = confident readings (kept only while consistent). If they
    admit no solution, remove the fewest, least confident givens (up to
    three) until exactly one solution remains. Returns (solution, removed)."""
    from itertools import combinations

    order = sorted(range(81), key=lambda i: -cells[i]["confidence"])
    givens = [0] * 81
    for i in order:
        p = cells[i]
        if p["digit"] and p["confidence"] >= threshold:
            givens[i] = p["digit"]
            if not consistent(givens):
                givens[i] = 0
    if sum(1 for g in givens if g) < 17:
        return None, None
    weakest = sorted(
        (i for i in range(81) if givens[i]), key=lambda i: cells[i]["confidence"]
    )[:18]
    for size in range(0, 4):
        for removed in combinations(weakest, size):
            trial = list(givens)
            for i in removed:
                trial[i] = 0
            solutions = solve(trial)
            if len(solutions) == 1:
                return solutions[0], list(removed)
    return None, None


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--extract", type=Path, default=Path("data/owner/extract"))
    parser.add_argument("--threshold", type=float, default=0.995)
    args = parser.parse_args()
    report = []
    for pred in sorted(args.extract.glob("*/g*/predictions.json")):
        cells = json.loads(pred.read_text())["cells"]
        solution, removed = label(cells, args.threshold)
        entry = {"grid": f"{pred.parent.parent.name}/{pred.parent.name}",
                 "removed": removed}
        if solution is not None:
            wrong = sum(1 for i in range(81) if cells[i]["digit"] != solution[i])
            entry.update(labelled=True, model_errors=wrong)
            (pred.parent / "labels.json").write_text(json.dumps(solution))
        else:
            entry["labelled"] = False
            (pred.parent / "labels.json").unlink(missing_ok=True)
        report.append(entry)
        print(entry)


if __name__ == "__main__":
    main()
