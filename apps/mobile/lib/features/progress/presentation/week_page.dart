import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/progress/domain/weekly_activity.dart';

@RoutePage()
final class WeekPage extends StatefulWidget {
  const WeekPage({this.games, this.clock, super.key});

  final GameRepository? games;
  final GameClock? clock;

  @override
  State<WeekPage> createState() => _WeekPageState();
}

final class _WeekPageState extends State<WeekPage> {
  late final Future<WeeklyActivity> _activity = _load();

  Future<WeeklyActivity> _load() async {
    final clock = widget.clock ?? getIt<GameClock>();
    final games = await (widget.games ?? getIt<GameRepository>())
        .loadRecentCompletedGames(limit: 1000);
    return WeeklyActivity.current(clock.now(), games);
  }

  String _dayStatus(BuildContext context, DayActivity day) => day.puzzles == 0
      ? context.t.week.noActivity
      : context.t.week.completedDay(n: day.puzzles);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    appBar: AppBar(),
    body: SafeArea(
      child: FutureBuilder<WeeklyActivity>(
        future: _activity,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: snapshot.hasError
                  ? Text(context.t.learn.unavailable)
                  : const CircularProgressIndicator(),
            );
          }
          final activity = snapshot.data!;
          final end = activity.monday.add(const Duration(days: 6));
          final localizations = MaterialLocalizations.of(context);
          final dateLabel =
              '${localizations.formatMediumDate(activity.monday)} – '
              '${localizations.formatMediumDate(end)}';
          final maxMinutes = math.max(
            1,
            activity.days.map((day) => day.elapsed.inMinutes).reduce(math.max),
          );
          final today = (widget.clock ?? getIt<GameClock>()).now().toLocal();
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            children: [
              Text(context.t.week.title, style: MichiTypography.display),
              const SizedBox(height: MichiSpacing.xs),
              Text(dateLabel, style: MichiTypography.secondary),
              const SizedBox(height: MichiSpacing.xxl),
              if (activity.puzzleCount == 0) ...[
                Text(context.t.week.empty, style: MichiTypography.body),
                const SizedBox(height: MichiSpacing.xxl),
              ],
              SizedBox(
                height: 220,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final day in activity.days)
                      Expanded(
                        child: Semantics(
                          label:
                              '${localizations.formatMediumDate(day.date)}, '
                              '${_dayStatus(context, day)}',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (day.elapsed.inMinutes > 0)
                                Text(
                                  '${day.elapsed.inMinutes}',
                                  style: MichiTypography.meta,
                                ),
                              const SizedBox(height: MichiSpacing.xs),
                              Container(
                                width: 24,
                                height: day.elapsed.inMinutes == 0
                                    ? 4
                                    : 8 +
                                          day.elapsed.inMinutes /
                                              maxMinutes *
                                              150,
                                decoration: BoxDecoration(
                                  color: day.isActive
                                      ? MichiColors.indigo
                                      : MichiColors.cream,
                                  borderRadius: BorderRadius.circular(
                                    MichiRadius.small,
                                  ),
                                  border:
                                      day.date.day == today.day &&
                                          day.date.month == today.month
                                      ? Border.all(
                                          color: MichiColors.indigoPressed,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(height: MichiSpacing.sm),
                              Text(
                                context.t.home.weekdaysShort.split(
                                  '|',
                                )[day.date.weekday - 1],
                                style: MichiTypography.meta,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: MichiSpacing.lg),
              const Divider(color: MichiColors.hairline),
              Row(
                children: [
                  _WeekStat(
                    value: '${activity.puzzleCount}',
                    label: context.t.week.puzzles,
                  ),
                  _WeekStat(
                    value: '${activity.elapsed.inMinutes}',
                    label: context.t.week.minutes,
                  ),
                  _WeekStat(
                    value: '${activity.dailyCount}',
                    label: context.t.week.daily,
                  ),
                ],
              ),
              const Divider(color: MichiColors.hairline),
              const SizedBox(height: MichiSpacing.lg),
              Text(
                context.t.week.activeDays(n: activity.activeDays),
                style: MichiTypography.body,
              ),
              const SizedBox(height: MichiSpacing.xs),
              Text(context.t.week.summary, style: MichiTypography.secondary),
            ],
          );
        },
      ),
    ),
  );
}

final class _WeekStat extends StatelessWidget {
  const _WeekStat({required this.value, required this.label});
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
