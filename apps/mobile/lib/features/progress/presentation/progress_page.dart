import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/progress/domain/weekly_activity.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:michi_mobile/features/recommendation/presentation/recommendation_copy.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class ProgressPage extends StatefulWidget {
  const ProgressPage({
    this.progressRepository,
    this.gameRepository,
    this.recommendationService,
    super.key,
  });

  final TechniqueProgressRepository? progressRepository;
  final GameRepository? gameRepository;
  final LearningRecommendationService? recommendationService;

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

final class _ProgressData {
  const _ProgressData(this.techniques, this.recommendation, this.games);
  final Map<SudokuTechnique, TechniqueProgress> techniques;
  final LearningRecommendation recommendation;
  final List<CompletedGame> games;
}

final class _ProgressPageState extends State<ProgressPage> {
  late Future<_ProgressData> _data = _load();
  SyncCoordinator? _sync;
  int _syncRevision = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sync = context.read<SyncCoordinator?>();
    if (identical(_sync, sync)) return;
    _sync?.removeListener(_onSynced);
    _sync = sync;
    _syncRevision = sync?.dataRevision ?? 0;
    sync?.addListener(_onSynced);
  }

  void _onSynced() {
    final revision = _sync?.dataRevision ?? 0;
    if (revision == _syncRevision) return;
    _syncRevision = revision;
    setState(() {
      _data = _load();
    });
  }

  @override
  void dispose() {
    _sync?.removeListener(_onSynced);
    super.dispose();
  }

  Future<_ProgressData> _load() async {
    final progress =
        widget.progressRepository ?? getIt<TechniqueProgressRepository>();
    final games = widget.gameRepository ?? getIt<GameRepository>();
    final recommendations =
        widget.recommendationService ?? getIt<LearningRecommendationService>();
    return _ProgressData(
      await progress.loadAll(),
      await recommendations.today(),
      await games.loadRecentCompletedGames(limit: 1000),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: FutureBuilder<_ProgressData>(
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
          final strong =
              data.techniques.values
                  .where(
                    (item) =>
                        item.mastery == TechniqueMastery.practicing ||
                        item.mastery == TechniqueMastery.mastered,
                  )
                  .toList()
                ..sort((a, b) => b.masteryPercent.compareTo(a.masteryPercent));
          final current = data.recommendation.technique;
          final currentProgress =
              data.techniques[current] ?? TechniqueProgress(technique: current);
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _data = _load();
              });
              await _data;
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              children: [
                Text(context.t.home.progress, style: MichiTypography.display),
                const SizedBox(height: MichiSpacing.xxl),
                Text(
                  context.t.progress.doingWell,
                  style: MichiTypography.heading,
                ),
                const SizedBox(height: MichiSpacing.md),
                if (strong.isEmpty)
                  Text(
                    context.t.progress.noStrong,
                    style: MichiTypography.secondary,
                  )
                else
                  for (final item in strong.take(2))
                    _TechniqueRow(
                      progress: item,
                      onTap: () => context.router.root.push(
                        TechniqueLessonRoute(technique: item.technique),
                      ),
                    ),
                const SizedBox(height: MichiSpacing.xxl),
                Text(
                  context.t.progress.learningNow,
                  style: MichiTypography.heading,
                ),
                const SizedBox(height: MichiSpacing.md),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: MichiColors.coralTint,
                    borderRadius: BorderRadius.circular(MichiRadius.card),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(MichiSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          TechniqueCopy.name(context.t, current),
                          style: MichiTypography.heading,
                        ),
                        const SizedBox(height: MichiSpacing.xs),
                        Text(
                          context.t.progress.mastery(
                            percent: currentProgress.masteryPercent,
                          ),
                          style: MichiTypography.secondary,
                        ),
                        const SizedBox(height: MichiSpacing.sm),
                        MichiProgressBar(
                          value: currentProgress.masteryPercent / 100,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: MichiSpacing.xxl),
                Text(context.t.progress.next, style: MichiTypography.heading),
                const SizedBox(height: MichiSpacing.sm),
                Text(
                  RecommendationCopy.reason(context.t, data.recommendation),
                  style: MichiTypography.secondary,
                ),
                const SizedBox(height: MichiSpacing.md),
                MichiButton(
                  key: const ValueKey('progress-next'),
                  label: RecommendationCopy.action(
                    context.t,
                    data.recommendation,
                  ),
                  onPressed: () => unawaited(
                    openRecommendation(context, data.recommendation).then((_) {
                      if (mounted) {
                        setState(() {
                          _data = _load();
                        });
                      }
                    }),
                  ),
                ),
                const SizedBox(height: MichiSpacing.xxl),
                const Divider(color: MichiColors.hairline),
                ListTile(
                  key: const ValueKey('progress-week'),
                  contentPadding: EdgeInsets.zero,
                  title: Text(context.t.progress.thisWeek),
                  subtitle: Text(
                    context.t.progress.completed(
                      n: WeeklyActivity.current(
                        getIt<GameClock>().now(),
                        data.games,
                      ).puzzleCount,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.router.root.push(WeekRoute()),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

final class _TechniqueRow extends StatelessWidget {
  const _TechniqueRow({required this.progress, required this.onTap});
  final TechniqueProgress progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: MichiSpacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  TechniqueCopy.name(context.t, progress.technique),
                  style: MichiTypography.body,
                ),
              ),
              Text('${progress.masteryPercent}%', style: MichiTypography.meta),
              const Icon(Icons.chevron_right_rounded, size: 20),
            ],
          ),
          const SizedBox(height: MichiSpacing.xs),
          MichiProgressBar(value: progress.masteryPercent / 100),
        ],
      ),
    ),
  );
}
