import 'package:sudoku_engine/sudoku_engine.dart';

/// Expectations for the Phase 3 puzzle corpus under Phase 4's four techniques.
///
/// `stuck` means the board remains mathematically solvable and consistent,
/// while this initial technique catalogue has no further deduction.
final class HumanPuzzleExpectation {
  const HumanPuzzleExpectation({
    required this.name,
    required this.status,
    required this.requiredTechniques,
  });

  final String name;
  final HumanSolveStatus status;
  final Set<SudokuTechnique> requiredTechniques;
}

const phase4Techniques = <SudokuTechnique>{
  SudokuTechnique.nakedSingle,
  SudokuTechnique.hiddenSingle,
  SudokuTechnique.nakedPair,
  SudokuTechnique.pointingPair,
};

const humanPuzzleExpectations = <HumanPuzzleExpectation>[
  HumanPuzzleExpectation(
    name: 'MICHI standard',
    status: HumanSolveStatus.solved,
    requiredTechniques: {SudokuTechnique.nakedSingle},
  ),
  HumanPuzzleExpectation(
    name: 'easy50 #0',
    status: HumanSolveStatus.solved,
    requiredTechniques: {SudokuTechnique.nakedSingle},
  ),
  HumanPuzzleExpectation(
    name: 'easy50 #1',
    status: HumanSolveStatus.solved,
    requiredTechniques: {
      SudokuTechnique.nakedSingle,
      SudokuTechnique.hiddenSingle,
    },
  ),
  HumanPuzzleExpectation(
    name: 'easy50 #2',
    status: HumanSolveStatus.solved,
    requiredTechniques: {
      SudokuTechnique.nakedSingle,
      SudokuTechnique.hiddenSingle,
    },
  ),
  HumanPuzzleExpectation(
    name: 'easy50 #3',
    status: HumanSolveStatus.solved,
    requiredTechniques: {
      SudokuTechnique.nakedSingle,
      SudokuTechnique.hiddenSingle,
    },
  ),
  HumanPuzzleExpectation(
    name: 'top95 #0',
    status: HumanSolveStatus.solved,
    requiredTechniques: phase4Techniques,
  ),
  HumanPuzzleExpectation(
    name: 'top95 #1',
    status: HumanSolveStatus.solved,
    requiredTechniques: phase4Techniques,
  ),
  HumanPuzzleExpectation(
    name: 'top95 #14',
    status: HumanSolveStatus.stuck,
    requiredTechniques: phase4Techniques,
  ),
  HumanPuzzleExpectation(
    name: 'top95 #24',
    status: HumanSolveStatus.stuck,
    requiredTechniques: phase4Techniques,
  ),
  HumanPuzzleExpectation(
    name: 'hardest #0',
    status: HumanSolveStatus.stuck,
    requiredTechniques: phase4Techniques,
  ),
  HumanPuzzleExpectation(
    name: 'hardest #5',
    status: HumanSolveStatus.stuck,
    requiredTechniques: {SudokuTechnique.hiddenSingle},
  ),
];
