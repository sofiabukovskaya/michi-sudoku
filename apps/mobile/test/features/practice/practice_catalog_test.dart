import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'every bundled scenario is valid, actionable and Coach-compatible',
    () async {
      final scenarios = await LocalPracticeCatalog().load();
      expect(scenarios, hasLength(40));
      expect(scenarios.map((item) => item.id).toSet(), hasLength(40));
      const exact = BacktrackingExactSolver();
      const human = DeterministicHumanSolver();
      const coach = StructuredCoachEngine();
      for (final technique in TechniqueLessons.supported) {
        expect(
          scenarios.where((item) => item.technique == technique),
          hasLength(5),
        );
      }
      for (final scenario in scenarios) {
        expect(scenario.contentVersion, 2, reason: scenario.id);
        expect(
          SudokuConstraints.validate(scenario.board).isValid,
          isTrue,
          reason: scenario.id,
        );
        expect(
          exact.countSolutions(scenario.board),
          1,
          reason: scenario.id,
        );
        final solution = exact.solve(scenario.board)!;
        final state = scenario.initialState;
        expect(state.hasContradiction, isFalse, reason: scenario.id);
        for (var index = 0; index < 81; index++) {
          final cell = CellRef.fromIndex(index);
          if (scenario.board.isEmpty(cell)) {
            expect(
              state.candidatesFor(cell).contains(solution.valueAt(cell)),
              isTrue,
              reason: '${scenario.id}: candidate at $cell',
            );
          }
        }
        final deduction = human.findNextDeduction(state);
        expect(deduction, isNotNull, reason: scenario.id);
        expect(deduction!.technique, scenario.technique, reason: scenario.id);
        if (techniqueIsPlacement(scenario.technique)) {
          expect(deduction.placements, isNotEmpty, reason: scenario.id);
          for (final move in deduction.placements) {
            expect(
              solution.valueAt(move.cell),
              move.digit,
              reason: scenario.id,
            );
          }
        } else {
          expect(deduction.eliminations, isNotEmpty, reason: scenario.id);
          expect(deduction.placements, isEmpty, reason: scenario.id);
          for (final move in deduction.eliminations) {
            expect(
              solution.valueAt(move.cell),
              isNot(move.digit),
              reason: scenario.id,
            );
          }
        }
        final plan = coach.createPlan(deduction);
        expect(plan.length, 4, reason: scenario.id);
        expect(
          plan.last.revealedPlacements,
          deduction.placements,
          reason: scenario.id,
        );
        expect(
          plan.last.revealedEliminations,
          deduction.eliminations,
          reason: scenario.id,
        );
      }
    },
  );

  test('malformed and duplicate practice content is rejected', () {
    expect(() => LocalPracticeCatalog.parse('{}'), throwsFormatException);
    expect(
      () => LocalPracticeCatalog.parse(
        '{"version":1,"scenarios":[]}',
      ),
      throwsFormatException,
    );
  });
}

bool techniqueIsPlacement(SudokuTechnique technique) =>
    technique == SudokuTechnique.nakedSingle ||
    technique == SudokuTechnique.hiddenSingle;
