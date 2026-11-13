import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';

/// A short entrance for a new result. Only the current child is interactive
/// or announced, including when the user advances faster than the animation.
final class MichiReveal extends StatelessWidget {
  const MichiReveal({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: MichiMotion.standard,
      curve: MichiMotion.curve,
      builder: (_, opacity, child) =>
          Opacity(opacity: opacity, alwaysIncludeSemantics: true, child: child),
      child: child,
    );
  }
}
