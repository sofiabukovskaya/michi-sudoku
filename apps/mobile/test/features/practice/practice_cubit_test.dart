import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/practice/application/practice_cubit.dart';
import 'package:michi_mobile/features/practice/application/practice_state.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/practice/domain/technique_practice_scenario.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _MemoryProgress implements TechniqueProgressRepository {
  final values = <SudokuTechnique, TechniqueProgress>{};

  @override
  Future<TechniqueProgress> load(SudokuTechnique technique) async =>
      values[technique] ?? TechniqueProgress(technique: technique);

  @override
  Future<Map<SudokuTechnique, TechniqueProgress>> loadAll() async => values;

  @override
  Future<TechniqueProgress> recordCheck({
    required SudokuTechnique technique,
    required bool correct,
    required bool firstTry,
    required CoachHintLevel? highestHint,
    required DateTime at,
  }) async {
    final next = (await load(technique)).afterCheck(
      correct: correct,
      firstTry: firstTry,
      highestHint: highestHint,
      at: at,
    );
    values[technique] = next;
    return next;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late List<TechniquePracticeScenario> scenarios;
  late _MemoryProgress progress;

  setUpAll(() async {
    scenarios = await LocalPracticeCatalog().load();
  });
  setUp(() => progress = _MemoryProgress());

  PracticeCubit cubitFor(SudokuTechnique technique, {int count = 1}) =>
      PracticeCubit(
        scenarios: scenarios
            .where((scenario) => scenario.technique == technique)
            .take(count)
            .toList(),
        humanSolver: const DeterministicHumanSolver(),
        coachEngine: const StructuredCoachEngine(),
        progressRepository: progress,
        initialProgress: TechniqueProgress(technique: technique),
        now: () => DateTime.utc(2026, 10, 29),
      );

  blocTest<PracticeCubit, PracticeState>(
    'correct Naked Single placement records an independent success',
    build: () => cubitFor(SudokuTechnique.nakedSingle),
    act: (cubit) async {
      final placement = cubit.state.deduction.placements.single;
      cubit
        ..selectCell(placement.cell)
        ..selectDigit(placement.digit);
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.correct);
      cubit.next();
    },
    verify: (cubit) {
      expect(cubit.state.status, PracticeStatus.completed);
      expect(cubit.state.progress.firstTryCorrect, 1);
      expect(cubit.state.progress.independentStreak, 1);
    },
  );

  for (final technique in [
    SudokuTechnique.nakedSingle,
    SudokuTechnique.hiddenSingle,
  ]) {
    test('$technique rejects wrong cell and digit', () async {
      final cubit = cubitFor(technique);
      addTearDown(cubit.close);
      final expected = cubit.state.deduction.placements.single;
      cubit
        ..selectCell(CellRef.fromIndex((expected.cell.index + 1) % 81))
        ..selectDigit(expected.digit);
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.incorrect);
      cubit
        ..tryAgain()
        ..selectCell(expected.cell)
        ..selectDigit(expected.digit == 9 ? 1 : expected.digit + 1);
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.incorrect);
      cubit
        ..tryAgain()
        ..selectCell(expected.cell)
        ..selectDigit(expected.digit);
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.correct);
      expect(cubit.state.progress.firstTryCorrect, 0);
      expect(cubit.state.progress.independentStreak, 0);
    });
  }

  for (final technique in [
    SudokuTechnique.nakedPair,
    SudokuTechnique.pointingPair,
  ]) {
    test('$technique requires the exact elimination set', () async {
      final cubit = cubitFor(technique);
      addTearDown(cubit.close);
      final expected = cubit.state.deduction.eliminations;
      for (final move in expected.skip(1)) {
        cubit.toggleElimination(move.cell, move.digit);
      }
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.incorrect);
      cubit.tryAgain();
      final extra = cubit.state.engineState.candidates.entries
          .expand(
            (entry) => [
              for (final digit in entry.value.digits)
                CandidateElimination(entry.key, digit),
            ],
          )
          .firstWhere((item) => !expected.contains(item));
      for (final move in expected) {
        cubit.toggleElimination(move.cell, move.digit);
      }
      cubit.toggleElimination(extra.cell, extra.digit);
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.incorrect);
      cubit.tryAgain();
      for (final move in expected) {
        cubit.toggleElimination(move.cell, move.digit);
      }
      await cubit.checkAnswer();
      expect(cubit.state.status, PracticeStatus.correct);
    });
  }

  test(
    'Coach reveals Direction, Focus, Reasoning, Result and records help',
    () async {
      final cubit = cubitFor(SudokuTechnique.nakedPair);
      addTearDown(cubit.close);
      for (final level in CoachHintLevel.values) {
        cubit.requestHint();
        expect(cubit.state.visibleHint?.level, level);
      }
      expect(
        cubit.state.visibleHint?.revealedEliminations,
        cubit.state.deduction.eliminations,
      );
      cubit
        ..dismissHint()
        ..requestHint();
      expect(cubit.state.visibleHint?.level, CoachHintLevel.direction);
      expect(cubit.state.highestHint, CoachHintLevel.result);
      cubit.dismissHint();
      for (final move in cubit.state.deduction.eliminations) {
        cubit.toggleElimination(move.cell, move.digit);
      }
      await cubit.checkAnswer();
      expect(cubit.state.progress.resultHintSuccesses, 1);
      expect(cubit.state.progress.firstTryCorrect, 0);
    },
  );

  test('five distinct scenarios complete one bounded session', () async {
    final cubit = cubitFor(SudokuTechnique.hiddenSingle, count: 5);
    addTearDown(cubit.close);
    for (var index = 0; index < 5; index++) {
      expect(
        cubit.state.scenario.id,
        scenarios
            .where((item) => item.technique == SudokuTechnique.hiddenSingle)
            .elementAt(index)
            .id,
      );
      final placement = cubit.state.deduction.placements.single;
      cubit
        ..selectCell(placement.cell)
        ..selectDigit(placement.digit);
      await cubit.checkAnswer();
      cubit.next();
    }
    expect(cubit.state.status, PracticeStatus.completed);
    expect(cubit.state.sessionCorrect, 5);
    expect(cubit.state.progress.mastery, TechniqueMastery.mastered);
  });
}
