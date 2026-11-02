import 'package:flutter/material.dart';

import '../theme/michi_palette.dart';
import '../tokens/michi_radius.dart';
import '../tokens/michi_spacing.dart';

final class MichiBottomSheet extends StatelessWidget {
  const MichiBottomSheet({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: MichiPalette.of(context).ivory,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(MichiRadius.hero),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.08),
          offset: const Offset(0, -8),
          blurRadius: 24,
        ),
      ],
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.xl),
        child: child,
      ),
    ),
  );
}
