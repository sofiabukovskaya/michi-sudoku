import 'package:flutter/widgets.dart';

import '../tokens/michi_motion.dart';

/// Tactile visual acknowledgement without intercepting the child's gestures
/// or delaying its action. Semantics remain owned by the button or row.
final class MichiPressFeedback extends StatefulWidget {
  const MichiPressFeedback({
    required this.child,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final bool enabled;

  @override
  State<MichiPressFeedback> createState() => _MichiPressFeedbackState();
}

final class _MichiPressFeedbackState extends State<MichiPressFeedback> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Listener(
      onPointerDown: widget.enabled ? (_) => _setPressed(true) : null,
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed && widget.enabled && !reduceMotion ? 0.985 : 1,
        duration: reduceMotion ? Duration.zero : MichiMotion.quick,
        curve: MichiMotion.curve,
        child: widget.child,
      ),
    );
  }
}
