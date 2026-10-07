import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';

@RoutePage()
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MICHI')),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Твій шлях у судоку', style: MichiTypography.display),
            const SizedBox(height: MichiSpacing.xxl),
            MichiButton(
              label: 'Гра',
              onPressed: () => context.router.push(const GameRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: 'Навчання',
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const LearnRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: 'Прогрес',
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const ProgressRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: 'Профіль',
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const ProfileRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: 'Сканер',
              variant: MichiButtonVariant.text,
              onPressed: () => context.router.push(const ScannerRoute()),
            ),
          ],
        ),
      ),
    ),
  );
}
