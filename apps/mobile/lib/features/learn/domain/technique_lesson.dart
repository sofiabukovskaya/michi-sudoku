import 'package:sudoku_engine/sudoku_engine.dart';

/// Static lesson structure. All visible wording belongs to localization.
enum LessonStepKind { concept, lookFor, reasoning, example, tryIt }

final class TechniqueLesson {
  const TechniqueLesson({required this.technique, required this.steps});

  final SudokuTechnique technique;
  final List<LessonStepKind> steps;
}

abstract final class TechniqueLessons {
  static const List<SudokuTechnique> supported = SudokuTechniqueOrder.supported;

  static TechniqueLesson forTechnique(SudokuTechnique technique) {
    if (!supported.contains(technique)) {
      throw ArgumentError.value(technique, 'technique');
    }
    return TechniqueLesson(
      technique: technique,
      steps: const [
        LessonStepKind.concept,
        LessonStepKind.example,
        LessonStepKind.tryIt,
      ],
    );
  }
}
