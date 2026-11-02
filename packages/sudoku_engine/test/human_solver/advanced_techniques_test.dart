import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:test/test.dart';

HumanSolverState stateWith(Map<CellRef, CandidateMask> overrides) {
  final board = SudokuBoard.fromValues(List<int>.filled(81, 0));
  return HumanSolverState.fromCandidates(
    board: board,
    candidates: {
      for (var index = 0; index < 81; index++)
        CellRef.fromIndex(index):
            overrides[CellRef.fromIndex(index)] ?? CandidateMask.all,
    },
  );
}

CellRef cell(int row, int column) => CellRef(row: row, column: column);

void main() {
  group('Hidden Pair', () {
    test('same two positions for two digits eliminate extras', () {
      final state = stateWith({
        for (var column = 2; column < 9; column++)
          cell(0, column): CandidateMask.all.remove(2).remove(7),
        cell(0, 0): CandidateMask.fromDigits(const [2, 5, 7]),
        cell(0, 1): CandidateMask.fromDigits(const [2, 7, 9]),
      });
      final deduction = const HiddenPairTechnique().find(state).first;
      expect(deduction.focusCells, [cell(0, 0), cell(0, 1)]);
      expect(deduction.eliminations, [
        CandidateElimination(cell(0, 0), 5),
        CandidateElimination(cell(0, 1), 9),
      ]);
      expect(deduction.placements, isEmpty);
      expect(
        const StructuredCoachEngine()
            .createPlan(deduction)
            .last
            .revealedEliminations,
        deduction.eliminations,
      );
    });

    test('mismatched positions and no-op pairs are rejected', () {
      final state = stateWith({
        for (var column = 2; column < 9; column++)
          cell(0, column): CandidateMask.all.remove(2).remove(7),
        cell(0, 0): CandidateMask.fromDigits(const [2, 7]),
        cell(0, 1): CandidateMask.fromDigits(const [2, 7]),
      });
      expect(const HiddenPairTechnique().find(state), isEmpty);
    });
  });

  test('Box-Line removes a digit from the box outside its source row', () {
    final state = stateWith({
      for (var column = 2; column < 9; column++)
        cell(0, column): CandidateMask.all.remove(4),
    });
    final deduction = const BoxLineReductionTechnique().find(state).first;
    expect(deduction.focusCells, [cell(0, 0), cell(0, 1)]);
    expect(deduction.eliminations.length, 6);
    expect(
      deduction.eliminations,
      contains(CandidateElimination(cell(2, 2), 4)),
    );
    expect(const StructuredCoachEngine().createPlan(deduction).length, 4);
  });

  test('Box-Line also works from a column and rejects absent eliminations', () {
    final state = stateWith({
      for (var row = 2; row < 9; row++)
        cell(row, 0): CandidateMask.all.remove(4),
    });
    final deduction = const BoxLineReductionTechnique().find(state).first;
    expect(deduction.focusCells, [cell(0, 0), cell(1, 0)]);
    expect(
      deduction.eliminations,
      contains(CandidateElimination(cell(2, 1), 4)),
    );

    final noOp = stateWith({
      for (var row = 2; row < 9; row++)
        cell(row, 0): CandidateMask.all.remove(4),
      for (var row = 0; row < 3; row++)
        for (var column = 1; column < 3; column++)
          cell(row, column): CandidateMask.all.remove(4),
    });
    expect(const BoxLineReductionTechnique().find(noOp), isEmpty);
  });

  test('Naked Triple accepts different two-digit masks', () {
    final state = stateWith({
      cell(0, 0): CandidateMask.fromDigits(const [1, 2]),
      cell(0, 1): CandidateMask.fromDigits(const [1, 3]),
      cell(0, 2): CandidateMask.fromDigits(const [2, 3]),
    });
    final deduction = const NakedTripleTechnique().find(state).first;
    expect(deduction.focusCells, [cell(0, 0), cell(0, 1), cell(0, 2)]);
    expect(
      deduction.eliminations,
      contains(CandidateElimination(cell(0, 3), 1)),
    );
    expect(const StructuredCoachEngine().createPlan(deduction).length, 4);
  });

  test('Naked Triple rejects a four-digit union and no-op triples', () {
    final invalid = stateWith({
      cell(0, 0): CandidateMask.fromDigits(const [1, 2]),
      cell(0, 1): CandidateMask.fromDigits(const [1, 3]),
      cell(0, 2): CandidateMask.fromDigits(const [2, 4]),
    });
    expect(const NakedTripleTechnique().find(invalid), isEmpty);

    final noOp = stateWith({
      cell(0, 0): CandidateMask.fromDigits(const [1, 2]),
      cell(0, 1): CandidateMask.fromDigits(const [1, 3]),
      cell(0, 2): CandidateMask.fromDigits(const [2, 3]),
      for (var column = 3; column < 9; column++)
        cell(0, column): CandidateMask.all.remove(1).remove(2).remove(3),
      for (var row = 1; row < 3; row++)
        for (var column = 0; column < 3; column++)
          cell(row, column): CandidateMask.all.remove(1).remove(2).remove(3),
    });
    expect(const NakedTripleTechnique().find(noOp), isEmpty);
  });

  group('X-Wing', () {
    test('row orientation removes matching column candidates', () {
      final state = stateWith({
        for (final row in [1, 5])
          for (var column = 0; column < 9; column++)
            if (column != 2 && column != 7)
              cell(row, column): CandidateMask.all.remove(6),
      });
      final deduction = const XWingTechnique().find(state).first;
      expect(deduction.focusCells, [
        cell(1, 2),
        cell(1, 7),
        cell(5, 2),
        cell(5, 7),
      ]);
      expect(
        deduction.eliminations,
        contains(CandidateElimination(cell(0, 2), 6)),
      );
      expect(deduction.eliminations.length, 14);
      expect(const StructuredCoachEngine().createPlan(deduction).length, 4);
    });

    test('column orientation removes matching row candidates', () {
      final state = stateWith({
        for (final column in [1, 6])
          for (var row = 0; row < 9; row++)
            if (row != 2 && row != 7)
              cell(row, column): CandidateMask.all.remove(8),
      });
      final deductions = const XWingTechnique().find(state);
      expect(deductions, isNotEmpty);
      expect(
        deductions.last.eliminations,
        contains(CandidateElimination(cell(2, 0), 8)),
      );
    });

    test('a source line with three candidates cannot form an X-Wing', () {
      final state = stateWith({
        for (final row in [1, 5])
          for (var column = 0; column < 9; column++)
            if (column != 2 && column != 7 && !(row == 1 && column == 8))
              cell(row, column): CandidateMask.all.remove(6),
      });
      expect(const XWingTechnique().find(state), isEmpty);
    });
  });
}
