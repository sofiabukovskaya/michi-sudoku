import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/practice/data/local_practice_catalog.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:michi_mobile/features/recommendation/presentation/recommendation_copy.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class LearnPage extends StatefulWidget {
  const LearnPage({
    this.progressRepository,
    this.catalog,
    this.recommendationService,
    super.key,
  });

  final TechniqueProgressRepository? progressRepository;
  final LocalPracticeCatalog? catalog;
  final LearningRecommendationService? recommendationService;

  @override
  State<LearnPage> createState() => _LearnPageState();
}

final class _LearnPageState extends State<LearnPage>
    with AutoRouteAwareStateMixin<LearnPage> {
  late final TechniqueProgressRepository _repository;
  late Future<Map<SudokuTechnique, TechniqueProgress>> _progress;
  LearningRecommendation? _focus;
  SyncCoordinator? _sync;
  int _syncRevision = 0;

  // PDF screen 18 places Hidden Pair before Pointing Pair in the path. The
  // engine's complexity priority remains SudokuTechniqueOrder.supported.
  static const _groups = <List<SudokuTechnique>>[
    [SudokuTechnique.nakedSingle, SudokuTechnique.hiddenSingle],
    [
      SudokuTechnique.nakedPair,
      SudokuTechnique.hiddenPair,
      SudokuTechnique.pointingPair,
      SudokuTechnique.boxLineReduction,
    ],
    [SudokuTechnique.nakedTriple, SudokuTechnique.xWing],
  ];

  @override
  void initState() {
    super.initState();
    _repository =
        widget.progressRepository ?? getIt<TechniqueProgressRepository>();
    _progress = _repository.loadAll();
    _loadFocus();
  }

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
      _progress = _repository.loadAll();
    });
    _loadFocus();
  }

  @override
  void dispose() {
    _sync?.removeListener(_onSynced);
    super.dispose();
  }

  void _loadFocus() {
    final service =
        widget.recommendationService ??
        (getIt.isRegistered<LearningRecommendationService>()
            ? getIt<LearningRecommendationService>()
            : null);
    if (service == null) return;
    unawaited(
      service.today().then((value) {
        if (mounted) setState(() => _focus = value);
      }),
    );
  }

  @override
  void didPopNext() {
    setState(() {
      _progress = _repository.loadAll();
    });
    _loadFocus();
  }

  Future<void> _openTechnique(
    SudokuTechnique technique, {
    required bool isCurrent,
  }) async {
    if (isCurrent && _focus != null) {
      await openRecommendation(context, _focus!);
    } else {
      await context.router.root.push(
        TechniqueLessonRoute(
          technique: technique,
          catalog: widget.catalog,
        ),
      );
    }
    if (!mounted) return;
    setState(() {
      _progress = _repository.loadAll();
    });
    _loadFocus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: FutureBuilder<Map<SudokuTechnique, TechniqueProgress>>(
        future: _progress,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(context.t.learn.unavailable));
          }
          if (!snapshot.hasData) {
            return Center(child: Text(context.t.learn.loading));
          }
          final values = snapshot.data!;
          final mastered = TechniqueLessons.supported
              .where(
                (item) => values[item]?.mastery == TechniqueMastery.mastered,
              )
              .length;
          final current =
              _focus?.technique ??
              TechniqueLessons.supported.firstWhere(
                (item) => values[item]?.mastery != TechniqueMastery.mastered,
                orElse: () => TechniqueLessons.supported.last,
              );
          final names = [
            context.t.learn.basicsGroup,
            context.t.learn.intermediateGroup,
            context.t.learn.advancedGroup,
          ];
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            children: [
              Text(context.t.learn.title, style: MichiTypography.display),
              const SizedBox(height: MichiSpacing.sm),
              Text(
                '$mastered / ${TechniqueLessons.supported.length} '
                '${context.t.learn.masteredLabel.toLowerCase()}',
                style: MichiTypography.secondary,
              ),
              const SizedBox(height: MichiSpacing.xxl),
              for (var group = 0; group < _groups.length; group++) ...[
                if (group > 0) const SizedBox(height: MichiSpacing.xl),
                _GroupHeading(
                  title: names[group],
                  completed: _groups[group]
                      .where(
                        (item) =>
                            values[item]?.mastery == TechniqueMastery.mastered,
                      )
                      .length,
                  // The two unsupported advanced techniques remain visible.
                  total: _groups[group].length + (group == 2 ? 2 : 0),
                ),
                const SizedBox(height: MichiSpacing.sm),
                for (final technique in _groups[group])
                  _PathItem(
                    technique: technique,
                    progress:
                        values[technique] ??
                        TechniqueProgress(technique: technique),
                    current: technique == current,
                    onTap: () => unawaited(
                      _openTechnique(
                        technique,
                        isCurrent: technique == current,
                      ),
                    ),
                  ),
                if (group == 2)
                  for (final name in ['XY-Wing', 'Swordfish'])
                    _FutureItem(name: name),
              ],
            ],
          );
        },
      ),
    ),
  );
}

