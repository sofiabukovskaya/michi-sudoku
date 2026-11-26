import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:michi_design_system/michi_design_system.dart';

/// Digit input with the Game keypad's language: large functional numerals
/// on paper, the chosen digit as an indigo pill, a selection haptic. Shared
/// by Practice, lesson "Try it" and scanner Review corrections.
final class MichiDigitPad extends StatelessWidget {
  const MichiDigitPad({
    required this.digits,
    required this.selected,
    required this.keyFor,
    required this.onDigit,
    this.strikeSelected = false,
    this.semanticsFor,
    super.key,
  });

  static const double height = 60;

  final List<int> digits;
  final Set<int> selected;
  final String Function(int digit) keyFor;
  final ValueChanged<int> onDigit;

  /// Elimination mode: a chosen candidate is crossed out, not filled.
  final bool strikeSelected;
  final String Function(int digit)? semanticsFor;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final keys = [
      for (final digit in digits)
        Expanded(
          child: Semantics(
            button: true,
            selected: selected.contains(digit),
            label: semanticsFor?.call(digit) ?? '$digit',
            onTap: () => onDigit(digit),
            child: ExcludeSemantics(
              child: MichiPressFeedback(
                child: InkWell(
                  key: ValueKey(keyFor(digit)),
                  onTap: () {
                    unawaited(HapticFeedback.selectionClick());
                    onDigit(digit);
                  },
                  borderRadius: BorderRadius.circular(MichiRadius.control),
                  child: AnimatedContainer(
                    duration: reduceMotion ? Duration.zero : MichiMotion.quick,
                    curve: MichiMotion.curve,
                    height: height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected.contains(digit)
                          ? strikeSelected
                                ? MichiColors.errorTint
                                : MichiColors.indigo
                          : null,
                      borderRadius: BorderRadius.circular(MichiRadius.control),
                    ),
                    child: Text(
                      '$digit',
                      style: TextStyle(
                        fontFamily: MichiTypography.functionalFamily,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: !selected.contains(digit)
                            ? MichiColors.textPrimary
                            : strikeSelected
                            ? MichiColors.error
                            : MichiColors.ivory,
                        decoration: strikeSelected && selected.contains(digit)
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: MichiColors.error,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    ];
    // Fewer candidates stay centered at keypad key width.
    return LayoutBuilder(
      builder: (context, constraints) {
        final keyWidth = constraints.maxWidth / 9;
        return Center(
          child: SizedBox(
            width: math.min(constraints.maxWidth, keyWidth * digits.length),
            child: Row(children: keys),
          ),
        );
      },
    );
  }
}
