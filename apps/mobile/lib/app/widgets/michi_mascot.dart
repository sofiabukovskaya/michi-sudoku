import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Image.asset(
    assetFor(state),
    width: size,
    height: size,
    fit: BoxFit.contain,
    excludeFromSemantics: true,
  );
}
