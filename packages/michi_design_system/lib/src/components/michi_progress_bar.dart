import 'package:flutter/material.dart';

import '../theme/michi_palette.dart';
import '../tokens/michi_radius.dart';

final class MichiProgressBar extends StatelessWidget {
  const MichiProgressBar({required this.value, super.key});

  /// Progress from zero to one.
  final double value;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(MichiRadius.small),
    child: LinearProgressIndicator(
      value: value.clamp(0, 1),
      minHeight: 8,
      color: MichiPalette.of(context).coral,
      backgroundColor: MichiPalette.of(context).cream,
    ),
  );
}
