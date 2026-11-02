import 'package:flutter/foundation.dart';

@immutable
final class CoachHintUiModel {
  const CoachHintUiModel({
    required this.stepLabel,
    required this.stepIndex,
    required this.instruction,
    required this.primaryActionLabel,
    this.secondaryActionLabel,
    this.techniqueLabel,
    this.placementDigit,
  });

  final String stepLabel;
  final int stepIndex;
  final String instruction;
  final String primaryActionLabel;
  final String? secondaryActionLabel;
  final String? techniqueLabel;
  final int? placementDigit;
}
