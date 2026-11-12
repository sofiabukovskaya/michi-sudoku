import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';

final class AuthErrorBanner extends StatelessWidget {
  const AuthErrorBanner({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: MichiColors.errorTint,
      border: Border.all(color: MichiColors.coral),
      borderRadius: BorderRadius.circular(MichiRadius.control),
    ),
    child: Padding(
      padding: const EdgeInsets.all(MichiSpacing.md),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: MichiColors.error, size: 20),
          const SizedBox(width: MichiSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: MichiTypography.secondary.copyWith(
                color: MichiColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
