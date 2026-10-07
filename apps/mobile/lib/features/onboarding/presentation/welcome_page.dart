import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: 'Твій шлях у судоку.',
    actionLabel: 'Продовжити',
    onAction: () => context.router.push(const OnboardingRoute()),
  );
}
