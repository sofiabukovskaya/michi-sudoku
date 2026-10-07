import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: 'MICHI',
    subtitle: 'Вчися бачити наступний хід.',
    actionLabel: 'Почати',
    onAction: () => context.router.replace(const WelcomeRoute()),
  );
}
