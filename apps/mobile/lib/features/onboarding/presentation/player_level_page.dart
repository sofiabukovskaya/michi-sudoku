import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class PlayerLevelPage extends StatefulWidget {
  const PlayerLevelPage({super.key});

  @override
  State<PlayerLevelPage> createState() => _PlayerLevelPageState();
}

final class _PlayerLevelPageState extends State<PlayerLevelPage> {
  int _selected = 1;

  @override
  Widget build(BuildContext context) {
    final options = [
      (context.t.playerLevel.beginner, context.t.playerLevel.beginnerDetail),
      (context.t.playerLevel.basics, context.t.playerLevel.basicsDetail),
      (context.t.playerLevel.regular, context.t.playerLevel.regularDetail),
      (context.t.playerLevel.advanced, context.t.playerLevel.advancedDetail),
    ];
    return Scaffold(
      backgroundColor: MichiColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  icon: const Icon(Icons.arrow_back_ios_new, size: 22),
                  onPressed: () => context.router.maybePop(),
                ),
              ),
              const SizedBox(height: MichiSpacing.lg),
              Text(
                context.t.playerLevel.title,
                style: MichiTypography.functionalTitle,
              ),
              const SizedBox(height: MichiSpacing.sm),
              Text(
                context.t.playerLevel.subtitle,
                style: MichiTypography.body.copyWith(
                  color: MichiColors.textSecondary,
                ),
              ),
              const SizedBox(height: MichiSpacing.xxl),
              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: MichiSpacing.sm),
                  itemBuilder: (context, index) {
                    final (title, detail) = options[index];
                    final selected = index == _selected;
                    return Semantics(
                      selected: selected,
                      button: true,
                      child: InkWell(
                        key: ValueKey('level-$index'),
                        onTap: () => setState(() => _selected = index),
                        borderRadius: BorderRadius.circular(MichiRadius.card),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 78),
                          padding: const EdgeInsets.all(MichiSpacing.md),
                          decoration: BoxDecoration(
                            color: selected
                                ? MichiColors.indigoTint
                                : MichiColors.ivory,
                            borderRadius: BorderRadius.circular(
                              MichiRadius.card,
                            ),
                            border: Border.all(
                              color: selected
                                  ? MichiColors.indigo
                                  : MichiColors.hairline,
                              width: selected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.grid_on, size: 42),
                              const SizedBox(width: MichiSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      title,
                                      style: MichiTypography.body.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      detail,
                                      style: MichiTypography.secondary,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                selected
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: selected
                                    ? MichiColors.indigo
                                    : MichiColors.inputLine,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              MichiButton(
                label: context.t.common.continueLabel,
                onPressed: () => context.router.replaceAll([AppShellRoute()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
