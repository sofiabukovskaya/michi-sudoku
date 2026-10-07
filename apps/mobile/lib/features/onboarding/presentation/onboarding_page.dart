import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: context.t.onboarding.title,
    actionLabel: context.t.onboarding.chooseLevel,
    onAction: () => context.router.push(const PlayerLevelRoute()),
  );
}
