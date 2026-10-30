import 'package:flutter/foundation.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/practice/domain/technique_practice_scenario.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

enum PracticeStatus { answering, incorrect, correct, completed }

@immutable
final class PracticeState {
  PracticeState({
    required List<TechniquePracticeScenario> scenarios,
    required this.index,
    required this.engineState,
    required this.deduction,
    required this.coachPlan,
    required this.progress,
    required Set<CandidateElimination> selectedEliminations,
    this.selectedCell,
    this.selectedDigit,
    this.attemptsOnCurrent = 0,
    this.sessionAttempts = 0,
    this.sessionCorrect = 0,
    this.sessionHintAssisted = 0,
    this.hintIndex,
    this.highestHint,
    this.status = PracticeStatus.answering,
    this.saving = false,
    this.persistenceFailed = false,
  }) : scenarios = List<TechniquePracticeScenario>.unmodifiable(scenarios),
       selectedEliminations = Set<CandidateElimination>.unmodifiable(
         selectedEliminations,
       );

  final List<TechniquePracticeScenario> scenarios;
  final int index;
  final HumanSolverState engineState;
  final Deduction deduction;
  final CoachPlan coachPlan;
  final TechniqueProgress progress;
  final Set<CandidateElimination> selectedEliminations;
  final CellRef? selectedCell;
  final int? selectedDigit;
  final int attemptsOnCurrent;
  final int sessionAttempts;
  final int sessionCorrect;
  final int sessionHintAssisted;
  final int? hintIndex;
  final CoachHintLevel? highestHint;
  final PracticeStatus status;
  final bool saving;
  final bool persistenceFailed;

  TechniquePracticeScenario get scenario => scenarios[index];
  bool get isPlacement => deduction.placements.isNotEmpty;
  bool get isLast => index == scenarios.length - 1;
  CoachHint? get visibleHint =>
      hintIndex == null ? null : coachPlan.hints[hintIndex!];

  PracticeState copyWith({
    int? index,
    HumanSolverState? engineState,
    Deduction? deduction,
    CoachPlan? coachPlan,
    TechniqueProgress? progress,
    Set<CandidateElimination>? selectedEliminations,
    CellRef? selectedCell,
    bool keepSelectedCell = true,
    int? selectedDigit,
    bool keepSelectedDigit = true,
    int? attemptsOnCurrent,
    int? sessionAttempts,
    int? sessionCorrect,
    int? sessionHintAssisted,
    int? hintIndex,
    bool keepHintIndex = true,
    CoachHintLevel? highestHint,
    bool keepHighestHint = true,
    PracticeStatus? status,
    bool? saving,
    bool? persistenceFailed,
  }) => PracticeState(
    scenarios: scenarios,
    index: index ?? this.index,
    engineState: engineState ?? this.engineState,
    deduction: deduction ?? this.deduction,
    coachPlan: coachPlan ?? this.coachPlan,
    progress: progress ?? this.progress,
    selectedEliminations: selectedEliminations ?? this.selectedEliminations,
    selectedCell: keepSelectedCell
        ? selectedCell ?? this.selectedCell
        : selectedCell,
    selectedDigit: keepSelectedDigit
        ? selectedDigit ?? this.selectedDigit
        : selectedDigit,
    attemptsOnCurrent: attemptsOnCurrent ?? this.attemptsOnCurrent,
    sessionAttempts: sessionAttempts ?? this.sessionAttempts,
    sessionCorrect: sessionCorrect ?? this.sessionCorrect,
    sessionHintAssisted: sessionHintAssisted ?? this.sessionHintAssisted,
    hintIndex: keepHintIndex ? hintIndex ?? this.hintIndex : hintIndex,
    highestHint: keepHighestHint
        ? highestHint ?? this.highestHint
        : highestHint,
    status: status ?? this.status,
    saving: saving ?? this.saving,
    persistenceFailed: persistenceFailed ?? this.persistenceFailed,
  );
}
