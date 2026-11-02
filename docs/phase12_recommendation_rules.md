# Phase 12 recommendation rules

MICHI uses local TechniqueProgress and the **last ten completed normal games**.
Daily Sudoku is excluded from this window. Each game contributes at most one
help observation per technique, using the highest Coach level already stored
for that technique. Direction and Focus are light help (levels 1–2); Reasoning
and Result are deep help (levels 3–4). Puzzle exposure comes from the bundled
catalog's required-technique metadata; retired IDs still retain Coach evidence.

The engine uses `SudokuTechniqueOrder.supported`. Unsupported future techniques
are never recommended. Within a rule, more helped games (or a larger practice
gap) wins, then the authoritative order breaks ties. The rules are:

1. For a just-finished game, deep technique-specific help recommends immediate
   Practice, or Review if already mastered. Light help alone does not.
2. An unmastered technique helped in **two or more recent normal games** gets
   Practice.
3. An unmastered technique with **at least three practice checks** and
   first-try independent successes **below half** of checks gets Practice.
4. A started, unmastered technique gets continued Practice.
5. An untouched technique gets Learn when all earlier supported techniques
   are mastered. With no history, this starts at Naked Single.
6. A mastered technique with deep help in **two or more recent normal games**
   gets Review. Mastery is never downgraded by game behaviour.
7. Otherwise the first unmastered technique gets Learn. When all are mastered,
   Review goes to the least recently practiced technique, with order as a tie.

One `daily_learning_focuses` row per local date stores only technique, action,
reason, static content duration and a small evidence summary (six minutes for
a lesson, five for practice/review). The first writer wins. Today's focus does not change when
practice progresses; tomorrow's is derived from fresh aggregates. Post-game
advice uses the same engine with the just-finished game and never overwrites
today's focus. There is no network, random selection, skill score, or puzzle
analysis during recommendation.

The Progress route is still a Phase 1 placeholder, so Phase 12 does not add a
new Progress layout. Home uses the approved Focus row, Learn its existing
current-item emphasis, and Screen 25 its one next-step row. The prior
post-game technique analytics block was removed from that screen.
