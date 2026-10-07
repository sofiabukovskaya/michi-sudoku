import 'package:flutter/material.dart';

import '../tokens/michi_colors.dart';
import '../tokens/michi_radius.dart';
import '../tokens/michi_spacing.dart';

final class MichiBottomSheet extends StatelessWidget {
  const MichiBottomSheet({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: MichiColors.ivory,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(MichiRadius.hero),
      ),
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
