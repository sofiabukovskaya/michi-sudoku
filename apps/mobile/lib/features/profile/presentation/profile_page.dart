import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class ProfilePage extends StatefulWidget {
  const ProfilePage({this.games, this.progress, super.key});

  final GameRepository? games;
  final TechniqueProgressRepository? progress;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final class _ProfileData {
  const _ProfileData(this.games, this.progress);
  final List<CompletedGame> games;
  final Map<SudokuTechnique, TechniqueProgress> progress;
}

final class _ProfilePageState extends State<ProfilePage> {
  late Future<_ProfileData> _data = _load();

  Future<_ProfileData> _load() async => _ProfileData(
    await (widget.games ?? getIt<GameRepository>()).loadRecentCompletedGames(
      limit: 1000,
    ),
    await (widget.progress ?? getIt<TechniqueProgressRepository>()).loadAll(),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: FutureBuilder<_ProfileData>(
        future: _data,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: snapshot.hasError
                  ? Text(context.t.learn.unavailable)
                  : const CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!;
          final mastered = data.progress.values
              .where((item) => item.mastery == TechniqueMastery.mastered)
              .length;
          final activeDays = data.games
              .map((game) {
                final day = game.completedAt.toLocal();
                return DateTime(day.year, day.month, day.day);
              })
              .toSet()
              .length;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _data = _load();
              });
              await _data;
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
              children: [
                Row(
                  children: [
                    const MichiMascot(state: MichiMascotState.calm, size: 88),
                    const SizedBox(width: MichiSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.t.profile.guest,
                            style: MichiTypography.display,
                          ),
                          Text(
                            context.t.profile.localOnly,
                            style: MichiTypography.secondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MichiSpacing.xxl),
                const Divider(color: MichiColors.hairline),
                Row(
                  children: [
                    _Stat(
                      value: '${data.games.length}',
                      label: context.t.profile.puzzles,
                    ),
                    _Stat(
                      value: '$mastered',
                      label: context.t.profile.mastered,
                    ),
                    _Stat(
                      value: '$activeDays',
                      label: context.t.profile.activeDays,
                    ),
                  ],
                ),
                const Divider(color: MichiColors.hairline),
                const SizedBox(height: MichiSpacing.xxl),
                Text(
                  context.t.profile.activity,
                  style: MichiTypography.heading,
                ),
                const SizedBox(height: MichiSpacing.md),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: MichiColors.ivory,
                    border: Border.all(color: MichiColors.hairline),
                    borderRadius: BorderRadius.circular(MichiRadius.card),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      children: [
                        _ProfileRow(
                          icon: Icons.menu_book_outlined,
                          title: context.t.profile.learnRow,
                          subtitle: context.t.profile.learnDetail,
                          onTap: () => context.tabsRouter.setActiveIndex(1),
                        ),
                        const Divider(height: 1, color: MichiColors.hairline),
                        _ProfileRow(
                          icon: Icons.settings_outlined,
                          title: context.t.profile.settingsRow,
                          subtitle: context.t.profile.settingsDetail,
                          onTap: () =>
                              context.router.root.push(const SettingsRoute()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

final class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: MichiSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: MichiTypography.heading),
          Text(label, style: MichiTypography.secondary),
        ],
      ),
    ),
  );
}

final class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: Icon(icon, color: MichiColors.textSecondary),
    title: Text(title, style: MichiTypography.body),
    subtitle: Text(subtitle, style: MichiTypography.secondary),
    trailing: const Icon(Icons.chevron_right_rounded),
  );
}
