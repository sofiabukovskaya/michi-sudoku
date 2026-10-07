import '../human_solver/deduction.dart';
import 'coach_plan.dart';

/// Turns a verified deduction into progressive, localizable hint data.
abstract interface class CoachEngine {
  CoachPlan createPlan(Deduction deduction);
}
