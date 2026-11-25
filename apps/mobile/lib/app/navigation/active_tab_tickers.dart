import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

/// Tabs stay alive in an IndexedStack whose hidden pages still tick. This
/// mutes animation tickers on every tab except the visible one, so a hidden
/// tab never draws frames. Outside the tab shell it changes nothing.
final class ActiveTabTickers extends StatelessWidget {
  const ActiveTabTickers({required this.index, required this.child, super.key});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scope = TabsRouterScope.of(context, watch: true);
    final controller = scope?.controller;
    if (controller is! TabsRouter) return child;
    return TickerMode(enabled: controller.activeIndex == index, child: child);
  }
}
