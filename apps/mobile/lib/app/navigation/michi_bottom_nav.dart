import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

enum MichiTab { game, learn, progress, profile }

/// The quiet four-tab shell from the approved MICHI navigation specification.
final class MichiBottomNav extends StatelessWidget {
  const MichiBottomNav({required this.current, super.key});

  final MichiTab current;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: MichiColors.paper,
      border: Border(top: BorderSide(color: MichiColors.hairline)),
    ),
    child: SafeArea(
      top: false,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            _item(
              context,
              MichiTab.game,
              Icons.grid_on_outlined,
              context.t.home.game,
            ),
            _item(
              context,
              MichiTab.learn,
              Icons.menu_book_outlined,
              context.t.home.learn,
            ),
            _item(
              context,
              MichiTab.progress,
              Icons.timeline_outlined,
              context.t.home.progress,
            ),
            _item(
              context,
              MichiTab.profile,
              Icons.person_outline,
              context.t.home.profile,
            ),
          ],
        ),
      ),
    ),
  );

  Widget _item(
    BuildContext context,
    MichiTab tab,
    IconData icon,
    String label,
  ) {
    final selected = current == tab;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: InkWell(
          onTap: selected ? null : () => _navigate(context, tab),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: selected ? MichiColors.indigoTint : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SizedBox(
                  width: 56,
                  height: 32,
                  child: Icon(
                    icon,
                    size: 24,
                    color: selected
                        ? MichiColors.indigoPressed
                        : MichiColors.textSecondary,
                  ),
                ),
              ),
              Text(
                label,
                maxLines: 1,
                style: MichiTypography.meta.copyWith(
                  color: selected
                      ? MichiColors.indigoPressed
                      : MichiColors.textSecondary,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, MichiTab tab) {
    switch (tab) {
      case MichiTab.game:
        unawaited(context.router.replace(HomeRoute()));
        return;
      case MichiTab.learn:
        unawaited(context.router.replace(LearnRoute()));
        return;
      case MichiTab.progress:
        unawaited(context.router.replace(const ProgressRoute()));
        return;
      case MichiTab.profile:
        unawaited(context.router.replace(const ProfileRoute()));
        return;
    }
  }
}
