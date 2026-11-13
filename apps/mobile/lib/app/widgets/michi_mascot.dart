import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';

/// Visual intent, rather than a file name, is selected by product surfaces.
enum MichiMascotState { calm, pointing, happy, notebook, celebrating, walking }

final class MichiMascot extends StatelessWidget {
  const MichiMascot({required this.state, required this.size, super.key});

  final MichiMascotState state;
  final double size;

  static String assetFor(MichiMascotState state) => switch (state) {
    MichiMascotState.calm => 'assets/images/michi_calm.png',
    MichiMascotState.pointing => 'assets/images/michi_pointing.png',
    MichiMascotState.happy => 'assets/images/michi_happy.png',
    MichiMascotState.notebook => 'assets/images/michi_notebook.png',
    MichiMascotState.celebrating => 'assets/images/completion_hero.png',
    MichiMascotState.walking => 'assets/images/splash_mascot.png',
  };

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : MichiMotion.standard,
    child: Image.asset(
      assetFor(state),
      key: ValueKey(state),
      width: size,
      height: size,
      fit: BoxFit.contain,
      excludeFromSemantics: true,
    ),
  );
}