final class _GroupHeading extends StatelessWidget {
  const _GroupHeading({
    required this.title,
    required this.completed,
    required this.total,
  });

  final String title;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(title, style: MichiTypography.heading)),
      Text(
        context.t.learn.groupProgress(
          completed: completed,
          total: total,
        ),
        style: MichiTypography.meta,
      ),
    ],
  );
}

final class _PathItem extends StatelessWidget {
  const _PathItem({
    required this.technique,
    required this.progress,
    required this.current,
    required this.onTap,
  });

  final SudokuTechnique technique;
  final TechniqueProgress progress;
  final bool current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mastered = progress.mastery == TechniqueMastery.mastered;
    final percent = progress.masteryPercent;
    return Semantics(
      button: true,
      label:
          '${TechniqueCopy.name(context.t, technique)}, '
          '${TechniqueCopy.mastery(context.t, progress.mastery)}',
      child: InkWell(
        key: ValueKey('learn-${technique.name}'),
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: 48,
              height: current ? 116 : 70,
              child: Column(
                children: [
                  Expanded(
                    child: Container(width: 2, color: MichiColors.hairline),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mastered
                          ? MichiColors.indigo
                          : current
                          ? MichiColors.coral
                          : MichiColors.paper,
                      border: Border.all(
                        color: mastered || current
                            ? Colors.transparent
                            : MichiColors.textPrimary,
                        width: 2,
                      ),
                    ),
                    child: SizedBox.square(
                      dimension: 32,
                      child: mastered
                          ? const Icon(
                              Icons.check,
                              size: 18,
                              color: MichiColors.ivory,
                            )
                          : current
                          ? const Icon(
                              Icons.pets,
                              size: 16,
                              color: MichiColors.textPrimary,
                            )
                          : null,
                    ),
                  ),
                  Expanded(
                    child: Container(width: 2, color: MichiColors.hairline),
                  ),
                ],
              ),
            ),
            const SizedBox(width: MichiSpacing.sm),
            Expanded(
              child: current
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        color: MichiColors.coralTint,
                        borderRadius: BorderRadius.circular(MichiRadius.card),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(MichiSpacing.md),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.t.learn.nowLabel,
                                    style: MichiTypography.meta.copyWith(
                                      color: MichiColors.coralText,
                                    ),
                                  ),
                                  Text(
                                    TechniqueCopy.name(context.t, technique),
                                    style: MichiTypography.editorialTitle,
                                  ),
                                  Text(
                                    '$percent%',
                                    style: MichiTypography.secondary,
                                  ),
                                  const SizedBox(height: MichiSpacing.sm),
                                  LinearProgressIndicator(
                                    value: percent / 100,
                                    minHeight: 4,
                                    color: MichiColors.coral,
                                    backgroundColor: MichiColors.cream,
                                  ),
                                ],
                              ),
                            ),
                            const MichiMascot(
                              state: MichiMascotState.notebook,
                              size: 72,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Text(
                            TechniqueCopy.name(context.t, technique),
                            style: MichiTypography.body.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (percent > 0)
                          Text('$percent%', style: MichiTypography.meta),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _FutureItem extends StatelessWidget {
  const _FutureItem({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 64,
    child: Row(
      children: [
        const SizedBox(
          width: 48,
          child: Icon(
            Icons.lock_outline,
            size: 18,
            color: MichiColors.textSecondary,
          ),
        ),
        const SizedBox(width: MichiSpacing.sm),
        Text(
          name,
          style: MichiTypography.body.copyWith(
            color: MichiColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
