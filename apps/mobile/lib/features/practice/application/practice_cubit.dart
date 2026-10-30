import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:michi_mobile/features/practice/domain/technique_practice_scenario.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

/// Owns a short session for one technique.
final class PracticeCubit extends Cubit<PracticeState> {
  PracticeCubit({
    required List<TechniquePracticeScenario> scenarios,
    required HumanSolver humanSolver,
    required CoachEngine coachEngine,
    required TechniqueProgressRepository progressRepository,
    required TechniqueProgress initialProgress,
    DateTime Function()? now,
  }) : _humanSolver = humanSolver,
       _coachEngine = coachEngine,
       _progressRepository = progressRepository,
       _now = now ?? DateTime.now,
       super(
         _initial(
           scenarios,
           humanSolver,
           coachEngine,
           initialProgress,
         ),
       );

  final HumanSolver _humanSolver;
  final CoachEngine _coachEngine;
  final TechniqueProgressRepository _progressRepository;
  final DateTime Function() _now;

  static PracticeState _initial(
    List<TechniquePracticeScenario> scenarios,
    HumanSolver solver,
    CoachEngine coach,
    TechniqueProgress progress,
  ) {
    if (scenarios.isEmpty ||
        scenarios.any((item) => item.technique != scenarios.first.technique) ||
        scenarios.map((item) => item.id).toSet().length != scenarios.length) {
      throw ArgumentError(
        'Practice needs distinct scenarios of one technique.',
      );
    }
    final engineState = HumanSolverState.initial(scenarios.first.board);
    final deduction = solver.findNextDeduction(engineState);
    if (deduction?.technique != scenarios.first.technique) {
      throw StateError('Practice content does not match HumanSolver.');
    }
    return PracticeState(
      scenarios: scenarios,
      index: 0,
      engineState: engineState,
      deduction: deduction!,
      coachPlan: coach.createPlan(deduction),
      progress: progress,
      selectedEliminations: const {},
    );
  }

  void selectCell(CellRef cell) {
    if (state.status != PracticeStatus.answering) return;
    emit(state.copyWith(selectedCell: cell));
  }

  void selectDigit(int digit) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
    if (!state.isPlacement || state.status != PracticeStatus.answering) return;
    emit(state.copyWith(selectedDigit: digit));
  }

  void toggleElimination(CellRef cell, int digit) {
    RangeError.checkValueInInterval(digit, 1, 9, 'digit');
    if (state.isPlacement ||
        state.status != PracticeStatus.answering ||
        !state.engineState.candidatesFor(cell).contains(digit)) {
      return;
    }
    final action = CandidateElimination(cell, digit);
    final selected = Set<CandidateElimination>.of(state.selectedEliminations);
    if (!selected.add(action)) selected.remove(action);
    emit(state.copyWith(selectedEliminations: selected));
  }

  Future<void> checkAnswer() async {
    if (state.status != PracticeStatus.answering || state.saving) return;
    final current = state;
    final correct = current.isPlacement
        ? current.deduction.placements.contains(
            current.selectedCell == null || current.selectedDigit == null
                ? null
                : DigitPlacement(current.selectedCell!, current.selectedDigit!),
          )
        : setEquals(
            current.selectedEliminations,
            current.deduction.eliminations.toSet(),
          );
    emit(current.copyWith(saving: true, persistenceFailed: false));
    try {
      final progress = await _progressRepository.recordCheck(
        technique: current.scenario.technique,
        correct: correct,
        firstTry: current.attemptsOnCurrent == 0,
        highestHint: current.highestHint,
        at: _now(),
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          progress: progress,
          attemptsOnCurrent: current.attemptsOnCurrent + 1,
          sessionAttempts: current.sessionAttempts + 1,
          sessionCorrect: current.sessionCorrect + (correct ? 1 : 0),
          sessionHintAssisted:
              current.sessionHintAssisted +
              (correct && current.highestHint != null ? 1 : 0),
          status: correct ? PracticeStatus.correct : PracticeStatus.incorrect,
          saving: false,
        ),
      );
    } on Object catch (error, stackTrace) {
      developer.log(
        'Practice progress could not be saved',
        name: 'michi.practice',
        error: error,
        stackTrace: stackTrace,
      );
      if (!isClosed) {
        emit(state.copyWith(saving: false, persistenceFailed: true));
      }
    }
  }

  void tryAgain() {
    if (state.status != PracticeStatus.incorrect) return;
    emit(
      state.copyWith(
        status: PracticeStatus.answering,
        selectedEliminations: const {},
        keepSelectedCell: false,
        keepSelectedDigit: false,
      ),
    );
  }

  void next() {
    if (state.status != PracticeStatus.correct) return;
    if (state.isLast) {
      emit(state.copyWith(status: PracticeStatus.completed));
      return;
    }
    final index = state.index + 1;
    final scenario = state.scenarios[index];
    final engineState = HumanSolverState.initial(scenario.board);
    final deduction = _humanSolver.findNextDeduction(engineState);
    if (deduction?.technique != scenario.technique) {
      throw StateError('Practice content does not match HumanSolver.');
    }
    emit(
      state.copyWith(
        index: index,
        engineState: engineState,
        deduction: deduction,
        coachPlan: _coachEngine.createPlan(deduction!),
        selectedEliminations: const {},
        keepSelectedCell: false,
        keepSelectedDigit: false,
        keepHintIndex: false,
        keepHighestHint: false,
        attemptsOnCurrent: 0,
        status: PracticeStatus.answering,
      ),
    );
  }

  void requestHint() {
    if (state.status == PracticeStatus.completed) return;
    final next = state.hintIndex == null
        ? 0
        : (state.hintIndex! + 1).clamp(0, 3);
    emit(
      state.copyWith(
        hintIndex: next,
        highestHint:
            CoachHintLevel.values[next > (state.highestHint?.index ?? -1)
                ? next
                : state.highestHint!.index],
      ),
    );
  }

  void dismissHint() => emit(state.copyWith(keepHintIndex: false));
}

bool setEquals<T>(Set<T> left, Set<T> right) =>
    left.length == right.length && left.containsAll(right);
