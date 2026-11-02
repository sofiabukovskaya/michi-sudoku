import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

abstract final class TechniqueCopy {
  static String name(Translations t, SudokuTechnique technique) {
    final label = switch (technique) {
      SudokuTechnique.nakedSingle => t.coach.nakedSingle,
      SudokuTechnique.hiddenSingle => t.coach.hiddenSingle,
      SudokuTechnique.nakedPair => t.coach.nakedPair,
      SudokuTechnique.pointingPair => t.coach.pointingPair,
      SudokuTechnique.hiddenPair => t.coach.hiddenPair,
      SudokuTechnique.boxLineReduction => t.coach.boxLineReduction,
      SudokuTechnique.nakedTriple => t.coach.nakedTriple,
      SudokuTechnique.xWing => t.coach.xWing,
      _ => throw ArgumentError.value(technique, 'technique'),
    };
    return '${label[0].toUpperCase()}${label.substring(1)}';
  }

  static String mastery(Translations t, TechniqueMastery value) =>
      switch (value) {
        TechniqueMastery.newTechnique => t.learn.newLabel,
        TechniqueMastery.learning => t.learn.learningLabel,
        TechniqueMastery.practicing => t.learn.practicingLabel,
        TechniqueMastery.mastered => t.learn.masteredLabel,
      };

  static String stepLabel(Translations t, LessonStepKind kind) =>
      switch (kind) {
        LessonStepKind.concept => t.learn.concept,
        LessonStepKind.lookFor => t.learn.lookFor,
        LessonStepKind.reasoning => t.learn.reasoning,
        LessonStepKind.example => t.learn.example,
        LessonStepKind.tryIt => t.learn.tryIt,
      };

  static String description(
    Translations t,
    SudokuTechnique technique,
  ) => switch (technique) {
    SudokuTechnique.nakedSingle => t.learn.lessons.nakedSingle.description,
    SudokuTechnique.hiddenSingle => t.learn.lessons.hiddenSingle.description,
    SudokuTechnique.nakedPair => t.learn.lessons.nakedPair.description,
    SudokuTechnique.pointingPair => t.learn.lessons.pointingPair.description,
    SudokuTechnique.hiddenPair => t.learn.lessons.hiddenPair.description,
    SudokuTechnique.boxLineReduction =>
      t.learn.lessons.boxLineReduction.description,
    SudokuTechnique.nakedTriple => t.learn.lessons.nakedTriple.description,
    SudokuTechnique.xWing => t.learn.lessons.xWing.description,
    _ => throw ArgumentError.value(technique, 'technique'),
  };

