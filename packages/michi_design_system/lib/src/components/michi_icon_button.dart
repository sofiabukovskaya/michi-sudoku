import 'package:flutter/material.dart';

import '../theme/michi_palette.dart';

final class MichiIconButton extends StatelessWidget {
  const MichiIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(icon),
    tooltip: tooltip,
    onPressed: onPressed,
    color: MichiPalette.of(context).textPrimary,
    constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
  );
}
