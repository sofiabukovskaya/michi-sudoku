import 'package:flutter/material.dart';

import '../tokens/michi_colors.dart';
import '../tokens/michi_radius.dart';
import '../tokens/michi_typography.dart';

enum MichiButtonVariant { primary, secondary, outline, text }

final class MichiButton extends StatelessWidget {
  const MichiButton({
    required this.label,
    required this.onPressed,
    this.variant = MichiButtonVariant.primary,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final MichiButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final action = isLoading ? null : onPressed;
    final child = isLoading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: variant == MichiButtonVariant.primary
                      ? MichiColors.ivory
                      : MichiColors.indigo,
                ),
              ),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MichiRadius.control),
    );
    final style = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(44, 52)),
      shape: WidgetStatePropertyAll(shape),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontFamily: MichiTypography.functionalFamily,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    return switch (variant) {
      MichiButtonVariant.primary => FilledButton(
        onPressed: action,
        style: style.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled) && !isLoading) {
              return MichiColors.disabledBackground;
            }
            if (states.contains(WidgetState.pressed)) {
              return MichiColors.indigoPressed;
            }
            return MichiColors.indigo;
          }),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled) && !isLoading
                ? MichiColors.disabledText
                : MichiColors.ivory,
          ),
        ),
        child: child,
      ),
      MichiButtonVariant.secondary => FilledButton(
        onPressed: action,
        style: style.copyWith(
          backgroundColor: const WidgetStatePropertyAll(MichiColors.cream),
          foregroundColor: const WidgetStatePropertyAll(
            MichiColors.textPrimary,
          ),
        ),
        child: child,
      ),
      MichiButtonVariant.outline => OutlinedButton(
        onPressed: action,
        style: style.copyWith(
          foregroundColor: const WidgetStatePropertyAll(MichiColors.indigo),
        ),
        child: child,
      ),
      MichiButtonVariant.text => TextButton(
        onPressed: action,
        style: style.copyWith(
          foregroundColor: const WidgetStatePropertyAll(MichiColors.indigo),
        ),
        child: child,
      ),
    };
  }
}
