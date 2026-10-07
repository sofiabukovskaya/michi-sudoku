import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class PlayerLevelPage extends StatelessWidget {
  const PlayerLevelPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: context.t.playerLevel.title,
    actionLabel: context.t.playerLevel.goToGame,
    onAction: () => context.router.replaceAll([const HomeRoute()]),
  );
}
