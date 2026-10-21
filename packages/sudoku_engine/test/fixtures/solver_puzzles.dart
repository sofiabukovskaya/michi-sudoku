import 'boards.dart';

final class SolverPuzzleFixture {
  const SolverPuzzleFixture(this.name, this.puzzle);

  final String name;
  final String puzzle;
}

/// Source for the easy, hard, and hardest fixtures:
/// https://norvig.com/sudoku.html
/// https://norvig.com/easy50.txt
/// https://norvig.com/top95.txt
/// https://norvig.com/hardest.txt
///
/// The source's difficulty labels describe its corpus, not MICHI's future
/// human-technique difficulty classification.
const solverRegressionPuzzles = <SolverPuzzleFixture>[
  SolverPuzzleFixture('MICHI standard', standardPuzzle),
  SolverPuzzleFixture('easy50 #0', '''
003020600
900305001
001806400
008102900
700000008
006708200
002609500
800203009
005010300
'''),
  SolverPuzzleFixture('easy50 #1', '''
200080300
060070084
030500209
000105408
000000000
402706000
301007040
720040060
004010003
'''),
  SolverPuzzleFixture('easy50 #2', '''
000000907
000420180
000705026
100904000
050000040
000507009
920108000
034059000
507000000
'''),
  SolverPuzzleFixture('easy50 #3', '''
030050040
008010500
460000012
070502080
000603000
040109030
250000098
001020600
080060020
'''),
  SolverPuzzleFixture(
    'top95 #0',
    '''
4.....8.5
.3.......
...7.....
.2.....6.
....8.4..
....1....
...6.3.7.
5..2.....
1.4......
''',
  ),
  SolverPuzzleFixture(
    'top95 #1',
    '''
52...6...
......7.1
3........
...4..8..
6......5.
.........
.418.....
....3..2.
..87.....
''',
  ),
  SolverPuzzleFixture(
    'top95 #14',
    '''
1.....3.8
.7.4.....
.........
2.3.1....
.......95
8........
.5.6...7.
....8.2..
.4.......
''',
  ),
  SolverPuzzleFixture(
    'top95 #24',
    '''
1.....7.9
.4...72..
8........
.7..1..6.
3.......5
.6..4..2.
........8
..53...7.
7.2....46
''',
  ),
  SolverPuzzleFixture(
    'hardest #0',
    '''
85...24..
72......9
..4......
...1.7..2
3.5...9..
.4.......
....8..7.
.17......
....36.4.
''',
  ),
  SolverPuzzleFixture(
    'hardest #5',
    '''
1....7.9.
.3..2...8
..96..5..
..53..9..
.1..8...2
6....4...
3......1.
.4......7
..7...3..
''',
  ),
];
