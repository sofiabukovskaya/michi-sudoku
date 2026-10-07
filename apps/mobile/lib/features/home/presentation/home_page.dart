import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.t.appName)),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.t.home.title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: MichiSpacing.xxl),
            MichiButton(
              label: context.t.home.game,
              onPressed: () => context.router.push(const GameRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.learn,
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const LearnRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.progress,
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const ProgressRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.profile,
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const ProfileRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.scanner,
              variant: MichiButtonVariant.text,
              onPressed: () => context.router.push(const ScannerRoute()),
            ),
          ],
        ),
      ),
    ),
  );
}
