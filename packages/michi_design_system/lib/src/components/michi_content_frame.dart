import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../tokens/michi_layout.dart';

/// Shared readable page width. Phone gutters remain owned by the content:
/// 16 for cards and 24 for text. Medium and expanded windows add outer
/// breathing room and center one readable column.
/// Place inside SafeArea and outside the page's scroll view.
final class MichiContentFrame extends StatelessWidget {
  const MichiContentFrame({
    required this.child,
    this.maxWidth = MichiLayout.readableWidth,
    this.expandedMaxHeight,
    this.expandedAlignment = Alignment.center,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  /// Bounds task compositions on tall tablets without changing phone layout.
  final double? expandedMaxHeight;

  /// Vertical placement of a height-bounded column on larger windows.
  final Alignment expandedAlignment;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final windowClass = MichiLayout.classify(constraints.maxWidth);
      final margin = MichiLayout.outerMargin(constraints.maxWidth);
      final height = windowClass == MichiWindowClass.compact
          ? null
          : expandedMaxHeight;
      return Align(
        // Unbounded pages size to their content; a height-bounded task
        // composition fills the window so it can be placed vertically.
        heightFactor: height == null || !constraints.hasBoundedHeight
            ? 1
            : null,
        alignment: height == null ? Alignment.topCenter : expandedAlignment,
        child: SizedBox(
          width: math.min(maxWidth, constraints.maxWidth - margin * 2),
          height: height == null
              ? null
              : math.min(height, constraints.maxHeight),
          child: child,
        ),
      );
    },
  );
}
