import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class PlayerLevelPage extends StatelessWidget {
  const PlayerLevelPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: 'Як добре ти знаєш судоку?',
    actionLabel: 'До гри',
    onAction: () => context.router.replaceAll([const HomeRoute()]),
  );
}
