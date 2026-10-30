import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

import 'coach_hint_ui_model.dart';

/// Maps engine semantics to localized, short MICHI instructions.
abstract final class CoachPresenter {
  static CoachHintUiModel present(
    Translations translations,
    ActiveCoachSession session,
  ) => presentPlan(translations, session.plan, session.hintIndex);

  static CoachHintUiModel presentPlan(
    Translations translations,
    CoachPlan plan,
    int hintIndex,
  ) {
    final hint = plan.hints[hintIndex];
    final unit = hint.focusUnits.firstOrNull;
    final unitLabel = unit == null ? '' : _unitLabel(translations, unit);
    final placement = hint.revealedPlacements.singleOrNull;
    final instruction = switch (hint.intent) {
      CoachHintIntent.inspectCell => translations.coach.inspectCell,
      CoachHintIntent.inspectUnit => translations.coach.inspectUnit(
        unit: unitLabel,
      ),
      CoachHintIntent.inspectCandidates => translations.coach.inspectCandidates,
      CoachHintIntent.inspectCandidatePositions =>
        translations.coach.inspectPositions(unit: unitLabel),
      CoachHintIntent.identifyMatchingCandidatePair =>
        translations.coach.inspectPair,
      CoachHintIntent.singleCandidateRemains =>
        translations.coach.singleRemains,
      CoachHintIntent.onlyPositionRemains => translations.coach.onlyPosition(
        unit: unitLabel,
      ),
      CoachHintIntent.understandPairRestriction =>
        translations.coach.pairRestriction(unit: unitLabel),
      CoachHintIntent.understandAlignment => translations.coach.alignment,
      CoachHintIntent.revealPlacement => translations.coach.resultPlacement(
        digit: placement!.digit,
      ),
      CoachHintIntent.revealEliminations =>
        translations.coach.resultEliminations,
      CoachHintIntent.revealActions => translations.coach.resultActions,
    };
    final isResult = hint.level == CoachHintLevel.result;
    return CoachHintUiModel(
      stepLabel: translations.coach.step(step: hintIndex + 1),
      stepIndex: hintIndex,
      instruction: instruction,
      primaryActionLabel: isResult
          ? placement == null
                ? translations.coach.close
                : translations.coach.place(digit: placement.digit)
          : hintIndex == 0
          ? translations.coach.show
          : translations.coach.more,
      secondaryActionLabel: isResult
          ? null
          : hintIndex == 0
          ? translations.coach.kTry
          : translations.coach.see,
      techniqueLabel: isResult
          ? translations.coach.technique(
              name: _techniqueName(translations, plan.technique),
            )
          : null,
      placementDigit: placement?.digit,
    );
  }

  static String _unitLabel(Translations translations, SudokuUnit unit) =>
      switch (unit.type) {
        SudokuUnitType.row => translations.coach.unitRow(index: unit.index + 1),
        SudokuUnitType.column => translations.coach.unitColumn(
          index: unit.index + 1,
        ),
        SudokuUnitType.box => translations.coach.unitBox(index: unit.index + 1),
      };

  static String _techniqueName(
    Translations translations,
    SudokuTechnique technique,
  ) => switch (technique) {
    SudokuTechnique.nakedSingle => translations.coach.nakedSingle,
    SudokuTechnique.hiddenSingle => translations.coach.hiddenSingle,
    SudokuTechnique.nakedPair => translations.coach.nakedPair,
    SudokuTechnique.pointingPair => translations.coach.pointingPair,
    _ => technique.name,
  };
}
