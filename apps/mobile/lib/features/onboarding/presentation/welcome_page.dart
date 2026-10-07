import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: context.t.welcome.title,
    actionLabel: context.t.common.continueLabel,
    onAction: () => context.router.push(const OnboardingRoute()),
  );
}
