import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/coach/presentation/coach_presenter.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final _target = CellRef(row: 4, column: 4);
const _engine = StructuredCoachEngine();

Map<SudokuTechnique, Deduction> _deductions() {
  final first = CellRef(row: 0, column: 0);
  final second = CellRef(row: 0, column: 1);
  return {
    SudokuTechnique.nakedSingle: Deduction(
      technique: SudokuTechnique.nakedSingle,
      focusCells: [_target],
      evidence: [
        CandidateSetEvidence(_target, CandidateMask.fromDigits(const [9])),
      ],
      eliminations: const [],
      placements: [DigitPlacement(_target, 9)],
    ),
    SudokuTechnique.hiddenSingle: Deduction(
      technique: SudokuTechnique.hiddenSingle,
      focusCells: [_target],
      evidence: [
        UnitCandidateEvidence(
          unit: SudokuUnit.box(4),
          digit: 7,
          candidateCells: [_target],
        ),
      ],
      eliminations: const [],
      placements: [DigitPlacement(_target, 7)],
    ),
    SudokuTechnique.nakedPair: Deduction(
      technique: SudokuTechnique.nakedPair,
      focusCells: [first, second],
      evidence: [
        UnitEvidence(SudokuUnit.row(0)),
        CandidateSetEvidence(first, CandidateMask.fromDigits(const [2, 7])),
        CandidateSetEvidence(second, CandidateMask.fromDigits(const [2, 7])),
      ],
      eliminations: [CandidateElimination(CellRef(row: 0, column: 2), 2)],
      placements: const [],
    ),
    SudokuTechnique.pointingPair: Deduction(
      technique: SudokuTechnique.pointingPair,
      focusCells: [first, second],
      evidence: [
        UnitCandidateEvidence(
          unit: SudokuUnit.box(0),
          digit: 6,
          candidateCells: [first, second],
        ),
        UnitEvidence(SudokuUnit.row(0)),
      ],
      eliminations: [CandidateElimination(CellRef(row: 0, column: 3), 6)],
      placements: const [],
    ),
  };
}

void main() {
  for (final locale in [AppLocale.en, AppLocale.uk]) {
    group('CoachPresenter ${locale.languageCode}', () {
      for (final entry in _deductions().entries) {
        test('${entry.key.name} maps all four semantic levels', () {
          final translations = locale.buildSync();
          final plan = _engine.createPlan(entry.value);
          for (var index = 0; index < 4; index++) {
            final model = CoachPresenter.present(
              translations,
              ActiveCoachSession(plan: plan, hintIndex: index),
            );
            expect(model.stepIndex, index);
            expect(model.stepLabel, isNotEmpty);
            expect(model.instruction, isNotEmpty);
            if (index < 3) {
              expect(model.techniqueLabel, isNull);
              expect(model.placementDigit, isNull);
              expect(model.secondaryActionLabel, isNotNull);
            } else {
              expect(model.techniqueLabel, isNotNull);
              expect(model.secondaryActionLabel, isNull);
              expect(
                model.placementDigit,
                entry.value.placements.singleOrNull?.digit,
              );
            }
          }
        });
      }
    });
  }
}
