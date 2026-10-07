import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: 'Навчання починається тут.',
    actionLabel: 'Обрати рівень',
    onAction: () => context.router.push(const PlayerLevelRoute()),
  );
}
