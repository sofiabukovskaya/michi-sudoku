import 'package:sudoku_engine/sudoku_engine.dart';

enum WhyAvailability { available, given, empty, wrong, unsupported }

final class WhySelection {
  const WhySelection(this.availability, {this.plan});

  final WhyAvailability availability;
  final WhyPlan? plan;
}
