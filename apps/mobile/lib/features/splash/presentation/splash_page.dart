import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: context.t.appName,
    subtitle: context.t.splash.subtitle,
    actionLabel: context.t.common.start,
    onAction: () => context.router.replace(const WelcomeRoute()),
  );
}
