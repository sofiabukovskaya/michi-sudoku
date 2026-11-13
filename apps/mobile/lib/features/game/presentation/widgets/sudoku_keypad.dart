import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';

final class SudokuKeypad extends StatelessWidget {
  const SudokuKeypad({
    required this.state,
    required this.onDigit,
    required this.compact,
    this.armedDigit,
    super.key,
  });

  final GameState state;
  final ValueChanged<int> onDigit;
  final bool compact;
  final int? armedDigit;

  @override
  Widget build(BuildContext context) {
    final selected = state.selectedCell;
    final selectedValue =
        armedDigit ?? (selected == null ? 0 : state.board.valueAt(selected));
    return SizedBox(
      height: compact ? 60 : 72,
      child: Row(
        children: [
          for (var digit = 1; digit <= 9; digit++)
            Expanded(
              child: Semantics(
                button: true,
                selected: selectedValue == digit,
                label: '$digit',
                child: InkWell(
                  key: ValueKey('keypad-$digit'),
                  onTap: () => onDigit(digit),
                  borderRadius: BorderRadius.circular(MichiRadius.control),
                  child: AnimatedContainer(
                    duration: MediaQuery.disableAnimationsOf(context)
                        ? Duration.zero
                        : MichiMotion.quick,
                    decoration: BoxDecoration(
                      color: selectedValue == digit ? MichiColors.indigo : null,
                      borderRadius: BorderRadius.circular(MichiRadius.control),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$digit',
                          style: TextStyle(
                            fontFamily: MichiTypography.functionalFamily,
                            fontSize: compact ? 29 : 32,
                            fontWeight: FontWeight.w500,
                            color: selectedValue == digit
                                ? MichiColors.ivory
                                : MichiColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${state.remainingCount(digit).clamp(0, 9)}',
                          style: MichiTypography.meta.copyWith(
                            color: selectedValue == digit
                                ? MichiColors.ivory
                                : MichiColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
