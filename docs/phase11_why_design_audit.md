# Phase 11 Why visual audit

Approved reference: `MICHI — Sudoku Coach.pdf`, page 62 (Screen 17, Hidden Single), page 64 (C2, Naked Single), page 65 (C3, original clue). These pages were reopened at 1200-pixel resolution and compared with running iOS simulators.

| State | Simulator | Result |
| --- | --- | --- |
| Naked Single | iPhone 16 Pro Max, 440×956 | Title, board width, rounded ivory explanation sheet, technique label, four numbered facts, cream Lesson and indigo Got it actions, and lower action placement match the PDF composition. Target uses the approved matcha outline. The pictured puzzle differs because the app uses the player's actual board and engine deduction. |
| Hidden Single | iPhone SE, 375×667 | Three numbered facts and both actions are reachable. The short viewport scrolls the fact list within the sheet while keeping actions in place. Unit focus uses a coral outline and excluded empty positions use coral slashes derived from the deduction evidence. The reference's specific box/column example is not hard-coded; the checked engine deduction was row-based. |
| Given digit | iPhone 16, regular | Board, centered title, low rounded sheet with grab handle, given-clue message and one indigo Got it action follow C3. The rendered board comes from the current game rather than the reference's illustrative puzzle. |

Widget checks cover Compact, Regular and Large for the Naked Single screen and all six locales on Compact. Hidden Single, given state, Lesson navigation, Got it navigation and accessibility labels are covered by widget tests. Board marker graphics are excluded from semantics so the numbered facts are announced once.

The production app was also walked through on a regular iPhone 16 simulator: entered a direct Naked Single at row 3, column 2; opened its four-step Why proof; visited the matching lesson; returned via Got it with the board intact; opened a given clue; restarted the app, resumed the saved game and confirmed the same Naked Single proof regenerated; then entered a direct Hidden Single at row 1, column 5 and saw its three-step proof.

The layouts follow the approved visual hierarchy. Pixel identity with the PDF's static board values is neither possible nor appropriate: Why always renders the player's real board and actual supported deduction. On Compact, the list scrolls to keep the board readable and actions reachable.
