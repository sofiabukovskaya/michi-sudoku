import 'package:flutter/material.dart';

import '../theme/michi_palette.dart';
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
    final palette = MichiPalette.of(context);
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
                      ? palette.ivory
                      : palette.indigo,
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
              return palette.disabledBackground;
            }
            if (states.contains(WidgetState.pressed)) {
              return palette.indigoPressed;
            }
            return palette.indigo;
          }),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled) && !isLoading
                ? palette.disabledText
                : palette.ivory,
          ),
        ),
        child: child,
      ),
      MichiButtonVariant.secondary => FilledButton(
        onPressed: action,
        style: style.copyWith(
          backgroundColor: WidgetStatePropertyAll(palette.cream),
          foregroundColor: WidgetStatePropertyAll(palette.textPrimary),
        ),
        child: child,
      ),
      MichiButtonVariant.outline => OutlinedButton(
        onPressed: action,
        style: style.copyWith(
          foregroundColor: WidgetStatePropertyAll(palette.indigo),
        ),
        child: child,
      ),
      MichiButtonVariant.text => TextButton(
        onPressed: action,
        style: style.copyWith(
          foregroundColor: WidgetStatePropertyAll(palette.indigo),
        ),
        child: child,
      ),
    };
  }
}