  static String step(
    Translations t,
    SudokuTechnique technique,
    LessonStepKind kind,
  ) => switch ((technique, kind)) {
    (SudokuTechnique.nakedSingle, LessonStepKind.concept) =>
      t.learn.lessons.nakedSingle.concept,
    (SudokuTechnique.nakedSingle, LessonStepKind.lookFor) =>
      t.learn.lessons.nakedSingle.lookFor,
    (SudokuTechnique.nakedSingle, LessonStepKind.reasoning) =>
      t.learn.lessons.nakedSingle.reasoning,
    (SudokuTechnique.nakedSingle, LessonStepKind.example) =>
      t.learn.lessons.nakedSingle.example,
    (SudokuTechnique.nakedSingle, LessonStepKind.tryIt) =>
      t.learn.lessons.nakedSingle.tryIt,
    (SudokuTechnique.hiddenSingle, LessonStepKind.concept) =>
      t.learn.lessons.hiddenSingle.concept,
    (SudokuTechnique.hiddenSingle, LessonStepKind.lookFor) =>
      t.learn.lessons.hiddenSingle.lookFor,
    (SudokuTechnique.hiddenSingle, LessonStepKind.reasoning) =>
      t.learn.lessons.hiddenSingle.reasoning,
    (SudokuTechnique.hiddenSingle, LessonStepKind.example) =>
      t.learn.lessons.hiddenSingle.example,
    (SudokuTechnique.hiddenSingle, LessonStepKind.tryIt) =>
      t.learn.lessons.hiddenSingle.tryIt,
    (SudokuTechnique.nakedPair, LessonStepKind.concept) =>
      t.learn.lessons.nakedPair.concept,
    (SudokuTechnique.nakedPair, LessonStepKind.lookFor) =>
      t.learn.lessons.nakedPair.lookFor,
    (SudokuTechnique.nakedPair, LessonStepKind.reasoning) =>
      t.learn.lessons.nakedPair.reasoning,
    (SudokuTechnique.nakedPair, LessonStepKind.example) =>
      t.learn.lessons.nakedPair.example,
    (SudokuTechnique.nakedPair, LessonStepKind.tryIt) =>
      t.learn.lessons.nakedPair.tryIt,
    (SudokuTechnique.pointingPair, LessonStepKind.concept) =>
      t.learn.lessons.pointingPair.concept,
    (SudokuTechnique.pointingPair, LessonStepKind.lookFor) =>
      t.learn.lessons.pointingPair.lookFor,
    (SudokuTechnique.pointingPair, LessonStepKind.reasoning) =>
      t.learn.lessons.pointingPair.reasoning,
    (SudokuTechnique.pointingPair, LessonStepKind.example) =>
      t.learn.lessons.pointingPair.example,
    (SudokuTechnique.pointingPair, LessonStepKind.tryIt) =>
      t.learn.lessons.pointingPair.tryIt,
    (SudokuTechnique.hiddenPair, LessonStepKind.concept) =>
      t.learn.lessons.hiddenPair.concept,
    (SudokuTechnique.hiddenPair, LessonStepKind.lookFor) =>
      t.learn.lessons.hiddenPair.lookFor,
    (SudokuTechnique.hiddenPair, LessonStepKind.reasoning) =>
      t.learn.lessons.hiddenPair.reasoning,
    (SudokuTechnique.hiddenPair, LessonStepKind.example) =>
      t.learn.lessons.hiddenPair.example,
    (SudokuTechnique.hiddenPair, LessonStepKind.tryIt) =>
      t.learn.lessons.hiddenPair.tryIt,
    (SudokuTechnique.boxLineReduction, LessonStepKind.concept) =>
      t.learn.lessons.boxLineReduction.concept,
    (SudokuTechnique.boxLineReduction, LessonStepKind.lookFor) =>
      t.learn.lessons.boxLineReduction.lookFor,
    (SudokuTechnique.boxLineReduction, LessonStepKind.reasoning) =>
      t.learn.lessons.boxLineReduction.reasoning,
    (SudokuTechnique.boxLineReduction, LessonStepKind.example) =>
      t.learn.lessons.boxLineReduction.example,
    (SudokuTechnique.boxLineReduction, LessonStepKind.tryIt) =>
      t.learn.lessons.boxLineReduction.tryIt,
    (SudokuTechnique.nakedTriple, LessonStepKind.concept) =>
      t.learn.lessons.nakedTriple.concept,
    (SudokuTechnique.nakedTriple, LessonStepKind.lookFor) =>
      t.learn.lessons.nakedTriple.lookFor,
    (SudokuTechnique.nakedTriple, LessonStepKind.reasoning) =>
      t.learn.lessons.nakedTriple.reasoning,
    (SudokuTechnique.nakedTriple, LessonStepKind.example) =>
      t.learn.lessons.nakedTriple.example,
    (SudokuTechnique.nakedTriple, LessonStepKind.tryIt) =>
      t.learn.lessons.nakedTriple.tryIt,
    (SudokuTechnique.xWing, LessonStepKind.concept) =>
      t.learn.lessons.xWing.concept,
    (SudokuTechnique.xWing, LessonStepKind.lookFor) =>
      t.learn.lessons.xWing.lookFor,
    (SudokuTechnique.xWing, LessonStepKind.reasoning) =>
      t.learn.lessons.xWing.reasoning,
    (SudokuTechnique.xWing, LessonStepKind.example) =>
      t.learn.lessons.xWing.example,
    (SudokuTechnique.xWing, LessonStepKind.tryIt) =>
      t.learn.lessons.xWing.tryIt,
    _ => throw ArgumentError.value(technique, 'technique'),
  };
}
